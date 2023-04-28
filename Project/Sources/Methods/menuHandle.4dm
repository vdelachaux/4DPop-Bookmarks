//%attributes = {}
var $action : Text

$action:=Get selected menu item parameter:C1005

Case of 
		//______________________________________________________
	: ($action="close")
		
		CANCEL:C270
		
		//______________________________________________________
	Else 
		
		// A "Case of" statement should never omit "Else"
		
		//______________________________________________________
End case 