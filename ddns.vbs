    Set objArgs = WScript.Arguments
    If objArgs.count =0 then wscript.quit 
    If objArgs(0)="/D" or objArgs(0)="/d" Then
    	Set fso = CreateObject("Scripting.FileSystemObject")
    	if Fso.FileExists(objArgs(1)) then
    		set  ds=fso.OpenTextFile(objArgs(1),1)
    		dl = ds.readall
    		dl=replace(dl,vbcrlf,"#")
    		dl=replace(dl,"<id>","ID£º")
    		dl=replace(dl,"</id>","  ¡ª¡ª  ")
    		dl=replace(dl,"<name>","Domain£º")
    		dl=replace(dl,"</name>","")
    		    		
    		d=split(dl,"#")
    		for i=1 to (ubound(d)+1)/2
    			WScript.echo  i&"£º"&d(i*2-2)&d(i*2-1)
    		next
    	end if
    ElseIf  objArgs(0)="/R" or objArgs(0)="/r"  Then
    	Set fso = CreateObject("Scripting.FileSystemObject")
    	if objargs.count=1 then wscript.quit
    		if  Fso.FileExists(objArgs(1)) then
    		set  rs=fso.OpenTextFile(objArgs(1),1)
    		i=1
			Do Until rs.AtEndOfStream
				ss=rs.ReadLine
				
				if ss="<domain>" then  we = "Domain "
				if ss="</domain>" then  WScript.echo  we & wen &"£¨"&weid&"£©"
				if ss="<item>" then we ="Item "
				if ss="</item>" then 
					WScript.echo  i&"£º"&wett&"¼ÇÂ¼£º	" & wen &"£¨"&weid&"£©	Ö¸Ïò£º" & wevv
					i=i+1
				end if 
				
				if we ="Domain " then
					if instr(ss,"<id>") then
						ss=replace(ss,"<id>","")
						ss=replace(ss,"</id>","")
						weid= ss
					end if
				
					if instr(ss,"<name>") then
						ss=replace(ss,"<name>","")
						ss=replace(ss,"</name>","")
						wen=ss
											
					end if				
				elseif we="Item " then 
					if instr(ss,"<id>") then
						ss=replace(ss,"<id>","")
						ss=replace(ss,"</id>","")
						weid= ss
					end if
					if instr(ss,"<value>") then
						ss=replace(ss,"<value>","")
						ss=replace(ss,"</value>","")
						wevv= ss
					end if
					if instr(ss,"<type>") then
						ss=replace(ss,"<type>","")
						ss=replace(ss,"</type>","")
						wett= ss
					end if
					if instr(ss,"<name>") then
						ss=replace(ss,"<name>","")
						ss=replace(ss,"</name>","")
						wen=ss
					end if				
				end if
			Loop 	
    		end if 
    else
    		WScript.echo 
    End If   
      
    
    		