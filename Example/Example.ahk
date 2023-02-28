#NoEnv
#Include %A_ScriptDir%\Class_ImageButton.ahk
#Include %A_ScriptDir%\UseGDIP.ahk

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
Gui, Margin, 20, 20
Gui, Font, s10 q4, ;Segoe UI
Gui, Color, %GuiColor%, %GuiElementsColor%
ImageButton.SetGuiColor(GuiColor)

;Options for Buttons
Opt1 := [0, GuiElementsColor, , "White", GuiElementsRadius, , GuiElementsBorderColor, 1]
Opt2 := [0, 0x414141]


;Create 2 Buttons
Gui, Add, Button, w200 hwndHBT1, Button 1`nLine 2
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)
Gui, Add, Button, w200 hwndHBT1, Button 2`nLine 2
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)



;Create Rounded Edit Field
Gui, Add, Button, w200 h30 hwndHBT1 vBackground1,
ImageButton.Create(HBT1, Opt1, Opt1, , , Opt1)
Gui, Add, Edit, x+-195 y+-23 h22 w190 Center -E0x200 -Border cWhite, Ist dieser Text nicht ein schönes Beispiel ;-E0x200 -> no border

;Create Rounded Edit Field with scroll bar
Gui, Add, Button, x20 h102 w202 hwndHBT1 vBackground2,
ImageButton.Create(HBT1, Opt1, Opt1, , , Opt1)
Gui, Add, Edit, h98 w194 x+-196 y+-100 vMyEdit1 hwndEdit1 -E0x200 -Border cWhite, Das ist ein Beispiel- `n text
DllCall("uxtheme\SetWindowTheme", "ptr", Edit1, "str", "DarkMode_Explorer", "ptr", 0)

;create Rounded progress bar
Gui, Add, Button, x20 w202 h22 hwndHBT1 vBackground3,
ImageButton.Create(HBT1, Opt1, Opt1, , , Opt1)
Gui, Add, Progress, x+-201 y+-21 w200 h20 Background%GuiElementsColor% c005FB8 vProgress, 33

;create Rounded UpDown
Gui, Add, Button, w200 h30 hwndHBT1 vBackground4,
ImageButton.Create(HBT1, Opt1, Opt1, , , Opt1)
Gui, Add, Edit, x+-195 y+-23 h22 w190 Center -E0x200 -Border cWhite
Gui, Add, UpDown, Hidden vMyRoundUpDown Range1-10, 5

Gui, Add, Picture, x+-14 y+-29 gUpRound, UpRound.png
Gui, Add, Picture, y+-0 gDownRound, DownRound.png



;Create Edit Field
Gui, Add, Progress, x20 w202 h32 Background%GuiElementsBorderColor% vBackground5, 0
Gui, Add, Progress, x+-201 y+-31 w200 h30 Background%GuiElementsColor% vBackground6, 0
Gui, Add, Edit, x+-195 y+-23 h22 w190 Center -E0x200 -Border cWhite, Warum bin ich so schlecht darin mir zufällig Dinge auszudenken?

;Create Edit Field with scroll bar
Gui, Add, Progress, x20 h102 w202 Background%GuiElementsBorderColor% vBackground7, 0
Gui, Add,Edit, h100 w200 x+-201 y+-101 vMyEdit2 hwndEdit2 -E0x200 -Border cWhite, Das ist ein Beispiel- `n text
DllCall("uxtheme\SetWindowTheme", "ptr", Edit2, "str", "DarkMode_Explorer", "ptr", 0)

;create progress bar
Gui, Add, Progress, w202 h22 Background%GuiElementsBorderColor% vBackground8, 0
Gui, Add, Progress, x+-201 y+-21 w200 h20 Background%GuiElementsColor% c005FB8 vProgress2, 66

;create UpDown
Gui, Add, Progress, x20 w202 h32 Background%GuiElementsBorderColor% vBackground9, 0
Gui, Add, Progress, x+-201 y+-31 w200 h30 Background%GuiElementsColor% vBackground10, 0
Gui, Add, Edit, x+-195 y+-23 h22 w190 Center -E0x200 -Border cWhite
Gui, Add, UpDown, Hidden vMyUpDown Range1-10, 5

Gui, Add, Picture, x+-12 y+-26 gUp, Up.png
Gui, Add, Picture, y+-0 gDown, Down.png


;create Checkbox
Gui, Add, CheckBox, Checked x20 y+15 h20 w20 vCheckbox,
Gui, Add, Text, x+-0 y+-18 w98 h20 +Left cWhite gCheckbox, installed ffmpeg

loop 100
	GuiControl, Disable, % "Background" . A_Index

;Let it load the Dark Changes
Gui, Show, Hide
Gui, Show

Return

Up:
Gui, Submit, NoHide
GuiControl, , MyUpDown, % MyUpDown + 1
return

Down:
Gui, Submit, NoHide
GuiControl, , MyUpDown, % MyUpDown - 1
return

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

