//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Method : mnu_SET_ACTIVATION
  // Created 20/04/10 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description
  // if $2 is true: Activates the item of the menu $1
  // if $2 is false or ommitted: Deactivates the item of the menu $1
  // if $3 is omitted, the method works with the last added line.
  // You can pass more than one line in parameters $3, $4, ..., $N
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_BOOLEAN:C305($2)
C_LONGINT:C283(${3})

C_BOOLEAN:C305($Boo_activate)
C_LONGINT:C283($Lon_i;$Lon_item;$Lon_parameters)
C_TEXT:C284($Mnu_ID)

If (False:C215)
	C_TEXT:C284(mnu_SET_ACTIVATION ;$1)
	C_BOOLEAN:C305(mnu_SET_ACTIVATION ;$2)
	C_LONGINT:C283(mnu_SET_ACTIVATION ;${3})
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259
$Lon_item:=-1

If (Asserted:C1132($Lon_parameters>=1))
	
	$Mnu_ID:=$1
	
	If ($Lon_parameters>=2)
		
		$Boo_activate:=$2
		
	End if 
End if 

  // ----------------------------------------------------

If ($Boo_activate)
	
	If ($Lon_parameters>=3)
		
		For ($Lon_i;3;$Lon_parameters;1)
			
			ENABLE MENU ITEM:C149($Mnu_ID;${$Lon_i})
			
		End for 
		
	Else 
		
		ENABLE MENU ITEM:C149($Mnu_ID;-1)  // Last item added
		
	End if 
	
Else 
	
	If ($Lon_parameters>=3)
		
		For ($Lon_i;3;$Lon_parameters;1)
			
			DISABLE MENU ITEM:C150($Mnu_ID;${$Lon_i})
			
		End for 
		
	Else 
		
		DISABLE MENU ITEM:C150($Mnu_ID;-1)  // Last item added
		
	End if 
End if 