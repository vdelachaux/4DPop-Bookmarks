//%attributes = {"invisible":true}

If (False:C215)
	
	//lstb_SET_SCROLLBAR
	C_TEXT:C284(lstb_SET_SCROLLBAR; $1)
	
	//ParseFile
	C_TEXT:C284(ParseFile; $1)
	C_POINTER:C301(ParseFile; $2)
	C_POINTER:C301(ParseFile; $3)
	C_POINTER:C301(ParseFile; $4)
	
	//GetPath
	C_TEXT:C284(getDataFilePath; $0)
	
	//ondrop
	C_BOOLEAN:C305(doDrop; $0)
	C_POINTER:C301(doDrop; $1)
	C_POINTER:C301(doDrop; $2)
	C_POINTER:C301(doDrop; $3)
	
	//POSIX_Path
	C_TEXT:C284(POSIX_Path; $0)
	C_TEXT:C284(POSIX_Path; $1)
	C_BOOLEAN:C305(POSIX_Path; $2)
	
End if 

