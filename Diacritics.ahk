StringCaseSense, On
^'::
{
   Input, char, L1
   if char = a
      Send á
   else if char = A
      Send Á
   else if char = e
      Send é
   else if char = E
      Send É
   else if char = i
      Send í
   else if char = I
      Send Í
   else if char = o
      Send ó
   else if char = O
      Send Ó
   else if char = u
      Send ú
   else if char = U
      Send Ú
   else if char = c
      Send ç
   else if char = C
      Send Ç
   else if char = y
      Send ý
   else if char = Y
      Send Ý
   else 
      Send %char% ;ignores ctrl+' is if it isn't followed by any of aeioucyAEIOUCY
   return
}

^`::
{
   Input, char, L1
   if char = a
      Send à
   else if char = A
      Send À
   else if char = e
      Send è
   else if char = E
      Send È
   else if char = i
      Send ì
   else if char = I
      Send Ì
   else if char = o
      Send ò
   else if char = O
      Send Ò
   else if char = u
      Send ù
   else if char = U
      Send Ù
   else 
      Send %char% ;ignores ctrl+` is if it isn't followed by any of aeiouAEIOU
   return
}


^+6:: ; +6 is circumflex
{
   Input, char, L1
   if char = a
      Send â
   else if char = A
      Send Â
   else if char = e
      Send ê
   else if char = E
      Send Ê
   else if char = i
      Send î
   else if char = I
      Send Î
   else if char = o
      Send ô
   else if char = O
      Send Ô
   else if char = u
      Send û
   else if char = U
      Send Û
   else 
      Send %char% ;ignores ctrl+^ is if it isn't followed by any of aeiouAEIOU
   return
}

^~::
{
   Input, char, L1
   if char = a
      Send ã
   else if char = A
      Send Ã
   else if char = i
      Send ĩ
   else if char = I
      Send Ĩ
   else if char = n
      Send ñ
   else if char = N
      Send Ñ
   else if char = o
      Send õ
   else if char = O
      Send Õ
   else 
      Send %char% ;ignores ctrl+~ is if it isn't followed by any of ainoAINO
   return
}

^"::
{
   Input, char, L1
   if char = a
      Send ä
   else if char = A
      Send Ä
   else if char = e
      Send ë
   else if char = E
      Send Ë
   else if char = i
      Send ï
   else if char = I
      Send Ï
   else if char = o
      Send ö
   else if char = O
      Send Ö
   else if char = u
      Send ü
   else if char = U
      Send Ü
   else if char = y
      Send ÿ
   else if char = Y
      Send Ÿ
   else 
      Send %char% ;ignores ctrl+" is if it isn't followed by any of aeiouyAEIOUY
   return
}

^#o::ø
^#a::å
^#e::æ
^+#o::Ø
^+#a::Å
^+#e::Æ
