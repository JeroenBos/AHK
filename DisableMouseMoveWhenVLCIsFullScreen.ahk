#InstallMouseHook
; for debugging remember to press F5 after starting debugging to trigger the global code

SetTitleMatchMode, 2
TIMER_PERIOD = 1000
PREVENT_BLOCK_SINCE_L_BUTTON = 10000
PREVENT_BLOCK_SINCE_VLC_ACTIVE = 10000

SetTimer checkVLCActive, %TIMER_PERIOD%




LButtonShortcutActive = false
; time stamp for the last action that prevented blocking mouse input
preventBlockingTimeStamp := -1

; time stamp for since when vlc has been active
vlcBecameActiveTimeStamp := -1 ; is -1 if vlc is not active


checkVLCActive:
{
	if (WinActive("VLC media player"))
	{
		OutputDebug active
		if(vlcBecameActiveTimeStamp = -1) 
		{
			vlcBecameActiveTimeStamp := A_TickCount
		}
		if(preventBlockingTimeStamp = -1) 
		{
			preventBlockingTimeStamp := A_TickCount
		}
		if(preventBlockingTimeStamp <> -1 and vlcBecameActiveTimeStamp <> -1)
		{
			blockNotPreventedForDuration := A_TickCount - preventBlockingTimeStamp
			vlcActiveDuration := A_TickCount - vlcBecameActiveTimeStamp
			
			OutputDebug blockNotPreventedForDuration=%blockNotPreventedForDuration%, vlcActiveDuration=%vlcActiveDuration%
			
			if(vlcActiveDuration > PREVENT_BLOCK_SINCE_VLC_ACTIVE and blockNotPreventedForDuration > PREVENT_BLOCK_SINCE_L_BUTTON) {
				blockMouseInput()
			}
		}
	} else {
		
		OutputDebug not active
		vlcBecameActiveTimeStamp := -1
		unblockMouseInput()
	}

	return
}

$LButton::
{
	unblockMouseInput()
    Send {LButton}
	return
}

$Esc::
{
	unblockMouseInput()
	Send {Esc}
	return
}

blockMouseInput()
{
	OutputDebug blocking
	global LButtonShortcutActive 
	BlockInput MouseMove
	LButtonShortcutActive := true
    Hotkey, LButton, On
}
unblockMouseInput()
{
	OutputDebug unblocking
	global preventBlockingTimeStamp
	global vlcBecameActiveTimeStamp
	preventBlockingTimeStamp := -1
	BlockInput MouseMoveOff
	LButtonShortcutActive := false
	Hotkey, LButton, Off
}