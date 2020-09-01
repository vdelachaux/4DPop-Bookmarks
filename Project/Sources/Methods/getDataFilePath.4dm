//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : getDataFilePath
// Created 25/01/07 by vdl
// ----------------------------------------------------
// Modified by vdl (06/05/08)
// V11 -> 11.2 compatibility: The 4D folder has moved
// ----------------------------------------------------
// Modified by: 保坂圭是 (2020/01/28)
// ----------------------------------------------------
// Modified by: vdl (1-9-2020)
// Code rewrites
// ----------------------------------------------------
var $0 : Text

If (False:C215)
	C_TEXT:C284(getDataFilePath; $0)
End if 

var $onErrCall : Text

var $file; $o : 4D:C1709.Document

$file:=Folder:C1567(fk user preferences folder:K87:10).file("4DPop_Bookmarks.xml")

// Added by vdl (06/05/08)
// Try to get the file from the old localisation
If (Not:C34($file.exists))
	
	$o:=Folder:C1567(fk licenses folder:K87:16).parent.file("4DPop_Bookmarks.xml")
	
	If ($o.exists)
		
		$onErrCall:=Method called on error:C704
		ON ERR CALL:C155("NoError")
		
		// Copy file...
		$o.copyTo(Folder:C1567(fk user preferences folder:K87:10))
		
		If ($file.exists)
			
			// ... and delete the old one
			$o.delete()
			
		End if 
		
		ON ERR CALL:C155($onErrCall)
		
	End if 
End if 

If (Not:C34(($file.exists)))
	
	// Get the defaults
	$file:=File:C1566(Get localized document path:C1105("DefaultBookmarks.xml"); fk platform path:K87:2)
	
End if 

$0:=$file.platformPath  // Bookmarks file