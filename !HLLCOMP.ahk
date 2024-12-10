;//CALCULATOR//
xMin := 100
xMax := 1600

; Options object for different nations
options := {}
options["us/ge"] := { "m": -0.237035714285714, "b": 1001.46547619048 }
options["ru"] := { "m": -0.2136691176, "b": 1141.7215 }
options["uk"] := { "m": -0.1773, "b": 550.69 }

; Arrays to store the last five inputs and results
lastInputs := []
lastResults := []
historyWindowVisible := false ; Tracks if the history GUI is visible

; Main GUI window
Gui, Color, f3f3f3
Gui, Font, s11, Bold
Gui -sysmenu
Gui, Add, DropDownList, vNationSelect gSubmitInput x0 y-9 w39 h110, us/ge|ru|uk
Gui, Add, Edit, vDistanceInput x39 y-5 w35 h20 gSubmitInput
Gui, Font, s26, Bold
Gui, Add, Text, vResultText x0 y13 w75 h35 center
Gui, Font, s11
Gui, Add, Button, x0 y0 w0 h0 gToggleHistory, Show History ; Button to toggle history
Gui, Show, x1835 y860 w76 h50, Comp

; Set a timer to update the history every 3 seconds
SetTimer, UpdateHistoryInBackground, 3000

SubmitInput:
SetTimer, DelayedUpdate, -50
Return

DelayedUpdate:
Gui, Submit, NoHide
if (StrLen(DistanceInput) >= 3) { ; Only calculate if input has at least 3 characters
    result := calculate(DistanceInput, NationSelect)
    updateHistory(DistanceInput, result)
    GuiControl, , ResultText, %result%
} else {
    GuiControl, , ResultText, ; Clear the result text if input is less than 3 characters
}
Return

calculate(x, nation) {
    global options, xMin, xMax
    if (x >= xMin && x <= xMax) {
        m := options[nation]["m"]
        b := options[nation]["b"]
        return Round(m * x + b)
    }
}

updateHistory(input, result) {
    global lastInputs, lastResults
    ; Check if input and result are numbers
    if (IsNumber(input) && IsNumber(result)) {
        lastInputs.Push(input)
        lastResults.Push(result)
        if (lastInputs.Length() > 8) {
            lastInputs.RemoveAt(1)
        }
        if (lastResults.Length() > 8) {
            lastResults.RemoveAt(1)
        }
    }
}

formatHistory() {
    global lastInputs, lastResults
    text := ""
    Loop % lastInputs.Length() {
        idx := lastInputs.Length() - A_Index + 1
        ; Only append numeric history entries
        if (IsNumber(lastInputs[idx]) && IsNumber(lastResults[idx])) {
            text .= lastInputs[idx] " m | " lastResults[idx] "`n"
        }
    }
    return text
}

UpdateHistoryInBackground:
if (historyWindowVisible) {
    Gui, 2:Submit, NoHide ; Update the history window even if it is not focused
    GuiControl, 2:, HistoryList, % formatHistory()
}
Return

up:: ; Hotkey to toggle history window visibility and always-on-top
ToggleHistory:
if (historyWindowVisible) {
    Gui, 2:Destroy ; Close the history window
    historyWindowVisible := false
} else {
    ; Create and show the history GUI
    Gui, 2:New, , History
    Gui -sysmenu
	Gui -caption
    Gui, 2:Font, s11
    Gui, 2:Add, Text, w100 h140 vHistoryList, % formatHistory()
    Gui, 2:Show, x1830 y720 w88 h140, History 
	-Caption
    WinSet, AlwaysOnTop, On, History ; Ensure the history window is always on top
    historyWindowVisible := true
}
Return

~`:: ; Hotkey to focus on main window and delete text
{
    WinActivate, Comp
    Sendinput ^a
    Sendinput {Backspace}
}
return

down:: ; Toggle "AlwaysOnTop" for main window
WinSet, AlwaysOnTop, Toggle, Comp
return

; Helper function to check if a value is numeric
IsNumber(value) {
    return (value is number)
}

;//MISC//
#MaxThreadsPerHotkey 2

~pgdn::Reload ;Recarga el script

f12::ExitApp ;Cierra

f4:: ;LOOP r (spamea recarga)
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

~CapsLock:: ;Mantiene "W" con capslock "S" con ctrl+capslock (on/off)
KeyDown := !KeyDown
If KeyDown
SendInput {w down}
Else
SendInput {w up}
Return
^CapsLock::
KeyDown := !KeyDown
If KeyDown
SendInput {s down}
Else
SendInput {s up}
Return

~j:: ;Mantiene apretado F por 5 segundos con J.
{
Sleep, 200
SendInput, {f Down}
Sleep, 7000
SendInput, {f Up}
}
Return

~=:: ;Mantiene apretado el click izq con ` (on/off)
KeyDown := !KeyDown
If KeyDown
SendInput {Click down}
Else
SendInput {Click up}
Return

;//SCRIPTS ARTILLERIA//
^1:: ;Recarga
{
Gosub DELAY
Gosub AMMO
}
Return

^2:: ;Recarga y dispara
{
Gosub DELAY
Gosub AMMO
Gosub SHOOT
}
Return

^3:: ;4 tiros(DISPERSION 15 MTS A 800 MTS)
{
Gosub DELAY
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 50
Sendinput {r Up}
Sleep, 50
Send {r Down}
Sleep, 50
Send {r Up}
Sleep, 3400
Send, {f1 Down}
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
Send, {f1 Up}
SendInput, {a Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {a Up}
Gosub SHOOT
Gosub SRCONT
Gosub SHOOT
Gosub SRCONT
Gosub SHOOT
Sleep, 500
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 50
Sendinput {r Up}
Sleep, 50
Send {r Down}
Sleep, 50
Send {r Up}
Sleep, 3400
Send, {f1 Down}
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
Send, {f1 Up}
}
Return

^4:: ;3 tiros (fire mission)
{
Gosub DELAY
Gosub AMMO
Gosub SHOOT
Gosub AMMO
Gosub SHOOT
Gosub AMMO
Gosub SHOOT
Gosub CHATY
}
Return

F5:: ;LOOP Recarga y dispar
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

F6:: ;4 TIROS LOOP (DISPERSION 15 MTS A 800 MTS)
Toggle := !Toggle
Loop
{
If (!Toggle)
Break
Gosub DELAY
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 50
Sendinput {r Up}
Sleep, 50
Send {r Down}
Sleep, 50
Send {r Up}
Sleep, 3400
Send, {f1 Down}
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
Send, {f1 Up}
SendInput, {a Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {a Up}
Gosub SHOOT
Gosub SRCONT
Gosub SHOOT
Gosub SRCONT
Gosub SHOOT
Sleep, 500
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 50
Sendinput {r Up}
Sleep, 50
Send {r Down}
Sleep, 50
Send {r Up}
Sleep, 3400
Send, {f1 Down}
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
Send, {f1 Up}
SendInput, {a Down}
Sleep, 200
Sleep, 800
SendInput, {a Up}
}
Return

f11:: ;"FIRE MISSION OVER" por chat
{
Sleep, 200
Goto CHATY
}
Return

;LABELS
AMMO:
SendInput, {f2 Down}
Sleep, 1500
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 50
Sendinput {r Up}
Sleep, 50
Send {r Down}
Sleep, 50
Send {r Up}
Sleep, 3400
Send, {f1 Down}
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
Send, {f1 Up}
return

SHOOT:
SendInput {Click down}
Sleep, 50
SendInput {Click down}
SendInput {Click up}
return

DELAY:
Sleep, 200
SendInput {Click down}
Sleep, 50
SendInput {Click down}
SendInput {Click up}
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

SRCONT: ;Shoot right continuous, (saves a second by pressing f2 before the shooting take place)
Sleep, 500
SendInput, {f2 Up}
Sendinput {r Down}
Sleep, 50
Sendinput {r Up}
Sleep, 50
Send {r Down}
Sleep, 50
Send {r Up}
Sleep, 3400
Send, {f1 Down}
SendInput, {f1 Down}
Sleep, 1500
SendInput, {f1 Up}
Send, {f1 Up}
SendInput, {d Down}
Sleep, 200
SendInput, {f2 Down}
Sleep, 800
SendInput, {d Up}
return
