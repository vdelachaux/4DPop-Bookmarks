//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : EDIT
// Created 25/01/07 by vdl
// ----------------------------------------------------
// Modified by: 保坂圭是 (2020/01/28)
// ----------------------------------------------------
// Modified by: vdl (1-9-2020)
// Code rewrites
// ----------------------------------------------------
var $root; $xml : Text
var $process; $window : Integer

var $file : 4D:C1709.Document
var $menuBar; $menuEdit; $menuFile : cs:C1710.menu

If (Process number:C372("$"+Current method name:C684)=0)
	
	$process:=New process:C317(Current method name:C684; 0; "$"+Current method name:C684; *)
	
Else 
	
	$menuBar:=cs:C1710.menu.new()
	
	$menuFile:=cs:C1710.menu.new()
	$menuFile.append("CommonMenuItemNew").shortcut("N")
	$menuFile.append("CommonMenuItemOpen").shortcut("O")
	$menuFile.line()
	$menuFile.append("CommonMenuItemSave").shortcut("S")
	$menuFile.append("CommonMenuItemRevertToSave")
	$menuFile.line()
	$menuFile.append("CommonMenuItemClose").shortcut("W")
	
	$menuBar.append("CommonMenuFile"; $menuFile)
	
	$menuEdit:=cs:C1710.menu.new()
	$menuEdit.edit()
	
	$menuBar.append("CommonMenuEdit"; $menuEdit)
	
	$menuBar.setBar()
	
	$file:=File:C1566(Get 4D folder:C485+"4DPop_Bookmarks.xml"; fk platform path:K87:2)
	
	If ($file.exists=False:C215)
		
		// Get default
		$xml:=File:C1566(Get localized document path:C1105("DefaultBookmarks.xml"); fk platform path:K87:2).getText()
		
	Else 
		
		$xml:=$file.getText()
		
	End if 
	
	$root:=DOM Parse XML variable:C720($xml)
	
	If (Bool:C1537(OK))
		
		$window:=Open form window:C675("EDIT"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
		
		DIALOG:C40("EDIT")
		CLOSE WINDOW:C154
		
		DOM EXPORT TO FILE:C862($root; $file.platformPath)
		DOM CLOSE XML:C722($root)
		
	End if 
End if 