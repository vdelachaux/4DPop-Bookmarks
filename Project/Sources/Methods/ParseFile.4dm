//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : ParseFile
// Created 02/04/07 by vdelachaux
// ----------------------------------------------------
#DECLARE($pathname : Text;  ...  : Pointer)

var $label; $name; $t; $url : Text
var $i; $pos; $type : Integer
var $docRfe : Time
var $blb : Blob

Case of 
		
		//.....................................................
	: (Test path name:C476($pathname)=Is a document:K24:1)
		
		// Get the file name
		For ($i; Length:C16($pathname); 1; -1)
			
			If ($pathname[[$i]]=Folder separator:K24:12)
				
				$name:=Substring:C12($pathname; $i+1)
				$i:=0
				
			End if 
		End for 
		
		// Parse the file according the extension
		Case of 
				
				//--------------
			: ($pathname="@.4DLink")  // 4DLink file
				
				$url:="file://"+Replace string:C233($pathname; Folder separator:K24:12; "/")
				$label:=$name
				$type:=15
				
				//--------------
			: ($pathname="@.url")  // Internet explorer Mac & PC
				
				DOCUMENT TO BLOB:C525($pathname; $blb)
				
				If (OK=1)
					
					$t:=BLOB to text:C555($blb; Mac text without length:K22:10)
					
					If (OK=1)
						
						$pos:=Position:C15("[InternetShortcut]\r\nURL="; $t)
						
						OK:=Num:C11($pos>0)
						
						If (OK=1)
							
							$t:=Substring:C12($t; $pos+24)
							$pos:=Position:C15("\r"; $t)
							OK:=Num:C11($pos>0)
							
							If (OK=1)
								
								$url:=Substring:C12($t; 1; $pos-1)
								$label:=Replace string:C233($name; ".url"; "")
								
							End if 
						End if 
					End if 
					
					$type:=13
					
				End if 
				
				//--------------
			: ($pathname="@.webloc")  // Mac OS
				
				$docRfe:=Open resource file:C497($pathname)
				
				If (OK=1)
					
					$url:=Get text resource:C504(256; $docRfe)
					GET RESOURCE:C508("urln"; 256; $blb; $docRfe)
					
					$label:=OK=1 ? BLOB to text:C555($blb; Mac text without length:K22:10) : $name
					
					$type:=13
					
				End if 
				
				//--------------
			: ($pathname="@.mailloc")  // Mac OS
				
				$docRfe:=Open resource file:C497($pathname)
				
				If (OK=1)
					
					$url:=Get text resource:C504(256; $docRfe)
					
					If (OK=1)
						
						$label:=Replace string:C233($name; ".mailloc"; "")
						
					End if 
					
					$type:=1
					
				End if 
				
				//--------------
			Else 
				
				$url:="file://"+Replace string:C233($pathname; Folder separator:K24:12; "/")
				$label:=$name
				$type:=14
				
				//--------------
		End case 
		
		//.....................................................
	: (Test path name:C476($pathname)=Is a folder:K24:2)
		
		$url:=Replace string:C233(Replace string:C233($pathname; "file://localhost"; $pathname; 1); "/"; Folder separator:K24:12)
		
		$label:=$url
		
		$label:=Delete string:C232($label; Length:C16($label); Num:C11($label[[Length:C16($label)]]=Folder separator:K24:12))
		
		Repeat 
			
			$pos:=Position:C15(Folder separator:K24:12; $label; $pos+1)
			
			If ($pos>0)
				
				$i:=$pos
				
			End if 
		Until ($pos=0)
		
		$label:=Replace string:C233(Delete string:C232($label; 1; $i); "%20"; " ")
		
		If ($pathname="@.app")  // Application package on mac
			
			$label:=Replace string:C233($label; ".app"; "")
			
			$type:=16
			
		Else 
			
			$type:=8
			
		End if 
		
		//.....................................................
	Else   // Volume
		
		$label:=Replace string:C233($pathname; "%20"; " ")
		
		GET PASTEBOARD DATA:C401("public.file-url"; $blb)
		
		If (OK=1)
			
			$url:=BLOB to text:C555($blb; Mac text without length:K22:10)
			$type:=3
			
		End if 
		
		//.....................................................
End case 

$label:=Replace string:C233($label; "("; "[")

$label:=Replace string:C233($label; ")"; "]")
$label:=Delete string:C232($label; 1; Num:C11($label[[1]]="-"))

${2}->:=$label
${3}->:=$url
${4}->:=$type