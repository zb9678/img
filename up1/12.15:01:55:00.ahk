#Requires AutoHotkey v2
#notrayicon
#SingleInstance Force
;#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

#Include %A_ScriptDir%\ControlColor.ahk
#Include %A_ScriptDir%\ColorButton.ahk
Gui +hWndhMainWnd
Gui Font, s9, Segoe UI
Gui Color, 0x04304E
;Gui Add, Text, hWndhTxt x102 y49 w132 h71 +0x200, 选择要启动的软件
;ControlColor(hTxt, hMainWnd, 0xFF8080, 0x800040)

Gui Add, Button, gdd x29 y177 w80 h23, geek
; 计算y坐标
yPos := A_ScreenHeight - 640  

; 显示窗口，设置宽度、高度和位置
Gui Show (w340 h260 x698 y%yPos% 选择要启动的软件)  
Return

dd:
run "D:\3\AdobePhotoshop_CC_2019_20.0.10.28848_Green\Photoshop.exe"
ExitApp 7  ; 设置返回码为 7
Return


GuiEscape:
GuiClose:
    ExitApp
