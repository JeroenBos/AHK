$Volume_Up::
    SoundGet, volume
    Send {Volume_Up}
    SoundSet, volume + 5
Return

$Volume_Down::
    SoundGet, volume
    Send {Volume_Down}
    SoundSet, volume - 5
Return

; shift + volume button will do smaller delta volume
$+Volume_Up::
    SoundGet, volume
    Send {Volume_Up}
    SoundSet, volume + 2
Return

$+Volume_Down::
    SoundGet, volume
    Send {Volume_Down}
    SoundSet, volume - 2
Return
