# -*- coding: utf-8 -*-
"""
控制计划转换工具 v4.5 —— 命令行批量调用器（脱离 tkinter GUI）
================================================================
配套知识卡 K-014（三厂小簧 knowledge_cards.md）。客户 exe 原件 F-025
（delivery/inbox/控制计划转换工具_v4.5.exe），拆解区在 tmp/cp_tool_extract/（不入库，
可由 exe 重新 pyinstxtractor 解包得到）。

用途：把一份（或一批）AIAG 控制计划 xlsx 跑成 MES 导入物：
  - SIP 导入 Excel + SQL（计量 TBLQCITEMFORVARIABLES / 计数 TBLQCITEMFORATTRIBUTES）
  - 产品流程 Excel（Sheet「范本」= MES 工艺流程导入模板，含作业站 OPNO）
  - 摘要报告 txt（计量/计数分布、未解析规格警告）

用法（需 Python 3.11，匹配 exe 的 PyInstaller 运行时；本机 `py -3.11`）：
  py -3.11 cp_convert_runner.py <控制计划.xlsx> [输出目录]
  py -3.11 cp_convert_runner.py 382-M0991E116控制计划.xlsx out_e116

两个关键坑（踩过，见 K-014「命令行调用」段）：
  1. 资源布局：解包后 pyc 在 PYZ.pyz_extracted/，而模板 xlsx / cp_supplement.json
     在解包根目录；但真实 frozen 运行时它们同在 sys._MEIPASS。脚本把 3 个资源
     复制到 pyc 同级目录还原该布局（幂等），否则 SIP 走「空白模板」、流程被跳过。
  2. config 传参不同：SIPGenerator 吃【扁平 defaults】；ProcessFlowWriter._get_cfg
     读 config['defaults']/config['products']，要吃【整个 supplement 对象】。
"""
import sys, os, json, shutil, io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")

# 拆解区路径（exe 解包产物；若迁移请改这里）
EXTRACT_ROOT = r"d:\AI_WAREHOUSE\tmp\cp_tool_extract\控制计划转换工具_v4.5.exe_extracted"
PYZ_DIR = os.path.join(EXTRACT_ROOT, "PYZ.pyz_extracted")
RESOURCES = ["SIPImportTemplate.xlsx", "ProcessFlowTemplate.xlsx", "cp_supplement.json"]


def ensure_layout():
    """把模板/supplement 复制到 pyc 同级，还原 PyInstaller _MEIPASS 资源布局。"""
    assert os.path.isdir(PYZ_DIR), f"找不到拆解区: {PYZ_DIR}（需先解包 F-025 exe）"
    for fn in RESOURCES:
        src, dst = os.path.join(EXTRACT_ROOT, fn), os.path.join(PYZ_DIR, fn)
        if os.path.exists(src) and not os.path.exists(dst):
            shutil.copy(src, dst)


def convert(cp_path: str, out_dir: str) -> dict:
    ensure_layout()
    sys.path.insert(0, PYZ_DIR)
    import cp_parser  # noqa: E402

    os.makedirs(out_dir, exist_ok=True)
    sup = json.load(open(os.path.join(EXTRACT_ROOT, "cp_supplement.json"), encoding="utf-8"))
    flat = dict(sup.get("defaults", {}))  # SIPGenerator 用扁平 defaults

    reader = cp_parser.ControlPlanReader(cp_path)
    header = reader.read_header()
    rows = reader.read_rows()

    sip_rows = cp_parser.SIPGenerator(flat, header, rows).generate_sip_rows()
    ow = cp_parser.OutputWriter(sip_rows, header, out_dir)
    sip_xlsx = ow.write_excel()
    sip_sql = ow.write_sql()
    summary = ow.write_summary()
    # ProcessFlowWriter 吃整个 supplement（嵌套 defaults/products）
    flow_xlsx = cp_parser.ProcessFlowWriter(sup, header, rows, out_dir).generate()

    return {
        "part_no": header.get("part_no"), "cp_code": header.get("cp_code"),
        "rows": len(rows), "sip_items": len(sip_rows),
        "sip_xlsx": sip_xlsx, "sip_sql": sip_sql, "summary": summary,
        "flow_xlsx": flow_xlsx,
    }


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(__doc__); sys.exit(1)
    cp = sys.argv[1]
    out = sys.argv[2] if len(sys.argv) > 2 else os.path.join(
        os.path.dirname(os.path.abspath(cp)), "cp_out_" + os.path.splitext(os.path.basename(cp))[0])
    r = convert(cp, out)
    print(f"[OK] {r['part_no']} ({r['cp_code']}) 特性行={r['rows']} SIP项={r['sip_items']}")
    for k in ("sip_xlsx", "sip_sql", "summary", "flow_xlsx"):
        print(f"  {k:9} -> {r[k]}")
    if r["summary"] and os.path.exists(r["summary"]):
        print("\n" + "=" * 60)
        print(open(r["summary"], encoding="utf-8").read())
