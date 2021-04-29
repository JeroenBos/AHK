#InstallKeybdHook
SetKeyDelay, 0

WheelDown:: 
    IfWinActive , ahk_exe vlc.exe
	    Send {Volume_Down}
	else if YouTubeActive()
		Send {Volume_Down}
	else
		Send {WheelDown}
Return

WheelUp:: 
    IfWinActive , ahk_exe vlc.exe
	    Send {Volume_Up}
	else if YouTubeActive()
		Send {Volume_Up}
	else
		Send {WheelUp}
Return