//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Method : ParseFile
  // Created 02/04/07 by vdelachaux
  // ----------------------------------------------------
  // Description
  //
  // ----------------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)

C_BLOB:C604($Blb_buffer)
C_LONGINT:C283($Lon_i;$Lon_type;$Lon_x)
C_TIME:C306($Doc_reference)
C_TEXT:C284($Txt_buffer;$Txt_label;$Txt_name;$Txt_path;$Txt_url)

If (False:C215)
	C_TEXT:C284(ParseFile ;$1)
	C_POINTER:C301(ParseFile ;$2)
	C_POINTER:C301(ParseFile ;$3)
	C_POINTER:C301(ParseFile ;$4)
End if 

$Txt_path:=$1

Case of 
		
		  //.....................................................
	: (Test path name:C476($Txt_path)=Is a document:K24:1)
		
		  //Get the file name
		For ($Lon_i;Length:C16($Txt_path);1;-1)
			
			If ($Txt_path[[$Lon_i]]=Folder separator:K24:12)
				
				$Txt_name:=Substring:C12($Txt_path;$Lon_i+1)
				$Lon_i:=0
				
			End if 
			
		End for 
		
		  //parse the file according the extension
		Case of 
				
				  //--------------
			: ($Txt_path="@.4DLink")  //4DLink file
				
				$Txt_url:="file://"+Replace string:C233($Txt_path;Folder separator:K24:12;"/")
				$Txt_label:=$Txt_name
				$Lon_type:=15
				
				  //--------------
			: ($Txt_path="@.url")  //Internet explorer Mac & PC
				
				DOCUMENT TO BLOB:C525($Txt_path;$Blb_buffer)
				
				If (OK=1)
					
					$Txt_buffer:=BLOB to text:C555($Blb_buffer;Mac text without length:K22:10)
					
					If (OK=1)
						
						$Lon_x:=Position:C15("[InternetShortcut]\r\nURL=";$Txt_buffer)
						
						OK:=Num:C11($Lon_x>0)
						
						If (OK=1)
							
							$Txt_buffer:=Substring:C12($Txt_buffer;$Lon_x+24)
							$Lon_x:=Position:C15("\r";$Txt_buffer)
							OK:=Num:C11($Lon_x>0)
							
							If (OK=1)
								
								$Txt_url:=Substring:C12($Txt_buffer;1;$Lon_x-1)
								$Txt_label:=Replace string:C233($Txt_name;".url";"")
								
							End if 
						End if 
					End if 
					
					$Lon_type:=13
					
				End if 
				
				  //--------------
			: ($Txt_path="@.webloc")  //Mac OS
				
				$Doc_reference:=Open resource file:C497($Txt_path)
				
				If (OK=1)
					
					$Txt_url:=Get text resource:C504(256;$Doc_reference)
					GET RESOURCE:C508("urln";256;$Blb_buffer;$Doc_reference)
					
					If (OK=1)
						
						$Txt_label:=BLOB to text:C555($Blb_buffer;Mac text without length:K22:10)
						
					Else 
						
						$Txt_label:=$Txt_name
						
					End if 
					
					$Lon_type:=13
					
				End if 
				
				  //--------------
			: ($Txt_path="@.mailloc")  //Mac OS
				
				$Doc_reference:=Open resource file:C497($Txt_path)
				
				If (OK=1)
					
					$Txt_url:=Get text resource:C504(256;$Doc_reference)
					
					If (OK=1)
						
						$Txt_label:=Replace string:C233($Txt_name;".mailloc";"")
						
					End if 
					
					$Lon_type:=1
					
				End if 
				
				  //--------------
			Else 
				
				$Txt_url:="file://"+Replace string:C233($Txt_path;Folder separator:K24:12;"/")
				$Txt_label:=$Txt_name
				$Lon_type:=14
				
				  //--------------
		End case 
		
		
		  //.....................................................
	: (Test path name:C476($Txt_path)=Is a folder:K24:2)
		
		
		$Txt_url:=Replace string:C233(Replace string:C233($Txt_path;"file://localhost";$Txt_path;1);"/";Folder separator:K24:12)
		
		$Txt_label:=$Txt_url
		
		$Txt_label:=Delete string:C232($Txt_label;Length:C16($Txt_label);Num:C11($Txt_label[[Length:C16($Txt_label)]]=Folder separator:K24:12))
		
		Repeat 
			
			$Lon_x:=Position:C15(Folder separator:K24:12;$Txt_label;$Lon_x+1)
			
			If ($Lon_x>0)
				
				$Lon_i:=$Lon_x
				
			End if 
			
		Until ($Lon_x=0)
		
		$Txt_label:=Replace string:C233(Delete string:C232($Txt_label;1;$Lon_i);"%20";" ")
		
		If ($Txt_path="@.app")  //Application package on mac
			
			$Txt_label:=Replace string:C233($Txt_label;".app";"")
			
			$Lon_type:=16
			
		Else 
			
			$Lon_type:=8
			
		End if 
		
		
		  //.....................................................
	Else   //Volume
		
		$Txt_label:=Replace string:C233($Txt_path;"%20";" ")
		
		GET PASTEBOARD DATA:C401("public.file-url";$Blb_buffer)
		
		If (OK=1)
			
			$Txt_url:=BLOB to text:C555($Blb_buffer;Mac text without length:K22:10)
			$Lon_type:=3
			
		End if 
		
		  //.....................................................
End case 

$Txt_label:=Replace string:C233($Txt_label;"(";"[")
$Txt_label:=Replace string:C233($Txt_label;")";"]")
$Txt_label:=Delete string:C232($Txt_label;1;Num:C11($Txt_label[[1]]="-"))

$2->:=$Txt_label
$3->:=$Txt_url
$4->:=$Lon_type
