//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : 4DPop_bookMarksInit
  // ID[EBA7B14E75714F2B8EEF5F3AE31118C0]
  // Created 30/01/12 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_POINTER:C301($1)

C_LONGINT:C283($Lon_i;$Lon_parameters)
C_TEXT:C284($Txt_4DFolderPath)

If (False:C215)
	C_POINTER:C301(4DPop_bookMarksInit ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

  //1] Cleanup in the current 4D Folder {
$Txt_4DFolderPath:=Get 4D folder:C485(Active 4D Folder:K5:10)

ARRAY TEXT:C222($tTxt_folders;0x0000)
FOLDER LIST:C473($Txt_4DFolderPath;$tTxt_folders)

  //Delete folder don't delete non empty folder 
  // but generate an erropr ;-)

ON ERR CALL:C155("NoError")

For ($Lon_i;1;Size of array:C274($tTxt_folders);1)
	
	DELETE FOLDER:C693($Txt_4DFolderPath+$tTxt_folders{$Lon_i})
	
End for 

ON ERR CALL:C155("")
  //}

  // ----------------------------------------------------
  // End