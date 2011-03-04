<?php
require_once 'dbConnect.php';

$error = '';
$content = '';

// get sent data
if(!isset($_POST['project_name']) || !isset($_POST['max_row'])){
	$error = 'missing parameter';
	writeReturn();
}else{
	$project_name = $_POST['project_name'];
	$max_row = $_POST['max_row'];
}

// send data to the database
dbConnect();
$query = "SELECT `user_name`, `score` 
			FROM `score` 
			WHERE `project_name`='". $project_name ."' 
			ORDER BY `score` DESC
			LIMIT ". $max_row .";"; 
$queryResult = mysql_query($query,$link) or die ('Erreur : '.mysql_error() );
while ($row = mysql_fetch_array($queryResult, MYSQL_ASSOC)) {
	$content .=  '<item><user_name>' . $row["user_name"] . '</user_name><score>' . $row["score"] . '</score></item>
';  
}
writeReturn();

// return string
function writeReturn(){
	global $error, $content;
	$return = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<root>
<content>' . $content . '</content>
<error>' . $error . '</error>
</root>';
	
	header('Content-type: application/xml; charset="utf-8"',true);
	header("Pragma: no-cache");
	header("Expires: 0"); 
	echo $return;
	exit();
}