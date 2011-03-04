<?php
require_once 'dbConnect.php';

$error = '';
$content = '';
$numScores = 0;

// get sent data
if(!isset($_POST['project_name']) || !isset($_POST['user_name']) || !isset($_POST['score'])){
	$error = 'missing parameter';
	writeReturn();
}else{
	$project_name = $_POST['project_name'];
	$user_name = $_POST['user_name'];
	$score = $_POST['score'];
}

// send data to the database
dbConnect();
$query = "INSERT INTO `score` (`id`, `project_name`, `user_name`, `score`)
		VALUES (NULL, '". $project_name ."', '". $user_name ."', '". $score ."');";
$queryResult = mysql_query($query,$link) or die ('Erreur : '.mysql_error() );

//get the number of scores
$query2 = "SELECT COUNT(*) as numScores FROM score WHERE project_name='" . $project_name . "'";
//echo $query2;
$queryResult2 = mysql_query($query2,$link) or die ('Erreur : '.mysql_error() );

while ($row = mysql_fetch_array($queryResult2)) {
	$numScores =  $row["numScores"];
}

writeReturn();

// return string
function writeReturn(){
	global $error, $numScores;
	$return = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<root>
<numScores>'. $numScores .'</numScores>
<error>' . $error . '</error>
</root>';
	
	header('Content-type: application/xml; charset="utf-8"',true);
	header("Pragma: no-cache");
	header("Expires: 0"); 
	echo $return;
	exit();
}