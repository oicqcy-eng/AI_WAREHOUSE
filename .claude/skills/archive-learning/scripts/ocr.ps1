param([string]$Path)

Add-Type -AssemblyName System.Runtime.WindowsRuntime
[Windows.Media.Ocr.OcrEngine, Windows.Foundation, ContentType = WindowsRuntime] | Out-Null
[Windows.Graphics.Imaging.BitmapDecoder, Windows.Graphics, ContentType = WindowsRuntime] | Out-Null
[Windows.Storage.Streams.InMemoryRandomAccessStream, Windows.Storage.Streams, ContentType = WindowsRuntime] | Out-Null
[Windows.Storage.Streams.DataWriter, Windows.Storage.Streams, ContentType = WindowsRuntime] | Out-Null
[Windows.Globalization.Language, Windows.Globalization, ContentType = WindowsRuntime] | Out-Null

$asTaskGeneric = ([System.WindowsRuntimeSystemExtensions].GetMethods() |
    Where-Object { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1' })[0]
function Await($WinRtTask, $ResultType) {
    $asTask = $asTaskGeneric.MakeGenericMethod($ResultType)
    $netTask = $asTask.Invoke($null, @($WinRtTask))
    $netTask.Wait(-1) | Out-Null
    if ($netTask.Exception) { throw $netTask.Exception }
    $netTask.Result
}

$lang = New-Object Windows.Globalization.Language "zh-Hans-CN"
$ocr = [Windows.Media.Ocr.OcrEngine]::TryCreateFromLanguage($lang)
if (-not $ocr) { $ocr = [Windows.Media.Ocr.OcrEngine]::TryCreateFromUserProfileLanguages() }

if (-not $ocr) { Write-Output "OCR_ENGINE_FAIL"; exit 1 }

$bytes = [System.IO.File]::ReadAllBytes($Path)
$stream = New-Object Windows.Storage.Streams.InMemoryRandomAccessStream
$dw = New-Object Windows.Storage.Streams.DataWriter($stream)
$dw.WriteBytes($bytes)
Await ($dw.StoreAsync()) ([System.UInt32]) | Out-Null
$dw.DetachStream() | Out-Null
$stream.Seek(0)
$decoder = Await ([Windows.Graphics.Imaging.BitmapDecoder]::CreateAsync($stream)) ([Windows.Graphics.Imaging.BitmapDecoder])
$bitmap = Await ($decoder.GetSoftwareBitmapAsync()) ([Windows.Graphics.Imaging.SoftwareBitmap])
$result = Await ($ocr.RecognizeAsync($bitmap)) ([Windows.Media.Ocr.OcrResult])
$stream.Dispose()

Write-Output "===== OCR 结果（第 $($result.Lines.Count) 行）====="
foreach ($line in $result.Lines) { Write-Output $line.Text }
