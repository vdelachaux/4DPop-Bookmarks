//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : POSIX_Path
// Created 06/10/06 by vdl
// ----------------------------------------------------
// Description
// A POSIX path is the location of an object specified with a POSIX (slash)-style pathname.
// This is the method commonly used in UNIX to refer to a location within a series of directories, as opposed to the (colon) pathnames often used in AppleScript and on the Classic Mac OS.
// The POSIX path is used to get the POSIX path from of an object.
// Example: POSIX path of file "HD:Users:me:Documents:Welcome.txt" is "/Users/me/Documents/Welcome.txt"
// $1 = path to convert
// $0 = converted (posix) path
// The first / is omited if $2 is true
// ----------------------------------------------------
#DECLARE($pathname : Text; $skipFirst : Boolean) : Text

var $posix; $volume : Text
var $i; $length : Integer

Case of 
		
		//------------------------------------------
	: (Length:C16($pathname)=0)
		
		// <NOTHING MORE TO DO>
		
		//------------------------------------------
	: (Is Windows:C1573)
		
		$posix:=Replace string:C233($pathname; "\\"; "/")
		
		//------------------------------------------
	Else 
		
		// ":" is remplaced by "/"
		$pathname:=Replace string:C233($pathname; ":"; "/")
		
		// Space character must be escaped
		$pathname:=Replace string:C233($pathname; " "; "\\ ")
		
		// Get the boot volume
		$volume:=System folder:C487  // "Macintosh_HD:System:"
		$length:=Length:C16($volume)
		
		For ($i; 1; $length; 1)
			
			If ($volume[[$i]]=":")
				
				$volume:=Substring:C12($volume; 1; $i-1)
				
				break
				
			End if 
		End for 
		
		If ($pathname=($volume+"/@"))
			
			// The path is on the boot disk
			// Macintosh_HD/Library/..." will be converted to "/Library/..."
			$posix:=Substring:C12($pathname; Length:C16($volume)+1)
			
		Else 
			
			// The path is not on the boot disk
			// Disk/work/..." will be converted to "/Volumes/Disk/work/..."
			$posix:="/Volumes/"+$pathname
			
		End if 
		
		//------------------------------------------
End case 

Case of 
		
		//-------------------------------
	: (Not:C34($skipFirst))\
		 || (Length:C16($posix)=0)
		
		// <NOTHING MORE TO DO>
		//-------------------------------
	: (Character code:C91($posix[[1]])=47)
		
		$posix:=Substring:C12($posix; 2)
		
		//-------------------------------
End case 

return $posix