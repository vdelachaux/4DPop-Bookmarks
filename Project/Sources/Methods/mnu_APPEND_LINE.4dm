//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : mnu_APPEND_LINE
  // ID[AE483A2C319B421E8224A90F4B955CCD]
  // Created 28/09/06 by vdl
  // ----------------------------------------------------
  // Description:
  // Ajoute une ligne au menu $1 si le dernier item de celui-ci n'en est pas déjà une
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_Lines;$Lon_parameters;$Lon_x)
C_TEXT:C284($Mnu_ID;$Txt_Buffer)

If (False:C215)
	C_TEXT:C284(mnu_APPEND_LINE ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	$Mnu_ID:=$1
	$Lon_Lines:=Count menu items:C405($Mnu_ID)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If ($Lon_Lines>0)
	
	$Txt_Buffer:=Get menu item:C422($Mnu_ID;$Lon_Lines)
	
	Case of 
			
		: ($Txt_Buffer="(-@")
			
		: ($Txt_Buffer="-@")
			
		Else 
			
			GET MENU ITEM PROPERTY:C972($Mnu_ID;$Lon_Lines;"4D_separator";$Lon_x)
			
			If ($Lon_x=0)
				
				APPEND MENU ITEM:C411($Mnu_ID;"(-")
				
			End if 
			
	End case 
End if 

  // ----------------------------------------------------
  // End