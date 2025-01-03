#SingleInstance Force
;Todo: add IniWrite for settings, add Uskin, add Animations?
TraySetIcon(A_WorkingDir . "\asset\hydropoxydrop.ico",,true)
view := Gui("+AlwaysOnTop +MaxSize +MinSize200x200 +Resize") ;+AlwaysOnTop
Toggle := false
Duration := 15
Compositing := false
Progress := 0
PrevHotActive := "F6"
PrevHotMode := "F7"
Interval := 10
view.Title := "Hydropoxy"
view.BackColor := "32363B"
filemenu := Menu()
filemenu.Add("&Exit",closeprog)
helpmenu := Menu()
helpmenu.Add("&About",showabout)
helpmenu.Add("&Help",showhelp)
bar := MenuBar()
bar.Add("File",filemenu)
bar.Add("Help",helpmenu)
view.MenuBar := bar
view.Add("Picture","w130 h130 xm",A_WorkingDir . "\asset\hydropoxylogo.png")
view.SetFont(, "MS Sans Serif")
view.SetFont(, "Arial")
view.SetFont(, "Bahnschrift")
view.SetFont("bold underline s24 q5")
titletext := view.Add("Text","cD4D2FC x+5", "Hydropoxy AutoClicker")
view.SetFont(, "MS Sans Serif")
view.SetFont(, "Arial")
view.SetFont(, "Verdana")
view.SetFont("norm s10 q5 cFFFFFF")
modesel := view.Add("DropDownList", "Choose1", ["Auto","Hold"])
stbtn := view.add("Button","Default w100 h40","Start (F6)")
spbtn := view.add("Button","x+m w100 h40","Stop (F6)")
view.Add("Text","xm", "Settings")
statuschk := view.Add("CheckBox","xm Checked","Show Status bar")
soundchk := view.Add("CheckBox","xm Checked","Play sound")
view.Add("Text","xm", "Interval (ms):")
intervalinp := view.Add("Edit","w100 Background202120 r1 x+5 Number Center -WantReturn -WantTab")
view.Add("UpDown", "Range1-10000",Interval)
view.Add("Text","xm", "Activation:")
activekey := view.Add("Hotkey","x+5")
view.Add("Text","x+5", "Mode:")
modekey := view.Add("Hotkey","x+5")
view.Add("Text","xm", "Other")
hpbtn := view.add("Button","xm w75","Help")
abbtn := view.add("Button","x+m w75","About")
view.SetFont("norm s8 q2")
view.Add("Text","xm", "Copyright Pacifiky 2025 All Rights Reserved.`nVersion 1.0`nMade by Pacifiky")
status := view.Add("StatusBar","BackgroundEEEEEE","Idle")
status.SetIcon(A_WorkingDir . "\asset\offico.ico")
spbtn.Enabled := false
modekey.Value := "F7"
activekey.Value := "F6"
view.OnEvent("Close",closeprog)
hpbtn.OnEvent("click",showhelp)
abbtn.OnEvent("click",showabout)
stbtn.OnEvent("click",startclick)
spbtn.OnEvent("click",stopclick)
activekey.OnEvent("change",changekey)
modekey.OnEvent("change",changekey)
intervalinp.OnEvent("change",updinterval)
/*
(*)=>{
MsgBox "Test"
}
*/
statuschk.OnEvent("click",changestatus)
AutoClick(){
Global Toggle
if((!Toggle) | (modesel.Value == 2))
	return
Click
}
showhelp(*){
MsgBox activekey.Value . " to Toggle AutoClick and " . modekey.Value . " to Toggle Mode.","Help","Owner" . view.Hwnd
}
showabout(*){
MsgBox "Copyright Pacifiky 2025 All Rights Reserved","About","Owner" . view.Hwnd
}
startclick(*){
Global Toggle
Toggle := true
stbtn.Enabled := false
spbtn.Enabled := true
titletext.setFont("cF54E7E")
WinSetTransparent 128, "Hydropoxy"
status.SetText("Clicking")
status.SetIcon(A_WorkingDir . "\asset\onico.ico")
if(soundchk.Value)
	SoundBeep 600, 30
}
stopclick(*){
Global Toggle
Toggle := false
stbtn.Enabled := true
spbtn.Enabled := false
titletext.setFont("cD4D2FC")
WinSetTransparent 255, "Hydropoxy"
status.SetText("Idle")
status.SetIcon(A_WorkingDir . "\asset\offico.ico")
if(soundchk.Value)
	SoundBeep 800, 30
}
changestatus(*){
status.Visible := statuschk.Value
}
closeprog(*){
ExitApp
}
changekey(*){
Global PrevHotActive,PrevHotMode
;MsgBox PrevHotActive
if modekey.Value == ""
	modekey.Value := PrevHotMode
else if activekey.Value == ""
	activekey.Value := PrevHotActive
Hotkey PrevHotActive,"off"
Hotkey PrevHotMode,"off"
Hotkey modekey.Value,togglemode,"on"
Hotkey activekey.Value,toggleactive,"on"
PrevHotActive := activekey.Value
PrevHotMode := modekey.Value
stbtn.Text := "Start (" . activekey.Value . ")"
spbtn.Text := "Stop (" . activekey.Value . ")"
}
togglemode(*){
if(modesel.Value == 2)
	modesel.Value := 1
else
	modesel.Value := 2
}
toggleactive(*){
Global Toggle
if(Toggle)
	stopclick
else
	startclick
}
updinterval(*){
Global Interval
Interval := Integer(intervalinp.Value)
SetTimer AutoClick, Interval
}

Hotkey PrevHotMode,togglemode,"on" ;F7::toggleactive
Hotkey PrevHotActive,toggleactive,"on" ;F6::toggleactive

#HotIf Toggle & (modesel.Value == 2)
LButton:: {
;SetKeyDelay 1, 1
While(GetKeyState(ThisHotkey, "P")){
SendEvent '{' ThisHotkey '}'
Sleep Interval
}
}
#HotIf

SetTimer AutoClick, Interval

view.show("h500 w500")
;MsgBox(A_WorkingDir)
TrayTip("Hydropoxy Successfully Init")