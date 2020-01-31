//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Method : 4DPop_bookMarks
  // Created 25/01/07 by vdl
  // ----------------------------------------------------
C_POINTER:C301($1)

C_BOOLEAN:C305($Boo_dummy)
C_DATE:C307($Dat_creation;$Dat_modification)
C_LONGINT:C283($Lon_bottom;$Lon_count;$Lon_dummy;$Lon_i;$Lon_index;$Lon_j;$Lon_left;$Lon_Platform)
C_LONGINT:C283($Lon_sortKey;$Lon_x)
C_TIME:C306($Gmt_creation;$Gmt_modification)
C_TEXT:C284($Dom_bookmark;$Dom_node;$Dom_root;$kTxt_indent;$Mnu_4D;$Mnu_current;$Mnu_database;$Mnu_sub)
C_TEXT:C284($Mnu_folders;$Mnu_main;$Txt_buffer;$Txt_databaseName;$Txt_fileName;$Txt_name;$Txt_path;$Txt_serverPath)
C_TEXT:C284($Txt_structure;$Txt_URL;$Txt_value)

ARRAY LONGINT:C221($tLon_sort;0)
ARRAY TEXT:C222($tTxt_4dlink;0)
ARRAY TEXT:C222($tTxt_folders;0)
ARRAY TEXT:C222($tTxt_names;0)
ARRAY TEXT:C222($tTxt_path;0)

If (False:C215)
	C_POINTER:C301(4DPop_bookMarks ;$1)
End if 

$Mnu_main:=Create menu:C408

If (True:C214)  //Current folders
	
	$Mnu_current:=Create menu:C408
	APPEND MENU ITEM:C411($Mnu_main;":xliff:MenuscurrentFolders";$Mnu_current)
	SET MENU ITEM ICON:C984($Mnu_main;-1;"#images/8.png")
	RELEASE MENU:C978($Mnu_current)
	
	If (True:C214)  //Database
		
		$Mnu_database:=Create menu:C408
		APPEND MENU ITEM:C411($Mnu_current;":xliff:Menusdatabase";$Mnu_database)
		SET MENU ITEM ICON:C984($Mnu_current;-1;"#images/database.png")
		RELEASE MENU:C978($Mnu_database)
		
		APPEND MENU ITEM:C411($Mnu_database;":xliff:MenusdatabaseFolder")
		SET MENU ITEM PARAMETER:C1004($Mnu_database;-1;4DPop_hostDatabaseFolder (kRoot))
		SET MENU ITEM ICON:C984($Mnu_database;-1;"#images/8.png")
		
		APPEND MENU ITEM:C411($Mnu_database;":xliff:Menuspreferences")
		$Txt_path:=4DPop_hostDatabaseFolder (kPreferences)
		SET MENU ITEM PARAMETER:C1004($Mnu_database;-1;$Txt_path)
		SET MENU ITEM ICON:C984($Mnu_database;-1;"#images/8.png")
		
		If (Test path name:C476($Txt_path)#Is a folder:K24:2)
			
			DISABLE MENU ITEM:C150($Mnu_database;-1)
			
		End if 
		
		  // Modified by Vincent de Lachaux (29/05/12)
		  // Add folders in resources as submenu {
		  //AJOUTER LIGNE MENU($Mnu_database;":xliff:Menusresources")
		  //FIXER PARAMETRE LIGNE MENU($Mnu_database;-1;4DPop_hostDatabaseFolder (kResources))
		  //FIXER ICONE LIGNE MENU($Mnu_database;-1;"#images/8.png")
		$Txt_path:=4DPop_hostDatabaseFolder (kResources)
		$Mnu_folders:=Create menu:C408
		FOLDER LIST:C473($Txt_path;$tTxt_folders)
		
		For ($Lon_i;1;Size of array:C274($tTxt_folders);1)
			
			APPEND MENU ITEM:C411($Mnu_folders;$tTxt_folders{$Lon_i})
			SET MENU ITEM PARAMETER:C1004($Mnu_folders;-1;$Txt_path+$tTxt_folders{$Lon_i})
			SET MENU ITEM ICON:C984($Mnu_folders;-1;"#images/8.png")
			
		End for 
		
		If (Count menu items:C405($Mnu_folders)>0)
			
			INSERT MENU ITEM:C412($Mnu_folders;0;"Resources")
			SET MENU ITEM PARAMETER:C1004($Mnu_folders;-1;$Txt_path)
			SET MENU ITEM ICON:C984($Mnu_folders;-1;"#images/8.png")
			
			INSERT MENU ITEM:C412($Mnu_folders;1;"-")
			
			APPEND MENU ITEM:C411($Mnu_database;":xliff:Menusresources";$Mnu_folders)
			
		Else 
			
			APPEND MENU ITEM:C411($Mnu_database;":xliff:Menusresources")
			
		End if 
		
		RELEASE MENU:C978($Mnu_folders)
		
		  //}
		SET MENU ITEM ICON:C984($Mnu_database;-1;"#images/8.png")
		
		If (Test path name:C476($Txt_path)#Is a folder:K24:2)
			
			DISABLE MENU ITEM:C150($Mnu_database;-1)
			
		End if 
		
		$Txt_path:=4DPop_hostDatabaseFolder (kComponents)
		
		If (Test path name:C476($Txt_path)=Is a folder:K24:2)
			
			APPEND MENU ITEM:C411($Mnu_database;":xliff:Menuscomponents")
			
		Else 
			
			APPEND MENU ITEM:C411($Mnu_database;Get localized string:C991("CommonAdd")+" "+Get localized string:C991("Menuscomponents"))
			
		End if 
		
		SET MENU ITEM PARAMETER:C1004($Mnu_database;-1;$Txt_path)
		SET MENU ITEM ICON:C984($Mnu_database;-1;"#images/8.png")
		
		$Txt_path:=4DPop_hostDatabaseFolder (kLogs)
		APPEND MENU ITEM:C411($Mnu_database;":xliff:Menuslogs")
		SET MENU ITEM PARAMETER:C1004($Mnu_database;-1;$Txt_path)
		SET MENU ITEM ICON:C984($Mnu_database;-1;"#images/8.png")
		
		If (Test path name:C476($Txt_path)#Is a folder:K24:2)
			
			DISABLE MENU ITEM:C150($Mnu_database;-1)
			
		End if 
		
		$Txt_path:=4DPop_hostDatabaseFolder (kLanguage)
		APPEND MENU ITEM:C411($Mnu_database;":xliff:Menuslanguage")
		SET MENU ITEM PARAMETER:C1004($Mnu_database;-1;$Txt_path)
		SET MENU ITEM ICON:C984($Mnu_database;-1;"#images/8.png")
		
		If (Test path name:C476($Txt_path)#Is a folder:K24:2)
			
			DISABLE MENU ITEM:C150($Mnu_database;-1)
			
		End if 
		
		$Txt_path:=4DPop_hostDatabaseFolder (kRoot)+"Macros v2"+Folder separator:K24:12
		
		If (Test path name:C476($Txt_path)=Is a folder:K24:2)
			
			APPEND MENU ITEM:C411($Mnu_database;":xliff:Menusmacros")
			
		Else 
			
			APPEND MENU ITEM:C411($Mnu_database;Get localized string:C991("CommonAdd")+" "+Get localized string:C991("Menusmacros"))
			
		End if 
		
		SET MENU ITEM PARAMETER:C1004($Mnu_database;-1;$Txt_path)
		SET MENU ITEM ICON:C984($Mnu_database;-1;"#images/8.png")
		
		$Txt_path:=Get 4D folder:C485(HTML Root folder:K5:20;*)
		
		If (Test path name:C476($Txt_path)=Is a folder:K24:2)
			
			APPEND MENU ITEM:C411($Mnu_database;":xliff:MenushtmlRootFolder")
			
		Else 
			
			APPEND MENU ITEM:C411($Mnu_database;Get localized string:C991("CommonAdd")+" "+Get localized string:C991("MenushtmlRootFolder"))
			
		End if 
		
		SET MENU ITEM PARAMETER:C1004($Mnu_database;-1;$Txt_path)
		SET MENU ITEM ICON:C984($Mnu_database;-1;"#images/8.png")
		
	End if 
	
	If (True:C214)  //4D
		
		$Mnu_4D:=Create menu:C408
		APPEND MENU ITEM:C411($Mnu_current;":xliff:Menus4dApplication";$Mnu_4D)
		SET MENU ITEM ICON:C984($Mnu_current;-1;"#images/16.png")
		RELEASE MENU:C978($Mnu_4D)
		
		APPEND MENU ITEM:C411($Mnu_4D;":xliff:Menus4dApplication")
		SET MENU ITEM PARAMETER:C1004($Mnu_4D;-1;Application file:C491)
		SET MENU ITEM ICON:C984($Mnu_4D;-1;"#images/16.png")
		
		APPEND MENU ITEM:C411($Mnu_4D;"-")
		
		$Txt_path:=4DPop_applicationFolder (kComponents)
		
		If (Test path name:C476($Txt_path)=Is a folder:K24:2)
			
			APPEND MENU ITEM:C411($Mnu_4D;":xliff:Menuscomponents")
			SET MENU ITEM PARAMETER:C1004($Mnu_4D;-1;$Txt_path)
			SET MENU ITEM ICON:C984($Mnu_4D;-1;"#images/8.png")
			
		End if 
		
		$Txt_path:=Get 4D folder:C485+"Macros v2"+Folder separator:K24:12
		
		If (Test path name:C476($Txt_path)=Is a folder:K24:2)
			
			APPEND MENU ITEM:C411($Mnu_4D;":xliff:Menusmacros")
			SET MENU ITEM PARAMETER:C1004($Mnu_4D;-1;$Txt_path)
			SET MENU ITEM ICON:C984($Mnu_4D;-1;"#images/8.png")
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_4D;"-")
		
		APPEND MENU ITEM:C411($Mnu_4D;":xliff:Menuslicences")
		SET MENU ITEM PARAMETER:C1004($Mnu_4D;-1;Get 4D folder:C485(Licenses folder:K5:11))
		SET MENU ITEM ICON:C984($Mnu_4D;-1;"#images/8.png")
		
		APPEND MENU ITEM:C411($Mnu_4D;":xliff:Menus4dFolder")
		SET MENU ITEM PARAMETER:C1004($Mnu_4D;-1;Get 4D folder:C485)
		SET MENU ITEM ICON:C984($Mnu_4D;-1;"#images/8.png")
		
		$Txt_buffer:=Application version:C493
		$Txt_buffer:=$Txt_buffer[[1]]+$Txt_buffer[[2]]
		
		APPEND MENU ITEM:C411($Mnu_4D;"4D Window Bounds v"+$Txt_buffer)
		SET MENU ITEM PARAMETER:C1004($Mnu_4D;-1;Get 4D folder:C485+"4D Window Bounds v"+$Txt_buffer)
		SET MENU ITEM ICON:C984($Mnu_4D;-1;"#images/8.png")
		
	End if 
End if 

If (False:C215)  //Recent databases
	
	$Txt_path:=Get 4D folder:C485\
		+"Favorites v"+Substring:C12(Application version:C493;1;2)\
		+Folder separator:K24:12
	
	If (Test path name:C476($Txt_path)=Is a folder:K24:2)
		
		$Mnu_sub:=recentDatabases 
		
		APPEND MENU ITEM:C411($Mnu_main;Get localized string:C991("MenusrecentDatabases");$Mnu_sub)
		SET MENU ITEM ICON:C984($Mnu_main;-1;"#images/8.png")
		
		RELEASE MENU:C978($Mnu_sub)
		
	End if 
End if 

$Txt_path:=getDataFilePath 

If (Test path name:C476($Txt_path)=Is a document:K24:1)
	
	$Dom_root:=DOM Parse XML source:C719($Txt_path;False:C215)
	
	If (OK=1)
		
		APPEND MENU ITEM:C411($Mnu_main;"-")
		
		$Dom_bookmark:=DOM Find XML element:C864($Dom_root;"bookmarks/bookmark")
		
		For ($Lon_i;1;DOM Count XML elements:C726($Dom_root;"bookmark");1)
			
			APPEND MENU ITEM:C411($Mnu_main;" ")  // !! at least one char
			
			For ($Lon_index;1;DOM Count XML attributes:C727($Dom_bookmark);1)
				
				DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_bookmark;$Lon_index;$Txt_name;$Txt_value)
				
				Case of 
						
						  //…………………………………………
					: ($Txt_name="name")
						
						SET MENU ITEM:C348($Mnu_main;-1;Choose:C955($Txt_value[[1]]#"-";Char:C90(1);"")+$Txt_value)
						
						  //…………………………………………
					: ($Txt_name="url")
						
						SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;$Txt_value)
						
						  //…………………………………………
					: ($Txt_name="type")
						
						SET MENU ITEM ICON:C984($Mnu_main;-1;"#images/"+$Txt_value+".png")
						
						  //…………………………………………
					Else 
						
						SET MENU ITEM PROPERTY:C973($Mnu_main;-1;$Txt_name;$Txt_value)
						
						  //…………………………………………
				End case 
			End for 
			
			$Dom_bookmark:=DOM Get next sibling XML element:C724($Dom_bookmark)
			
		End for 
		
		DOM CLOSE XML:C722($Dom_root)
		
		APPEND MENU ITEM:C411($Mnu_main;"-")
		APPEND MENU ITEM:C411($Mnu_main;Get localized string:C991("EditWindowTitle")+"…")
		SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"Edit")
		
	End if 
End if 

If (True:C214)  //in works
	
	ARRAY TEXT:C222($tTxt_files;0x0000)
	$Txt_Path:=Get 4D folder:C485(Active 4D Folder:K5:10)+"Favorites v"+Substring:C12(Application version:C493;1;2)
	DOCUMENT LIST:C474($Txt_Path;$tTxt_files;Absolute path:K24:14+Recursive parsing:K24:13+Ignore invisible:K24:16)
	
	For ($Lon_i;1;Size of array:C274($tTxt_files);1)
		
		$Txt_fileName:=$tTxt_files{$Lon_i}
		
		If ($Txt_fileName="@.4dlink")
			
			  //Compute a timestamp to sort files with most recently used databases first
			GET DOCUMENT PROPERTIES:C477($Txt_fileName;$Boo_dummy;$Boo_dummy;$Dat_creation;$Gmt_creation;$Dat_modification;$Gmt_modification)
			$Lon_sortKey:=(($Dat_modification-Add to date:C393(!00-00-00!;Year of:C25(Current date:C33)-10;1;1))*86400)+($Gmt_modification+0)
			
			$Dom_root:=DOM Parse XML source:C719($Txt_fileName)
			
			If (OK=1)
				
				APPEND TO ARRAY:C911($tTxt_4dlink;$Txt_fileName)
				
				$Dom_node:=DOM Find XML element:C864($Dom_root;"database_shortcut")
				$Lon_count:=DOM Count XML attributes:C727($Dom_node)
				ARRAY TEXT:C222($tTxt_keys;$Lon_count)
				ARRAY TEXT:C222($tTxt_values;$Lon_count)
				
				For ($Lon_j;1;$Lon_count;1)
					
					DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_node;$Lon_j;$tTxt_keys{$Lon_j};$tTxt_values{$Lon_j})
					
				End for 
				
				$Lon_x:=Find in array:C230($tTxt_keys;"structure_file")
				
				If ($Lon_x#-1)  // Local database
					
					$Txt_Path:=$tTxt_values{$Lon_x}
					
					APPEND TO ARRAY:C911($tLon_sort;$Lon_sortKey)
					
					  //Get the package name if any {
					$Txt_buffer:=doc_getFromPath ("parent";Convert path POSIX to system:C1107(Replace string:C233($Txt_Path;"file://";"")))
					
					If ($Txt_buffer=("@.4dbase"+Folder separator:K24:12))
						
						$Txt_databaseName:=doc_getFromPath ("shortName";$Txt_buffer)
						$Txt_buffer:=Substring:C12($Txt_buffer;1;Length:C16($Txt_buffer)-1)
						
					Else 
						
						$Txt_databaseName:=doc_getFromPath ("fullName";$tTxt_values{$Lon_x};"/")
						
					End if   //}
					
					APPEND TO ARRAY:C911($tTxt_path;$Txt_buffer)
					APPEND TO ARRAY:C911($tTxt_names;$kTxt_indent+$Txt_databaseName)
					
				Else   // Server
					
					$Lon_x:=Find in array:C230($tTxt_keys;"server_database_name")
					
					If ($Lon_x#-1)
						
						$Txt_structure:=$tTxt_values{$Lon_x}
						
					End if 
					
					$Lon_x:=Find in array:C230($tTxt_keys;"server_path")
					
					If ($Lon_x#-1)
						
						$Txt_serverPath:=$tTxt_values{$Lon_x}
						
					End if 
					
					If (Length:C16($Txt_structure)#0)\
						 & (Length:C16($Txt_serverPath)#0)
						
						APPEND TO ARRAY:C911($tTxt_names;$kTxt_indent+$Txt_structure+" - "+$Txt_serverPath)
						APPEND TO ARRAY:C911($tTxt_path;$Txt_serverPath)
						APPEND TO ARRAY:C911($tLon_sort;$Lon_sortKey)
						
					End if 
				End if 
				
				DOM CLOSE XML:C722($Dom_root)
				
			End if 
		End if 
	End for 
	
End if 

If (Count parameters:C259>0)
	
	OBJECT GET COORDINATES:C663($1->;$Lon_left;$Lon_dummy;$Lon_dummy;$Lon_bottom)
	
	$Txt_URL:=mnu_PopUp ($Mnu_main;"";$Lon_left;$Lon_bottom)
	
Else 
	
	$Txt_URL:=mnu_PopUp ($Mnu_main)
	
End if 

RELEASE MENU:C978($Mnu_main)

Case of 
		
		  //-----------------------------------
	: (Length:C16($Txt_URL)=0)
		
		  //-----------------------------------
	: ($Txt_URL="addCurrent4DLink")
		
		
		  //-----------------------------------
	: ($Txt_URL="Edit")
		
		EDIT 
		
		  //-----------------------------------
	: ($Txt_URL="file://@")
		
		If (Macintosh command down:C546)
			
			$Txt_URL:=Replace string:C233($Txt_URL;"file://";"")
			SHOW ON DISK:C922($Txt_URL;*)
			
		Else 
			
			_O_PLATFORM PROPERTIES:C365($Lon_Platform)
			
			If ($Lon_Platform=Windows:K25:3)
				
				OPEN URL:C673(Replace string:C233($Txt_URL;"file://";""))
				
			Else 
				
				$Txt_URL:=Replace string:C233($Txt_URL;"file://";"")
				LAUNCH EXTERNAL PROCESS:C811("open "+POSIX_Path ($Txt_URL))
				
			End if 
		End if 
		
		  //-----------------------------------
	: (Test path name:C476($Txt_URL)=Is a folder:K24:2)
		
		If ($Txt_URL="@.app")  //Application package on mac
			
			If ($Txt_URL=Application file:C491)
				
				SHOW ON DISK:C922($Txt_URL)
				
			Else 
				
				LAUNCH EXTERNAL PROCESS:C811("open "+POSIX_Path ($Txt_URL))
				
			End if 
			
			
		Else 
			
			SHOW ON DISK:C922($Txt_URL;*)
			
		End if 
		
		  //-----------------------------------
	: (Test path name:C476($Txt_URL)#Is a folder:K24:2)\
		 & ($Txt_URL#"@.app")\
		 & (Position:C15(Get 4D folder:C485(Database folder:K5:14);$Txt_URL)=1)  //create a database folder
		
		CREATE FOLDER:C475($Txt_URL;*)
		SHOW ON DISK:C922($Txt_URL;*)
		
		  //-----------------------------------
	Else 
		
		If (Macintosh command down:C546)
			
			$Txt_URL:=Replace string:C233($Txt_URL;"file://";"")
			SHOW ON DISK:C922($Txt_URL;*)
			
		Else 
			
			OPEN URL:C673($Txt_URL;*)
			
		End if 
		
		  //-----------------------------------
End case 