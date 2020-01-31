//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : mnu_APPEND_ITEM
  // ID[71972AAC7DEE4B9D830C66D792DA26A1]
  // Created 23/05/12 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Mnu_ref;$Txt_item)

If (False:C215)
	C_TEXT:C284(mnu_APPEND_ITEM ;$1)
	C_TEXT:C284(mnu_APPEND_ITEM ;$2)
	C_TEXT:C284(mnu_APPEND_ITEM ;$3)
	C_TEXT:C284(mnu_APPEND_ITEM ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	$Mnu_ref:=$1
	$Txt_item:=$2
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

If ($Lon_parameters>=4)
	
	APPEND MENU ITEM:C411($Mnu_ref;$Txt_item;$4)
	SET MENU ITEM PARAMETER:C1004($Mnu_ref;-1;$3)
	
Else 
	
	APPEND MENU ITEM:C411($Mnu_ref;$Txt_item)
	
	If ($Lon_parameters>=3)
		
		SET MENU ITEM PARAMETER:C1004($Mnu_ref;-1;$3)
		
	End if 
End if 

  // ----------------------------------------------------
  // End