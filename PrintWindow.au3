#include-once
#include <ScreenCapture.au3>


Local $WinHandle = WinGetHandle("NoxPlayer")
$iWidth = _WinAPI_GetWindowWidth($WinHandle)
$iHeight = _WinAPI_GetWindowHeight($WinHandle)

;Example 1
_WinCapture($WinHandle ,$iWidth ,$iHeight)

;Example 2
_WinCaptureArea($WinHandle,$iWidth,$iHeight,700,50)


; #FUNCTION# ====================================================================================================================
; Name ..........: _WinCapture
; Description ...: Windown Capture hidden active dont work for minimize.
; Syntax ........: _WinCapture($WinHandle [,$iWidth = -1 [,$iHeight = -1]])
; Parameters ....: $WinHandle        -  The WinHandle to matching picture.
;				   $iWidth           -  Window Width
;                  $iHeight          -  Window Height
; Author ........: wraithdu
; Modified ......: Linlijian
; ===============================================================================================================================
Func _WinCapture($hWnd, $iWidth = -1, $iHeight = -1)
    Local $iH, $iW, $hDDC, $hCDC, $hBMP

    If $iWidth = -1 Then $iWidth = _WinAPI_GetWindowWidth($hWnd)
    If $iHeight = -1 Then $iHeight = _WinAPI_GetWindowHeight($hWnd)

    $hDDC = _WinAPI_GetDC($hWnd)
    $hCDC = _WinAPI_CreateCompatibleDC($hDDC)
    $hBMP = _WinAPI_CreateCompatibleBitmap($hDDC, $iWidth, $iHeight)
    _WinAPI_SelectObject($hCDC, $hBMP)

    DllCall("User32.dll", "int", "PrintWindow", "hwnd", $hWnd, "hwnd", $hCDC, "int", 0)
    _WinAPI_BitBlt($hCDC, 0, 0, $iW, $iH, $hDDC, 0, 0, 0x00330008)

    _WinAPI_ReleaseDC($hWnd, $hDDC)
    _WinAPI_DeleteDC($hCDC)

    _ScreenCapture_SaveImage(@ScriptDir&"\window.jpg", $hBMP)
    _WinAPI_DeleteObject($hBMP)

    Return $hBMP
EndFunc   ;==>_WinCapture

; #FUNCTION# ====================================================================================================================
; Name ..........: _WinCaptureArea
; Description ...: Windown Capture Area hidden active dont work for minimize.
; Syntax ........: _WinCaptureArea($WinHandle [,$iWidth = -1 [,$iHeight = -1 [,$iLeft = -1 [, $iTop = -1]]]]])
; Parameters ....: $WinHandle        -  The WinHandle to matching picture.
;				   $iWidth           -  Window Width
;                  $iHeight          -  Window Height
;                  $iLeft            -  Window Left Width 
;                  $iTop             -  Window Top Height 
; Author ........: Linlijian
; Modified ......: Linlijian
; ===============================================================================================================================
Func _WinCaptureArea($hWnd, $iWidth = -1, $iHeight = -1, $iLeft = -1, $iTop = -1)
    Local $iH, $iW, $hDDC, $hCDC, $hBMP

    If $iWidth = -1 Then $iWidth = _WinAPI_GetWindowWidth($hWnd)
    If $iHeight = -1 Then $iHeight = _WinAPI_GetWindowHeight($hWnd)
    If $iLeft = -1 Then $iLeft = 0
    If $iTop = -1 Then $iTop = 0
    If $iWidth < $iLeft Then $iLeft = 0
    If $iHeight < $iTop Then $iTop = 0

    $iW = ($iWidth - $iLeft)
    $iH = ($iHeight - $iTop)

    $hDDC = _WinAPI_GetDC($hWnd)
    $hCDC = _WinAPI_CreateCompatibleDC($hDDC)
    $hBMP = _WinAPI_CreateCompatibleBitmap($hDDC, $iW, $iH)
    _WinAPI_SelectObject($hCDC, $hBMP)

    DllCall("User32.dll", "int", "PrintWindow", "hwnd", $hWnd, "hwnd", $hCDC, "int", 0)
    _WinAPI_BitBlt($hCDC, 0, 0, $iWidth, $iHeight, $hDDC, $iLeft, $iTop, 0x00CC0020)

    _WinAPI_ReleaseDC($hWnd, $hDDC)
    _WinAPI_DeleteDC($hCDC)

    _ScreenCapture_SaveImage(@ScriptDir&"\windowArea.jpg", $hBMP)
    _WinAPI_DeleteObject($hBMP)

    Return $hBMP
EndFunc   ;==>_WinCaptureArea