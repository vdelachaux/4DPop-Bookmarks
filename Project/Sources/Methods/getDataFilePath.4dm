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
#DECLARE() : Text

var $file : 4D:C1709.File:=Folder:C1567(fk user preferences folder:K87:10).file("4DPop_Bookmarks.xml")

// Added by vdl (06/05/08)
// Try to get the file from the old localisation
If (Not:C34($file.exists))
	
	var $old : 4D:C1709.File:=Folder:C1567(fk licenses folder:K87:16).parent.file("4DPop_Bookmarks.xml")
	
	If ($old.exists)
		
		Try
			
			// Copy file...
			$old.copyTo(Folder:C1567(fk user preferences folder:K87:10))
			
			If ($file.exists)
				
				// ... and delete the old one
				$old.delete()
				
			End if 
			
		End try
		
	End if 
End if 

If (Not:C34(($file.exists)))
	
	// Get the defaults
	$file:=File:C1566(Localized document path:C1105("DefaultBookmarks.xml"); fk platform path:K87:2)
	
End if 

return $file.platformPath  // Bookmarks file