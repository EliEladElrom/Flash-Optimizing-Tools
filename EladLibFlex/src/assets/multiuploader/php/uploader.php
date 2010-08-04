<?

header("Expires: Mon, 25 Jan 1970 05:00:00 GMT");   
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT"); 
header("Cache-Control: no-store, no-cache, must-revalidate");  
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

// in MAMP the default folder is located on MAC os here:
// /Applications/MAMP/htdocs/temp 
$TEMP_FOLDER = 'temp/';

print_r($_FILES);

// Different file fields
if (isset($_FILES['Filedata'])) 
{
	$fileName = $_FILES['Filedata']['name'];
	$filePath = $TEMP_FOLDER.basename($fileName);
	
	$message = "upload strarted... filePath: " . $filePath;
	
	if ( move_uploaded_file($_FILES['Filedata']['tmp_name'], $filePath) )
	{
		$message = $message . " -> success";
	}
	
	print_r( get_last_error() );
}
else
{
	$message = "false: " . $fileName = $_POST['Filename'];
}

echo $message;
exit(0);

?>