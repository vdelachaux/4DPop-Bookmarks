//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Method : EDIT
  // Created 25/01/07 by vdl
  // ----------------------------------------------------

  // Modified by: 保坂圭是 (2020/01/28)

C_LONGINT:C283($Lon_bottom;$Lon_currentWindow;$Lon_left;$Lon_process;$Lon_right;$Lon_top)
C_TEXT:C284($Dom_position;$Dom_pref;$kTxt_currentForm;$kTxt_ToolName;$Txt_xml;$Txt_currentMethod)
C_OBJECT:C1216($bookmerk_file;$defaultBookmerk_file)

$Txt_currentMethod:=Current method name:C684
$kTxt_currentForm:="EDIT"
$kTxt_ToolName:="BookMarks"

If (Process number:C372("$"+$Txt_currentMethod)=0)
	
	$Lon_process:=New process:C317($Txt_currentMethod;0;"$"+$Txt_currentMethod;*)
	
Else 
	
	COMPILER_main 
	
	MENUS_main ("Install")
	
	  // Get the window position if any {
	  //4DPop_preferenceLoad ($kTxt_ToolName)
	$bookmerk_file:=File:C1566(Get 4D folder:C485+"4DPop_Bookmarks.xml";fk platform path:K87:2)
	
	If ($bookmerk_file.exists=False:C215)
		
		$defaultBookmerk_file:=File:C1566(Get localized document path:C1105("DefaultBookmarks.xml");fk platform path:K87:2)
		$Txt_xml:=$defaultBookmerk_file.getText()
		
	Else 
		
		$Txt_xml:=$bookmerk_file.getText()
		
	End if 
	
	$Dom_pref:=DOM Parse XML variable:C720($Txt_xml)
	
	If (OK=1)
		
		$Dom_position:=DOM Find XML element:C864($Dom_pref;"preference/BookMarks/edit.window")
		
		If (OK=1)
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_position;"left";$Lon_left)
			
			If (OK=1)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_position;"top";$Lon_top)
				
				If (OK=1)
					
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_position;"right";$Lon_right)
					
					If (OK=1)
						
						DOM GET XML ATTRIBUTE BY NAME:C728($Dom_position;"bottom";$Lon_bottom)
						
					End if 
				End if 
			End if 
		End if 
	End if 
	  //}
	
	If (OK=1)
		
		$Lon_currentWindow:=Open window:C153(\
			$Lon_left;\
			$Lon_top;\
			$Lon_right;\
			$Lon_bottom;\
			Plain window:K34:13+_o_Compositing mode:K34:18;\
			Get localized string:C991("EditWindowTitle");\
			"CLOSE_WINDOW")
		
	Else 
		
		$Lon_currentWindow:=Open form window:C675(\
			$kTxt_currentForm;\
			Plain form window:K39:10;\
			Horizontally centered:K39:1;\
			Vertically centered:K39:4)
		
	End if 
	
	DIALOG:C40($kTxt_currentForm)
	
	  // Store the window position {
	GET WINDOW RECT:C443($Lon_left;$Lon_top;$Lon_right;$Lon_bottom;$Lon_currentWindow)
	
	$Dom_position:=DOM Find XML element:C864($Dom_pref;"preference/BookMarks/edit.window")
	
	If (OK=0)
		
		$Dom_position:=DOM Create XML element:C865($Dom_pref;"preference/BookMarks/edit.window")
		
	End if 
	
	If (OK=1)
		
		DOM SET XML ATTRIBUTE:C866($Dom_position;\
			"left";$Lon_left;\
			"top";$Lon_top;\
			"right";$Lon_right;\
			"bottom";$Lon_bottom)
		
		If (OK=1)
			
			DOM EXPORT TO FILE:C862($Dom_pref;$bookmerk_file.platformPath)
			
			  //4DPop_preferenceStore ($kTxt_ToolName;$Dom_pref)
			
		End if 
	End if 
	  //}
	
	DOM CLOSE XML:C722($Dom_pref)
	
	CLOSE WINDOW:C154
	
	MENUS_main ("release")
	
	COMPILER_main 
	
End if 