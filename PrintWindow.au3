#include-once
#include <ScreenCapture.au3>

;~ Local $val1 = 0 ;จุดเริ่มตำแหน่งภาพ แกน X 
;~ Local $val2 = 0 ;จุดเริ่มตำแหน่งภาพ แกน Y
;~ Local $val3 = 100 ;ขนาดภาพที่ cap แกน X
;~ Local $val4 = 100 ;ขนาดภาพที่ cap แกน Y
;~ Local $val5 = 560 ;ตำแหน่งแกน X ภาพที่ cap จากขนาดของ windown
;~ Local $val6 = 300 ;ตำแหน่งแกน Y ภาพที่ cap จากขนาดของ windown
;~ Local $arry[4] = [560,300,100,100]
;~ _WinCaptureAreaPosition($WinHandle,$arry[0],$arry[1],$arry[2],$arry[3])

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

    Return $hBMP
EndFunc   ;==>_WinCaptureArea

; #FUNCTION# ====================================================================================================================
; Name ..........: _WinCaptureAreaPosition
; Description ...: Windown Capture Position hidden active dont work for minimize.
; Syntax ........: _WinCaptureAreaPosition($WinHandle [,$winX = -1 [,$winY = -1 [,$imgX = -1 [, $imgY = -1]]]]])
; Parameters ....: $WinHandle        -  The WinHandle to matching picture.
;				   $winX             -  Start point for Window Width
;                  $winY             -  Start point for Window Height
;                  $imgX             -  Image cap size X
;                  $imgY             -  Image cap size Y
; Author ........: Linlijian
; Modified ......: Linlijian
; ===============================================================================================================================
Func _WinCaptureAreaPosition($hWnd, $winX = -1, $winY = -1, $imgX = -1, $imgY = -1)
    Local $hDDC, $hCDC, $hBMP

    If $winX = -1 Then $winX = _WinAPI_GetWindowWidth($hWnd)
    If $winY = -1 Then $winY = _WinAPI_GetWindowHeight($hWnd)
    If $imgX = -1 Then $imgX = 0
    If $imgY = -1 Then $imgY = 0
    If $winX < $imgX Then $imgX = 0
    If $winY < $imgY Then $imgY = 0

    $hDDC = _WinAPI_GetDC($hWnd)
    $hCDC = _WinAPI_CreateCompatibleDC($hDDC)
    $hBMP = _WinAPI_CreateCompatibleBitmap($hDDC, $imgX, $imgY)
    _WinAPI_SelectObject($hCDC, $hBMP)

    DllCall("User32.dll", "int", "PrintWindow", "hwnd", $hWnd, "hwnd", $hCDC, "int", 0)
    _WinAPI_BitBlt($hCDC, 0, 0, $imgX, $imgY, $hDDC, $winX, $winY, 0x00CC0020)

    _WinAPI_ReleaseDC($hWnd, $hDDC)
    _WinAPI_DeleteDC($hCDC)

    ;~ _ScreenCapture_SaveImage(@ScriptDir&"\winCaptureAreaPosition.jpg", $hBMP)
    ;~ _WinAPI_DeleteObject($hBMP)

    Return $hBMP
EndFunc   ;==>_WinCaptureAreaPosition