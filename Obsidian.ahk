#InstallMouseHook
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%




WaitForClipAndAddToFile()
{
    KeyWait, LButton, D
    KeyWait, LButton

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
~#+d::
{
    RunWait, "C:\Program Files\AHK\NoteWork\NoteWork.exe"
    return
}

; t for Todo
~#+t::
{
    ; false is the omitPrintscreen parameter
    RunWait, "C:\Program Files\AHK\PrintscreenToTodo\PrintscreenToTodo.exe" "true"
    return
}
