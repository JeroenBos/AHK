#InstallMouseHook
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%




WaitForClipAndAddToFile()
{
    KeyWait, LButton, D
    ; TODO: detect if any other key had been pressed and then cancel
    KeyWait, LButton
    ; TODO: detect if any other key had been pressed and then cancel
    AddToFile()
}
AddToFile()
{
    Sleep, 100 ; otherwise ClipToFile is under the current programs
    ; false is the omitPrintscreen parameter
    RunWait, "C:\Program Files\AHK\PrintscreenToTodo\PrintscreenToTodo.exe" "false"
}





; this script requires Snip and Sketch notifictions to be disabled!




~#+PrintScreen::
{
    ; Win+Shift+s is the windows keyboard shortcut for the clip functionality
    ; Send {LWinDown}+s{LWinUp} 
    ; but we omit it because CommonTypos.ahk already does Win+Shift+s on the same shortcut
    ; and the tilde allows it. And the user experience is better (no Windows Start Menu popping up)
    WaitForClipAndAddToFile()
    return
}
#PrintScreen::
{
    Send {PrintScreen}
    AddToFile()
    return
}
#!PrintScreen::
{
    Send {LAlt Down}{PrintScreen}{LAlt Up}
    AddToFile()
    return
}

; d for Done
#+d::
{
    RunWait, "C:\Program Files\AHK\NoteWork\NoteWork.exe"
    return
}

; t for Todo; for some reason #+t is different than the others, e.g. #+d. tilde is required, otherwise the windows menu pops up
~#+t::
{
    ; "true" is the omitPrintscreen parameter
    RunWait, "C:\Program Files\AHK\PrintscreenToTodo\PrintscreenToTodo.exe" "true"
    return
}


; e for enable
; this unfortunately requires admin rights :/ and probably requires that obsidian.exe is started with admin rights :/
; #+e::
; {
;     RunWait, "C:\Program Files\AHK\ToggleTouchpad\ToggleTouchpad.exe"
;     return
; }
