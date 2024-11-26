
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ

#Requires AutoHotkey v1.1.36                             ; -----------------------------------V1版本
Menu, Tray, Icon, D:\ahk1.0\Lib\0\Library.ico       ;--------------------------------- 脚本图标
Menu , tray , tip , Ahk1.1                                       ;---------------------------- 鼠标悬浮提示
#NoEnv                                                                 ;--------------------------------- 改善性能
#SingleInstance Force        　                               ;------只允许单个该脚本运行,脚本强制替换
SendMode Input             ;-------Send,SendRaw,Click,MouseMove/Click/Drag到SendInput
#WinActivateForce                                               ;-------------------- 用强制的方法激活窗口
#Persistent                      ;----------- 使非热键类的脚本持久运行 直到用户关闭或遇到 ExitApp
#ClipboardTimeout -1                         ;首次访问剪贴板失败后脚本继续访问剪贴板的持续时间
                                        ; -1 表示持续访问剪贴板. 0 只访问1次. 无 使用 1000 ms 的超时时间
SetWorkingDir, %A_ScriptDir%                            ;----------- 脚本所在的文件夹作为工作目录
SetTitleMatchMode fast
SetBatchLines, -1                                               ; 脚本快速执行,减少 CPU 占用,  使用10ms -1
Process,priority, , high                                         ;------------------------脚本进程优先级为高
;#HotkeyModifierTimeout 0  ;影响热键修饰符的行为：^!#+。设为 0 时则总是超时 (修饰键总是不会被推回到按下的状态).
;DetectHiddenWindows, On
;SetTitleMatchMode, 2     ; 2 窗口标题部分匹配. 3 要求标题必须准确匹配
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ

#include *i %A_ScriptDir%\Lib\ImagePut.ahk%A_TrayMenu%.ahk
#Include *i %A_ScriptDir%\Lib\ImagePut.ahk
#Include *i %A_ScriptDir%\Lib\BTT.ahk
#Include *i %A_ScriptDir%\Lib\Gdip_All.ahk
#Include *i %A_ScriptDir%\Lib\NonNull.ahk
#Include *i %A_ScriptDir%\Lib\TrayIcon.ahk
#Include *i %A_ScriptDir%\Lib\StdOutToVar.ahk
#Include *i %A_ScriptDir%\Lib\ahk777.ahk
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ

;🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫    基本   设置   🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫

#SingleInstance Off
;MsgBox, 4096,, % A_Now
return
OnlyOne(flag="") {
  static init:=OnlyOne("001")
  DetectHiddenWindows, % (bak:=A_DetectHiddenWindows) ? "On":"On"
  mypid:=DllCall("GetCurrentProcessId")
  flag:="Ahk_OnlyOne_Ahk<<" . flag . ">>"
  Gui, Ahk_OnlyOne_Ahk: Show, Hide, %flag%
  WinGet, list, List, %flag% ahk_class AutoHotkeyGUI
  Loop, % list
  IfWinExist, % "ahk_id " . list%A_Index%
  {
    WinGet, pid, PID
    IfEqual, pid, %mypid%, Continue
    WinClose, ahk_pid %pid% ahk_class AutoHotkey,, 3
    IfWinNotExist,,, Continue
    Process, Close, %pid%
    WinWaitClose
  }
  WinGet, list, List, %flag% ahk_class AutoHotkeyGUI
  IfNotEqual, list, 1, ExitApp
  DetectHiddenWindows, %bak%
}

;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   限制单进程运行   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ

;🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫    基本   设置   🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫
;🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁    复制   粘贴   🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁

global MyClipData
global page
*>!q:: 批量复制粘贴工具()
	#IfWinExist, 批量复制粘贴工具 ahk_class AutoHotkeyGUI
$^c::
	Clipboard:=""
	Send ^c{Ctrl Up}
	ClipWait, 3
	s:=Clipboard
	if (s="")
	ToolTip,
else
	批量复制粘贴工具(s)
	return
1::
	nume:=1
	Gosub copytt(nume)
	return
2::
	nume:=2
	Gosub copytt(nume)
	return
3::
	nume:=3
	Gosub copytt(nume)
	return
4::
	nume:=4
	Gosub copytt(nume)
	return
5::
	nume:=5
	Gosub copytt(nume)
	return
6::
	nume:=6
	Gosub copytt(nume)
	return
7::
	nume:=7
	Gosub copytt(nume)
	return
8::
	nume:=8
	Gosub copytt(nume)
	return
9::
	nume:=9
	Gosub copytt(nume)
	return
copytt(nume):
{
	i:=nume
	Clipboard:=MyClipData[i:=(page-1)*10+i]
	Send ^v
	return
}
0::
nume1:=0
Gosub copytt(nume1)
return

copytt(nume1):
{
	i:=nume1
	Clipboard:=MyClipData[i:=(page-1)*10+10+i]
	Send ^v
	return
}
#IfWinExist
;-------- 下面是函数 --------
批量复制粘贴工具(s:="", Cmd:="")
{
static
  	if (Cmd="Move")
{
	if (A_GuiControl="")
	SendMessage, 0xA1, 2
	return
}
else if (Cmd="Click")
{
    	i:=SubStr(A_GuiControl, 3)
    	if (i>=1 and i<=10)
{
      	s:=MyClipData[i:=(page-1)*10+i]
      	if (s="")
        	return
      	if (!clear)
{
       	; Gui, MyClip: Hide
        	; Gui, MyClip: Show, NA
        	Clipboard:=s
        	Send ^v
        	Sleep, 200
        	return
}
      	MyClipData.RemoveAt(i)
      	if (MyClipData.length()<(page-1)*10+1)
        	page--
}
else if (i=11 and page>1)
	page--
else if (i=13 and MyClipData.length()>page*10)
	page++
else if (i=12)
      	clear:=!clear
}
else if (Cmd="" and s!="")
{
    	MyClipData.InsertAt(1,s), page:=1, clear:=0
}
 	 if !IsObject(MyClipData)
{
    MyClipData:=[], page:=1, clear:=0
    Run:=Func(A_ThisFunc).Bind("","Click")
    Gui, MyClip: Destroy
    Gui, MyClip: +AlwaysOnTop +ToolWindow +E0x08000000
    Gui, MyClip: Margin, 10, 10
    Gui, MyClip: Color, f39bdc8
    Gui, MyClip: Font, s11,c364f6b
    Loop, 13
    {
      i:=A_Index, v:=(i=11 ? "<<" : i=13 ? ">>" : "")
      j:=(i=1 ? "w250 Left" : i=11 ? "xm w75"
        : i=12 ? "x+0 w100" : i=13 ? "x+0 w75" : "y+0 wp Left")
      Gui, MyClip: Add, Button, %j% vbt%i% Hwndid -Wrap, %v%
      GuiControl, MyClip: +g, %id%, % Run
    }
    Gui, MyClip: Show, NA, %A_ThisFunc%
    OnMessage(0x201, Func(A_ThisFunc).Bind("","Move"))
    v:=Func(A_ThisFunc).Bind("","")
    Menu, Tray, Add
    Menu, Tray, Add, %A_ThisFunc%, %v%
    Menu, Tray, Default, %A_ThisFunc%
    Menu, Tray, Click, 1
  }
  Loop, 10
  {    Menu, Tray, Click, 1

    i:=A_Index, v:=MyClipData[(page-1)*10+i]
    v:=(v="" ? v : "[" StrLen(v) "] " SubStr(v,1,50))
    v:=RegExReplace(v, "s+", " ")
    GuiControl, MyClip: , bt%i%, %v%
  }
  GuiControl, MyClip: , bt12, % clear ? "点选条目":"+删除条目+"
  Gui, MyClip: Show, NA
}
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ art+q 批量复制粘贴   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 04-249

#Persistent
	Copy(clipboardID) 
{
	global ; All variables are global by default
	local oldClipboard := ClipboardAll ; Save the (real) clipboard

	Clipboard := "" ; Erase the clipboard first, or else ClipWait does nothing
	SendInput {Ctrl Down}c{Ctrl Up}
	ClipWait, 2, 1 ; Wait 1s until the clipboard contains any kind of data
if ErrorLevel 
{
	Clipboard := oldClipboard ; Restore old (real) clipboard
	return
}
	ClipboardData%clipboardID% := Clipboard
	Clipboard := oldClipboard ; Restore old (real) clipboard
}
Cut(clipboardID) 
{
	global ; All variables are global by default
	local oldClipboard := ClipboardAll ; Save the (real) clipboard
	Clipboard := "" ; Erase the clipboard first, or else ClipWait does nothing
	SendInput {Ctrl Down}x{Ctrl Up}
	ClipWait, 2, 1 ; Wait 1s until the clipboard contains any kind of data
if ErrorLevel 
{
	Clipboard := oldClipboard ; Restore old (real) clipboard
	return
}
	ClipboardData%clipboardID% := Clipboard
	Clipboard := oldClipboard ; Restore old (real) clipboard
}
Paste(clipboardID) 
{
	global
	local oldClipboard := ClipboardAll ; Save the (real) clipboard
	Clipboard := "" ; Erase the clipboard first, or else ClipWait does nothing
	Clipboard := ClipboardData%clipboardID%
	ClipWait, 2, 1 ; Wait 1s until the clipboard contains any kind of data
	SendRaw, % Clipboard ; Was having an issue with ^v
	Clipboard := oldClipboard ; Restore old (real) clipboard
}
	return
;---------------------------------------------------------------------------   copy
 >!2::Copy(1)
 >!3::Copy(2)
 >!4::Copy(3)
 >!5::Copy(4)
 >!s::Copy(5)
 >!d::Copy(6)
 >!f::Copy(7)
 ;---------------------------------------------------------------------------   paste
 >!w::Paste(1)
 >!e::Paste(2)
 >!r::Paste(3)
 >!t::Paste(4)
 >!x::Paste(5)
 >!c::Paste(6)
 >!v::Paste(7)
;-----------------------------------------------------------------------------   cut
 >!g::Cut(1)
 >!h::Cut(2)
 >!j::Cut(3)
 >!k::Cut(4)
;---------------------------------------------------------------------------   paste
 >!b::Paste(1)                                 ;-------------->! g 剪切    >! b 粘贴
 >!n::Paste(2)
 >!m::Paste(3)
 >!,::Paste(4)
;-----------------------------------------------------------------------------------
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ >! 2345sdf复制  wertxcv 粘贴  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 05-322

 >^c::                                              
	clipboard :=GetFilename(GetPath())   ;---------获取带后缀名的文件名
	sleep,1000
	send, {f2}^c                    ;---------------------再一次获取无后缀文件名
	return
;-----------剪贴板中现在有２个文件名，有后缀和无后缀
 >^x::                                                
	clipboard :=GetPath()         ;----------------------------------获取路径
	return

GetFolder(txt)
{
	SplitPath, txt,, o
	return o
}
GetFilename(txt)
{
	SplitPath, txt, o
	return o
}
;在当前资源管理器窗口中，获取选中文件路径
GetPath(hwnd="")
{
	ComObjError(false)
WinGet, process, processName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")
        	WinGetClass class, ahk_id %hwnd%
        	if (process != "explorer.exe")
	return
        	if (class ~= "Progman|WorkerW") {
ControlGet, files, List, Selected Col1, SysListView321, ahk_class %class%
	Loop, Parse, files, `n, `r
	ToReturn .= A_Desktop "\" A_LoopField "`n"
}
        	else if (class ~= "(Cabinet|Explore)WClass")
{
	for window in ComObjCreate("Shell.Application").Windows
{
	if (window.hwnd==hwnd)
	sel := window.Document.SelectedItems
}
	for item in sel
	ToReturn .= item.path "`n"
}
        	return Trim(ToReturn,"`n")
}
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  >^c 复制文件名 >^x 获取路径  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 06-369

 >^v::
	send, {F2}
	sleep, 200
	send, {ctrl down}v{ctrl up}{enter}
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  >^v 对文件夹文件粘贴文件名  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 07-376

;🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁    复制   操作   🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁
;🎆🎆🎆🎆🎆🎆🎆🎆🎆🎆    截图   操作   🎆🎆🎆🎆🎆🎆🎆🎆🎆🎆🎆

;ImagePutFile(Image)             ; 将图片存为文件
;ImagePutClipboard(Image)   ; 将图片存入剪贴板
;ImagePutWindow(Image)     ; 将图片显示出来
;ImageShow(Image)               ; 将图片显示出来（无标题栏）
;ImagePutDesktop(Image)     ; 将图片放在桌面壁纸前、桌面图标后的位置

Appskey & 1::
Run, nircmd  savescreenshot "C:\oneD\OneDrive\desktop\~$currdate.yyyyMMdd$-~$currtime.HHmmss$.png"  
return                                                                   ;-----------------------截全屏
;ImagePutClipboard(ImagePutFile("A", "C:\oneD\OneDrive\desktop\"))        ;-- 只截窗口 存剪
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ Appskey & 1  全屏截存桌面选格式   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 001-392

Appskey & 6::
Imageshow("a")                                                                      ;------------------截图并贴图
ImagePutFile(Image)                                           ;----------- 将图片存入剪贴板
ImagePutClipboard(ImagePutFile("A", "C:\oneD\OneDrive\desktop"))     ; 存desktop
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ Appskey & 6 当前窗口 截图并贴图   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 002-399

Appskey & 2::
	Run "D:\ahk1.0\Lib\0 tool\窗口隐藏工具\窗口隐藏工具.exe"
	Run c:\3\4\Gif123.exe
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  Appskey & 2  录屏gif    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 003-405

Appskey & 3::
	Run "D:\ahk1.0\Lib\0 tool\窗口隐藏工具\窗口隐藏工具.exe"
	Run c:\3\9ZDSoftScnRec\ScnRecPortable.exe
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  Appskey & 3 录屏MP4    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 004-411
Appskey & 4::
file := ImagePutFile(clip, "C:\Users\z\Desktop\" )
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞ  Appskey & 4  剪贴板中截图保存于desktop  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 005-415

#SingleInstance force
isRunning := false                                                ;---- 用于跟踪脚本是否在运行
timerRunning := false                                          ;-- 用于跟踪定时器是否在运行
+Esc::  
Run, c:\3\9 FSCapture97\FSCapture.exe , , min
        	Sleep, 800
        	SendInput, !+z                                       
       	isRunning := true 
return
/*
+Esc::                                             
    	Process, Exist, FSCapture.exe                  ; --------检查程序是否在运行
    	if (ErrorLevel) 
{
        	Process, Close, FSCapture.exe                ;---- 如果程序在运行则关闭它
        	isRunning := false                                   ;----------- 更新状态为未运行
        	SetTimer, AutoCloseFSCapture, Off       ;------------------ 关闭定时器
        	timerRunning := false                             ;------------- 更新定时器状态
}
else 
{
Run, c:\3\9 FSCapture97\FSCapture.exe , , min   ;---- 如果程序没运行则启动它
        	Sleep, 30
	click                                                　　  ;------------- 这个点击动作可以在截图时不显示输入法指示
        	Sleep, 1200
        	SendInput, !+z                                        ;--------------截图快捷键 !+z
       	isRunning := true                                    ;-------- 更新状态为正在运行

        	if (!timerRunning)                                   ;----------- 如果定时器未运行
       {                                          
            	SetTimer, AutoCloseFSCapture, -3000000  ; --------------------------设置一个50分钟的单次定时器
            	timerRunning := true                               ;--- 更新定时器状态为运行中
       }
}
return
;----------------------------------------------------------------------------定时器
AutoCloseFSCapture:
    	Process, Close, FSCapture.exe                ;----------- 自动关闭截图软件
    	isRunning := false                                   ;----------- 更新状态为未运行
    	timerRunning := false                             ;---- 更新定时器状态为未运行
	return
*/
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  !+z::   FSCapture.exe     ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 006-452

#SingleInstance force
isRunning := false                                                ;---- 用于跟踪脚本是否在运行
timerRunning := false                                          ;-- 用于跟踪定时器是否在运行

F5 & n::                                             
    	Process, Exist, Umi-OCR.exe                   ; --------检查程序是否在运行
    	if (ErrorLevel) 
{
        	Process, Close, Umi-OCR.exe                 ;---- 如果程序在运行则关闭它
        	isRunning := false                                  ;----------- 更新状态为未运行
        	SetTimer, AutoCloseUmi-OCR, Off        ;------------------ 关闭定时器
        	timerRunning := false                            ;------------- 更新定时器状态
}
else 
{
        	Run, "D:\ahk1.0\Lib\0 tool\Umi-OCR\Umi-OCR.exe"
        	Sleep, 1700
        	Send, +^!z                                             ;-------------截图快捷键 +^!z  
       	isRunning := true                                   ;--------  更新状态为正在运行

        	if (!timerRunning)                                   ;----------- 如果定时器未运行
       {                                          
            	SetTimer, AutoCloseUmi-OCR, -11000  ; --------------------------设置一个11秒的单次定时器
            	timerRunning := true                             ;---- 更新定时器状态为运行中
       }
}
return
;----------------------------------------------------------------------------定时器
AutoCloseUmi-OCR:
    	Process, Close, Umi-OCR.exe                ;------------自动关闭截图软件
    	isRunning := false                                  ;----------- 更新状态为未运行
    	timerRunning := false                            ;---- 更新定时器状态为未运行
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F5 & n  Umi-OCR.exe    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 007-487

Appskey & 5::                                ;---- 后台截图　4000 为间隔4秒  共运行3 次 
run, nircmd  loop 30000 2000 savescreenshot "C:\Users\z\Desktop\aa\~$currtime.HHmm_ss$ ~$loopcount$.png"
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ Appskey & 5  后台间隔截图 全屏  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 008-492

;  shift+alt+a      框选画中画       Mouselnc
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ shift+alt+a  框选画中画   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 009-495

;  win+Esc     ahk777 替换 win+shift+Esc    框选OCR         Mouselnc　
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ win+Esc  框选OCR   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 010-498

; shift+alt+S  截图存剪
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  shift+alt+S  截图存剪   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 010-499

$+#s::                                        ;-------------------系统自带加了一个保存在桌面
	clipboard =
	clipboard = clipboardALL
	Send, {PrintScreen}
sleep,5000
	file := ImagePutFile(clip, "C:\oneD\OneDrive\desktop\" )
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  +#s  截图  剪贴板 desktop   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 011-507

<!esc::                                      ;------------------------------------ OCR 或截图
    	send, !j                        ;----------------------------------暂时关闭 VPN
Click, 1400,170                        ;---------------------------防止截图时显示光标等
    	run "D:\ahk1.0\Lib\0 tool\SGScreencapture\screencapture.exe"
    	SetTimer, ReEnableVPN, -14000            ;----------------------------- 设置一个14秒的单次定时器
	return

	ReEnableVPN:
    	send, !u                       ;---------------------------------- 重新启用 VPN
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ <!esc  截图 OCR  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 012-518

;#SingleInstance Force
;#NoEnv
displayNum := 0
visibleState := true

F9 & 9::
	pasteToScreen(){
	if DllCall("IsClipboardFormatAvailable", "UInt", 1)
	displayText(Clipboard)
	If DllCall("IsClipboardFormatAvailable", "UInt", 2)
{
	if DllCall("OpenClipboard", "uint", 0) 
{
	hBitmap := DllCall("GetClipboardData", "uint", 2)
	DllCall("CloseClipboard")
}
	displayImg(hBitmap)
}
	if DllCall("IsClipboardFormatAvailable", "UInt", 15){
	imgFile := Clipboard
	if(hBitmap := LoadPicture(imgFile))
	displayImg(hBitmap)
}
}
	displayText(text)
{
	global
Gui, New, +hwndpasteText%displayNum% -Caption +AlwaysOnTop +ToolWindow -DPIScale
	local textHnd := pasteText%displayNum%
	Gui, Margin, 10, 10
	Gui, Font, s16
	Gui, Add, Text,, % text
	OnMessage(0x201, "move_Win")
	OnMessage(0x203, "close_Win")
	Gui, Show,, pasteToScreen_text
	transparency%textHnd% := 100
	displayNum++
}
	displayImg(hBitmap)
{
	global
Gui, New, +hwndpasteImg%displayNum% -Caption +AlwaysOnTop +ToolWindow -DPIScale
	local imgHnd := pasteImg%displayNum%
	Gui, Margin, 0, 0
	Gui, Add, Picture, Hwndimg%imgHnd%, % "HBITMAP:*" hBitmap
	OnMessage(0x201, "move_Win")
	OnMessage(0x203, "close_Win")
	Gui, Show,, pasteToScreen_img
	local img := img%imgHnd%
ControlGetPos,,, width%imgHnd%, height%imgHnd%,, ahk_id %img%
	scale%imgHnd% := 100
	transparency%imgHnd% := 100
	displayNum++
}
	move_Win()
{
	PostMessage, 0xA1, 2
}
	close_Win()
{
	id := WinExist("A")
	transparency%id% := ""
	scale%id% := ""
	width%id% := ""
	height%id% := ""
	Gui, Destroy
}
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F9+9 贴图   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 013-588
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    Shift+鼠标滚动   改变粘贴的透明度   ΞΞΞΞΞΞΞΞΞΞ 014-588
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    鼠标滚轮改变贴图大小 双击关闭   ΞΞΞΞΞΞΞΞΞΞΞΞΞ015-588

F9 & 0::
	toggleVisibleState()
{
	global visibleState
	if(visibleState){
	WinGet, id, List, pasteToScreen
	Loop, %id%
{
	this_id := id%A_Index%
	WinHide, ahk_id %this_id%
}
	visibleState := false
} 
	else 
{
	DetectHiddenWindows, On
	WinGet, id, List, pasteToScreen
	Loop, %id%
{
	this_id := id%A_Index%
	WinShow, ahk_id %this_id%
}
	DetectHiddenWindows, Off
	visibleState := true
}
}
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F9+0 隐藏或显示所有粘贴    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 016-619

F9 & -::
	destroyAllPaste()
{
	WinGet, id, List, pasteToScreen
	Loop, %id%
{
	this_id := id%A_Index%
	SendMessage, 0x203,,,, ahk_id %this_id%
}
}
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F9+- 关闭贴图    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 017-632

F9 & =::
	FileSelectFile, imgFile, 3, C:\oneD\OneDrive\desktop\
	hBitmap := LoadPicture(imgFile)
	displayImg(hBitmap)
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F9+= 打开图并设置为贴图   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 018-639

F9 & 8::
	Imageshow({image: %clipboardAll%, scale: ["auto", 600]})  ;长自动，宽600
	;Imageshow({image: %clipboardAll%, scale: 2.25})   ; 放大到2.25倍
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F9 & 8 剪贴板贴图 放大到1.25倍   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 019-645

;🎆🎆🎆🎆🎆🎆🎆🎆🎆🎆    截图   操作   🎆🎆🎆🎆🎆🎆🎆🎆🎆🎆🎆
;🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟    显隐   操作   🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟🎟

F1 & y::
send,<!{Enter}
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F1 & y 右键属性    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0001-653

F5 & 1::
	HideShowTaskbar()
{
   	static SW_HIDE := 0, SW_SHOWNA := 8, SPI_SETWORKAREA := 0x2F
   	DetectHiddenWindows, On
   	hTB := WinExist("ahk_class Shell_TrayWnd")
   	WinGetPos,,,, H
hBT := WinExist("ahk_class Button ahk_exe Explorer.EXE")  ; for Windows 7
   	b := DllCall("IsWindowVisible", "Ptr", hTB)
   	for k, v in [hTB, hBT]
( v && DllCall("ShowWindow", "Ptr", v, "Int", b ? SW_HIDE : SW_SHOWNA) )
   	VarSetCapacity(RECT, 16, 0)
   	NumPut(A_ScreenWidth, RECT, 8)
   	NumPut(A_ScreenHeight - !b*H, RECT, 12, "UInt")
DllCall("SystemParametersInfo", "UInt", SPI_SETWORKAREA, "UInt", 0, "Ptr", &RECT, "UInt", 0)
   	WinGet, List, List
	Loop % List
{
	WinGet, res, MinMax, % "ahk_id" . List%A_Index%
	if (res = 1)
WinMove, % "ahk_id" . List%A_Index%,, 0, 0, A_ScreenWidth, A_ScreenHeight - !b*H
}
}
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F5 & 1  隐藏任务栏   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0002-679

F5 & 2::
	ControlGet, q, Hwnd,, SysListView321, ahk_class Progman
If q =
	ControlGet, q, Hwnd,, SysListView321, ahk_class WorkerW
If DllCall("IsWindowVisible", UInt, q)
	WinHide, ahk_id %q%
Else
	WinShow, ahk_id %q%
Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F5 & 2  隐藏桌面图标   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0003-690

toggle := false           ; ---------------------定义一个变量来跟踪状态

F5 & 3::
if (toggle)             ;检查当前状态，如果为 true，则显示；如果为 false，则隐藏。
{
        	run, nircmd.exe win show class progman                    ; 显示桌面图标
} 
	else 
{
        	run, nircmd.exe win hide class progman                      ; 隐藏桌面图标
}

toggle := !toggle              ;---切换状态使得下次按下 F5.. 时能够执行相反的操作。
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F5 & 3  隐.显桌面   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0004-706

F5 & =::          ;;显示文件
RegRead,value,HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, Hidden
	If(value=1)
	value = 2
	Else
	value = 1
RegWrite, REG_DWORD, HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, Hidden, %Value%
RegWrite, REG_DWORD, HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, ShowSuperHidden, %Value%-1
	PostMessage,0x111,0x7103,0,SHELLDLL_DefView1,A
	return

F5 & -::           ;;显示文件扩展名
RegRead,Value,HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\,HideFileExt
	If(value=0)
	value = 1
	Else
	value = 0
RegWrite, REG_DWORD,HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\,HideFileExt, %Value%
	PostMessage,0x111,0x7103,0,SHELLDLL_DefView1,A
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F5 & - 显示扩展名 F5 & = 显隐文件   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0005-728

F5 & 4::
; 设置注册表路径和值名称
regPath := "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
valueName := "IconsOnly"

; 读取当前的 IconsOnly 值
RegRead, currentValue, %regPath%, %valueName%

; 如果读取失败（值不存在），则将值初始化为 0
if (ErrorLevel)
    currentValue := 0

; 切换值：如果当前值是 0 则设置为 1，否则设置为 0
newValue := (currentValue = 0) ? 1 : 0

; 写入新值到注册表
RegWrite, REG_DWORD, %regPath%, %valueName%, %newValue%

 ; 刷新资源管理器以应用更改
;send, ^r
; 使用 COM 对象刷新桌面和文件资源管理器窗口
for window in ComObjCreate("Shell.Application").Windows
{
    if (window.FullName != "")  ; 检查是否是有效的资源管理器窗口
        window.Refresh()
}
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F5 & 4  缩略图   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0006-757

F5 & 5::
Send, <!p
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ F5 & 5 显示预览窗格  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0007-762

F5 & 6::
	WinGetActiveTitle, Title
	Title := StrReplace(Title, "Ξ置顶 Ξ")
	ID := WinExist("A")
	WinGet, ExStyle, ExStyle, ahk_id %ID%
	If (ExStyle & 0x8)
{
	WinSet,TopMost,,A
	WinSetTitle, , ,Ξ OFF Ξ
 	SoundPlay, D:\ahk1.0\Lib\0\y2253.mp3
}
	Else
{
	WinSet,TopMost,,A
	WinSetTitle, , ,Ξ 置顶 Ξ
   	SoundPlay, D:\ahk1.0\Lib\0\2.mp3
}
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F5 & 6  窗口置顶    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0008-782

;🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁    显隐   操作   🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁🍁
;🎆🎆🎆🎆🎆🎆🎆🎆🎆🎆    打开   操作   🎆🎆🎆🎆🎆🎆🎆🎆🎆🎆🎆

F5 & e::
clipboard := ""
    Send {ctrl down}c{ctrl up}
Run, D:\ahk1.0\Lib\0\0000000                 AutoHotkey.chm
sleep, 600
SendInput {alt down}s{alt up}
sleep, 50
SendInput {ctrl down}v{ctrl up}{Enter}
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F5 & e  帮助文档    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00001-796

F5 & 9::
	Imageshow("D:\ahk1.0\1\1.png")
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F5 & 9  快捷键目录   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00002-801

F5 & 0::
	Imageshow("D:\ahk1.0\1\2.png")
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F5 & 0  快捷键目录   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00003-806
 
F1 & k::
{
; 保存当前剪贴板内容
   	clipboardBackup := ClipboardAll
	Clipboard := ""  ; 清空剪贴板
; 复制选中的快捷方式路径
    	Send, ^c
    	ClipWait, 1
if ErrorLevel 
{
        	MsgBox, 未能复制到剪贴板。
        	Clipboard := clipboardBackup  ; 还原剪贴板内容
        	return
}
; 获取快捷方式的目标路径
    	FileGetShortcut, %Clipboard%, shortcutPath
if (shortcutPath != "") {
; 使用资源管理器打开并选中目标文件
        	Run, explorer.exe /select`, %shortcutPath%
;select`：是用于资源管理器中打开包含指定文件的文件夹并选中该文件的参数。
;  , :         逗号用于分隔命令和参数。在这里，它将 select 命令与后面的参数分开。
} 
	else 
{
        	MsgBox, 当前剪贴板内容不是有效的快捷方式。
}
	; 还原剪贴板内容
    	Clipboard := clipboardBackup
    	return
}
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F1 & k 打开快捷方式的文件夹    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00004-838

^+z:: 
	WinGet, processID, PID, A                      ;--获取当前活动窗口的进程ID
WinGet, exePath, ProcessPath, ahk_pid %processID%    ; 获取可执行文件路径 
	SplitPath, exePath, , fileDir            ; 提取文件夹路径
	Run, %fileDir%            ; 打开文件夹
 	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  ^+z 打开当前活动窗口的文件夹   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00005-846



#SingleInstance force                                                          ; 强制加载新的脚本
isRunning := false                  ; 状态变量: isRunning 用于跟踪脚本是否正在运行
Rctrl & 5::
    Process, Exist, v2rayN.exe                                      ; 检查程序是否已经在运行
    if (ErrorLevel)                 ;根据 ErrorLevel 的值来决定是关闭程序还是启动程序
    {
                                                                            ; 如果程序正在运行，则关闭它
        Process, Close, v2rayN.exe
        isRunning := false                                                        ; 更新状态为未运行
    } 
    else 
    {
                                                                        ; 如果程序没有在运行，则启动它
        Run, C:\3\v2rayN-With-Core\v2rayN.exe , , min 
        isRunning := true                                                     ; 更新状态为正在运行
    }
return

;Rctrl & 5::
if (u := !u)
	{
	Process,close,v2rayN.exe
	}
else
	{
    	Run, C:\3\v2rayN-With-Core\v2rayN.exe , , min 
keywait, 5
}
Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    Rctrl & 5 打开 v2rayN   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00007-887

Rctrl & t::
TrayIcon_Button("v2rayN.exe", "L")
sleep, 100
send, !l
return 
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    Rctrl & t 打开托盘 v2rayN   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00008-894

DetectHiddenWindows, On                                 ;------ 启用对隐藏窗口的检测
SetTitleMatchMode, 2                                         ;----------- 设置标题匹配模式

F9 & [::
	Run, "D:\ahk1.0\Lib\SnoMouse.ahk"
     Loop
{
	Sleep, 120000 ; 等待120秒
                                                                             ;----------------------------- 显示确认对话框
	MsgBox, 4,, 关闭 SnoMouse.ahk 请点是
    IfMsgBox, Yes
	{
       	WinClose, SnoMouse.ahk ahk_class AutoHotkey
	}
	break ; 退出循环                                      ;-- 如果选择“否”，则继续循环
}
	return
;-----------------------------------------------------------------------------------
F9 & ]::
       	WinClose, SnoMouse.ahk ahk_class AutoHotkey
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F1 & [ 启动 F1 & ] 退出 SnoMouse  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00009-917

#SingleInstance force      ; 强制加载新的脚本
isRunning := false         ; 状态变量: isRunning 用于跟踪脚本是否正在运行。
F5 & c::
    Process, Exist, ZoomIt64.exe       ; 检查程序是否已经在运行
    if (ErrorLevel)      ;根据 ErrorLevel 的值来决定是关闭程序还是启动程序，而不再依赖于 isRunning 状态变量。这可以避免因状态更新不及时而导致的需要按两次热键的问题。
    {
                                                                          ; 如果程序正在运行，则关闭它
        Process, Close, ZoomIt64.exe
        isRunning := false     ; 更新状态为未运行
    } 
    else 
    {
                                                                      ; 如果程序没有在运行，则启动它
        Run, D:\ahk1.0\Lib\0 tool\ZoomIt64\ZoomIt64.exe
sleep, 1000
send, ^2
        isRunning := true      ; 更新状态为正在运行
    }
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F5 & c[ 启动 / 关闭ZoomIt64.exe  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00010-938

#Persistent                     ;确保脚本常驻：保证脚本不因长时间未使用而自动退出。
Rctrl & 1::
    KeyWait, Rctrl, D  ; 确保释放 Rctrl 键后再执行操作

    ; 检查 chrome.exe 是否已存在
    IfWinNotExist, ahk_exe chrome.exe
    {
        Run "C:\Program Files\Google\Chrome\Application\chrome.exe", , max
        WinWait, ahk_exe chrome.exe, , 5  ; 最多等待 5 秒
    }
    Else IfWinNotActive, ahk_exe chrome.exe
    {
        WinActivate  ; 激活窗口
    }
    Else
    {
        ; 检查窗口是否已最小化
        IfWinExist, ahk_exe chrome.exe
        {
            WinGet, MinimizedState, MinMax, ahk_exe chrome.exe
            if (MinimizedState = -1)  ; 如果窗口已最小化
                WinRestore  ; 还原窗口
            else
                WinMinimize  ; 否则最小化窗口
        }
    }
Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  Rctrl & 1  打开 chrome  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00011-969

F5 & 8::
o=D:\ahk1.0\Lib\0 tool\EmEditor\EmEditor.exe
3=D:\ahk1.0\Lib\ahk777.ahk
4=D:\ahk1.0\Ahk1.1.ahk
2=C:\Users\z\.picgo\config.json
1=D:\ahk1.0\Lib\0 tool\picgo-croe\config.toml

Run,%o% "%1%" "%2%" "%3%" "%4%"
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F5 & 8    EmEditor 打开4文件   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00006-856

#Persistent                     ;确保脚本常驻：保证脚本不因长时间未使用而自动退出。
Rctrl & 2::
    KeyWait, Rctrl, D  ; 确保释放 Rctrl 键后再执行操作

    ; 检查 EmEditor.exe 是否已存在
    IfWinNotExist, ahk_exe EmEditor.exe
    {
        Run "C:\0　　tool\EmEditor\EmEditor.exe"
        WinWait, ahk_exe EmEditor.exe, , 5  ; 最多等待 5 秒
    }
    Else IfWinNotActive, ahk_exe EmEditor.exe
    {
        WinActivate  ; 激活窗口
    }
    Else
    {
        ; 检查窗口是否已最小化
        IfWinExist, ahk_exe EmEditor.exe
        {
            WinGet, MinimizedState, MinMax, ahk_exe EmEditor.exe
            if (MinimizedState = -1)  ; 如果窗口已最小化
                WinRestore  ; 还原窗口
            else
                WinMinimize  ; 否则最小化窗口
        }
    }
Return

;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  Rctrl & 2   打开 EmEditor  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00012-999

Rctrl & 3::
    KeyWait, Rctrl, D  ; 确保释放 Rctrl 键后再执行操作

    IfWinNotExist, ahk_class CabinetWClass
    {
        Run, "C:\Windows\explorer.exe"
        WinWait, ahk_class CabinetWClass, , 5  ; 最多等待 5 秒
        If !ErrorLevel  ; 确保窗口确实已存在
        {
            Sleep, 100  ; 短暂延时确保稳定
            WinActivate
        }
    }
    Else IfWinNotActive, ahk_class CabinetWClass
    {
        WinActivate
    }
    Else
    {
        WinMinimize
    }
Return

;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  Rctrl & 3  打开 资源处理器   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00013-1026

CoordMode, Mouse, Window
Rctrl & 4::
WeChat:="ahk_class WeChatMainWndForPC"
WeChat_path:="C:\Program Files\Tencent\WeChat\WeChat.exe" ，max

if ProcessExist("WeChat.exe")=0
{
	Run, %WeChat_path%
WinWait, ahk_class WeChatLoginWndForPC
}
else
{
	WinGet,wxhwnd,ID,%WeChat%
	if strlen(wxhwnd)=0
	{
		winshow,%WeChat%
		winactivate,%WeChat%
	}
	else
	{
		winhide,%WeChat%
	}
}
return

ProcessExist(exe){		   ;一个自定义函数,根据自定义函数的返回值作为#if成立依据原GetPID
	Process, Exist,% exe
	return ErrorLevel
}
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  Rctrl & 4  打开 微信    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00014-1062

#Persistent
Rctrl & 7::
    KeyWait, Rctrl, D  ; 确保释放 Rctrl 键后再执行操作

    ; 检查 Vs Code.exe 是否已存在
    IfWinNotExist, ahk_exe Code.exe
    {
        Run "C:\Users\z\AppData\Local\Programs\Microsoft VS Code\Code.exe"
        WinWait, ahk_exe Code.exe, , 5  ; 最多等待 5 秒
    }
    Else IfWinNotActive, ahk_exe Code.exe
    {
        WinActivate  ; 激活窗口
    }
    Else
    {
        ; 检查窗口是否已最小化
        IfWinExist, ahk_exe Code.exe
        {
            WinGet, MinimizedState, MinMax, ahk_exe Code.exe
            if (MinimizedState = -1)  ; 如果窗口已最小化
                WinRestore  ; 还原窗口
            else
                WinMinimize  ; 否则最小化窗口
        }
    }
Return

;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  Rctrl & 7 Vs Code.exe ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00015-1067


;🎆🎆🎆🎆🎆🎆🎆🎆🎆🎆    打开   操作   🎆🎆🎆🎆🎆🎆🎆🎆🎆🎆🎆
; 💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐    杂类   操作   ⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢

F5 & F4::AltTab
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ     F5 & F4  AltTab   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000001-1074

F6 & d::
	Clip(Format("{:" GetNextCaseFormat() "}", Clip()), true)
	GetNextCaseFormat()
{
   	static i := 0, Formats := ["U", "L", "T"]
   	return Formats[++i > 3 ? i := 1 : i]
}
	Clip(Text="", Reselect="")
{
	Static BackUpClip, Stored, LastClip
If (A_ThisLabel = A_ThisFunc) 
{
	If (Clipboard == LastClip)
	Clipboard := BackUpClip
	BackUpClip := LastClip := Stored := ""
} 
	Else 
{
If !Stored {
	Stored := True
	BackUpClip := ClipboardAll ; ClipboardAll must be on its own line
} 
	Else
	SetTimer, %A_ThisFunc%, Off
	LongCopy := A_TickCount, Clipboard := "", LongCopy -= A_TickCount ; LongCopy gauges the amount of time it takes to empty the clipboard which can predict how long the subsequent clipwait will need
	If (Text = "") 
{
	SendInput, ^c
	ClipWait, LongCopy ? 0.6 : 0.2, True
} 
	Else 
{
	Clipboard := LastClip := Text
	ClipWait, 10
	SendInput, ^v
}
	SetTimer, %A_ThisFunc%, -700
Sleep 20 ; Short sleep in case Clip() is followed by more keystrokes such as {Enter}
If (Text = "")
	Return LastClip := Clipboard
	Else If ReSelect and ((ReSelect = True) or (StrLen(Text) < 3000))
	SendInput, % "{Shift Down}{Left " StrLen(StrReplace(Text, "`r")) "}{Shift Up}"
}
	Return
	Clip:
	Return Clip()
}
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F6 & d 大小写 首字母大写  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000002-1124

F5 & ,::
run D:\ahk1.0\Lib\diskeys.ahk
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ F5 & ,   锁键盘鼠标  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000003-1129

~Shift & Wheelup::
; 透明度调整，增加。
WinGet, Transparent, Transparent,A
If (Transparent="")
    Transparent=255
    Transparent_New:=Transparent+15    ;透明度增加速度。
    If (Transparent_New > 254)
                    Transparent_New =255
    WinSet,Transparent,%Transparent_New%,A

    tooltip now: ▲%Transparent_New%`nmae: __%Transparent%  ;查看当前透明度（操作之后的）。
    ;sleep 1500
    SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, 1500  ;设置统一的这个格式，label在最后。
return

~Shift & WheelDown::
;透明度调整，减少。
WinGet, Transparent, Transparent,A
If (Transparent="")
    Transparent=255
    Transparent_New:=Transparent-15  ;透明度减少速度。
    ;msgbox,Transparent_New=%Transparent_New%
            If (Transparent_New < 30)    ;最小透明度限制。
                    Transparent_New = 30
    WinSet,Transparent,%Transparent_New%,A
    tooltip now: ▲%Transparent_New%`nmae: __%Transparent%  ;查看当前透明度（操作之后的）。
    ;sleep 1500
    SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, 1500  ;设置统一的这个格式，label在最后。
return
;设置shift &Mbutton直接恢复透明度到255。

shift & Mbutton::
WinGet, Transparent, Transparent,A
WinSet,Transparent,255,A
tooltip ▲Restored ;查看当前透明度（操作之后的）。
;sleep 1500
SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, 1500  ;设置统一的这个格式，label在最后。
return

removetooltip_transparent_Lwin__2016.09.20:     ;LABEL
tooltip
SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, Off
return
;---------------shift+滚轮down +10透明度
;--------------------------------shift+滚轮up -10透明度
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  shift+中键按下 复原   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000004-1176

NumpadEnter::reload
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  NumpadEnter 重启脚本 ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000005-1180

+appskey::
send {Tab}
loop,4
SoundBeep, 12000, 20
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  +appskey   Tab  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000006-1187

<^!z::
send, ^y
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  <^!z   撤消    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000007-1192

;#NoEnv
   ;SendMode Input
   ;SetWorkingDir %A_ScriptDir%
	MoveCycle(Add)
{
	static StepsInCycle = 2                        ;--------------在2种状态间切换
	static SizeCycle = 0
	SizeCycle := Mod(SizeCycle + Add, StepsInCycle)
	if (SizeCycle < 0)
	{
		SizeCycle := SizeCycle + StepsInCycle
	}
	if (Add = 111) {
		SizeCycle = 1
	}
	else if (Add = 222) {
		SizeCycle = 2
	}
	else if (Add = 333) {
		SizeCycle = 3
	}

	if (SizeCycle = 0) {
		MoveWindow(50, 50)
	}
	else if (SizeCycle = 1) {
		MoveWindow(0, 50)
	}
	else if (SizeCycle = 2) {
		MoveWindow(0, 100)
	}
	else if (SizeCycle = 3) {
		MoveWindow(15, 70)

	}
	else if (SizeCycle = 4) {
		MoveWindow(20, 80)
	}
else if (SizeCycle = 5)
	{
		MoveWindow(10, 80)
	}
}

MoveWindow(XP, WP)
{
	; Get current Window
	WinGetActiveTitle, WinTitle
	WinGetPos, X, Y, WinWidth, WinHeight, %WinTitle%

	; Get Taskbar height
	WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd

	; Calculate new position and size
	XNew := (A_ScreenWidth * XP / 100)
	WNew := (A_ScreenWidth * WP / 100)
	HNew := (A_ScreenHeight - tbH)
	TopNew := 2

	; MsgBox, %XNew% - %WNew% ; DEBUG
	WinRestore, %WinTitle%
	WinMove, %WinTitle%,, %XNew%, %TopNew%, %WNew%, %HNew%
}

<!z::
	MoveCycle(-1)
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ <!z  窗口左半，右半切换   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000008-1261

;#NoEnv
  ; SendMode Input
  ; SetWorkingDir %A_ScriptDir%
	MoveCycle2(Add)
{
	static StepsInCycle2 = 2                        ;--------------------------------------在2种状态间切换
	static SizeCycle2 = 0
	SizeCycle2 := Mod(SizeCycle2 + Add, StepsInCycle2)
	if (SizeCycle2 < 0)
	{
		SizeCycle2 := SizeCycle2 + StepsInCycle2
	}
	if (Add = 111) {
		SizeCycle2 = 1
	}
	else if (Add = 222) {
		SizeCycle2 = 2
	}
	else if (Add = 333) {
		SizeCycle2 = 3
	}

	if (SizeCycle2 = 0) {
		MoveWindow2(0, 100)
	}
	else if (SizeCycle2 = 1) {
		MoveWindow2(15, 70)
	}
	else if (SizeCycle2 = 2) {
		MoveWindow2(0, 100)
	}
	else if (SizeCycle2 = 3) {
		MoveWindow2(15, 70)

	}
	else if (SizeCycle2 = 4) {
		MoveWindow2(10, 80)
	}
else if (SizeCycle2 = 5) {
		MoveWindow2(0, 80)
	}
}

MoveWindow2(XP, WP)
{
	; Get current Window2
	WinGetActiveTitle, WinTitle
	WinGetPos, X, Y, WinWidth, WinHeight, %WinTitle%

	; Get Taskbar height
	WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd

	; Calculate new position and size
	XNew := (A_ScreenWidth * XP / 100)
	WNew := (A_ScreenWidth * WP / 100)
	HNew := (A_ScreenHeight - tbH  / 1.3)
	TopNew := 1

	; MsgBox, %XNew% - %WNew% ; DEBUG
	WinRestore, %WinTitle%
	WinMove, %WinTitle%,, %XNew%, %TopNew%, %WNew%, %HNew%
}

	<!x::
	MoveCycle2(-1)
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  < !x  切换窗口  70%·····100%    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000009-1329

if !A_IsAdmin && !RegExMatch(_:=DllCall("GetCommandLineW", "Str"), " /restart(?!\S)")
    RunWait % "*RunAs " RegExReplace(_, "^\"".*?\""\K|^\S*\K", " /restart")
F5 & 7::
send, ^c
sleep, 800
run D:\ahk1.0\Lib\二维码.ahk
sleep, 400
click 122,233
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F5 & 7  二维码  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000010-1320

!LButton::    ;-- 【Win+鼠标左键】任意移动窗口位置
#LButton::    ;-- 【Win+鼠标右键】任意调整窗口大小
Critical
CoordMode, Mouse
MouseGetPos, x1, y1, id
IfWinNotExist, ahk_id %id%
  return
WinGet, flag, MinMax    ;-- 不操作最大化的窗口
if flag=1
  return
SetWinDelay, 20
WinGetPos, x2, y2, w2, h2
While GetKeyState(SubStr(A_ThisLabel,2),"P")
{
  MouseGetPos, x3, y3
  if A_ThisLabel = !LButton
    WinMove, x3-x1+x2, y3-y1+y2
  else
    WinMove,,,,, x3-x1+w2, y3-y1+h2
}
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  !+左键 移窗口 #+左键 调窗口大小   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000011-1363

    ; Windows messages to monitor
    msg_WM_WTSSESSION_CHANGE = 0x2b1
    msg_WM_POWERBROADCAST    = 0x218

    ; Registry key and value to store the state of the mouse buttons
    reg_KeyName = HKEY_CURRENT_USER\SessionInformation
    reg_ValueName = LeftHandedMouse

    ; Set taskbar tray icon
    Menu, Tray, Icon, shell32.dll, 44 ; Gold star icon
    Menu, Tray, Tip, Swap Mouse Buttons

    ; Initialize
    ; Create an invisile window which is registered to receive WTSRegisterSessionNotification notifications (for lock and unlock messages)
    ; and RegisterPowerSettingNotification notifications (for suspend and wake-up messages)
    Gui,+LastFound
    hwnd:=WinExist()

    ; Register the window for WTSRegisterSessionNotification notifications in order to receive the WM_WTSSESSION_CHANGE messages
    DllCall("Wtsapi32.dll\WTSRegisterSessionNotification","UInt",hwnd,"UInt",0)

    ; Register the window for RegisterPowerSettingNotification notification in order to receive the WM_POWERBROADCAST messages
    ; hHandle is set to the hidden window
    ; PowerSettingGuid is set to GUID_SYSTEM_AWAYMODE
    ; Flags is 0 (DEVICE_NOTIFY_WINDOW_HANDLE) to register for notifications sent using WM_POWERBROADCAST messages
    DllCall("User32.dll\RegisterPowerSettingNotification",hwnd,"98a7f580-01f7-48aa-9c0f-44352c29e5C0",0)

    ; Register function to recieive the WM_WTSSESSION_CHANGE messages
    OnMessage(msg_WM_WTSSESSION_CHANGE,"f_WM_Monitor")

    ; Register functino to receive the WM_POWERBROADCAST messages
    OnMessage(msg_WM_POWERBROADCAST,"f_WM_Monitor")

    ; Set the mouse to the last known state
    RegRead, buttonState, %reg_KeyName%, %reg_ValueName%
    if (ErrorLevel) ; Reistry value not found
    {
        buttonState := DllCall("user32.dll\SwapMouseButton", "UInt", 1) ; Set left-handed mouse
        if buttonState <> 0 ; If the result is non-zero, the mouse was set to left-handed before the above DLL call
        {
            buttonState := 1
        }
        RegWrite, REG_DWORD, %reg_KeyName%, %reg_ValueName%, %buttonState%
    }
    tmpInt := DllCall("user32.dll\SwapMouseButton", "UInt", buttonState)

Return

F5 & .::
    buttonState := DllCall("user32.dll\SwapMouseButton", "UInt", 1) ; Set left-handed mouse
    if buttonState <> 0 ; If the result is non-zero, the mouse was set to left-handed before the above DLL call
    {
        buttonState := 0
        tmpInt := DllCall("user32.dll\SwapMouseButton", "UInt", 0) ; Set right-handed mouse
        ToolTip, Right Handed
    }
    else
    {
        buttonState := 1
        ToolTip, Left Handed
    }
    RegWrite, REG_DWORD, %reg_KeyName%, %reg_ValueName%, %buttonState%

    SetTimer, tRemoveToolTip, -3000 ; Whith negative period, the timer will run only once
Return


; Function to monitor the WM_WTSSESSION_CHANGE and WM_POWERBROADCAST messages
f_WM_Monitor(wParam, lParam, msg)
{

Global reg_KeyName, reg_ValueName
Global msg_WM_WTSSESSION_CHANGE, msg_WM_POWERBROADCAST

    ; Lock or Suspend
    if ((msg = msg_WM_WTSSESSION_CHANGE and wParam = 7) or (msg = msg_WM_POWERBROADCAST and wParam = 4))
    {
        ; Get mouse buttons' state and store it in the registry. Required if the mouse buttons were swapped using the
        ; Control Panel and not by using the script
        buttonState := DllCall("user32.dll\SwapMouseButton", "UInt", 1) ; Note: Sets left-handed mouse
        if buttonState <> 0 ; If the result is non-zero, the mouse was set to left-handed before the above DLL call
            RegWrite, REG_DWORD, %reg_KeyName%, %reg_ValueName%, 1
        else
            RegWrite, REG_DWORD, %reg_KeyName%, %reg_ValueName%, 0
    }

    ; Unlock
    if ((msg = msg_WM_WTSSESSION_CHANGE and wParam = 8) or (msg = msg_WM_POWERBROADCAST and wParam = 7))
    {
        ; Synaptics driver and Windows 10 issues might reset the mouse buttons to right-handed mouse after unlock/wake-up
        ; The timer is to make sure that the state of the mouse buttons is set to what it was before the computer was locked/suspended
        SetTimer, tSetMouseButtons, -1000 ; With negarive period, the timer will run only once
    }
}
; Timers
tRemoveToolTip:
    ToolTip
Return
tSetMouseButtons:
    RegRead, buttonState, %reg_KeyName%, %reg_ValueName%
    tmpInt := DllCall("user32.dll\SwapMouseButton", "UInt", buttonState)
Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F5 & . 切换鼠标左右键    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000012-1467
 >^b::
if wincc_presses > 0 ; SetTimer 已经启动, 所以我们记录键击.
{
    wincc_presses += 1
    return
}
; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动
; 计时器：
wincc_presses = 1
SetTimer, Keywincc, 300 ; 在 400 毫秒内等待更多的键击.
return

Keywincc:
SetTimer, Keywincc, off
if wincc_presses = 1 ; 此键按下了一次.
{
   Click right
sleep,200
Send, wf
Clipboard= %Clipboard%
sleep,200
send,{ctrl down}v{ctrl up}
ClipWait
send, {enter}
}
else if wincc_presses = 2 ; 此键按下了两次.
{
   Click right
sleep,200
Send, w{up 2}{enter}
Clipboard= %Clipboard%
sleep,200
send,{ctrl down}v{ctrl up}
ClipWait
send, {enter}
}
wincc_presses = 0
return
;ΞΞΞΞΞΞΞΞΞΞΞΞ   >^b  单 新建文件夹 双 TxT文件  名为剪贴板    ΞΞΞΞΞΞΞΞΞΞΞΞΞ 000013-1506
F5 & u::
Clipboard =
Send, ^c
Run  "D:\ahk1.0\Lib\0 tool\bat\新建htm覆盖不提示.vbs"
sleep, 900
FileAppend, %clipboard% `n, C:\oneD\OneDrive\desktop\q.htm

 	IfWinNotExist ahk_exe AudioRecorder.exe
{
	Run "C:\3\0\语音合成\录音\录音.exe"  , , max
	WinActivate
}
	Else IfWinNotActive ahk_exe AudioRecorder.exe
{
	WinActivate
}
sleep, 4000
runwait C:\oneD\OneDrive\desktop\q.htm
sleep, 3000
send ^+u
sleep, 300
send ^+{space}
return
; 耳机,扬声器状态都能录，但中途不要切换音频设备。开Vpn也没关系。如失败，不要操作别的，再按一次F5 & u就可以了。
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F5 & u  文字转语音    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000014-1531

b105(timeout = 400)
{
	tout := timeout/1000
	key := RegExReplace(A_ThisHotKey,"[\*\~\$\#\+\!\^]")
	Loop
	{
     	 t := A_TickCount
      	KeyWait %key%
      	Pattern .= A_TickCount-t > timeout
      	KeyWait %key%,DT%tout%
      	If (ErrorLevel)
	Return Pattern
	}
}
;-----------------------------------------------------------------------------------
+F12::
   p := b105()

          If (p = "0")
	Run ms-settings:network-proxy            ;------------------------- 代理 1

   Else If (p = "00")
	Run control.exe sysdm.cpl`,`,3               ;---------------------环境变量 2

   Else If (p = "000")
	;Run compMgmtLauncher                      ;------------------ 计算机管理 3
              Run compmgmt.msc
   Else If (p = "0000")
	run devmgmt.msc                                  ;------------------ 设备管理器 4
		
   Else If (p = "1")　
;Run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\Task Scheduler.lnk
Run, C:\3\Windows11Manager\App\MyTask.exe ;------------------- 计划任务  5

   Else
{
	;Run dcomcnfg                                    ;------------------------组件服务 6  次数5次以上
Run mmc 
}
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F12  代理 变量 管理 控制台 组件服务    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000015-1571
+F11::
   p := b105()

          If (p = "0")
	Run control                                            ;---------------------控制面板 1
	;Run control.exe  main.cpl`,`,2
	;Run control.exe sysdm.cpl`,`,2
	;Run control.exe  intl.cpl`,`,0
	;Run  intl.cpl
	;Run control.exe ncpa.cpl 
   Else If (p = "00")
Run, %A_ComSpec% /k ipconfig  ; 打开 CMD 并直接运行 ipconfig   ; ipconfig 2
		
   Else If (p = "000")　　
	Run gpedit.msc                                      ;-----------------------组策略 3

   Else If (p = "0000")
	Run ncpa.cpl                                          ;---------------------网络连接 4

   Else If (p = "1")　　
{
	Run shrpubw
	Run fsmgmt.msc                                    ;-------------------共享文件夹   长按
;Run C:\Windows\System32\net1.exe
;Run C:\Windows\System32\net.exe
}
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ F11 控制面板 IP 组策略 网络连接 共享  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000016-1593

#Persistent
SetWorkingDir %A_ScriptDir%

~CapsLock::
if (A_PriorHotkey != "CapsLock" or A_TimeSincePriorHotkey > 400)
     {
    ; 这是第一次点击
    KeyWait, CapsLock
    KeyWait, CapsLock, D T0.4   ;等待400毫秒看是否会有第二次点击
    if (ErrorLevel)
{
        Send, !p                                                        ;------------------------- 单击
        Sleep, 100
        Send, s
}
    else
	{
        ; 可能是双击或三击 双击后有轻微的延迟，等1小段时间来确定是否有第3次点击
        KeyWait, CapsLock
        KeyWait, CapsLock, D T0.4
        if (ErrorLevel)
{
            Send, !p                                                    ;------------------------- 双击
            Sleep, 100
            Send, 9
}
        else
{
            KeyWait, CapsLock                                  ;------------------------- 三击
            Send, !p
            Sleep, 100
            Send, 0
}
	}
     }
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ CapsLock  浏览器  1全局 2auto 3直连   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000017-1631

 >^q::
ControlGetFocus, control, A
SendMessage, 0x115, 2, , %control%, A
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  >^q 上一页   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000018-1637

 >^e::
ControlGetFocus, control, A
SendMessage, 0x115, 3, , %control%, A
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  >^e 下一页   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000019-1643
F4 & -::
loop,10
{
var := 0
InputBox, time, KevZ:计时器 请输入一个时间__分钟
time := time*60000
Sleep,%time%
loop,26
{
var += 180
SoundBeep, var, 900
;SoundPlay, %A_WinDir%\Media\Ring10.wav
}
msgbox 时间到！！！! ! ! ! ! ! !
return
}
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ F4 & -  计时器   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000020-1660

#IfWinActive ahk_class WindowsForms10.Window.8.app.0.2bf8098_r6_ad1
:*b:++::610712一2550800一122一018{Bs 13}{left 2}{Bs}{left 4}{Bs 4}{Enter}   ;BS 回退13，left 左移 Enter确认 输入+2成功替换
#IfWinActive
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   ++ keepast    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0000001-1665

; 💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐    杂类   操作   ⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢⭐💢
; ➰➰➰➰➰➰➰➰➰➰   选行   选段   ➰➰➰➰➰➰➰➰➰➰➰

<!1::
send, {home}{shiftdown}{end}{shiftup}^c
Return
<!q::
Send +{Home}^c
Return
<!a::
Send {shift down}{End down}{End up}{shift up}^c
Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  <!1 复整行　<!q 到行首  <!a 到行尾   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0000002-1679

<!2::
send, {home}{shiftdown}{end}{shiftup}^v
Return
<!w::
Send +{Home}^v
Return
<!s::
Send {shift down}{End down}{End up}{shift up}^v
Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  <!2 粘整行  <!w 光标前 <!s 光标后     ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0000003-1690

<!3::
send, {home}{shiftdown}{end}{shiftup}^x
Return
<!e::
Send +{Home}^x
Return
<!d::
Send {shift down}{End down}{End up}{shift up}^x
Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  <!3 剪整行  <!e 光标前   <!d 光标后    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0000004-1701

<#1::
send, {home}{shift down}{end}{shift up}
Return
<#q::
Send +{Home}
Return
<#a::
Send {shift down}{End down}{End up}{shift up}
Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  <#1选整行　<#q到行首 <#a到行尾    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0000005-1712

<#2::
send !{End}+!{home}
Return
<#w::
Send ^+{home}
Return
<#s::
Send ^+{End}
Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  <#2 选整段  <#w光标前 <#s光标后    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0000006-1723

<#3::
send, {home}{shiftdown}{end}{shiftup}{delete}
Return
#If (WinActive("ahk_class XLMAIN") or WinActive("ahk_class OpusApp") or WinActive("ahk_exe Notepad3.exe") or WinActive("ahk_exe EmEditor.exe") or WinActive("ahk_class Chrome_WidgetWin_1"))
<#e::
Send +{Home}{delete}
Return
#IfWinActive
<#d::
Send {shift down}{End down}{End up}{shift up}{delete}
Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  <#3 删整行 <#e 光标前 <#d 光标后   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0000007-1736

; ➰➰➰➰➰➰➰➰➰➰   选行   选段   ➰➰➰➰➰➰➰➰➰➰➰
; 🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵   滚动   速度   🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵

#If ( WinActive("ahk_exe chrome.exe")  or WinActive("ahk_exe WeChatAppEx.exe")  or WinActive("ahk_exe Typora.exe") or WinActive("ahk_exe Notepad3.exe") or WinActive("ahk_exe EmEditor.exe") or WinActive("ahk_exe Joplin.exe"))
www=0
F2 & F1::
{
www:=!www
If(www=0)
{
SetTimer, aaaa, Off
SetTimer, bba, Off

}
ELSE
	{
	SetTimer, aaaa, 50	 ;滚动速度
	}
}
Return
	aaaa:
	{
	ControlGetFocus, control, A
	SendMessage, 0x115, 0, 0, %control%, A
	;SendMessage, 0x115, 2, , %control%, A
	}
Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F2 & F1 快速向上滚动   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000001-1765

F2 & F3::
{
	www:=!www
	If(www=0)
	{
	SetTimer, bba, Off
	SetTimer, aaaa, Off
	}
ELSE
	{
	SetTimer, bba, 50	;滚动速度
	}
}
Return
	bba:
	{
	ControlGetFocus, control, A
	SendMessage, 0x115, 1, 0, %control%, A
	;SendMessage, 0x115, 3, , %control%, A
	}
Return
#IfWinActive
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F2 & F3 快速向下滚动   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000002-1789

F2 & Esc::
{
www:=!www
If(www=0)
{
SetTimer, aaa, Off
SetTimer, bb, Off
}
ELSE
	{
	SetTimer, aaa, 1000	 ;滚动速度
	}
}
Return
	aaa:
	{
	ControlGetFocus, fcontrol, A
	Loop 1                                                          ; 行数
	SendMessage, 0x115, 0, 0, %fcontrol%, A
	}
Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F2 & Esc 缓慢向上滚动  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000003-1812

#ifwinactive
www=0

F2 & F4::
{
	www:=!www
	If(www=0)
	{
	SetTimer, bb, Off
	SetTimer, aaa, Off
	}
ELSE
	{
	SetTimer, bb, 1000	;滚动速度
	}
}
Return
	bb:
	{
	ControlGetFocus, fcontrol, A
	Loop 1                                     ; 行数
	SendMessage, 0x115, 1, 0, %fcontrol%, A
}
Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F2 & F4 缓慢向下滚动   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000004-1838

; 🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵   滚动   速度   🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵
;🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵    颜色   坐标   🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵

F5 & o::
	MouseGetPos, mouseX, mouseY
PixelGetColor, color, %mouseX%, %mouseY%, RGB ; 调用 PixelGetColor 函数，获得 RGB 值，并赋值给 color                     
StringRight color,color,6    ; 截取 color（第二个 color）右边的6个字符，因为获得的值是这样的：0x8700FF，一般我们只需要 8700FF 部分。把截取到的值再赋给 color（第一个 color）。

	clipboard = #%color%        ;--------------------------------- 添加了 #
	tooltip, %clipboard%          ;--------------- 把 color 的值发送到剪贴板
	sleep 2000
	tooltip,
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F5 & o 获得 RGB 值    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000000001-1853

F5 & P::  
    	ClipSaved := ClipboardAll        ; ------------------保存当前剪贴板内容
    	Clipboard := ""                         ;-- 清空剪贴板以确保后续操作的准确性
	Send ^c  
    	ClipWait                                    ; ------------------等待剪贴板内容更新
	color := Clipboard                    ;------------------ 获取剪贴板中的色值
    	;Clipboard := ClipSaved           ;----------------------- 恢复剪贴板内容

    ; 检查颜色格式并转换为 RGB
    if (SubStr(color, 1, 1) = "#") {
        color := SubStr(color, 2)  ; 去掉 "#"
    }
    
    if (StrLen(color) = 6) {
        ; 使用 AutoHotkey 内置的十六进制转换
        r := "0x" SubStr(color, 1, 2)
        g := "0x" SubStr(color, 3, 2)
        b := "0x" SubStr(color, 5, 2)

Gui, New, +Escape +AlwaysOnTop, Color Preview          ; 创建 GUI 窗口以显示颜色，并启用 Esc 关闭功能
        	Gui, Color, % "0x" color  ; 设置背景颜色为获取的颜色        

        	Gui, Add, Text, Center, #%color%）
        	Gui, Font, s14 Bold  ; 设置字体大小和样式
Gui, Show, w200 h200, Color Preview    ; 设置窗口大小为正方形 200x200 像素
} 
	else 
{
        	MsgBox, Invalid color format. Please use #RRGGBB.
}
	return
	GuiClose:
	GuiEscape:
	Gui, Destroy
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F5 & p 显示颜色  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000000002-1890

	autostart:=1
	autostartLnk:=A_StartupCommon . "D:\ahk1.0\Lib\se.ahk"
F5 & [::

	if(autostart)
{
    	IfExist, % autostartLnk
{
        	FileGetShortcut, %autostartLnk%, lnkTarget
        	if(lnkTarget!=A_ScriptFullPath)
FileCreateShortcut, %A_ScriptFullPath%, %autostartLnk%, %A_WorkingDir%
}
	else
{
FileCreateShortcut, %A_ScriptFullPath%, %autostartLnk%, %A_WorkingDir%
}
}
	else
{
    	IfExist, % autostartLnk
{
       	FileDelete, %autostartLnk%
}
}
;----------------------------------------------------------------------------------
WinMoveZ(hWnd, C, X, Y, W, H, Redraw:=0) 
{ ;  WinMoveZ v0.5 by SKAN on D35V/D361 @ tiny.cc/winmovez
Local V:=VarSetCapacity(R,48,0), A:=&R+16, S:=&R+24, E:=&R, NR:=&R+32, TPM_WORKAREA:=0x10000
C:=( C:=Abs(C) ) ? DllCall("SetRect", "Ptr",&R, "Int",X-C, "Int",Y-C, "Int",X+C, "Int",Y+C) : 0
DllCall("SetRect", "Ptr",&R+16, "Int",X, "Int",Y, "Int",W, "Int",H)
DllCall("CalculatePopupWindowPosition", "Ptr",A, "Ptr",S, "UInt",TPM_WORKAREA, "Ptr",E, "Ptr",NR)
X:=NumGet(NR+0,"Int"),  Y:=NumGet(NR+4,"Int")
Return DllCall("MoveWindow", "Ptr",hWnd, "Int",X, "Int",Y, "Int",W, "Int",H, "Int",Redraw)
}
;----------------------------------------------------------------------------------
	#NoEnv
	#SingleInstance, Force
	CoordMode, Mouse, Screen
	CoordMode, Pixel, Screen

Gui New, -Caption  +Escape +Border +hWndhWnd +Disabled +AlwaysOnTop
	Gui, Margin, 15, 70         ; ----------------------------------宽度与高度
Gui, Add, Edit, w50 Center  yellow   ;文字左右居中 Center, yellow  加上逗号则上下居中
	Gui, Show
	WinGetPos, X, Y, W, H, ahk_id %hWnd%
	PX:=X, PY:=Y
	Loop
{
  	MouseGetPos, X, Y
  	If ! (X=PX and Y=PY)
{
      	WinMoveZ(hWnd, 96, X, Y, W, H), PX:=X, PY:=Y
      	PixelGetColor, C, %X%, %Y%, RGB
      	Gui, Color, % PC:=C
      	GuiControl,,Edit1, % Format("{:06X}",C)
}
  	Sleep 50
}
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F5 & [  颜色值 鼠标跟随  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000000003-1951

F5 & ]::
	MouseGetPos, xpos, ypos
	clipboard = %xpos%,%ypos%
	a = %xpos%_%ypos% 	;-------------------------a = 鼠标位置`(X,Y`)
	tooltip, %a%
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F5 & ] 获取当前鼠标指针的坐标   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000000004-1959

;🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵    颜色   坐标   🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵
; 🚧 🚧 🚧 🚧 🚧 🚧 🚧 🚧🚧    上传   图库   🚧 🚧 🚧 🚧 🚧 🚧 🚧 🚧🚧   

F1 & a::
    ; 启动截图程序
    Run, "D:\ahk1.0\Lib\0 tool\9金山截图王\kscrcap.exe"
    
    ; 延迟 2 秒后弹出确认对话框
    Sleep, 2000
    MsgBox, 4,, 请在完成截图和编辑后点击“是”确认上传图片。
    IfMsgBox, No
        return ; 如果选择“否”，则直接退出脚本
    
    ; 上传图片
    Run, D:\ahk1.0\Lib\0 tool\picgo-croe\upgit.exe :clipboard -o clipboard -f ccc, , hide
    return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F1 & a  上传截图到github/img   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  000001-1984

F1 & s::
    ; 获取选中文件的路径
    FilePath := ""
    Send, ^c  ; 复制选中文件路径到剪贴板
    Sleep, 200
    FilePath := Clipboard
    if (FilePath = "")
    {
        MsgBox, 请先选中一个文件！
        return
    }

    ; 提取目录和扩展名
    SplitPath, FilePath, , Dir, Ext, Name
    NewFileName := "up111." . Ext
    NewFilePath := Dir . "\" . NewFileName

    ; 重命名文件（避免中文名）
    FileMove, %FilePath%, %NewFilePath%, 1
    if (ErrorLevel)
    {
        MsgBox, 文件重命名失败！
        return
    }

    ; 调用 upgit.exe 上传文件
    RunWait, "upgit.exe" "%NewFilePath%", , hide

    ; 恢复原文件名
    FileMove, %NewFilePath%, %FilePath%, 1
    if (ErrorLevel)
    {
        MsgBox, 恢复文件名失败！请手动重命名为：`n%Name%.%Ext%
    }
    return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F1 & s  上传剪贴板中的文件   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  000006-2067

F1 & d::
Text= ⭕       上传图片中     ⭕ 
btt(Text,600,0,,"Style4") 
send ^c
sleep, 2000
RunWait, cmd /c "picgo u"
,, hide
return
sleep, 9000
btt()​
clipboard = <p align = "center"><img src="%clipboard%" style="width:400px;"><br><br>
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F1 & d  上传剪贴板中的文件   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  000005-2051

F1 & f::
    ; 启动截图程序
    Run, "D:\ahk1.0\Lib\0 tool\9金山截图王\kscrcap.exe"
    
    ; 延迟 2 秒后弹出确认对话框
    Sleep, 2000
    MsgBox, 4,, 请在完成截图和编辑后点击“是”确认上传图片。
    IfMsgBox, No
        return ; 如果选择“否”，则直接退出脚本

    ; 上传图片
	RunWait, cmd /c "picgo u",, hide
    return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F1 & f  上传截图到github/img   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  000002-2000

F1 & g::       
	run, https://tuku.zbb07.us.kg
	;run, https://tuku.zcr07.us.kg
    	;run, https://tu.k07.us.kg         ;需要先在浏览器上将窗口设为67%
	;run, https://tu.w07.us.kg
	;run, https://tu.n06.us.kg
	;run, https://tu.z07.us.kg
	sleep, 7000
Click, 320, 370, 1, 6, ahk_class Chrome_WidgetWin_1  ; 点击左键
    	Sleep, 1000
send, ^v
    	Sleep, 1000  
    	ControlClick, x1160 y505, ahk_class Chrome_WidgetWin_1
    	Sleep, 9500

    ; 使用 ControlClick 模拟鼠标点击特定位置
    ControlClick, x480 y609, ahk_class Chrome_WidgetWin_1
    Sleep, 100

clipboard = <p align = "center"><img src="%clipboard%" style="width:600px; height:400px;">

return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F1 & g  上传截图到图库     ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  000004-2037

F1 & h::       
         run, https://picx.xpoet.cn/#/upload    ;需要先在浏览器上将窗口设为67%
         sleep, 4000
click, 1400, 255
	sleep, 1000
	send, ^v
    	Sleep, 100
	send, ^s
    	Sleep, 3000
clipboard = <p align = "center"><img src="%clipboard%" style="width:400px;"><br><br>
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F1 & h  上传截图到图库     ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  000003-2013

; 🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧  上传   图库    🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧
; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞  光标   操作    🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞

AppsKey & w::Send {Up}
	AppsKey & s::Send {Down}
		AppsKey & a::Send {Left}
			AppsKey & d::Send {Right}
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    adws 上 下 左 右   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0000001-2076

AppsKey & q:: Send, {Bs}
	AppsKey & e:: Send, {delete}
		AppsKey & f:: Send, {Enter}
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    q 退格 e 删除 f 回车    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0000002-2081

AppsKey & g::
	Send {End}
	Send {Enter}
	Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    AppsKey & g 任意位置回     ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 0000003-2087



; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞  光标 鼠标  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞
; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞 快捷  搜索  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞

F1 & 1::
send,{ctrl down}c{ctrl up}
sleep,200
ClipWait

  	Run, "C:\3\Everything-1.5.0.1356a.x64\Everything64.exe"  -s "%clipboard%"

return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F1 & 1 用Evething搜索选中的文字    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000001-2102

/*
#IfWinActive ahk_exe chrome.exe or ahk_exe EmEditor.exe     ;只对chrome  EmEditor 起作用
F1::return                                         ; 覆盖单独按下 F1 的功能，不执行任何操作
F1 & 2::                                            ; 打开谷歌翻译，回车激活切换中英
Click, 1400,170  , Right
	Click Right
	Send {T}{enter}
Click, 1400,170
return
#IfWinActive                                     ; 结束限制
*/
;-----------------------------------------------------------------------------------

#If (WinActive("ahk_exe chrome.exe") or WinActive("ahk_exe EmEditor.exe"))
F1::return  ; 禁用 F1 的单独功能
F1 & 2:: 
Click, 1400,170  , Right
	Click Right
	Send {T}{enter}
Click, 1400,170
return
#If  ; 结束限制
;如果你的条件比较简单且仅仅是检查窗口，#IfWinActive 完全可以满足需求。
;如果你需要更复杂的条件判断，下面这种  #If 更加灵活且强大。
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ F1 & 2   谷歌翻译  中/ 英   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000002 -2128

F1 & 3::
; 复制当前选中的文本
send, ^c
sleep, 100

; 启动 Mobipocket Reader，如果已经运行则激活窗口
if WinExist("ahk_class MobiDesktopReader")
{
    WinActivate
}
else
{
    run, "C:\3\4\9 MobipocketReader_6.2.exe"
}

; 等待 Mobipocket Reader 窗口存在，最多等待10秒
WinWait, ahk_class MobiDesktopReader, , 10000
if ErrorLevel
{
    MsgBox, 程序未能在10秒内启动。
    return
}

; 等待窗口激活
WinWaitActive, ahk_class MobiDesktopReader, , 1000
if ErrorLevel
{
    MsgBox, 窗口未能在1秒内激活。
    return
}

; 将焦点设置到搜索框控件
ControlFocus, Edit1, ahk_class MobiDesktopReader
sleep, 100  ; 等待焦点设置生效

; 模拟鼠标点击搜索框
ControlClick, Edit1, ahk_class MobiDesktopReader
sleep, 100  ; 等待点击生效

; 清空搜索框内容
ControlSetText, Edit1,, ahk_class MobiDesktopReader
sleep, 100  ; 等待清空生效

; 确保剪贴板内容是干净的
clipboard := Trim(clipboard)

; 使用 ControlSend 粘贴剪贴板内容并发送 Enter 按键
ControlSend, Edit1, ^v, ahk_class MobiDesktopReader
sleep, 100  ; 等待粘贴生效

; 发送 Enter 按键进行搜索
ControlSend, Edit1, {Enter}, ahk_class MobiDesktopReader
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F1 & 3 Mobi    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000003-2183

F1 & 4::
	Send, {ctrl down}c{ctrl up}
	KeyWait F1
	Run https://www.baidu.com/s?ie=UTF-8&wd=%clipboard%
	return
 ;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F1 & 4 用百度搜索选中的文字   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000004-2190

F1 & 5::
  	Send, {ctrl down}c{ctrl up}
	KeyWait F1
	Run http://www.google.com.tw/search?hl=zh-TW&q=%Clipboard%
	return
 ;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F1 & 5 用谷歌搜索选中的文字   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000005-2197

F1 & 6::
	send, ^c
	sleep,100
	run, "C:\3\4\9 MobipocketReader_6.2.exe"
	WinWait, ahk_class MobiDesktopReader, , 15000   ; 等待 Mobipocket Reader 窗口存在，最多等待15秒
if ErrorLevel
{
    MsgBox, 程序未能在15秒内启动。
    return
}
	send, {NumpadUp}
	WinWaitActive, ahk_class MobiDesktopReader, , 4000     ; 等待窗口激活
if ErrorLevel
{
    MsgBox, 窗口未能在1秒内激活。
    return
}
	send, {enter}
	sleep, 100
	send, ^v{enter}
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F1 & 6 Mobi    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000006-2220

F1 & 7::
	Send, {ctrl down}c{ctrl up}
 	 Runwait https://transmart.qq.com/zh-CN/index?sourcelang=en&targetlang=zh&source=%clipboard%
	WinWait, ahk_class Chrome_WidgetWin_1, , 15000  
	return
 ;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F1 & 7 腾讯翻译    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000007-2227

F1 & 8::
	Send, {ctrl down}c{ctrl up}
	KeyWait F1
	sleep,20
  	Run  http://youtube.com/results?q=%clipboard%
	return
 ;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F1 & 8  youtube   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000008-2235

F1 & 0::
	Send, {ctrl down}c{ctrl up}
 	Runwait https://fanyi.baidu.com/mtpe-individual/multimodal?aldtype=23#/en/zh/%clipboard%
	WinWait, ahk_class Chrome_WidgetWin_1, , 15000  
	return
 ;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F1 & 0 百度翻译  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000009-2242

F1 & =:: 
	Send, {ctrl down}c{ctrl up}   
sleep, 400
	KeyWait F1                         
 	 Runwait https://transmart.qq.com/zh-CN/index
	sleep, 3000
	Send, {ctrl down}v{ctrl up}                                                               
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F1 & = 腾讯翻译   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000009-2252

F1 & 9::
	Send, {ctrl down}c{ctrl up}
		KeyWait F1
	sleep,20
  	Run  https://zh.wikipedia.org/wiki/Special:Search/%clipboard%
	  	return
 ;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F1 & 9  wiki    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000010-2260

F1 & -::      
	Send, {ctrl down}c{ctrl up}
	send, #!/     
	KeyWait F1
	;sleep,2000                        
  	Run https://www.deepl.com/translator?q=Adds%20shortcuts%20to%20increase%2Fdecrease%20font%20size#en/zh/%clipboard%  
	sleep,16000
	send, #!/  
  	return
 ;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F1 & -  DeepL    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00000010-2261

; 🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞 快捷  搜索  🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞🎞
; 🎼🎼🎼🎼🎼🎼🎼🎼🎼🎼 关机  重启  🎼🎼🎼🎼🎼🎼🎼🎼🎼🎼🎼🎼

F4 & z::
Run, nircmd speak text "确定注销，请点是" 0 90
Run, nircmd.exe cmdwait 100 qboxcom ".............注  销............." "  注意：保存文件" exitwin logoff
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F4 & z 注销     ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000000001-2280
F4 & c::
Run, nircmd speak text "确定重启 请点是" 0 90
Run, nircmd.exe  cmdwait 100 qboxcom ".............重  启............." "  注意：保存文件" exitwin reboot
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F4 & c 重启     ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000000002-2285

F4 & g::
Run, nircmd speak text "确定关机 请点是" 0 90
Run, nircmd.exe cmdwait 100 qboxcom ".............关  机............." "  注意：保存文件" exitwin poweroffr
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F4 & g 关机    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000000003-2291

F4 & d::
Run, nircmd speak text "进入待机 请点是" 0 90
Run, nircmd.exe cmdwait 100 qboxcom ".............待　机............" "  睡眠：注意保存文件" standby
sleep, 5000
send, y
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F4 & d 待机    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000000004-2299

F4 & x::
Run, nircmd speak text "确定休眠 请点是" 0 90
Run, nircmd.exe cmdwait 100 qboxcom ".............休　眠............." "  注意：保存文件" hibernate
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F4 & q 重启资源管理器    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000000005-2305

F4 & q::
Run, nircmd speak text "重启资源管理器" 0 90
sleep, 2000
process,close,explorer.exe
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F4 & q 重启资源管理器    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000000006-2312

F4 & p::
Run, nircmd speak text "关屏" 0 90
Run, nircmd.exe cmdwait 2000 monitor off
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ    F4 & p 关屏    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 000000007-2318

; 🎼🎼🎼🎼🎼🎼🎼🎼🎼🎼 关机  重启  🎼🎼🎼🎼🎼🎼🎼🎼🎼🎼🎼🎼
; 🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️ 文档  编辑  🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️
/*
;     ::a111::ā        a111按下空格后　ā 　　ā后有１个空格    sa111 空格无法替换　　　不能有前缀
;     :?:a111::ā       a111按下空格后　ā 　    ā后有１个空格     sa111 空格完成替换　　  可有前缀

;     :o:     :o:a111::ā      a111按下空格后　ā   　   ā后无空格           sa111 空格无法替换        非自动　去除后面的空格  o omit　即忽略空格，但不能自动触发
;     :*:      :*:a111::ā       a111自动替换为　ā　　  ā后无空格           sa111 空格无法替换　　　自动　 去除后面的空格   *  无需空格,就能自动触发

;      :c:　输入时需要区分大小写　　  :c:Gu::xxx   只有输入的是是Gu才能输出xxx　　gu　GU　gU　　都无法输出xxx

;      :r:　原样输出　:r:dc::{enter}　原样输出 {enter} 　而不会转义成按下回车

;      :b0:              :b0:<li>::</li>{left 5}　　在输入内容后添加::后的内容　<li></li>

;      :b:              :b:<li>::</li>{left 5}　　输出 </li>　然后光标移至最左边　

#IfWinActive ahk_class EmEditorMainFrame3
::,t1::xxx
#IfWinActive
*/

:*?:a111::ā
:*?:a222::á
:*?:a333::ǎ
:*?:a444::à
:*?:e111::ē
:*?:e222::é
:*?:e333::ě
:*?:e444::è
:*?:o111::ō
:*?:o222::ó
:*?:o333::ǒ
:*?:o444::ò
:*?:i111::ī
:*?:i222::í
:*?:i333::ǐ
:*?:i444::ì
:*?:u111::ū
:*?:u222::ú
:*?:u333::ǔ
:*?:u444::ù
:*?:v111::ǖ
:*?:v222::ǘ
:*?:v333::ǚ
:*?:v444::ǜ
:*?:v555::ü
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  3个12345  aoeiuü    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 01-2354

:*?:``m::<br>
:?*:m``::<>{left}

:?*:9'::(){left}
:?*:0'::（）{left}

:?*:['::[]{left}
:?*:]'::{{}{}}{left}

:?*:-'::【】{left}
:?*:='::〖〗{left}
:?*:8'::《》{left}
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   `m::<br>  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 02-2368

:*:.'::。
:*:,'::，

:*::'::：
:*:`;'::；

:*:`/``::、  
:*:.``:: •{space}

:*:,``::……
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   。，：；、 • ……    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 03 -2380

; 🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️ 文档  编辑  🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️🕸️
;🎁🎁🎁🎁🎁🎁🎁🎁🎁🎁  颜色  处理  🎁🎁🎁🎁🎁🎁🎁🎁🎁🎁🎁🎁

{
    ; F6 & R 红色        ;ROYGQBP WETUI
    F6 & r::b205("#f20c00")

    ; F6 & O 橙色                       
    F6 & o::b205("#ec6800")

; F6 & y 暗红色
    F6 & y::b205("#fff143")

; F6 & g 亮绿色
    F6 & g::b205("#00e500")

; F6 & q 兰绿色
    F6 & q::b205("#177cb0")

    ; F6 & B 浅蓝色
    F6 & b::b205("#44cef6")

; F6 & p 暗紫色
    F6 & p::b205("#b61aae")

; F6 & w 绿色
    F6 & w::b205("#bce672")

; F6 & e 绿色
    F6 & e::b205("#955539")

; F6 & t 兰绿色

    F6 & t::b205("#d7003a")

; F6 & u 深紫色
    F6 & u::b205("#ff0097")

; F6 & i 紫色
    F6 & i::b205("#ff461f")
}

; 快捷增加字体颜色
b205(s){
      clipboard := ""
    SendInput,^x
sleep,100
	clipboard = <span style="color: %s%; font-size:18px">%clipboard%</span>
 	SendInput {ctrl down}v{ctrl up}
	;Send {Left 7} ; 光标跟随到文本
}
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F6 & O 橙色   joplin字体颜色  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 04 -2434

{
; F7 & q 兰绿色
    F7 & q::b204("#177cb0")

; F7 & w 绿色
    F7 & w::b204("#bce672")

; F7 & e 绿色
    F7 & e::b204("#955539")

; F7 & R 红色
    F7 & r::b204("#f20c00")

; F7 & t 兰绿色
    F7 & t::b204("#d7003a")

; F7 & y 暗红色
    F7 & y::b204("#fff143")

; F7 & u 深紫色
    F7 & u::b204("#ff0097")

; F7 & i 紫色
    F7 & i::b204("#ff461f")

; F7 & O 橙色      ; ORBPYGMST
    F7 & o::b204("#ec6800")

; F7 & p 暗紫色
    F7 & p::b204("#b61aae")

; F7 & B 浅蓝色
    F7 & b::b204("#44cef6")

; F7 & G 亮绿色
    F7 & g::b204("#00e500")
}

; 快捷增加字体颜色
b204(s){
      clipboard := ""
    SendInput,^x
sleep,100
	clipboard = <span style="font-family:KaiTi; font-size:30px; color: %s%">%clipboard%</span>
	SendInput {ctrl down}v{ctrl up}
	;Send {Left 7} ; 光标跟随到文本
}
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F7 & O 橙色   joplin字体颜色  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 05-2484

    ; F8 & q 兰绿色       ;   QWERTYUIOP  BG
    F8 & q::b203("#177cb0")

; F8 & w 绿色
    F8 & w::b203("#426666")

; F8 & e 绿色
    F8 & e::b203("#955539")

    ; F8 & R 红色
    F8 & r::b203("#f20c00")

; F8 & t 兰绿色
    F8 & t::b203("#d7003a")

; F8 & y 暗红色
    F8 & y::b203("#fff143")

; F8 & u 兰绿色
    F8 & u::b203("#ff0097")

; F8 & i 紫色
    F8 & i::b203("#ff461f")

    ; F8 & O 橙色
    F8 & o::b203("#ec6800")

; F8 & p 暗紫色
    F8 & p::b203("#b61aae")

    ; F8 & B 浅蓝色
    F8 & b::b203("#44cef6")

; F8 & g 暗绿色
    F8 & g::b203("#00e500")

; 快捷增加字体颜色
b203(s)
{
    clipboard := ""
    SendInput,^x
sleep,100
    SendInput, {TEXT}<span style="font-family:LiSu; font-size:24px; color: #2E3138; background: %s%">%clipboard%</span>
    Send {Left 25}{home}
}                                             ;  ------------------------------------- r t y o p     g b     m s
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F8 & O 橙色 Tyora 背景色    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 06 -2532

; F9 & q 兰绿色       ;   QWERTYUIOP  BG
    F9 & q::b202("#177cb0")

; F9 & w 绿色
    F9 & w::b202("#426666")

; F9 & e 绿色
    F9 & e::b202("#955539")

    ; F9 & R 红色
    F9 & r::b202("#f20c00")

; F9 & t 兰绿色
    F9 & t::b202("#d7003a")

; F9 & y 暗红色
    F9 & y::b202("#000000")

; F9 & u 兰绿色
    F9 & u::b202("#ff0097")

; F9 & i 紫色
    F9 & i::b202("#ff461f")

    ; F9 & O 橙色
    F9 & o::b202("#ec6800")

; F9 & p 暗紫色
    F9 & p::b202("#b61aae")

    ; F9 & B 浅蓝色
    F9 & b::b202("#44cef6")

; F9 & g 暗绿色
    F9 & g::b202("#00e500")

; 快捷增加字体颜色
b202(s)
{
   clipboard := ""
    SendInput ^x
sleep,100
          SendInput, {TEXT}<table><td bgcolor=%s%><font size = '4'></font>%clipboard%<td bgcolor=#2E3138></table>
a := "1"
;Send {Left 8}%a%{Left 20}{home}-{Space}
Send {Left 8}%a%{home}{up}-{Space}
}                                             ;  ------------------------------------- r t y o p     g b     m s
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F9 & O 橙色 Tyora 背景色    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 07-2582

F7 & 1::b201(12)
F7 & 2::b201(14)
F7 & 3::b201(16)
F7 & 4::b201(18)
F7 & 5::b201(20)
F7 & 6::b201(22)
F7 & 7::b201(24)

b201(size)
{
    clipboard := ""          ; 清空剪贴板
    SendInput ^x             ; 剪切选中的文本
    Sleep, 100               ; 等待剪贴板有内容
    ClipWait                 ; 等待剪贴板内容更新
    ; 设置新的剪贴板内容
    clipboard := "<span style='font-family: KaiTi; font-size: " size "pt;'>" clipboard "</span>"
    ; 等待剪贴板内容更新    color: #d7003a;
    ClipWait
    ; 粘贴新的内容
    SendInput ^v
    ; 光标左移 7 次
    Send {Left 7}
}
return
#IfWinActive
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F7 & 1-7  Tyora 字号    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 08-2609

;🎁🎁🎁🎁🎁🎁🎁🎁🎁🎁🎁  颜色  处理  🎁🎁🎁🎁🎁🎁🎁🎁🎁🎁🎁
;👔👔👔👔👔👔👔👔👔👔👔  段落  处理  👔👔👔👔👔👔👔👔👔👔👔

#F2::
if (onoff := !onoff)
	{
	Send {home}
	}
else
	{
    	Send {end}
keywait, F2
}
 Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   #F2 行首 行尾    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 09-2625

#F3::
if (onoff := !onoff)
	{
	Send #!{home}
	}
else
	{
    	Send #!{end}
keywait, F3
}
 Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  #F3 段首 段尾     ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 10 -2638

#F4::
if (onoff := !onoff)
	{
send, ^a{left}
	}
else
	{
send, ^a{right}
	keywait, F4
	}
 Return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   #F4 页首 页尾    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 11-2651


;👔👔👔👔👔👔👔👔👔👔👔  段落  处理  👔👔👔👔👔👔👔👔👔👔👔
;🎀🎀🎀🎀🎀🎀🎀🎀🎀🎀🎀  空行  处理  🎀🎀🎀🎀🎀🎀🎀🎀🎀🎀🎀

F6 & 1::
    Clipboard := ""
    Send, ^c
    ClipWait, 2
    Clipboard := RegExReplace(Clipboard, "(\R\s*){2,}", "`r`n`r`n")
    Send, ^v
return
; 当我们使用 "`r`n" 时，它只会将光标移动到下一行的开始，但不会创建一个空行。使用 "`r`n`r`n" 实际上是创建了两个连续的换行符，这就会产生一个空行的效果.
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ F6 & 1  选中 合并多行空行为１行   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 12-2665

F6 & 2::
SetWorkingDir, %A_ScriptDir%  ; 设置工作目录

; 复制内容到剪贴板
Send, ^c
ClipWait, 2
sleep, 200
if ErrorLevel
{
    MsgBox, 复制失败或超时
    return
}

; 处理剪贴板内容
text := Clipboard
text := StrReplace(text, "`r")  ; 移除所有回车符

; 使用数组存储非空行
lines := StrSplit(text, "`n")
output := ""

for index, line in lines
{
    if (line != "") {  ; 忽略空行
        output .= line . "`n"
    }
}

; 移除最后一个换行符
output := RTrim(output, "`n")

; 将结果写回剪贴板
Clipboard := output
Send, ^v

return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ F6 & 2  选中 删除空行   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 13-2706

F6 & 3::
    Clipboard := ""
    Send, ^c
    ClipWait
    Clipboard := RegExReplace(Clipboard, "\R", "`r`n`r`n")
    Send, ^v
return                                                                   ;-------回车变换行即增加一行
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F6 & 3 选中 添加空行   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 14-2715

F6 & 4::
clipboard =
send, ^c
sleep, 100
a = %clipboard%
stringreplace, out, a, ` , `n, All
send, %out%
return                                                                   ;-------回车变换行即增加一行．和上面的区别：空格处也变换行　
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ F6 & 4  选中 空格及回车 变换行  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 15-2725

F6 & 5::
    Clipboard := ""  ; 清空剪贴板
    Send, ^c         ; 发送 Ctrl+C 复制选中的文本
    ClipWait, 1     ; 等待最多 1 秒，直到剪贴板有内容
    if (ErrorLevel) {
        MsgBox, 剪贴板没有内容，请确保已选中文本。
        return
    }
    ; 使用更简单的正则表达式来替换换行符
    Clipboard := RegExReplace(Clipboard, "\s*[\r\n]+\s*", "")  ; 替换多个换行符为空格
    Send, ^v         ; 粘贴处理后的内容
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F6 & 5 多行文字合并成一行  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 16-2739

;🎀🎀🎀🎀🎀🎀🎀🎀🎀🎀🎀  空行  处理  🎀🎀🎀🎀🎀🎀🎀🎀🎀🎀🎀
;🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️  空格  处理  🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️

F6 & 6::
	Clipboard := ""
	Send, ^c
	ClipWait
	Clipboard := RegExReplace(Clipboard, "[ \R]+", "$1")
sleep, 400
send, ^v
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ F6 & 6  选中 删除空格   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 17-2752

F6 & 7::
	Clipboard := ""
	Send, ^c
	ClipWait
	Clipboard := RegExReplace(Clipboard, "[ \R]+", " ")
sleep, 400
send, ^v^a
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F6 & 7  选中 多个空格变一个  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 18-2762

F6 & 8::
	Clipboard := ""
	Send, ^c
	ClipWait
	Clipboard := RegExReplace(Clipboard, "m)^[ \R]+|[ \R]+$", "$1")
	Clipboard := Trim(clipboard)
sleep, 400
send, ^v
	return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F6 & 8  选中  只删除首尾空格  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 19-2773

F6 & 9::
clipboard =
send, ^c
sleep, 500
Loop
{
StringReplace, clipboard, clipboard, `t ,` , UseErrorLevel                         ;  注意`后有个空格    空格表示法 `
    if ErrorLevel = 0
        break
}
sleep,200
send,^v
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ  F6 & 9 Tab替换成空格    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 20-2788

;🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️  空格  处理  🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️🎞️
;🛒🛒🛒🛒🛒🛒🛒🛒🛒🛒🛒  马克  文档  🛒🛒🛒🛒🛒🛒🛒🛒🛒🛒🛒

#If (WinActive("ahk_exe Typora.exe") or WinActive("ahk_exe Joplin.exe"))                  ;---仅Typora  Joplin 

F6 & F1::
	clipboard := ""
    	SendInput,^x
	sleep,100
	clipboard = #  <span style="font-family:KaiTi; font-size:30px; color: #d7003a">%clipboard%</span>  [^0]   ; ------------- 12 握了请握  [^012] {left}
	SendInput {ctrl down}v{ctrl up}{home}{up}{right 2}
return
#If
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F6 & F1 标题添加序号等    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 001-2803 

#If (WinActive("ahk_exe Typora.exe") or WinActive("ahk_exe Joplin.exe"))
F6 & F2::
	send {space 2}
	clipboard = - [ ] <span style="color: #4c221b">确定已经掌握了请打上对勾！</span>
	SendInput {ctrl down}v{ctrl up}                      ; ------------- 确定已经掌握了请打上对勾！
return
#If
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F6 & F2 确定已经掌握了请打上对勾    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 002-2812 

#If (WinActive("ahk_exe Typora.exe") or WinActive("ahk_exe Joplin.exe"))

 F6 & F4::zaa()
	zaa()
{
	clipboard := ""
	Send ^x
	Sleep 500
	clipboard = <center>%clipboard%</center>
	Sleep 50
	Send ^v
}
return
#IfWinActive
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F6 & F4 Tyora 居中   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 003-2828

#If (WinActive("ahk_exe Typora.exe") or WinActive("ahk_exe Joplin.exe"))

F6 & F5::
	send >✌️ 
	sleep, 100
	send {enter}{bs}{enter}{left 2}
return
#If
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F6 & F5  > :v:    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 004-2838 

#If (WinActive("ahk_exe Typora.exe") or WinActive("ahk_exe Joplin.exe"))

F6 & F7::zc()
	zc()
{
	clipboard := ""
	Send ^x
	Sleep 500
	clipboard = ``%clipboard%``
	Sleep 50
	Send ^v
}
return
#If
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F6 & F7 Tyora 代码块   ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 005-2854

#If (WinActive("ahk_exe Typora.exe") or WinActive("ahk_exe Joplin.exe"))

 F6 & F8::zb()
	 zb()
{
	clipboard := ""
	Send ^x
	Sleep 500
	clipboard = ^%clipboard%^
	Sleep 50
	Send ^v
}
return
#If
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F6 & F8 上标    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 006-2870

#If (WinActive("ahk_exe Typora.exe") or WinActive("ahk_exe Joplin.exe"))

 F6 & F9::zd()
	zd()
{
	clipboard := ""
	Send ^x
	Sleep 500
	clipboard = ~%clipboard%~
	Sleep 50
	Send ^v
}
return
#If
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F6 & F9 下标    ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 007-2886

;🛒🛒🛒🛒🛒🛒🛒🛒🛒🛒🛒  马克  文档  🛒🛒🛒🛒🛒🛒🛒🛒🛒🛒🛒
;🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧  观察  设置  🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧

F5 & b::
    Process, Exist, uTools.exe       ; 检查程序是否已经在运行
    if (ErrorLevel)      ;根据 ErrorLevel 的值来决定是关闭程序还是启动程序，而不再依赖于 isRunning 状态变量。这可以避免因状态更新不及时而导致的需要按两次热键的问题。
    {
                                                                          ; 如果程序正在运行，则关闭它
        Process, Close, uTools.exe
        isRunning := false     ; 更新状态为未运行
    } 
    else 
    {
                                                                      ; 如果程序没有在运行，则启动它
        Run, C:\Users\z\AppData\Local\Programs\utools\uTools.exe
sleep, 1000
send, ^2
        isRunning := true      ; 更新状态为正在运行
    }
return
;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ   F5 & b 启动 / 关闭uTools.exe  ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ 00010-2909




/*
保存后  自动刷新脚本                                        01-45
复制后通知                                                            02-68
限制单进程运行                                                         03-95
art+q 批量复制粘贴                                          04-249
 >! 2345sdf复制  wertxcv 粘贴                       05-322
 >^c 复制文件名 >^x 获取路径                     06-369
 >^v 对文件夹文件粘贴文件名                      07-376
Appskey & 1  全屏截存桌面选格式                      001-392
Appskey & 6 当前窗口 截图并贴图                     002-399
Appskey & 2  录屏gif                                        003-405
Appskey & 3 录屏MP4                                       004-411
Appskey & 4  剪贴板中截图保存于desktop                 005-415
Appskey & 5  后台间隔截图 全屏                      008-492
shift+alt+a  框选画中画                                        009-495
win+Esc  框选OCR                                         010-498
+#s  截图  剪贴板 desktop                                     011-507
<!esc  截图 OCR                                                      012-518
F9+9 贴图                                                              013-588
Shift+鼠标滚动   改变粘贴的透明度                            014-588
鼠标滚轮改变贴图大小 双击关闭                              015-588
F9+0 隐藏或显示所有粘贴                                    016-619
F9+- 关闭贴图                                                           017-632
F9+= 打开图并设置为贴图                                     018-639
F9 & 8 剪贴板贴图 放大到1.25倍                       019-645
F1 & y 右键属性                                                         0001-653
F1 & k 打开快捷方式的文件夹                       00004-838
^+z 打开当前活动窗口的文件夹                      00005-846
Rctrl & 5 打开 v2rayN                                       00007-887
Rctrl & t 打开托盘 v2rayN                                    00008-894
F1 & [ 启动 F1 & ] 退出 SnoMouse                    00009-917
Rctrl & 1  打开 chrome                                        00011-969
Rctrl & 2   打开 EmEditor                                      00012-999
Rctrl & 3  打开 资源处理器                                      00013-1026
Rctrl & 4  打开 微信                                          00014-1062
F6 & d 大小写 首字母大写                                       000002-1124
shift+中键按下 复原                                                      000004-1176
NumpadEnter 重启脚本                                     000005-1180
+appskey   Tab                                                       000006-1187
<^!z   撤消                                                           000007-1192
<!z  窗口左半，右半切换                                       000008-1261
< !x  切换窗口  70%·····100%                                       000009-1329
!+左键 移窗口 #+左键 调窗口大小                    000011-1363
 >^b  单 新建文件夹 双 TxT文件  名为剪贴板                  000013-1506
F12  代理 变量 管理 控制台 组件服务                   000015-1571
F11 控制面板 IP 组策略 网络连接 共享                    000016-1593
CapsLock  浏览器  1全局 2auto 3直连                    000017-1631
 >^q 上一页                                                         000018-1637
 >^e 下一页                                                         000019-1643
F4 & -  计时器                                                       000020-1660
++ keepast                                                            0000001-1665
<!1 复整行　<!q 到行首  <!a 到行尾                   0000002-1679
<!2 粘整行  <!w 光标前 <!s 光标后                     0000003-1690
<!3 剪整行  <!e 光标前   <!d 光标后                    0000004-1701
<#1选整行　<#q到行首 <#a到行尾                    0000005-1712
<#2 选整段  <#w光标前 <#s光标后                    0000006-1723
<#3 删整行 <#e 光标前 <#d 光标后                   0000007-1736
F2 & F1 快速向上滚动                                                      00000001-1765
F2 & F3 快速向下滚动                                                      00000002-1789
F2 & Esc 缓慢向上滚动                                                     00000003-1812
F2 & F4 缓慢向下滚动                                                      00000004-1838

F1 & z  上传截图到github/img                                    000001-1984
F1 & x  上传截图到github/img                                    000002-2000
F1 & c  上传截图到图库                                        000003-2013
F1 & v  上传截图到图库                                        000004-2037
F1 & b  上传剪贴板中的文件                                     000005-2051
F1 & n  上传剪贴板中的文件                                     000006-2067
adws 上 下 左 右                                                       0000001-2076
q 退格 e 删除 f 回车                                                     0000002-2081
AppsKey & g 任意位置回                                       0000003-2087
F1 & 1 用Evething搜索选中的文字                         00000001-2102
F1 & 2   谷歌翻译  中/ 英                                       00000002 -2128
F1 & 3 Mobi                                                         00000003-2183
 F1 & 4 用百度搜索选中的文字                               00000004-2190
 F1 & 5 用谷歌搜索选中的文字                               00000005-2197
F1 & 6 Mobi                                                         00000006-2220
 F1 & 7 腾讯翻译                                                   00000007-2227
 F1 & 8  youtube                                                  00000008-2235
 F1 & 0 百度翻译                                                   00000009-2242
F1 & = 腾讯翻译                                                   00000009-2252
 F1 & 9  wiki                                                         00000010-2260
F4 & z 注销                                                           000000001-2280
F4 & c 重启                                                           000000002-2285
F4 & g 关机                                                          000000003-2291
F4 & d 待机                                                          000000004-2299
F4 & q 重启资源管理器                                         000000005-2305
F4 & q 重启资源管理器                                         000000006-2312
F4 & p 关屏                                                          000000007-2318

3个12345  aoeiuü                                                 01-2354
`m::<br>                                                               02-2368
。，：；、 • ……                                                   03 -2380
F6 & O 橙色   joplin字体颜色                                04 -2434
F7 & O 橙色   joplin字体颜色                                05-2484
F8 & O 橙色 Tyora 背景色                                    06 -2532
F9 & O 橙色 Tyora 背景色                                    07-2582
F7 & 1-7  Tyora 字号                                            08-2609
#F2 行首 行尾                                                       09-2625
#F3 段首 段尾                                                       10 -2638
#F4 页首 页尾                                                       11-2651
F6 & 1  选中 合并多行空行为１行                         12-2665
F6 & 2  选中 删除空行                                          13-2706
F6 & 3 选中 添加空行                                           14-2715
F6 & 4  选中 空格及回车 变换行                            15-2725
F6 & 5 多行文字合并成一行                                  16-2739
F6 & 6  选中 删除空格                                          17-2752
F6 & 7  选中 多个空格变一个                                18-2762
F6 & 8  选中  只删除首尾空格                               19-2773
F6 & 9 Tab替换成空格                                           20-2788
F6 & F1 标题添加序号等                                        001-2803 
F6 & F2 确定已经掌握了请打上对勾                       002-2812 
F6 & F4 Tyora 居中                                               003-2828
F6 & F5  > :v:                                                        004-2838 
F6 & F7 Tyora 代码块                                            005-2854
F6 & F8 上标                                                         006-2870
F6 & F9 下标                                                         007-2886

F5 & v  FSCapture.exe                                          006-452
F5 & b  Umi-OCR.exe                                           007-487
F5 & 1  隐藏任务栏                                                0002-679
F5 & 2  隐藏桌面图标                                            0003-690
F5 & 3  隐.显桌面                                                  0004-706
F5 & - 显示扩展名 F5 & = 显隐文件                      0005-728
F5 & 4  缩略图                                                      0006-757
F5 & 5 显示预览窗格                                             0007-762
F5 & 6  窗口置顶                                                   0008-782
F5 & e  帮助文档                                                   00001-796
F5 & 9  快捷键目录                                                00002-801
F5 & 0  快捷键目录                                               00003-806
F5 & 8   EmEditor打开3文件                                 00006-856
F5 & c[ 启动 / 关闭ZoomIt64.exe                          00010-938
F5 & /  VS Code                                                   00015-1067
F5 & F4  AltTab                                                    000001-1074
F5 & ,   锁键盘鼠标                                                000003-1129
F5 & 7  二维码                                                      000010-1340
F5 & . 切换鼠标左右键                                           000012-1467
F5 & u  文字转语音                                               000014-1531
F5 & o 获得 RGB 值                                              000000001-1853
F5 & p 显示颜色                                                    000000002-1890
F5 & [  颜色值 鼠标跟随                                         000000003-1951
F5 & ] 获取当前鼠标指针的坐标                             000000004-1959
F5 & b 启动 / 关闭uTools.exe                               00010-2909
*/