//%attributes = {"invisible":true}

If (False:C215)
	
	  //mnu_RELEASE_MENU
	C_TEXT:C284(mnu_RELEASE_MENU ;$1)
	
	  //lstb_SET_SCROLLBAR
	C_TEXT:C284(lstb_SET_SCROLLBAR ;$1)
	
	  //ParseFile
	C_TEXT:C284(ParseFile ;$1)
	C_POINTER:C301(ParseFile ;$2)
	C_POINTER:C301(ParseFile ;$3)
	C_POINTER:C301(ParseFile ;$4)
	
	  //MENUS_main
	C_TEXT:C284(MENUS_main ;$1)
	
	  //GetPath
	C_TEXT:C284(getDataFilePath ;$0)
	
	  //Display_Menu
	C_POINTER:C301(4DPop_bookMarks ;$1)
	
	  //Tool_ondrop
	C_POINTER:C301(4DPop_bookMarksOnDrop ;$1)
	
	  //Tool init
	C_POINTER:C301(4DPop_bookMarksInit ;$1)
	
	  //ondrop
	C_BOOLEAN:C305(ondrop ;$0)
	C_POINTER:C301(ondrop ;$1)
	C_POINTER:C301(ondrop ;$2)
	C_POINTER:C301(ondrop ;$3)
	
	  //POSIX_Path
	C_TEXT:C284(POSIX_Path ;$0)
	C_TEXT:C284(POSIX_Path ;$1)
	C_BOOLEAN:C305(POSIX_Path ;$2)
	
	C_TEXT:C284(doc_getFromPath ;$0)
	C_TEXT:C284(doc_getFromPath ;$1)
	C_TEXT:C284(doc_getFromPath ;$2)
	C_TEXT:C284(doc_getFromPath ;$3)
	
	
	C_TEXT:C284(recentDatabases ;$0)
	
	
	C_POINTER:C301(env_4D_RECENT_DATABASES ;$1)
	C_POINTER:C301(env_4D_RECENT_DATABASES ;$2)
	C_POINTER:C301(env_4D_RECENT_DATABASES ;$3)
	C_POINTER:C301(env_4D_RECENT_DATABASES ;$4)
	
End if 

