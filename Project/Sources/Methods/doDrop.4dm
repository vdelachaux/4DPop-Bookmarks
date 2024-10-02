//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : ondrop
// Created 21/05/07 by vdl
// ----------------------------------------------------
#DECLARE( ...  : Pointer) : Boolean

var $blb : Blob
var $i; $type; $pos : Integer
var $label; $url : Text
var $success : Boolean

ARRAY TEXT:C222($_formatNames; 0)
ARRAY TEXT:C222($_nativeKinds; 0)
ARRAY TEXT:C222($_4Dsignatures; 0)

// 1] What is in the drag container
GET PASTEBOARD DATA TYPE:C958($_4Dsignatures; $_nativeKinds; $_formatNames)

$type:=100
OK:=0

Case of 
		
		//……………………………………………………………………………
	: (Find in array:C230($_nativeKinds; "public.url-name")>0)
		
		GET PASTEBOARD DATA:C401("public.url"; $blb)
		
		If (OK=1)
			
			$url:=BLOB to text:C555($blb; Mac text without length:K22:10)
			GET PASTEBOARD DATA:C401("public.url-name"; $blb)
			
			If (OK=1)
				
				$label:=Convert to text:C1012($blb; "UTF-8")
				$type:=13
				
			End if 
		End if 
		
		//……………………………………………………………………………
	: (Find in array:C230($_nativeKinds; "public.vcard")>0)
		
		$url:=Get text from pasteboard:C524
		$label:=Substring:C12($url; 1; Position:C15(Char:C90(At sign:K15:46); $url)-1)
		$pos:=Length:C16($label)
		
		If ($pos>0)
			
			$label:=Lowercase:C14($label)
			$label[[1]]:=Uppercase:C13($label[[1]])
			
			For ($i; 2; $pos; 1)
				
				If ($label[[$i]]=".")\
					 | ($label[[$i]]="-")\
					 | ($label[[$i]]="_")
					
					$label[[$i]]:=Char:C90(Space:K15:42)
					
					If ($i<$pos)
						
						$label[[$i+1]]:=Uppercase:C13($label[[$i+1]])
						
					End if 
				End if 
			End for 
			
			$type:=1
			
		End if 
		
		$url:="mailto:"+$url
		
		//……………………………………………………………………………
	: (Find in array:C230($_nativeKinds; "public.file-url")>0)  // File or folder Mac
		
		ParseFile(Get file from pasteboard:C976(1); ->$label; ->$url; ->$type)
		
		//……………………………………………………………………………
	: (Find in array:C230($_4Dsignatures; "com.4d.private.file.url")>0)  // File or folder PC
		
		ParseFile(Get file from pasteboard:C976(1); ->$label; ->$url; ->$type)
		
		//……………………………………………………………………………
End case 

If (OK=0)
	
	// 2] And the container text ?
	$url:=Get text from pasteboard:C524
	$label:=$url
	
	Case of 
			
			//……………………………………………………………………………
		: (OK=0)
			
			//……………………………………………………………………………
		: (Position:C15(Char:C90(At sign:K15:46); $label)>0)
			
			$pos:=Position:C15(Char:C90(At sign:K15:46); $label)
			OK:=Num:C11($pos>0)
			
			If (OK=1)
				
				$url:="mailto:"+$url
				$label:=Substring:C12($label; 1; $pos-1)
				$type:=1
				
			End if 
			
			//……………………………………………………………………………
		: (Position:C15(" // "; $label)>0)
			
			GET PASTEBOARD DATA:C401("public.url-name"; $blb)
			
			If (OK=1)
				
				$label:=Convert to text:C1012($blb; "UTF-8")
				
			Else 
				
				$pos:=Position:C15(" // "; $label)
				OK:=Num:C11($pos>0)
				
				If (OK=1)
					
					$label:=Substring:C12($label; $pos+2)
					$pos:=Position:C15("/"; $label)
					
					If ($pos>0)
						
						$label:=Substring:C12($label; 1; $pos-1)
						
					End if 
				End if 
			End if 
			
			$type:=13
			
			//……………………………………………………………………………
	End case 
End if 

$success:=((OK=1) & (Length:C16($label)>0))

If ($success)
	
	${1}->:=$label
	${2}->:=$url
	${3}->:=$type
	
End if 

return $success