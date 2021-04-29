DispatchKey(key)
{
	IfWinExist, ahk_exe wmplayer.exe
	{
		ControlSend, , {%key%} ;even though the controls don't seem to work on WMP, but that might just be WMP settings
		return
	}
	
	IfWinExist, ahk_exe vlc.exe
	{
		ControlSend, , {%key%}
		return
	}

	; send key any other listener (i.e. chrome since it has highest priority and is pretty much always on, at least in the background)
	Send {%key%}
}

$Media_Play_Pause::DispatchKey("Media_Play_Pause")
$Media_Next::DispatchKey("Media_Next")
$Media_Prev::DispatchKey("Media_Prev")