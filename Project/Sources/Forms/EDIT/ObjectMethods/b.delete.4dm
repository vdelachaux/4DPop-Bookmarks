C_LONGINT:C283($Lon_x)
C_POINTER:C301($Ptr_label)

$Ptr_label:=OBJECT Get pointer:C1124(Object named:K67:5;"list.label")
$Lon_x:=$Ptr_label->

LISTBOX DELETE ROWS:C914(*;"listbox";$Lon_x)

If ($Lon_x>Size of array:C274($Ptr_label->))
	
	$Lon_x:=$Lon_x-1
	
End if 

LISTBOX SELECT ROW:C912(*;"listbox";$Lon_x;lk replace selection:K53:1)
