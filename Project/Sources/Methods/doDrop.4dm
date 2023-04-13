//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : ondrop
// Created 21/05/07 by vdl
// ----------------------------------------------------
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_BLOB:C604($Blb_buffer)
C_LONGINT:C283($Lon_i; $Lon_type; $Lon_x)
C_TEXT:C284($Txt_label; $Txt_url)

ARRAY TEXT:C222($tTxt_formatNames; 0)
ARRAY TEXT:C222($tTxt_nativeKinds; 0)
ARRAY TEXT:C222($tTxt_scrapKinds; 0)

If (False:C215)
	C_BOOLEAN:C305(doDrop; $0)
	C_POINTER:C301(doDrop; $1)
	C_POINTER:C301(doDrop; $2)
	C_POINTER:C301(doDrop; $3)
End if 

//1] What is in the drag container
GET PASTEBOARD DATA TYPE:C958($tTxt_scrapKinds; $tTxt_nativeKinds; $tTxt_formatNames)

$Lon_type:=100
OK:=0

Case of 
		
		//……………………………………………………………………………
	: (Find in array:C230($tTxt_nativeKinds; "public.url-name")>0)
		
		GET PASTEBOARD DATA:C401("public.url"; $Blb_buffer)
		
		If (OK=1)
			
			$Txt_url:=BLOB to text:C555($Blb_buffer; Mac text without length:K22:10)
			GET PASTEBOARD DATA:C401("public.url-name"; $Blb_buffer)
			
			If (OK=1)
				
				$Txt_label:=Convert to text:C1012($Blb_buffer; "UTF-8")
				$Lon_type:=13
				
			End if 
		End if 
		
		//……………………………………………………………………………
	: (Find in array:C230($tTxt_nativeKinds; "public.vcard")>0)
		
		$Txt_url:=Get text from pasteboard:C524
		$Txt_label:=Substring:C12($Txt_url; 1; Position:C15(Char:C90(At sign:K15:46); $Txt_url)-1)
		$Lon_x:=Length:C16($Txt_label)
		
		If ($Lon_x>0)
			
			$Txt_label:=Lowercase:C14($Txt_label)
			$Txt_label[[1]]:=Uppercase:C13($Txt_label[[1]])
			
			For ($Lon_i; 2; $Lon_x; 1)
				
				If ($Txt_label[[$Lon_i]]=".") | ($Txt_label[[$Lon_i]]="-") | ($Txt_label[[$Lon_i]]="_")
					
					$Txt_label[[$Lon_i]]:=Char:C90(Space:K15:42)
					
					If ($Lon_i<$Lon_x)
						
						$Txt_label[[$Lon_i+1]]:=Uppercase:C13($Txt_label[[$Lon_i+1]])
						
					End if 
				End if 
				
			End for 
			
			$Lon_type:=1
			
		End if 
		
		$Txt_url:="mailto:"+$Txt_url
		
		//……………………………………………………………………………
	: (Find in array:C230($tTxt_nativeKinds; "public.file-url")>0)  //File or folder Mac
		
		ParseFile(Get file from pasteboard:C976(1); ->$Txt_label; ->$Txt_url; ->$Lon_type)
		
		//……………………………………………………………………………
	: (Find in array:C230($tTxt_scrapKinds; "com.4d.private.file.url")>0)  //File or folder PC
		
		ParseFile(Get file from pasteboard:C976(1); ->$Txt_label; ->$Txt_url; ->$Lon_type)
		
		//……………………………………………………………………………
End case 

If (OK=0)
	
	//2] And the container text ?
	$Txt_url:=Get text from pasteboard:C524
	$Txt_label:=$Txt_url
	
	Case of 
			//……………………………………………………………………………
		: (OK=0)
			
			//……………………………………………………………………………
		: (Position:C15(Char:C90(At sign:K15:46); $Txt_label)>0)
			
			$Lon_x:=Position:C15(Char:C90(At sign:K15:46); $Txt_label)
			OK:=Num:C11($Lon_x>0)
			
			If (OK=1)
				
				$Txt_url:="mailto:"+$Txt_url
				$Txt_label:=Substring:C12($Txt_label; 1; $Lon_x-1)
				$Lon_type:=1
				
			End if 
			
			//……………………………………………………………………………
		: (Position:C15("//"; $Txt_label)>0)
			
			GET PASTEBOARD DATA:C401("public.url-name"; $Blb_buffer)
			
			If (OK=1)
				
				$Txt_label:=Convert to text:C1012($Blb_buffer; "UTF-8")
				
			Else 
				
				$Lon_x:=Position:C15("//"; $Txt_label)
				OK:=Num:C11($Lon_x>0)
				
				If (OK=1)
					
					$Txt_label:=Substring:C12($Txt_label; $Lon_x+2)
					$Lon_x:=Position:C15("/"; $Txt_label)
					
					If ($Lon_x>0)
						
						$Txt_label:=Substring:C12($Txt_label; 1; $Lon_x-1)
						
					End if 
				End if 
			End if 
			
			$Lon_type:=13
			
			//……………………………………………………………………………
	End case 
	
End if 

$0:=((OK=1) & (Length:C16($Txt_label)>0))

If ($0)
	
	$1->:=$Txt_label
	$2->:=$Txt_url
	$3->:=$Lon_type
	
End if 
