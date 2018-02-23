set oArgs = WScript.Arguments
ss=oArgs(0)
s=Split(ss,";",-1,TEXT)
For i = 0 To UBound(s)
	WScript.Echo s(i)
next
