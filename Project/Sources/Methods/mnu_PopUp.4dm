//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : mnu_PopUp
  // ID[1262B4A436494165934813E066B47F3D]
  // Created 24/05/12 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // Display and erase
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_BOOLEAN:C305($5)

C_BOOLEAN:C305($Boo_clear)
C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_x;$Lon_y)
C_TEXT:C284($Mnu_hdl;$Txt_choice;$Txt_default)

ARRAY TEXT:C222($tTxt_menuID;0)
ARRAY TEXT:C222($tTxt_menuLabels;0)

If (False:C215)
	C_TEXT:C284(mnu_PopUp ;$0)
	C_TEXT:C284(mnu_PopUp ;$1)
	C_TEXT:C284(mnu_PopUp ;$2)
	C_LONGINT:C283(mnu_PopUp ;$3)
	C_LONGINT:C283(mnu_PopUp ;$4)
	C_BOOLEAN:C305(mnu_PopUp ;$5)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	$Mnu_hdl:=$1
	
	$Boo_clear:=True:C214
	$Lon_x:=-1
	$Lon_y:=-1
	
	If ($Lon_parameters>=2)
		
		$Txt_default:=$2
		
		If ($Lon_parameters>=4)
			
			$Lon_x:=$3
			$Lon_y:=$4
			
			If ($Lon_parameters>=5)
				
				$Boo_clear:=$5
				
			End if 
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Count menu items:C405($Mnu_hdl)>0)
	
	Case of 
			  //______________________________________________________
		: ($Lon_x#-1)
			
			$Txt_choice:=Dynamic pop up menu:C1006($Mnu_hdl;$Txt_default;$Lon_x;$Lon_y)
			
			  //______________________________________________________
		: (Length:C16($Txt_default)>0)
			
			$Txt_choice:=Dynamic pop up menu:C1006($Mnu_hdl;$Txt_default)
			
			  //______________________________________________________
		Else 
			
			$Txt_choice:=Dynamic pop up menu:C1006($Mnu_hdl)
			
			  //______________________________________________________
	End case 
	
End if 

If ($Boo_clear)
	
	GET MENU ITEMS:C977($Mnu_hdl;$tTxt_menuLabels;$tTxt_menuID)
	
	For ($Lon_i;1;Size of array:C274($tTxt_menuID);1)
		
		If (Length:C16($tTxt_menuID{$Lon_i})>0)
			
			mnu_RELEASE_MENU ($tTxt_menuID{$Lon_i})
			
		End if 
		
	End for 
	
	RELEASE MENU:C978($Mnu_hdl)
	
End if 

$0:=$Txt_choice

  // ----------------------------------------------------
  // End