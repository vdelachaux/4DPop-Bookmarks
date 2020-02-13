//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Method : getDataFilePath
  // Created 25/01/07 by vdl
  // ----------------------------------------------------
  // Modified by vdl (06/05/08)
  // v11 -> 11.2 compatibility: The 4D folder has moved
  // ----------------------------------------------------
  // Modified by: 保坂圭是 (2020/01/28)
  // ----------------------------------------------------
C_TEXT:C284($0)

C_LONGINT:C283($i)
C_TEXT:C284($t_pathname;$tErrorMethod)

If (False:C215)
	C_TEXT:C284(getDataFilePath ;$0)
End if 

$t_pathname:=Get 4D folder:C485+"4DPop_Bookmarks.xml"

  // Added by vdl (06/05/08) {
  // Try to get the file from the old localisation
If (Test path name:C476($t_pathname)#Is a document:K24:1)
	
	$t_pathname:=Get 4D folder:C485(Licenses folder:K5:11)
	$t_pathname:=Substring:C12($t_pathname;1;Length:C16($t_pathname)-1)
	
	For ($i;Length:C16($t_pathname);1;-1)
		
		If ($t_pathname[[$i]]=Folder separator:K24:12)
			
			$t_pathname:=Substring:C12($t_pathname;1;$i)
			$i:=0
			
		End if 
	End for 
	
	$t_pathname:=$t_pathname+"4DPop_Bookmarks.xml"
	
	If (Test path name:C476($t_pathname)=Is a document:K24:1)
		
		$tErrorMethod:=Method called on error:C704
		ON ERR CALL:C155("NoError")
		
		  // Copy file...
		COPY DOCUMENT:C541($t_pathname;Get 4D folder:C485+"4DPop_Bookmarks.xml")
		
		If (OK=1)
			
			  // ... and delete the old one
			DELETE DOCUMENT:C159($t_pathname)
			
		End if 
		
		ON ERR CALL:C155($tErrorMethod)
		
		$t_pathname:=Get 4D folder:C485+"4DPop_Bookmarks.xml"
		
	End if 
End if 
  //}

If (Test path name:C476($t_pathname)#Is a document:K24:1)
	
	  // Get the defaults
	$t_pathname:=Get 4D folder:C485(Current resources folder:K5:16)
	
	ARRAY TEXT:C222($tTxt_Codes;6)
	$tTxt_Codes{1}:="en"
	$tTxt_Codes{2}:="fr"
	$tTxt_Codes{3}:="de"
	$tTxt_Codes{4}:="it"
	$tTxt_Codes{5}:="ja"
	$tTxt_Codes{6}:="es"
	
	$tTxt_Codes:=Abs:C99(Find in array:C230($tTxt_Codes;Get database localization:C1009))  // 4DPop_applicationLanguage ))
	
	ARRAY TEXT:C222($tTxt_Folders;6)
	$tTxt_Folders{1}:="en"
	$tTxt_Folders{2}:="fr"
	$tTxt_Folders{3}:="de"
	$tTxt_Folders{4}:="it"
	$tTxt_Folders{5}:="ja"
	$tTxt_Folders{6}:="es"
	$tTxt_Folders{0}:=$tTxt_Folders{$tTxt_Codes}
	
	$t_pathname:=$t_pathname+$tTxt_Folders{0}+".lproj"+Folder separator:K24:12
	
	  // Added by vdl (06/05/08){
	If (Test path name:C476($t_pathname)#Is a folder:K24:2)
		
		For ($i;1;Size of array:C274($tTxt_Folders);1)
			
			$t_pathname:=Get 4D folder:C485(Current resources folder:K5:16)\
				+$tTxt_Folders{$i}\
				+".lproj"\
				+Folder separator:K24:12
			
			If (Test path name:C476($t_pathname)=Is a folder:K24:2)
				
				$i:=MAXLONG:K35:2-1
				
			End if 
		End for 
	End if 
	  //}
	
	$t_pathname:=$t_pathname+"DefaultBookmarks.xml"
	
End if 

$0:=$t_pathname  // User bookmarks file