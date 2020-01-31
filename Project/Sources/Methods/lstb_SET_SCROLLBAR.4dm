//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Method : lstb_SET_SCROLLBAR
  // Created 06/12/06 by vdl
  // ----------------------------------------------------
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_hScroolbar;$Boo_vScroolbar)
C_LONGINT:C283($Lon_bottom;$Lon_i;$Lon_left;$Lon_maxHeight;$Lon_maxWidth;$Lon_right;$Lon_top)

ARRAY BOOLEAN:C223($tBoo_visible;0)
ARRAY POINTER:C280($tPtr_styles;0)
ARRAY POINTER:C280($tPtr_varCol;0)
ARRAY POINTER:C280($tPtr_varHeader;0)
ARRAY TEXT:C222($Txt_colNames;0)
ARRAY TEXT:C222($tTxt_headerNames;0)

If (False:C215)
	C_TEXT:C284(lstb_SET_SCROLLBAR ;$1)
End if 

If (LISTBOX Get property:C917(*;$1;lk display header:K53:4)=1)
	
	$Lon_maxHeight:=LISTBOX Get property:C917(*;$1;_o_lk header height:K53:5)
	
End if 

$Boo_hScroolbar:=(LISTBOX Get property:C917(*;$1;2)=1)
If ($Boo_hScroolbar)
	
	$Lon_maxHeight:=$Lon_maxHeight+LISTBOX Get property:C917(*;$1;4)
	
End if 

$Lon_maxHeight:=$Lon_maxHeight+(LISTBOX Get rows height:C836(*;$1)*LISTBOX Get number of rows:C915(*;$1))

$Boo_vScroolbar:=(LISTBOX Get property:C917(*;$1;_o_lk display ver scrollbar:K53:8)=1)
If ($Boo_vScroolbar)
	
	$Lon_maxWidth:=$Lon_maxWidth+LISTBOX Get property:C917(*;$1;lk ver scrollbar width:K53:9)
	
End if 

LISTBOX GET ARRAYS:C832(*;$1;$Txt_colNames;$tTxt_headerNames;$tPtr_varCol;$tPtr_varHeader;$tBoo_visible;$tPtr_styles)

For ($Lon_i;1;Size of array:C274($Txt_colNames);1)
	
	If ($tBoo_visible{$Lon_i})
		
		$Lon_maxWidth:=$Lon_maxWidth+LISTBOX Get column width:C834(*;$Txt_colNames{$Lon_i})
		
	End if 
	
End for 

OBJECT GET COORDINATES:C663(*;$1;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
OBJECT SET SCROLLBAR:C843(*;$1;($Lon_right-$Lon_left)<$Lon_maxWidth;($Lon_bottom-$Lon_top)<$Lon_maxHeight)
