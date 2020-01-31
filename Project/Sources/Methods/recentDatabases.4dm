//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : recentDatabases
  // Database: 4DPop Bookmarks
  // ID[11B366FFF3FA422799F5EAE420CFED6C]
  // Created #14-5-2013 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)

C_LONGINT:C283($Lon_j;$Lon_parameters)
C_TEXT:C284($Mnu_recent)

ARRAY LONGINT:C221($tLon_type;0)
ARRAY TEXT:C222($tTxt_4dlink;0)
ARRAY TEXT:C222($tTxt_names;0)
ARRAY TEXT:C222($tTxt_path;0)

If (False:C215)
	C_TEXT:C284(recentDatabases ;$0)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
env_4D_RECENT_DATABASES (->$tLon_type;->$tTxt_names;->$tTxt_path;->$tTxt_4dlink)

$Mnu_recent:=Create menu:C408

For ($Lon_j;1;Size of array:C274($tLon_type);1)
	
	Case of 
			
			  //______________________________________________________
		: ($Lon_j=1)  //Local
			
			mnu_APPEND_ITEM ($Mnu_recent;Get localized string:C991("MenusLocalDatabases"))
			mnu_SET_ACTIVATION ($Mnu_recent;False:C215)
			
			  //______________________________________________________
		: ($tLon_type{$Lon_j}#$tLon_type{0})  //Remote
			
			$tLon_type{0}:=$tLon_type{$Lon_j}
			
			mnu_APPEND_LINE ($Mnu_recent)
			
			mnu_APPEND_ITEM ($Mnu_recent;Get localized string:C991("MenusRemoteDatabases"))
			mnu_SET_ACTIVATION ($Mnu_recent;False:C215)
			
			  //______________________________________________________
	End case 
	
	mnu_APPEND_ITEM ($Mnu_recent;Char:C90(1)+$tTxt_names{$Lon_j};$tTxt_4dlink{$Lon_j})
	
End for 

$0:=$Mnu_recent

  // ----------------------------------------------------
  // End