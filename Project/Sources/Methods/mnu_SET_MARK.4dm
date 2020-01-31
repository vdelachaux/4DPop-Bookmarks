//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : mnu_SET_MARK
  // ID[49BD96C41C5F4F1A89143EC4F100F913]
  // Created 23/05/12 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_BOOLEAN:C305($2)
C_LONGINT:C283(${3})

C_BOOLEAN:C305($Boo_mark)
C_LONGINT:C283($Lon_i;$Lon_item;$Lon_parameters)
C_TEXT:C284($Mnu_ref)

If (False:C215)
	C_TEXT:C284(mnu_SET_MARK ;$1)
	C_BOOLEAN:C305(mnu_SET_MARK ;$2)
	C_LONGINT:C283(mnu_SET_MARK ;${3})
End if 


  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	$Mnu_ref:=$1
	$Boo_mark:=True:C214
	$Lon_item:=-1
	
	If ($Lon_parameters>=2)
		
		$Boo_mark:=$2
		
		If ($Lon_parameters>=3)
			
			$Lon_item:=$3
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

If ($Lon_item=-1)
	
	SET MENU ITEM MARK:C208($Mnu_ref;$Lon_item;Choose:C955($Boo_mark;Char:C90(18);""))
	
Else 
	
	For ($Lon_i;3;$Lon_parameters;1)
		
		SET MENU ITEM MARK:C208($Mnu_ref;${$Lon_i};Choose:C955($Boo_mark;Char:C90(18);""))
		
	End for 
	
End if 

  // ----------------------------------------------------
  // End