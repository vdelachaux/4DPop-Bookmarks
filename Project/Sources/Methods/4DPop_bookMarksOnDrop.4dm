//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Method : Tool_ondrop
  // Created 21/05/07 by vdl
  // ----------------------------------------------------
C_POINTER:C301($1)

C_LONGINT:C283($Lon_type)
C_TEXT:C284($Dom_bookmark;$Dom_root;$Txt_name;$Txt_path;$Txt_url)

If (False:C215)
	C_POINTER:C301(4DPop_bookMarksOnDrop ;$1)
End if 

If (ondrop (->$Txt_name;->$Txt_url;->$Lon_type))
	
	$Txt_path:=Get 4D folder:C485+"4DPop_Bookmarks.xml"
	
	If (Test path name:C476($Txt_path)#Is a document:K24:1)
		
		COPY DOCUMENT:C541(getDataFilePath ;$Txt_path;*)
		
	End if 
	
	If (Test path name:C476($Txt_path)=Is a document:K24:1)
		
		$Dom_root:=DOM Parse XML source:C719($Txt_path;False:C215)
		
		If (OK=1)
			
			$Dom_bookmark:=DOM Create XML element:C865($Dom_root;"bookmark"\
				;"name";$Txt_name\
				;"url";$Txt_url\
				;"type";String:C10($Lon_type))
			
			DOM EXPORT TO FILE:C862($Dom_root;$Txt_path)
			DOM CLOSE XML:C722($Dom_root)
			
		End if 
	End if 
End if 