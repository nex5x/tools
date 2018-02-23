Dim IE 

if WScript.Arguments.count =0 then s=" " else s=wscript.arguments(0)
Set IE = CreateObject("InternetExplorer.Application") 
IE.Navigate "about:blank" 
Set screen3389 = IE.Document.parentWindow.screen

Set objShell = CreateObject("Wscript.Shell")
objShell.Run "mstsc /h:" & int(screen3389.height*.9)  & " /w:"& int(screen3389.width*.9) & " /v:" &s