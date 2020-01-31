//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : lstb_ON_DOUBLE_CLIC
  // ID[F07C0D1F322B45BB8D80802919709D04]
  // Created 30/01/12 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_colonne;$Lon_ligne;$Lon_parameters)
C_POINTER:C301($Ptr_Array)
C_TEXT:C284($Txt_object)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	$Txt_object:=OBJECT Get name:C1087(Object current:K67:2)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

LISTBOX GET CELL POSITION:C971(*;$Txt_object;$Lon_colonne;$Lon_ligne;$Ptr_Array)

If ($Lon_ligne=0)
	
	$Lon_ligne:=LISTBOX Get number of rows:C915(*;$Txt_object)+1
	LISTBOX INSERT ROWS:C913(*;$Txt_object;$Lon_ligne)
	
End if 

EDIT ITEM:C870($Ptr_Array->;$Lon_ligne)

  // ----------------------------------------------------
  // End