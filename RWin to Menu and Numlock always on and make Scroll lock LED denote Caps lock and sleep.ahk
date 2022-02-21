;comment

#InstallKeybdHook
SetNumLockState AlwaysOn
SC15C:: Send {AppsKey}
Capslock::
{
   if GetKeyState("Capslock", "T") = 0
   {
      SetScrollLockState, On
      SetCapsLockState, On
   }
   else
   {
      SetScrollLockState, Off
      SetCapsLockState, Off
   }
   return
}


;^9:: Send \left(
;^0:: Send \right)
;^[:: Send \left[
;^]:: Send \right]

;^{Media_Next}
;!SC12E::
;Send {Media_Prev}
;!SC045::
;Send {Media_Play_Pause}
return

; Numpad -	SC04A
; Volume_Up  	SC130
; Volume_Down 	SC12E
; Pause 	SC045
; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.


^#l::Run C:\Users\Windows\.Sleep.lnk  ; contains `rundll32.exe powrprof.dll,SetSuspendState 0,1,0`
