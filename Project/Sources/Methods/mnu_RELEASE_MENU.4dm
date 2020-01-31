//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Method : mnu_RELEASE_MENU
  // Created 21/07/06 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description
  // Clears from memory the menu $1 and all menu called from this one
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_i;$Lon_parameters)

ARRAY TEXT:C222($tTxt_menuID;0)
ARRAY TEXT:C222($tTxt_menuLabels;0)

If (False:C215)
	C_TEXT:C284(mnu_RELEASE_MENU ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

  // ----------------------------------------------------

If (Length:C16($1)>0)
	
	GET MENU ITEMS:C977($1;$tTxt_menuLabels;$tTxt_menuID)
	
	For ($Lon_i;1;Size of array:C274($tTxt_menuID);1)
		
		If (Length:C16($tTxt_menuID{$Lon_i})>0)
			
			mnu_RELEASE_MENU ($tTxt_menuID{$Lon_i})  //<-- Recursive
			
		End if 
		
	End for 
	
	RELEASE MENU:C978($1)
	
End if 
