#InstallMouseHook
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


; this script requires Snip and Sketch notifictions to be disabled!


#+PrintScreen::
{
    ; Win+Shift+s is the windows keyboard shortcut for the clip functionality
    Send {LWinDown}+s{LWinUp}
    WaitForClipAndAddToFile()
}


#PrintScreen::
{
    Send {PrintScreen}
    AddToFile()
}


#!PrintScreen::
{
    Send {LAlt Down}{PrintScreen}{LAlt Up}
    AddToFile()
}




WaitForClipAndAddToFile()
{
    KeyWait, LButton, D
    KeyWait, LButton

    AddToFile()
}
AddToFile()
{
    Sleep, 100 ; otherwise ClipToFile is under the current programs
    RunWait, "C:\Program Files\AHK\ClipToFile\ClipToFile.exe"
}
