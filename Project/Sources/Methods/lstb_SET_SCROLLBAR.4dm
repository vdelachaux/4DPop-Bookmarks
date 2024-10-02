//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : lstb_SET_SCROLLBAR
// Created 06/12/06 by vdl
// ----------------------------------------------------
#DECLARE($widget : Text)

var $hScroolbar; $vScroolbar : Boolean
var $bottom; $i; $left; $maxHeight; $maxWidth; $right; $top : Integer

ARRAY BOOLEAN:C223($_visible; 0)
ARRAY POINTER:C280($_styles; 0)
ARRAY POINTER:C280($_varCol; 0)
ARRAY POINTER:C280($_varHeader; 0)
ARRAY TEXT:C222($_colNames; 0)
ARRAY TEXT:C222($_headerNames; 0)

If (LISTBOX Get property:C917(*; $widget; lk display header:K53:4)=1)
	
	$maxHeight:=LISTBOX Get property:C917(*; $widget; _o_lk header height:K53:5)
	
End if 

$hScroolbar:=(LISTBOX Get property:C917(*; $widget; 2)=1)

If ($hScroolbar)
	
	$maxHeight:=$maxHeight+LISTBOX Get property:C917(*; $widget; 4)
	
End if 

$maxHeight:=$maxHeight+(LISTBOX Get rows height:C836(*; $widget)*LISTBOX Get number of rows:C915(*; $widget))

$vScroolbar:=(LISTBOX Get property:C917(*; $widget; _o_lk display ver scrollbar:K53:8)=1)

If ($vScroolbar)
	
	$maxWidth:=$maxWidth+LISTBOX Get property:C917(*; $widget; lk ver scrollbar width:K53:9)
	
End if 

LISTBOX GET ARRAYS:C832(*; $widget; $_colNames; $_headerNames; $_varCol; $_varHeader; $_visible; $_styles)

For ($i; 1; Size of array:C274($_colNames); 1)
	
	If ($_visible{$i})
		
		$maxWidth:=$maxWidth+LISTBOX Get column width:C834(*; $_colNames{$i})
		
	End if 
End for 

OBJECT GET COORDINATES:C663(*; $widget; $left; $top; $right; $bottom)
OBJECT SET SCROLLBAR:C843(*; $widget; ($right-$left)<$maxWidth; ($bottom-$top)<$maxHeight)