//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Method : 4DPop_bookMarks
  // Created 25/01/07 by vdl
  // ----------------------------------------------------
  // Modified by: 保坂圭是 (2020/01/28)
  // ----------------------------------------------------
C_POINTER:C301($1)

C_LONGINT:C283($bottom;$i;$j;$l;$left)
C_TEXT:C284($node;$root;$t;$t_folder;$tName;$tValue)
C_OBJECT:C1216($file;$folder;$folderDatabase;$menu;$menu4D;$menuDatabase)
C_OBJECT:C1216($menuResources;$o)
C_COLLECTION:C1488($c)

If (False:C215)
	C_POINTER:C301(4DPop_bookMarks ;$1)
End if 

$t_folder:="/RESOURCES/images/8.png"

/* -------------------------
Database folders
-------------------------*/
$folderDatabase:=Folder:C1567(fk database folder:K87:14;*)
$menuDatabase:=menu \
.append("MenusdatabaseFolder";$folderDatabase.platformPath).icon($t_folder)\
.line()\
.append("Preferences";$folderDatabase.folder("Preferences").platformPath).icon($t_folder).enable($folderDatabase.folder("Preferences").exists)\
.append("Settings";$folderDatabase.folder("Settings").platformPath).icon($t_folder).enable($folderDatabase.folder("Settings").exists)

  // Logs
$folder:=Folder:C1567(fk logs folder:K87:17)
$menuDatabase.append("Menuslogs";$folder.platformPath).icon($t_folder).enable($folder.exists)

  // Resources folder
$folder:=Folder:C1567(fk resources folder:K87:11;*)

If ($folder.exists)
	
	$menuResources:=menu \
		.append("Resources";$folder.platformPath).icon($t_folder)
	
	$c:=$folder.folders()
	
	If ($c.length>0)
		
		$menuResources.line()
		
		For each ($o;$c)
			
			$menuResources.append($o.name;$o.platformPath).icon($t_folder)
			
		End for each 
	End if 
End if 

$menuDatabase.append("Resources";$menuResources).icon($t_folder)

  // Components folder
$folder:=$folderDatabase.folder("Components")

If ($folder.exists)
	
	$menuDatabase.append("Menuscomponents";$folder.platformPath).icon($t_folder)
	
Else 
	
	$menuDatabase.append(Get localized string:C991("CommonAdd")+" "+Get localized string:C991("Menuscomponents");$folder.platformPath)
	
End if 

  // Macros v2 folder
$folder:=$folderDatabase.folder("Macros v2")

If ($folder.exists)
	
	$menuDatabase.append("Menusmacros";$folder.platformPath).icon($t_folder)
	
Else 
	
	$menuDatabase.append(Get localized string:C991("CommonAdd")+" "+Get localized string:C991("Menusmacros");$folder.platformPath)
	
End if 

  // Web folder
$folder:=Folder:C1567(fk web root folder:K87:15;*)

If ($folder.exists)
	
	$menuDatabase.append("MenushtmlRootFolder";$folder.platformPath).icon($t_folder)
	
Else 
	
	$menuDatabase.append(Get localized string:C991("CommonAdd")+" "+Get localized string:C991("MenushtmlRootFolder");$folder.platformPath)
	
End if 

If (Path to object:C1547(Structure file:C489(*)).extension=".4dproject")
	
	$menuDatabase.line()
	$menuDatabase.append("Project";$folderDatabase.folder("Project").platformPath).icon($t_folder)
	$menuDatabase.line()
	$menuDatabase.append("Sources";$folderDatabase.folder("Project/Sources").platformPath).icon($t_folder)
	$menuDatabase.append("DerivedData";$folderDatabase.folder("Project/DerivedData").platformPath).icon($t_folder)
	$menuDatabase.append("Trash";$folderDatabase.folder("Project/Trash").platformPath).icon($t_folder)
	$menuDatabase.line()
	$menuDatabase.append("Forms";$folderDatabase.folder("Project/Sources/Forms").platformPath).icon($t_folder)
	$menuDatabase.append("Methods";$folderDatabase.folder("Project/Sources/Methods").platformPath).icon($t_folder)
	$menuDatabase.append("DatabaseMethods";$folderDatabase.folder("Project/Sources/DatabaseMethods").platformPath).icon($t_folder)
	$menuDatabase.append("Triggers";$folderDatabase.folder("Project/Sources/Triggers").platformPath).icon($t_folder)
	$menuDatabase.line()
	
End if 

/* -------------------------
4D folders
-------------------------*/
$menu4D:=menu \
.append("Menus4dApplication";Application file:C491).icon("/RESOURCES/images/4D.png")\
.line()

  // Current 4D folder
$folder:=Folder:C1567(fk user preferences folder:K87:10)

If ($folder.exists)
	
	$menu4D.append("Menus4dFolder";$folder.platformPath).icon($t_folder)\
		.line()
	
End if 

  // 4D Components folder
$folder:=Folder:C1567(Application file:C491;fk platform path:K87:2).folder(Choose:C955(Is macOS:C1572;"Contents/";"Components"))

If ($folder.exists)
	
	$menu4D.append("Menuscomponents";$folder.platformPath).icon($t_folder)
	
End if 

  // 4D Macros folder
$folder:=Folder:C1567(fk user preferences folder:K87:10).folder("Macros v2")

If ($folder.exists)
	
	$menu4D.append("Menusmacros";$folder.platformPath).icon($t_folder)\
		.line()
	
End if 

$t:=Application version:C493
$folder:=Folder:C1567(fk user preferences folder:K87:10).folder("4D Window Bounds v"+$t[[1]]+$t[[2]])
$menu4D.append("4D Window Bounds v"+$t[[1]]+$t[[2]];$folder.platformPath).icon($t_folder)

$menu:=menu \
.append("MenuscurrentFolders";menu \
.append("Menusdatabase";$menuDatabase).icon("/RESOURCES/images/database.png")\
.append("Menus4dApplication";$menu4D).icon("/RESOURCES/images/4D.png")).icon($t_folder)\
.line()

/* -------------------------
User bookmaks
-------------------------*/
$file:=File:C1566(getDataFilePath ;fk platform path:K87:2)

If ($file.exists)
	
	$menu.line()
	
	$t:=$file.getText()
	$root:=DOM Parse XML variable:C720($t)
	
	If (Bool:C1537(OK))
		
		$node:=DOM Find XML element:C864($root;"bookmarks/bookmark")
		
		For ($i;1;DOM Count XML elements:C726($root;"bookmark");1)
			
			$o:=New object:C1471
			
			For ($j;1;DOM Count XML attributes:C727($node);1)
				
				DOM GET XML ATTRIBUTE BY INDEX:C729($node;$j;$tName;$tValue)
				
				Case of 
						
						  //………………………………………………………………………………………………………………………………
					: ($tName="name")
						
						$o.label:=Choose:C955($tValue[[1]]#"-";Char:C90(1);"")+$tValue
						
						  //………………………………………………………………………………………………………………………………
					: ($tName="url")
						
						$o.url:=$tValue
						
						  //………………………………………………………………………………………………………………………………
					: ($tName="type")
						
						$o.icon:="/RESOURCES/images/"+$tValue+".png"
						
						  //………………………………………………………………………………………………………………………………
					Else 
						
						$o[$tName]:=$tValue
						
						  //………………………………………………………………………………………………………………………………
				End case 
			End for 
			
			If (String:C10($o.label)="-")
				
				$menu.line()
				
			Else 
				
				$menu.append(String:C10($o.label);String:C10($o.url)).icon(String:C10($o.icon))
				
				$c:=New collection:C1472("label";"url";"icon")
				
				For each ($t;$o)
					
					If ($c.indexOf($t)=-1)
						
						  // SET MENU ITEM PROPERTY ?
						
					End if 
				End for each 
			End if 
			
			$node:=DOM Get next sibling XML element:C724($node)
			
		End for 
		
		DOM CLOSE XML:C722($root)
		
		$menu.line().append("EditWindowTitle";"Edit")
		
	End if 
End if 

If (Count parameters:C259>0)
	
	OBJECT GET COORDINATES:C663($1->;$left;$l;$l;$bottom)
	
	$menu.popup("";$left;$bottom)
	
Else 
	
	$menu.popup()
	
End if 

Case of 
		
		  //______________________________________________________
	: (Not:C34($menu.selected))
		
		  //______________________________________________________
	: ($menu.choice="Edit")
		
		EDIT 
		
		  //______________________________________________________
	: ($menu.choice="file:// @")
		
		If (Macintosh command down:C546)
			
			SHOW ON DISK:C922(Replace string:C233($menu.choice;"file:// ";"");*)
			
		Else 
			
			If (Is Windows:C1573)
				
				OPEN URL:C673(Replace string:C233($menu.choice;"file:// ";""))
				
			Else 
				
				LAUNCH EXTERNAL PROCESS:C811("open "+POSIX_Path (Replace string:C233($menu.choice;"file:// ";"")))
				
			End if 
		End if 
		
		  //______________________________________________________
	: (Test path name:C476($menu.choice)=Is a folder:K24:2)
		
		If ($menu.choice="@.app")  // Application package on mac
			
			If ($menu.choice=Application file:C491)
				
				SHOW ON DISK:C922($menu.choice)
				
			Else 
				
				LAUNCH EXTERNAL PROCESS:C811("open "+POSIX_Path ($menu.choice))
				
			End if 
			
		Else 
			
			SHOW ON DISK:C922($menu.choice;*)
			
		End if 
		
		  //______________________________________________________
	: (Test path name:C476($menu.choice)#Is a folder:K24:2)\
		 & ($menu.choice#"@.app")\
		 & (Position:C15(Get 4D folder:C485(Database folder:K5:14;*);$menu.choice)=1)
		
		  // Create a database folder
		CREATE FOLDER:C475($menu.choice;*)
		SHOW ON DISK:C922($menu.choice;*)
		
		  //______________________________________________________
	Else 
		
		If (Macintosh command down:C546)
			
			SHOW ON DISK:C922(Replace string:C233($menu.choice;"file:// ";"");*)
			
		Else 
			
			OPEN URL:C673($menu.choice;*)
			
		End if 
		
		  //______________________________________________________
End case 