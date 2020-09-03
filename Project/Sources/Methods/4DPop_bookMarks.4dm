//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Method : 4DPop_bookMarks
// Created 25/01/07 by vdl
// ----------------------------------------------------
// Modified by: 保坂圭是 (2020/01/28)
// ----------------------------------------------------
// Modified by: vdl (1-9-2020)
// More compatibility with projects and code rewrites
// ----------------------------------------------------
var $1 : Pointer

If (False:C215)
	C_POINTER:C301(4DPop_bookMarks; $1)
End if 

var $folderIcon; $key; $root; $t; $value; $version : Text
var $i; $j : Integer
var $o : Object
var $folders; $optionals : Collection

var $databaseRoot; $folder : 4D:C1709.Directory
var $file : 4D:C1709.Document
var $application; $database; $menu; $project; $resources : cs:C1710.menu

$folderIcon:="/RESOURCES/images/8.png"
$version:=Application version:C493

$databaseRoot:=Folder:C1567(fk database folder:K87:14; *)

$database:=cs:C1710.menu.new()
$database.append("MenusdatabaseFolder"; $databaseRoot.platformPath).icon($folderIcon)

$database.append("MenusDataFolder"; Folder:C1567("/DATA").platformPath).icon($folderIcon)

$folder:=Folder:C1567(fk logs folder:K87:17; *)
$database.append("Menuslogs"; $folder.platformPath).icon($folderIcon).enable($folder.exists)

$database.line()

$optionals:=New collection:C1472

For each ($folder; $databaseRoot.folders().orderBy("name asc"))
	
	Case of 
			
			//______________________________________________________
		: ($folder.name="Project")
			
			$project:=cs:C1710.menu.new()
			$project.append("MenusProject"; $databaseRoot.folder("Project").platformPath).icon($folderIcon)\
				.line()
			
			$folder:=$databaseRoot.folder("Project/Sources/Classes")
			$project.append("Classes"; $folder.platformPath).icon($folderIcon).enable($folder.exists)
			
			$project.append("DatabaseMethods"; $databaseRoot.folder("Project/Sources/DatabaseMethods").platformPath).icon($folderIcon)
			
			$folder:=$databaseRoot.folder("Documentation")
			$project.append("Documentation"; $folder.platformPath).icon($folderIcon).enable($folder.exists)
			
			$project.append("Forms"; $databaseRoot.folder("Project/Sources/Forms").platformPath).icon($folderIcon)
			$project.append("Methods"; $databaseRoot.folder("Project/Sources/Methods").platformPath).icon($folderIcon)
			$project.append("Triggers"; $databaseRoot.folder("Project/Sources/Triggers").platformPath).icon($folderIcon)
			
			$project.line()\
				.append("DerivedData"; $databaseRoot.folder("Project/DerivedData").platformPath).icon($folderIcon)\
				.append("Trash"; $databaseRoot.folder("Project/Trash").platformPath).icon($folderIcon)
			
			$database.append("Project"; $project).icon($folderIcon)
			
			//______________________________________________________
		: ($folder.name="Resources")
			
			$resources:=cs:C1710.menu.new()
			$resources.append("Resources"; $folder.platformPath).icon($folderIcon)
			
			$folders:=$folder.folders()
			
			If ($folders.length>0)
				
				$resources.line()
				
				For each ($o; $folders)
					
					$resources.append($o.name; $o.platformPath).icon($folderIcon)
					
				End for each 
			End if 
			
			$database.append("Resources"; $resources).icon($folderIcon)
			
			//______________________________________________________
		Else 
			
			$database.append($folder.fullName; $folder.platformPath).icon($folderIcon)
			
			If ($folder.name="Components")\
				 | ($folder.name="Macros v2")\
				 | ($folder.name=Folder:C1567(fk web root folder:K87:15; *).name)
				
				$optionals.push($folder)
			End if 
			
			//______________________________________________________
	End case 
End for each 

$database.line()
$folder:=Folder:C1567(fk user preferences folder:K87:10).folder($databaseRoot.name).folder("4D Window Bounds v"+$version[[1]]+$version[[2]])
$database.append("4D Window Bounds v"+$version[[1]]+$version[[2]]; $folder.platformPath).icon($folderIcon)

$folder:=Folder:C1567(fk web root folder:K87:15; *)

If ($optionals.query("name = :1"; "Components").pop()=Null:C1517)\
 | ($optionals.query("name = :1"; "Macros v2").pop()=Null:C1517)\
 | ($optionals.query("name = :1"; $folder.name).pop()=Null:C1517)
	
	// Enable metacharacters
	$database.metacharacters:=True:C214
	
	$database.line()
	
	$t:="<I"+Get localized string:C991("CommonAdd")+" "
	
	If ($optionals.query("name = :1"; "Components").pop()=Null:C1517)
		
		$database.append($t+Get localized string:C991("Menuscomponents"); $databaseRoot.folder("Components").platformPath).icon("/RESOURCES/images/0.png")
		
	End if 
	
	If ($optionals.query("name = :1"; "Macros v2").pop()=Null:C1517)
		
		$database.append($t+Get localized string:C991("Menusmacros"); $databaseRoot.folder("Macros v2").platformPath).icon("/RESOURCES/images/0.png")
		
	End if 
	
	If ($optionals.query("name = :1"; $folder.name).pop()=Null:C1517)
		
		$database.append($t+Get localized string:C991("MenushtmlRootFolder"); $folder.platformPath).icon("/RESOURCES/images/0.png")
		
	End if 
	
	// Disable metacharacters
	$database.metacharacters:=False:C215
	
End if 

$application:=cs:C1710.menu.new()
$application.append("Menus4dApplication"; Application file:C491).icon("/RESOURCES/images/4D.png")\
.line()

// Current 4D folder
$folder:=Folder:C1567(fk user preferences folder:K87:10)

If ($folder.exists)
	
	$application.append("Menus4dFolder"; $folder.platformPath).icon($folderIcon)\
		.line()
	
End if 

// 4D Components folder
$folder:=Folder:C1567(Application file:C491; fk platform path:K87:2).folder(Choose:C955(Is macOS:C1572; "Contents/Components"; "Components"))
$application.append("Menuscomponents"; $folder.platformPath).icon($folderIcon).enable($folder.exists)

// 4D Macros folder
$folder:=Folder:C1567(fk user preferences folder:K87:10).folder("Macros v2")
$application.append("Menusmacros"; $folder.platformPath).icon($folderIcon).enable($folder.exists)

$application.line()

$folder:=Folder:C1567(fk user preferences folder:K87:10).folder("4D Window Bounds v"+$version[[1]]+$version[[2]])
$application.append("4D Window Bounds v"+$version[[1]]+$version[[2]]; $folder.platformPath).icon($folderIcon)

$menu:=cs:C1710.menu.new()
$menu.append("Menusdatabase"; $database).icon("/RESOURCES/images/database.png")\
.append("Menus4dApplication"; $application).icon("/RESOURCES/images/4D.png")\
.line()

/*-------------------------
User bookmaks
-------------------------*/
$file:=File:C1566(getDataFilePath; fk platform path:K87:2)

If ($file.exists)
	
	$menu.line()
	
	$t:=$file.getText()
	$root:=DOM Parse XML variable:C720($t)
	
	If (Bool:C1537(OK))
		
		ARRAY TEXT:C222($nodes; 0x0000)
		$nodes{0}:=DOM Find XML element:C864($root; "/bookmarks/bookmark"; $nodes)
		
		For ($i; 1; Size of array:C274($nodes); 1)
			
			$o:=New object:C1471
			
			For ($j; 1; DOM Count XML attributes:C727($nodes{$i}); 1)
				
				DOM GET XML ATTRIBUTE BY INDEX:C729($nodes{$i}; $j; $key; $value)
				
				Case of 
						
						//………………………………………………………………………………………………………………………………
					: ($key="name")
						
						$o.label:=Choose:C955($value[[1]]#"-"; Char:C90(1); "")+$value
						
						//………………………………………………………………………………………………………………………………
					: ($key="url")\
						 & (Length:C16($value)>0)
						
						$o.url:=$value
						
						//………………………………………………………………………………………………………………………………
					: ($key="type")\
						 & ($value#"0")
						
						$o.icon:="/RESOURCES/images/"+$value+".png"
						
						//………………………………………………………………………………………………………………………………
					Else 
						
						$o[$key]:=$value
						
						//………………………………………………………………………………………………………………………………
				End case 
			End for 
			
			$t:=String:C10($o.label)
			
			If (Position:C15("-"; $t)=1)
				
				$menu.line()
				
			Else 
				
				If (Length:C16($t)#0)
					
					$menu.append($t; String:C10($o.url)).icon(String:C10($o.icon))
					
				End if 
			End if 
		End for 
		
		DOM CLOSE XML:C722($root)
		
		$menu.line().append(Get localized string:C991("EditWindowTitle")+"..."; "Edit")
		
	End if 
End if 

$menu.popup()

Case of 
		
		//______________________________________________________
	: (Not:C34($menu.selected))
		
		// <NOTHING MORE TO DO>
		
		//______________________________________________________
	: ($menu.choice="Edit")
		
		EDIT
		
		//______________________________________________________
	: ($menu.choice="file://@")
		
		If (Macintosh command down:C546)
			
			SHOW ON DISK:C922(Replace string:C233($menu.choice; "file://"; ""); *)
			
		Else 
			
			If (Is Windows:C1573)
				
				OPEN URL:C673(Replace string:C233($menu.choice; "file://"; ""))
				
			Else 
				
				LAUNCH EXTERNAL PROCESS:C811("open "+POSIX_Path(Replace string:C233($menu.choice; "file://"; "")))
				
			End if 
		End if 
		
		//______________________________________________________
	: (Test path name:C476($menu.choice)=Is a folder:K24:2)
		
		If ($menu.choice="@.app")  // Application package on mac
			
			If ($menu.choice=Application file:C491)
				
				SHOW ON DISK:C922($menu.choice)
				
			Else 
				
				LAUNCH EXTERNAL PROCESS:C811("open "+POSIX_Path($menu.choice))
				
			End if 
			
		Else 
			
			If (Position:C15(Application file:C491; $menu.choice)=1)
				
				SHOW ON DISK:C922($menu.choice)
				
			Else 
				
				SHOW ON DISK:C922($menu.choice; *)
				
			End if 
		End if 
		
		//______________________________________________________
	: (Test path name:C476($menu.choice)#Is a folder:K24:2)\
		 & ($menu.choice#"@.app")\
		 & (Position:C15(Get 4D folder:C485(Database folder:K5:14; *); $menu.choice)=1)
		
		// Create a database folder
		CREATE FOLDER:C475($menu.choice; *)
		SHOW ON DISK:C922($menu.choice; *)
		
		//______________________________________________________
	Else 
		
		If (Macintosh command down:C546)
			
			SHOW ON DISK:C922(Replace string:C233($menu.choice; "file://"; ""); *)
			
		Else 
			
			OPEN URL:C673($menu.choice; *)
			
		End if 
		
		//______________________________________________________
End case 