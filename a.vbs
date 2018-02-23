Set objArgs = WScript.Arguments
If objArgs.count =0 then wscript.quit
num=objArgs(0)
   if num=0 or isnull(num) then
       formatnuma="0"
   else
       formatnuma=formatnumber(num)
   end if
   
WScript.echo formatnuma