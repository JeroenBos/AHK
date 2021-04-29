#InstallKeybdHook
SetKeyDelay, 0

MButton::
    MsgBox Hi
    ctrl_down = true
    Send {Ctrl Down}
Return

^MButton::
    ctrl_down = false
    Send {Ctrl Up}
Return

^XButton1::
    if(ctrl_down)
    {
        Loop
        {
            GetKeyState, state, XButton1, P
            if state = U ; The key has been released, so break out of the loop.
                break
            Send {Volume_Down} 
            Sleep, 40
        }		
    }
Return

^XButton2:: 
    if(ctrl_down)
    {
        Loop
        {
            GetKeyState, state, XButton2, P
            if state = U ; The key has been released, so break out of the loop.
                break
            Send {Volume_Up} 
            Sleep, 60
        }
    }
Return

