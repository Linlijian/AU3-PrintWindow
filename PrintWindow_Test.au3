#include-once
#include <ScreenCapture.au3>
#include <PrintWindow.au3>

Local $WinHandle = WinGetHandle("NoxPlayer 7")
$iWidth = _WinAPI_GetWindowWidth($WinHandle)
$iHeight = _WinAPI_GetWindowHeight($WinHandle)

;Example 1
$hBMP = _WinCapture($WinHandle ,$iWidth ,$iHeight)
_ScreenCapture_SaveImage(@ScriptDir&"\_WinCapture.jpg", $hBMP)

;Example 2
$hBMP = _WinCaptureArea($WinHandle,$iWidth,$iHeight,700,50)
_ScreenCapture_SaveImage(@ScriptDir&"\_WinCaptureArea.jpg", $hBMP)

;Example 3
Local $arry[4] = [560,300,100,100]
$hBMP = _WinCaptureAreaPosition($WinHandle,$arry[0],$arry[1],$arry[2],$arry[3])
_ScreenCapture_SaveImage(@ScriptDir&"\_WinCaptureAreaPosition.jpg", $hBMP)