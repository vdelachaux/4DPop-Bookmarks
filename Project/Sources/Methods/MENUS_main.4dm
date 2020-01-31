//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Method : MENUS_main
  // Created 03/04/07 by vdelachaux
  // ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($Mnu_menu;$Mnu_menuBar;$Txt_entryPoint)

If (False:C215)
	C_TEXT:C284(MENUS_main ;$1)
End if 

$Txt_entryPoint:=$1

Case of 
		
		  //_____________________________________________________________________
	: ($Txt_entryPoint="install")
		
		  //Create menu bar
		$Mnu_menuBar:=Create menu:C408
		
		  //Create FILE menu
		$Mnu_menu:=Create menu:C408
		APPEND MENU ITEM:C411($Mnu_menu;":xliff:CommonMenuItemNew")
		SET MENU ITEM SHORTCUT:C423($Mnu_menu;-1;"N";Command key mask:K16:1)
		DISABLE MENU ITEM:C150($Mnu_menu;-1)
		
		APPEND MENU ITEM:C411($Mnu_menu;":xliff:CommonMenuItemOpen")
		SET MENU ITEM SHORTCUT:C423($Mnu_menu;-1;"O";Command key mask:K16:1)
		DISABLE MENU ITEM:C150($Mnu_menu;-1)
		
		APPEND MENU ITEM:C411($Mnu_menu;"(-")
		
		APPEND MENU ITEM:C411($Mnu_menu;":xliff:CommonMenuItemSave")
		SET MENU ITEM SHORTCUT:C423($Mnu_menu;-1;"S";Command key mask:K16:1)
		DISABLE MENU ITEM:C150($Mnu_menu;-1)
		
		APPEND MENU ITEM:C411($Mnu_menu;":xliff:CommonMenuItemRevertToSave")
		DISABLE MENU ITEM:C150($Mnu_menu;-1)
		
		APPEND MENU ITEM:C411($Mnu_menu;"(-")
		
		APPEND MENU ITEM:C411($Mnu_menu;":xliff:CommonMenuItemClose")
		SET MENU ITEM SHORTCUT:C423($Mnu_menu;-1;"W";Command key mask:K16:1)
		SET MENU ITEM METHOD:C982($Mnu_menu;-1;"CLOSE_WINDOW")
		
		  //Install FILE menu
		APPEND MENU ITEM:C411($Mnu_menuBar;":xliff:CommonMenuFile";$Mnu_menu)
		
		  //Create EDIT menu
		$Mnu_menu:=Create menu:C408
		APPEND MENU ITEM:C411($Mnu_menu;":xliff:CommonMenuItemUndo")
		SET MENU ITEM PROPERTY:C973($Mnu_menu;-1;"4D_standard_action";17)
		SET MENU ITEM SHORTCUT:C423($Mnu_menu;-1;"Z";Command key mask:K16:1)
		APPEND MENU ITEM:C411($Mnu_menu;"(-")
		
		APPEND MENU ITEM:C411($Mnu_menu;":xliff:CommonMenuItemCut")
		SET MENU ITEM PROPERTY:C973($Mnu_menu;-1;"4D_standard_action";18)
		SET MENU ITEM SHORTCUT:C423($Mnu_menu;-1;"X";Command key mask:K16:1)
		SET MENU ITEM PROPERTY:C973($Mnu_menu;-1;"4D_enable";1)
		
		APPEND MENU ITEM:C411($Mnu_menu;":xliff:CommonMenuItemCopy")
		SET MENU ITEM PROPERTY:C973($Mnu_menu;-1;"4D_standard_action";19)
		SET MENU ITEM SHORTCUT:C423($Mnu_menu;-1;"C";Command key mask:K16:1)
		SET MENU ITEM PROPERTY:C973($Mnu_menu;-1;"4D_enable";1)
		
		APPEND MENU ITEM:C411($Mnu_menu;":xliff:CommonMenuItemPaste")
		SET MENU ITEM PROPERTY:C973($Mnu_menu;-1;"4D_standard_action";20)
		SET MENU ITEM SHORTCUT:C423($Mnu_menu;-1;"V";Command key mask:K16:1)
		SET MENU ITEM PROPERTY:C973($Mnu_menu;-1;"4D_enable";1)
		
		APPEND MENU ITEM:C411($Mnu_menu;":xliff:CommonMenuItemClear")
		SET MENU ITEM PROPERTY:C973($Mnu_menu;-1;"4D_standard_action";21)
		
		APPEND MENU ITEM:C411($Mnu_menu;":xliff:CommonMenuItemSelectAll")
		SET MENU ITEM PROPERTY:C973($Mnu_menu;-1;"4D_standard_action";22)
		SET MENU ITEM SHORTCUT:C423($Mnu_menu;-1;"A";Command key mask:K16:1)
		
		APPEND MENU ITEM:C411($Mnu_menu;"(-")
		
		APPEND MENU ITEM:C411($Mnu_menu;":xliff:CommonMenuItemShowClipboard")
		SET MENU ITEM PROPERTY:C973($Mnu_menu;-1;"4D_standard_action";23)
		
		  //Install EDIT menu
		APPEND MENU ITEM:C411($Mnu_menuBar;":xliff:CommonMenuEdit";$Mnu_menu)
		
		  //Install Menu bar
		SET MENU BAR:C67($Mnu_menuBar)
		  //_____________________________________________________________________
	: ($Txt_entryPoint="release")
		
		$Mnu_menuBar:=Get menu bar reference:C979(Current process:C322)
		
		If ($Mnu_menuBar#"")
			
			mnu_RELEASE_MENU ($Mnu_menuBar)
			
		End if 
		
		  //_____________________________________________________________________
End case 
