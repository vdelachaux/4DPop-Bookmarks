//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : Tool_ondrop
// Created 21/05/07 by vdl
// ----------------------------------------------------
#DECLARE($widget : Object)

If (False:C215)
	C_OBJECT:C1216(onDrop; $1)
End if 

var $bookmark; $name; $pathname; $root; $url : Text
var $type : Integer

If (doDrop(->$name; ->$url; ->$type))
	
	$pathname:=Get 4D folder:C485+"4DPop_Bookmarks.xml"
	
	If (Test path name:C476($pathname)#Is a document:K24:1)
		
		COPY DOCUMENT:C541(getDataFilePath; $pathname; *)
		
	End if 
	
	If (Test path name:C476($pathname)=Is a document:K24:1)
		
		$root:=DOM Parse XML source:C719($pathname; False:C215)
		
		If (OK=1)
			
			$bookmark:=DOM Create XML element:C865($root; "bookmark"\
				; "name"; $name\
				; "url"; $url\
				; "type"; String:C10($type))
			
			DOM EXPORT TO FILE:C862($root; $pathname)
			DOM CLOSE XML:C722($root)
			
		End if 
	End if 
End if 
