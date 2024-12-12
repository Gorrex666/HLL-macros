;// CALCULATOR //
Process, Priority,, A

; Options for different nations
xMin := 100, xMax := 1600
options := {}
options["us/ge"] := { "m": -0.237, "b": 1001.465 }
options["ru"] := { "m": -0.214, "b": 1141.722 }
options["uk"] := { "m": -0.177, "b": 550.69 }

; History data
lastInputs := [], lastResults := []

; Main GUI
Gui, Color, afaca9
Gui, Font, s11, Bold
Gui -sysmenu -caption
Gui, Show, x1848 y923 w70 h44, Comp
Gui, Add, DropDownList, vNationSelect gUpdateResult x49 y-9 w39 h110, us/ge|ru|uk
Gui, color,, afaca9
Gui, Add, Edit, vDistanceInput gUpdateResult x7 y-5 w35 h20
Gui, Font, s20, Bold
Gui, Add, Text, vResultText x-4 y12 w75 h30 center

; Update Result
UpdateResult:
    SetTimer, DelayedUpdate, -400
Return

DelayedUpdate:
    Gui, Submit, NoHide
    if (StrLen(DistanceInput) >= 3 && DistanceInput != lastInputs[lastInputs.Length()]) {
        result := calculate(DistanceInput, NationSelect)
        if (!IsNumber(result)) {
            GuiControl, , ResultText,
        } else {
            GuiControl, , ResultText, %result%
            updateHistory(DistanceInput, result)
            updateHistoryDisplay()
        }
    }
Return

; Calculation
calculate(x, nation) {
    global options, xMin, xMax
    if (x >= xMin && x <= xMax) {
        m := options[nation].m, b := options[nation].b
        return Round(m * x + b)
    }
}

; Update History
updateHistory(input, result) {
    global lastInputs, lastResults
    if (lastInputs.MaxIndex() > 7) {
        lastInputs.RemoveAt(1), lastResults.RemoveAt(1)
    }
    lastInputs.Push(input), lastResults.Push(result)
}

; Format and Update History Display
updateHistoryDisplay() {
    global lastInputs, lastResults, historyWindowVisible
    if (!historyWindowVisible) return
    text := ""
    Loop % lastInputs.Length() {
        idx := lastInputs.Length() - A_Index + 1
        text .= lastInputs[idx] "m | " lastResults[idx] "`n"
    }
    GuiControl, 2:, HistoryList, %text%
}

; Toggle History Window
~down::
    if (historyWindowVisible) {
        Gui, 2:Destroy
        historyWindowVisible := false
    } else {
        Gui, 2:New, , History
        Gui, Color, afaca9
        Gui -sysmenu -caption
		Gui, Font, s11, Bold
        Gui, Add, Text, x0 y0 w80 h110 vHistoryList center
        Gui, Show, x1839 y968 w80 h110
        WinSet, AlwaysOnTop, On, History
        historyWindowVisible := true
        updateHistoryDisplay()
    }
Return

; Hotkeys
~`::
WinActivate, Comp
Send ^a{Backspace}
Return

up:: WinSet, AlwaysOnTop, Toggle, Comp

; Helper
IsNumber(value) {
    return (value is number)
}

;//MISC//

#MaxThreadsPerHotkey 2

~pgdn::Reload ;Recarga el script

~f12::ExitApp ;Cierra

#IfWinActive ahk_exe HLL-Win64-Shipping.exe

~f4:: ;LOOP r
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
Sendinput {r Down}
Sleep, 200
Sendinput {r Up}
}
Return

~CapsLock:: ;HOLDS "W" capslock, "S"  alt+capslock (on/off)
KeyDown := !KeyDown
If KeyDown
SendInput {w down}
Else
SendInput {w up}
Return
!CapsLock::
KeyDown := !KeyDown
If KeyDown
SendInput {s down}
Else
SendInput {s up}
Return

~j:: ;HOLDS F por 5 seCS J.
{
Sleep, 200
SendInput, {f Down}
Sleep, 7000
SendInput, {f Up}
}
Return

~=:: ;HOLDS LEFT click (on/off)
KeyDown := !KeyDown
If KeyDown
SendInput {Click down}
Else
SendInput {Click up}
Return

;//ARTILLERY SCRIPTS//
~/:: ;RELOAD
{
Gosub DELAY
Gosub AMMO
}
Return

~.:: ;RELOAD AND SHOOT
{
Gosub DELAY
Gosub AMMO
Gosub SHOOT
}
Return

~,:: ;3 SHOTS (fire mission)
{
Gosub DELAY
Gosub AMMO
Gosub SHOOT
Gosub AMMO
Gosub SHOOT
Gosub AMMO
Gosub SHOOT
}
Return

~;:: ;4 shots(15 MTS dispersion) Dynamic
{
gui, Submit, NoHide ; Ensure the distance is updated from GUI
distance := DistanceInput ; Get the distance input
Time := Round(((800 * 1075) / distance) / 15 * 15) ; Calculate the press time, Split Time into two parts if it's greater than 800 ,Add a third value if the total is less than 1400
V1 := (Time > 800) ? 800 : Time
V2 := (Time > 800) ? (Time - 800) : 0
TotalTime := V1 + V2
V3 := (TotalTime < 1400) ? (1400 - TotalTime) : 0
Gosub DELAY
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sendinput {r Down}
Sendinput {r Up}
Send {r Down}
Send {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, V2
Send, {f2 Down}
SendInput, {f2 Down}
Sleep, V1 
SendInput {Click down}
SendInput {Click up}
SendInput, {a Up}
Sleep, V3
Send, {f2 up}
SendInput, {f2 Up}
Gosub AMMODYN
Gosub SRCONTDYN
Gosub AMMODYN
Sleep, 50
SendInput, {d Down}
Sleep, V2
Sleep, V1 
Send {Click down}
Send {Click up}
SendInput, {d Up}
Sleep, 50
}
Return

~F5:: ;LOOP RELOAD AND SHOOT
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
Gosub DELAY
Gosub AMMO
Gosub SHOOT
}
Return

F6:: ;4 shots loop(15 MTS dispersion) Dynamic 
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
gui, Submit, NoHide ; Ensure the distance is updated from GUI
distance := DistanceInput ; Get the distance input
Time := Round((800 * 1075) / distance) ; Calculate the press time, Split Time into two parts if it's greater than 800 ,Add a third value if the total is less than 1400
V1 := (Time > 800) ? 800 : Time
V2 := (Time > 800) ? (Time - 800) : 0
TotalTime := V1 + V2
V3 := (TotalTime < 1400) ? (1400 - TotalTime) : 0
Gosub DELAY
SendInput, {f2 Down}
Sleep, 1400
SendInput, {f2 Up}
Sendinput {r Down}
Sendinput {r Up}
Send {r Down}
Send {r Up}
Sleep, 3300
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
SendInput, {a Down}
Sleep, V2
Send, {f2 Down}
SendInput, {f2 Down}
Sleep, V1 
SendInput {Click down}
SendInput {Click up}
SendInput, {a Up}
Sleep, V3
Send, {f2 up}
SendInput, {f2 Up}
Gosub AMMODYN
Gosub SRCONTDYN
Gosub AMMODYN
Gosub SRCONTDYN
Gosub AMMODYN
SendInput, {a Down}
Sleep, V2
Sleep, V1 
SendInput, {a Up}
}
Return

~f11:: ;"FIRE MISSION OVER" por chat
{
Sleep, 200
Goto CHATY
}
Return

;//LABELS//

DELAY:
Sleep, 200
SendInput {Click down}
Sleep, 50
SendInput {Click down}
SendInput {Click up}
return

AMMO:
SendInput, {f2 Down}
Sleep, 1300
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 150
Sendinput {r Up}
Send {r Down}
Send {r Up}
Sleep, 3300
Send, {f1 Down}
SendInput, {f1 Down}
Sleep, 1300
SendInput, {f1 Up}
Send, {f1 Up}
return

SHOOT:
SendInput {Click down}
Sleep, 50
SendInput {Click down}
SendInput {Click up}
return

AMMODYN:
Sendinput {r Down}
Sleep, 50
Sendinput {r Up}
Send {r Down}
Send {r Up}
Sleep, 3300
Send, {f1 Down}
SendInput, {f1 Down}
Sleep, 1400
SendInput, {f1 Up}
Send, {f1 Up}
return

SRCONTDYN:
SendInput, {d Down}
Sleep, V2
Send, {f2 Down}
Sleep, V1 
Send {Click down}
Send {Click up}
SendInput, {d Up}
Sleep, V3 
Send, {f2 Up}
return

CHATY:
Random, rand, 21, 23
SendInput {k Down}
SendInput {k Up}
Send, >fire stop, approx{space}
Send, %rand%
Send, {space}secs.
SendInput {enter Down}
SendInput {enter Up}
return
