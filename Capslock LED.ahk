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

Insert::
{
   if GetKeyState("Insert", "T") = 0
   {
      send {Insert}
   }
}

Numlock::
{
   SetNumLockState, On
}
