;;;// CALCULATOR // ;;;dispersion is wrong at long ranges series of shots with low dispersion (at shots with lower dispersion of 1.2 degrees it will always turn 1.2 degrees as a minimum "error start at 1000 mts and scales to limit dispersion to 30 mts between shooting points at 1600 mts"), it surely can be fixed but the firing rate will be the same

Process, Priority,, A
#MaxThreadsPerHotkey 2
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

; Hotkeys

~`::
WinActivate, Comp
SendInput ^a{Backspace}
Return

~up:: WinSet, AlwaysOnTop, Toggle, Comp

; Helper
IsNumber(value) {
    return (value is number)
}

;//MISC//

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
HandleShots(20)
Return

~':: ; 4 shots (30 MTS dispersion) Dynamic
HandleShots(30)
Return

~\:: ; 4 shots (40 MTS dispersion) Dynamic
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
HandleShotLoop(20)
Return

~F7:: ; Loop 4 shots (30 MTS dispersion)
HandleShotLoop(30)
Return

~F8:: ; Loop 4 shots (40 MTS dispersion)
HandleShotLoop(40)
Return

; Functions
HandleShots(dispersion) {
    global
    Gui, Submit, NoHide ; Ensure the distance is updated from GUI
    distance := DistanceInput ; Get the distance input
    Time := Round(((101 * 28436) / distance) / 49.48 * dispersion) ; Calculate the press time
    ; Initialize all parts
    Part1N := 0 ; The natural state of Part1
    Part1A := 0 ; Artificial filling for Part1
    Part2N := 0 ; The natural state of Part2
    Part2A := 0 ; Artificial filling for Part2
    Part3 := 0  ; Remaining time
    ; Calculate Part1 Natural and Artificial
    if (Time >= 800) {
        Part1N := 800
        Part1A := 0
    } else {
        Part1N := Time
        Part1A := 800 - Time
    }
    ; Calculate remaining time after Part1
    RemainingTime := Max(Time - 800, 0)
    ; Calculate Part2 Natural and Artificial
    if (RemainingTime >= 400) {
        Part2N := 400
        Part2A := 0
    } else {
        Part2N := RemainingTime
        Part2A := 400 - RemainingTime
    }
    ; Calculate Part3 (remainder after 1200 is allocated)
        Part3 := Time - (Part1N + Part1A + Part2N + Part2A)
    }
    ; Ensure all values are positive
    Part1N := Max(Part1N, 0)
    Part1A := Max(Part1A, 0)
    Part2N := Max(Part2N, 0)
    Part2A := Max(Part2A, 0)
    Part3 := Max(Part3, 0)
Gosub DELAY
Gosub AMMO
SendInput, {a Down}
Sleep, Part3
SendInput, {F2 Down}
Sleep, Part1N
Sleep, Part1A
SendInput, {a Up}
SendInput {Click down}{Click up}
Sleep, Part2N
Sleep, Part2A
SendInput, {F2 Up}
Gosub AMMODYN
Gosub SRDYN 
Gosub AMMODYN
SendInput, {d Down}
Sleep, Part3
Sleep, Part1N
Sleep, Part1A
Sleep, Part2N
Sleep, Part2A
SendInput, {d Up} 
SendInput {Click down}{Click up}
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
    Time := Round(((101 * 28436) / distance) / 49.48 * dispersion) ; Calculate the press time
    ; Initialize all parts
    Part1N := 0 ; The natural state of Part1
    Part1A := 0 ; Artificial filling for Part1
    Part2N := 0 ; The natural state of Part2
    Part2A := 0 ; Artificial filling for Part2
    Part3 := 0  ; Remaining time
    ; Calculate Part1 Natural and Artificial
    if (Time >= 800) {
        Part1N := 800
        Part1A := 0
    } else {
        Part1N := Time
        Part1A := 800 - Time
    }
    ; Calculate remaining time after Part1
    RemainingTime := Max(Time - 800, 0)
    ; Calculate Part2 Natural and Artificial
    if (RemainingTime >= 400) {
        Part2N := 400
        Part2A := 0
    } else {
        Part2N := RemainingTime
        Part2A := 400 - RemainingTime
    }
    ; Calculate Part3 (remainder after 1200 is allocated)
        Part3 := Time - (Part1N + Part1A + Part2N + Part2A)
    }
    ; Ensure all values are positive
    Part1N := Max(Part1N, 0)
    Part1A := Max(Part1A, 0)
    Part2N := Max(Part2N, 0)
    Part2A := Max(Part2A, 0)
    Part3 := Max(Part3, 0)
Gosub DELAY
Gosub AMMO
SendInput, {a Down}
Sleep, Part3
SendInput, {F2 Down}
Sleep, Part1N
Sleep, Part1A
SendInput, {a Up}
SendInput {Click down}{Click up}
Sleep, Part2N
Sleep, Part2A
SendInput, {F2 Up}
Gosub AMMODYN
Gosub SRDYN 
Gosub AMMODYN
Gosub SRDYN 
Gosub AMMODYN
SendInput, {a Down}
Sleep, Part3
Sleep, Part1N
Sleep, Part1A
Sleep, Part2N
Sleep, Part2A
SendInput, {a Up}
    }
}

;//LABELS//

DELAY:
Sleep, 200
SendInput {Click down}{Click up}
return

SHOOT:
SendInput {Click down}{Click up}
return

AMMO:
SendInput, {f2 Down}
Sleep, 1200
SendInput, {f2 Up}
Sleep, 100
SendInput {r Down}{r Up}
Sleep, 3500
SendInput, {f1 Down}
Sleep, 1200
SendInput, {f1 Up}
return

AMMODYN:
Sleep, 100
SendInput {r Down}{r Up}
Sleep, 3500
SendInput, {f1 Down}
Sleep, 1200
SendInput, {f1 Up}
return

SRDYN:
SendInput, {d Down}
Sleep, Part3
SendInput, {f2 Down}
Sleep, Part1N
Sleep, Part1A
SendInput, {d Up}
SendInput {Click down}{Click up}
Sleep, Part2N
Sleep, Part2A
SendInput, {f2 Up}
return
