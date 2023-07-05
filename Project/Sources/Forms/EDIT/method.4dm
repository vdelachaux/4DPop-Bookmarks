// ----------------------------------------------------
// Method : Méthode formulaire : EDIT
// Created 25/01/07 by vdl
// ----------------------------------------------------
C_LONGINT:C283($Lon_formEvent; $Lon_i; $Lon_index)
C_PICTURE:C286($Pic_buffer)
C_POINTER:C301($Ptr_icon; $Ptr_label; $Ptr_type; $Ptr_url)
C_TEXT:C284($Dom_element; $root; $kTxt_pictureFolder; $Txt_name; $Txt_path; $Txt_value)

$Lon_formEvent:=Form event code:C388

$Ptr_icon:=OBJECT Get pointer:C1124(Object named:K67:5; "list.icon")
$Ptr_label:=OBJECT Get pointer:C1124(Object named:K67:5; "list.label")
$Ptr_url:=OBJECT Get pointer:C1124(Object named:K67:5; "list.url")
$Ptr_type:=OBJECT Get pointer:C1124(Object named:K67:5; "list.type")

Case of 
		
		// ----------------------------------------------------
	: ($Lon_formEvent=On Load:K2:1)
		
		//%W-518.5
		
		ARRAY PICTURE:C279($Ptr_icon->; 0x0000)
		ARRAY TEXT:C222($Ptr_label->; 0x0000)
		ARRAY TEXT:C222($Ptr_url->; 0x0000)
		ARRAY LONGINT:C221($Ptr_type->; 0x0000)
		
		$kTxt_pictureFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"images"+Folder separator:K24:12
		
		$Txt_path:=getDataFilePath
		
		If (Test path name:C476($Txt_path)=Is a document:K24:1)
			
			$root:=DOM Parse XML source:C719($Txt_path; False:C215)
			
			If (OK=1)
				
				$Dom_element:=DOM Find XML element:C864($root; "/bookmarks/bookmark")
				
				For ($Lon_i; 1; DOM Count XML elements:C726($root; "bookmark"); 1)
					
					For ($Lon_index; 1; DOM Count XML attributes:C727($Dom_element))
						
						DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_element; $Lon_index; $Txt_name; $Txt_value)
						
						Case of 
								
								//…………………………………………
							: ($Txt_name="name")
								
								APPEND TO ARRAY:C911($Ptr_label->; $Txt_value)
								
								//…………………………………………
							: ($Txt_name="url")
								
								APPEND TO ARRAY:C911($Ptr_url->; $Txt_value)
								
								//…………………………………………
							: ($Txt_name="type")
								
								APPEND TO ARRAY:C911($Ptr_type->; Num:C11($Txt_value))
								
								READ PICTURE FILE:C678($kTxt_pictureFolder+$Txt_value+".png"; $Pic_buffer)
								APPEND TO ARRAY:C911($Ptr_icon->; $Pic_buffer)
								
								//…………………………………………
						End case 
						
					End for 
					
					$Dom_element:=DOM Get next sibling XML element:C724($Dom_element)
					
				End for 
				
				DOM CLOSE XML:C722($root)
				
			End if 
			
			$Lon_i:=Size of array:C274($Ptr_label->)
			
			ARRAY TEXT:C222($Ptr_url->; $Lon_i)
			ARRAY LONGINT:C221($Ptr_type->; $Lon_i)
			ARRAY PICTURE:C279($Ptr_icon->; $Lon_i)
			
		End if 
		
		OBJECT SET ENABLED:C1123(*; "b.delete"; False:C215)
		
		SET TIMER:C645(-1)
		
		// ----------------------------------------------------
	: ($Lon_formEvent=On Timer:K2:25)
		SET TIMER:C645(0)
		
		lstb_SET_SCROLLBAR("listbox")
		
		// ----------------------------------------------------
	: ($Lon_formEvent=On Unload:K2:2)
		
		$Txt_path:=Get 4D folder:C485+"4DPop_Bookmarks.xml"
		
		If (Test path name:C476($Txt_path)=Is a document:K24:1)
			
			DELETE DOCUMENT:C159($Txt_path)
			
		End if 
		
		$root:=DOM Create XML Ref:C861("bookmarks")
		
		If (OK=1)
			
			For ($Lon_i; 1; Size of array:C274($Ptr_label->); 1)
				
				$Dom_element:=DOM Create XML element:C865($root; "bookmark"\
					; "name"; $Ptr_label->{$Lon_i}\
					; "url"; $Ptr_url->{$Lon_i}\
					; "type"; String:C10($Ptr_type->{$Lon_i}))
				
			End for 
			
			DOM EXPORT TO FILE:C862($root; $Txt_path)
			DOM CLOSE XML:C722($root)
			
		End if 
		
		// ----------------------------------------------------
	: ($Lon_formEvent=On Resize:K2:27)
		
		lstb_SET_SCROLLBAR("listbox")
		
		// ----------------------------------------------------
End case 
