;comment

#InstallKeybdHook
SetNumLockState AlwaysOn
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


return
