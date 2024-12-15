;// CALCULATOR //
;NOTE: TIMING IS WRONG WHEN USING DIFFERENT DISPERSIONS AND RANGES, kind of maked it work adding sleep times (AddTime200,AddTime300,AddTime400) but its a wrong solution, it should work without adding custom wait times, may have to remade that section
Process, Priority,, A

; Options for different nations
xMin := 100, xMax := 1600
options := {}
options["us/ge"] := { "m": -0.237, "b": 1001.465 }
options["ru"] := { "m": -0.214, "b": 1141.722 }
options["uk"] := { "m": -0.177, "b": 550.69 }

; History data
lastInputs := [], lastResults := []
global AddTime := 0
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
        Gui, Show, x1839 y968 w80 h140
        WinSet, AlwaysOnTop, On, History
        historyWindowVisible := true
        updateHistoryDisplay()
    }
Return

; Handlers for adding sleep times
AddTime200:
    AddTime(200)
Return

AddTime300:
    AddTime(300)
Return

AddTime400:
    AddTime(400)
Return

AddTime(ms) {
    global AddTime
    AddTime := ms ; Update the global AddTime variable
}

; Hotkeys

~`::
WinActivate, Comp
Send ^a{Backspace}
Return

~up:: WinSet, AlwaysOnTop, Toggle, Comp

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

~;:: ; 4 shots (20 MTS dispersion) Dynamic
Gosub AddTime200
HandleShots(20)
Return

~':: ; 4 shots (30 MTS dispersion) Dynamic
Gosub AddTime300
HandleShots(30)
Return

~\:: ; 4 shots (40 MTS dispersion) Dynamic
Gosub AddTime400
HandleShots(40)
Return

~F5:: ; Loop reload and shoot
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

~F6:: ; Loop 4 shots (20 MTS dispersion)
Gosub AddTime200
HandleShotLoop(20)
Return

~F7:: ; Loop 4 shots (30 MTS dispersion)
Gosub AddTime300
HandleShotLoop(30)
Return

~F8:: ; Loop 4 shots (40 MTS dispersion)
Gosub AddTime400
HandleShotLoop(40)
Return

; Functions
HandleShots(dispersion) {
    global
    Gui, Submit, NoHide ; Ensure the distance is updated from GUI
    distance := DistanceInput ; Get the distance input
    Time := Round(((200 * 29640) / distance) / 100.348 * dispersion) ; Calculate the press time
V800 := (Time > 800) ? 800 : Time
V500 := (Time > 500) ? Max(0, Min(500, Time - 800)) : 0 ; Clamp V500 to [0, 500]
Vm := (Time > 1300) ? (Time - 1300) : 0
TotalTime := V500 + V800 + Vm
V4 := (TotalTime < 1300) ? (1300 - TotalTime) : 0

    Gosub DELAY
    Gosub AMMO
    SendInput, {a Down}
    Sleep, Vm
	Sleep, V500
    Send, {f2 Down}
    Sleep, V800
    SendInput, {a Up}
	SendInput {Click down}{Click up}
    Sleep, V4
    Gosub AMMODYN
    Gosub SRCONTDYN
    Gosub AMMODYN
    SendInput, {d Down}
    Sleep, Vm
    Sleep, V500
    Sleep, V800
    SendInput {Click down}{Click up}
    SendInput, {d Up}
}

HandleShotLoop(dispersion) {
    global
    Toggle := !Toggle
    Loop
    {
        If (!Toggle)
            Break
			    
 Gui, Submit, NoHide ; Ensure the distance is updated from GUI
    distance := DistanceInput ; Get the distance input
    Time := Round(((200 * 29640) / distance) / 100.348 * dispersion) ; Calculate the press time
    V800 := (Time > 800) ? 800 : Time
V500 := (Time > 500) ? Max(0, Min(500, Time - 800)) : 0 ; Clamp V500 to [0, 500]
    Vm := (Time > 1300) ? (Time - 1300) : 0
    TotalTime := V500 + V800 + Vm
    V4 := (TotalTime < 1300) ? (1300 - TotalTime) : 0
Gosub DELAY
Gosub AMMO
SendInput, {a Down}
Sleep, Vm
Sleep, V500
Send, {f2 Down}
Sleep, V800
SendInput, {a Up}
SendInput {Click down}{Click up}
Sleep, V4 
Gosub AMMODYN
Gosub SRCONTDYN
Gosub AMMODYN
Gosub SRCONTDYN
Gosub AMMODYN
SendInput, {a Down}
Sleep, Vm
Sleep, V500
Sleep, V800 
SendInput, {a Up}
    }
}

~f11:: ;"FIRE MISSION OVER" por chat
{
Sleep, 200
Goto CHATY
}
Return

;//LABELS//

DELAY:
Sleep, 200
SendInput {Click down}{Click up}
return

SHOOT:
Send {Click down}{Click up}
return

AMMO:
SendInput, {f2 Down}
Sleep, 1300
SendInput, {f2 Up}
Sleep, 100
SendInput {r Down}{r Up}
SendInput {r Down}{r Up}
Sleep, 3500
SendInput, {f1 Down}
Sleep, 1300
SendInput, {f1 Up}
return

AMMODYN:
Sleep, 200
sleep, addtime
SendInput {r Down}{r Up}
SendInput {r Down}{r Up}
Sleep, 3500
SendInput, {f2 Up}
SendInput, {f1 Down}
Sleep, 1300
SendInput, {f1 Up}
return

SRCONTDYN:
SendInput, {d Down}
Sleep, Vm
Sleep, V500
Send, {f2 Down}
Sleep, V800
SendInput, {d Up}
SendInput {Click down}{Click up}
Sleep, V4 
return

CHATY:
Random, rand, 21, 23
SendInput {k Down}{k Up}
SendInput, >fire stop, approx{space}
SendInput, %rand%
SendInput, {space}secs.
SendInput {enter Down}{enter Up}
return
