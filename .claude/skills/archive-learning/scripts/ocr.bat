@echo off
if "%~1"=="" (
    echo 用法: ocr "图片路径"
    echo 示例: ocr "D:\path\to\image.png"
    exit /b 1
)
powershell -ExecutionPolicy Bypass -File "%~dp0ocr.ps1" "%~1"
