// ----------------------------------------------------
// Method : Méthode objet :BookMarks_Edit.List Box1
// Created 18/11/06 by vdl
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($Lon_colonne; $Lon_ligne; $Lon_objectEvent; $Lon_type; $Lon_x)
C_PICTURE:C286($Pic_buffer)
C_POINTER:C301($Ptr_Array; $Ptr_icon; $Ptr_label; $Ptr_type; $Ptr_url)
C_TEXT:C284($Txt_currentObject; $Txt_name; $Txt_url)

$Lon_objectEvent:=Form event code:C388
$Txt_currentObject:=OBJECT Get name:C1087(Object current:K67:2)

Case of 
		
		//______________________________________________________
	: ($Lon_objectEvent=On Column Resize:K2:31)
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($Lon_objectEvent=On Double Clicked:K2:5)
		
		lstb_ON_DOUBLE_CLIC
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($Lon_objectEvent=On Drag Over:K2:13)
		
		//______________________________________________________
	: ($Lon_objectEvent=On Drop:K2:12)
		
		If (doDrop(->$Txt_name; ->$Txt_url; ->$Lon_type))
			
			$Ptr_icon:=OBJECT Get pointer:C1124(Object named:K67:5; "list.icon")
			$Ptr_label:=OBJECT Get pointer:C1124(Object named:K67:5; "list.label")
			$Ptr_url:=OBJECT Get pointer:C1124(Object named:K67:5; "list.url")
			$Ptr_type:=OBJECT Get pointer:C1124(Object named:K67:5; "list.type")
			
			APPEND TO ARRAY:C911($Ptr_label->; $Txt_name)
			APPEND TO ARRAY:C911($Ptr_url->; $Txt_url)
			APPEND TO ARRAY:C911($Ptr_type->; $Lon_type)
			
			READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"images"+Folder separator:K24:12+String:C10($Lon_type)+".png"; $Pic_buffer)
			APPEND TO ARRAY:C911($Ptr_icon->; $Pic_buffer)
			
			$Lon_x:=Size of array:C274($Ptr_label->)
			LISTBOX SELECT ROW:C912(*; $Txt_currentObject; $Lon_x; lk replace selection:K53:1)
			OBJECT SET SCROLL POSITION:C906(*; $Txt_currentObject; $Lon_x)
			
			SET TIMER:C645(-1)
			
		Else 
			
			BEEP:C151
			
		End if 
		
		SET CURSOR:C469
		
		//______________________________________________________
End case 

If ($Lon_objectEvent=On Selection Change:K2:29)
	
	OBJECT SET ENABLED:C1123(*; "b.delete"; (OBJECT Get pointer:C1124(Object named:K67:5; "list.label"))->#0)
	
End if 

