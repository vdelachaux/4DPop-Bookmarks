//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : env_4D_RECENT_DATABASES
  // Database: development
  // ID[6D8E80B1DE0B497AB1E4B8D63B8AE939]
  // Created 6-2-2013 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // Fills 3 arrays (pointer parameters)
  // with the type the name and path of the recently used databases
  //
  // ----------------------------------------------------
  // Declarations
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)

C_BOOLEAN:C305($Boo_dummy)
C_DATE:C307($Dat_creation;$Dat_modification)
C_LONGINT:C283($Lon_count;$Lon_i;$Lon_j;$Lon_parameters;$Lon_sortKey;$Lon_x)
C_TIME:C306($Gmt_creation;$Gmt_modification)
C_TEXT:C284($Dom_node;$Dom_root;$kTxt_indent;$Txt_buffer;$Txt_databaseName;$Txt_fileName;$Txt_Path;$Txt_serverPath)
C_TEXT:C284($Txt_structure)

ARRAY LONGINT:C221($tLon_sort;0)
ARRAY LONGINT:C221($tLon_type;0)
ARRAY TEXT:C222($tTxt_4dlink;0)
ARRAY TEXT:C222($tTxt_files;0)
ARRAY TEXT:C222($tTxt_names;0)
ARRAY TEXT:C222($tTxt_path;0)

If (False:C215)
	C_POINTER:C301(env_4D_RECENT_DATABASES ;$1)
	C_POINTER:C301(env_4D_RECENT_DATABASES ;$2)
	C_POINTER:C301(env_4D_RECENT_DATABASES ;$3)
	C_POINTER:C301(env_4D_RECENT_DATABASES ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	$kTxt_indent:=" "*4
	$Txt_Path:=Get 4D folder:C485(Active 4D Folder:K5:10)+"Favorites v"+Substring:C12(Application version:C493;1;2)
	
	DOCUMENT LIST:C474($Txt_Path;$tTxt_files;Absolute path:K24:14+Recursive parsing:K24:13+Ignore invisible:K24:16)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
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
				
				APPEND TO ARRAY:C911($tLon_type;0)
				APPEND TO ARRAY:C911($tTxt_path;$Txt_Path)
				APPEND TO ARRAY:C911($tLon_sort;$Lon_sortKey)
				
				  //Get the package name if any {
				$Txt_buffer:=doc_getFromPath ("parent";Convert path POSIX to system:C1107(Replace string:C233($Txt_Path;"file://";"")))
				
				If ($Txt_buffer=("@.4dbase"+Folder separator:K24:12))
					
					$Txt_databaseName:=doc_getFromPath ("shortName";$Txt_buffer)
					
				Else 
					
					$Txt_databaseName:=doc_getFromPath ("fullName";$tTxt_values{$Lon_x};"/")
					
				End if   //}
				
				APPEND TO ARRAY:C911($tTxt_names;$kTxt_indent+$Txt_databaseName)
				
			Else   // Server
				
				APPEND TO ARRAY:C911($tLon_type;1)
				
				$Lon_x:=Find in array:C230($tTxt_keys;"server_database_name")
				
				If ($Lon_x#-1)
					
					$Txt_structure:=$tTxt_values{$Lon_x}
					
				End if 
				
				$Lon_x:=Find in array:C230($tTxt_keys;"server_path")
				
				If ($Lon_x#-1)
					
					$Txt_serverPath:=$tTxt_values{$Lon_x}
					
				End if 
				
				If (($Txt_structure#"")\
					 & ($Txt_serverPath#""))
					
					APPEND TO ARRAY:C911($tTxt_names;$kTxt_indent+$Txt_structure+" - "+$Txt_serverPath)
					APPEND TO ARRAY:C911($tTxt_path;$Txt_serverPath)
					APPEND TO ARRAY:C911($tLon_sort;$Lon_sortKey)
					
				End if 
			End if 
			
			DOM CLOSE XML:C722($Dom_root)
			
		End if 
	End if 
End for 

MULTI SORT ARRAY:C718($tLon_type;>;$tLon_sort;<;$tTxt_names;$tTxt_path;$tTxt_4dlink)

If ($Lon_parameters>=3)
	
	COPY ARRAY:C226($tLon_type;$1->)
	COPY ARRAY:C226($tTxt_names;$2->)
	COPY ARRAY:C226($tTxt_path;$3->)
	
	If ($Lon_parameters>=4)
		
		COPY ARRAY:C226($tTxt_4dlink;$4->)
		
	End if 
End if 

  // ----------------------------------------------------
  // End