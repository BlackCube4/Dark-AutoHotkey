#NoEnv
#Include Class_ImageButton.ahk
#Include UseGDIP.ahk

;Make Tray Menu Dark
uxtheme := DllCall("GetModuleHandle", "str", "uxtheme", "ptr")
SetPreferredAppMode := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 135, "ptr")
FlushMenuThemes := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 136, "ptr")
DllCall(SetPreferredAppMode, "int", 1) ; Dark
DllCall(FlushMenuThemes)

;Create a Gui with dark Title bar
Gui, New , HwndDarkGui, Dark Gui
DllCall("dwmapi\DwmSetWindowAttribute", "ptr", DarkGui, "int", "20", "int*", true, "int", 4)

;Set Margin Color and Font
GuiColor := "0x191919"
GuiElementsColor := "0x333333"
GuiElementsBorderColor := "0x454545"
GuiElementsRadius := 5
Gui, Margin, 15, 15
Gui, Font, s10 q4, ;Segoe UI
Gui, Color, %GuiColor%, %GuiElementsColor%
ImageButton.SetGuiColor(GuiColor)

;Options for Buttons
Opt1 := [0, GuiElementsColor, , "White", GuiElementsRadius, , GuiElementsBorderColor, 1]
Opt2 := [0, 0x414141]

;Create Button
Gui, Add, Button, x15 w200 hwndHBT1, Button 1`nLine 2
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)

;Create Rounded Edit Field
Gui, Add, Button, x15 w200 h30 hwndHBT1 vBackground1,
ImageButton.Create(HBT1, Opt1, Opt1, , , Opt1)
Gui, Add, Edit, x+-195 y+-23 w190 h16 Center -E0x200 cWhite, Ist dieser Text nicht ein schönes Beispiel ;-E0x200 -> no border

;Create Rounded Edit Field with scroll bar
Gui, Add, Button, x15 w200 h102 hwndHBT1 vBackground2,
ImageButton.Create(HBT1, Opt1, Opt1, , , Opt1)
Gui, Add, Edit, x+-194 y+-100 w192 h98 vMyEdit1 hwndEdit1 -E0x200 cWhite, Das ist ein Beispiel- `ntext
DllCall("uxtheme\SetWindowTheme", "ptr", Edit1, "str", "DarkMode_Explorer", "ptr", 0)

;create Rounded progress bar
Gui, Add, Button, x15 w200 h22 hwndHBT1 vBackground3,
ImageButton.Create(HBT1, Opt1, Opt1, , , Opt1)
Gui, Add, Progress, x+-199 y+-21 w198 h20 Background%GuiElementsColor% c005FB8 vProgress, 33

;create Rounded UpDown
Gui, Add, Button, x15 w200 h26 hwndHBT1 vBackground4,
ImageButton.Create(HBT1, Opt1, Opt1, , , Opt1)
Gui, Add, Edit, x+-195 y+-21 w190 h16 Center -E0x200 cWhite
Gui, Add, UpDown, Hidden vMyRoundUpDown Range1-10, 5
Gui, Add, Picture, x+-14 y+-21 gUpRound, UpRound.png
Gui, Add, Picture, y+-0 gDownRound, DownRound.png

;create Checkbox
Gui, Add, CheckBox, Checked x15 y+15 w20 h20 vCheckbox,
Gui, Add, Text, x+-0 y+-18 w98 h20 +Left cWhite gCheckbox, installed ffmpeg

;Disable Background Buttons
loop 100
	GuiControl, Disable, % "Background" . A_Index

;Let it load the Dark Changes
Gui, Show, Hide
Gui, Show

Return

UpRound:
Gui, Submit, NoHide
GuiControl, , MyRoundUpDown, % MyRoundUpDown + 1
return

DownRound:
Gui, Submit, NoHide
GuiControl, , MyRoundUpDown, % MyRoundUpDown - 1
return

Checkbox:
Gui, Submit, NoHide
GuiControl, , Checkbox, % Checkbox * (- 1) + 1
return

GuiClose:
GuiEscape:
ExitApp

