<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT, GET, POST");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Content-Type: application/json');

$queryArr = explode(" ", $_GET["query"]); // Split GET query by space
$xmlDirPath = dirname(__FILE__) . "\\xml\\"; // Path for xml folder
$dirIter = new DirectoryIterator($xmlDirPath); // Initialize directory iterator 
$books = []; // Stores XML book data

function contains($str, array $arr) // Returns the number of $arr strings contained in $str
{
  $i = 0;
  foreach ($arr as $a) {
    if (stripos($str, $a) !== false) $i++;
  }
  return $i;
}

function transformArr(array $arr)
{
  $n = sizeof($arr);
  for ($i = 1; $i < $n; $i++) { // Sort the array by number of matched words
    for ($j = $n - 1; $j >= $i; $j--) {
      if ($arr[$j - 1]["matches"] > $arr[$j]["matches"]) {
        $tmp = $arr[$j - 1];
        $arr[$j - 1] = $arr[$j];
        $arr[$j] = $tmp;
      }
    }
  }
  return $arr;
}

foreach ($dirIter as $fileinfo) { // Iterate over the XML files in the xml forlder
  if (!$fileinfo->isDot() && $fileinfo->getExtension() === "xml") {
    $file = $xmlDirPath . $fileinfo->getFilename(); // File name
    $xmlDoc = new DOMDocument(); // Initialize a DOMDocument object
    $xmlDoc->load($file); // Load the current XML file
    // Get the nodes values
    $title = $xmlDoc->getElementsByTagName('titre')->item(0)->nodeValue;
    $lname = $xmlDoc->getElementsByTagName('nom')->item(0)->nodeValue;
    $fname = $xmlDoc->getElementsByTagName('prenom')->item(0)->nodeValue;
    foreach ($xmlDoc->getElementsByTagName('image') as $imageNode) {
      $image = $imageNode->getAttribute("xlink:href");
    }
    $desc = $xmlDoc->getElementsByTagName('Paragraphe')->item(0)->nodeValue;
    $path = "xml/" . $fileinfo->getFilename();
    $j = contains($title, $queryArr); // Match the words in the query with the content of "title" element
    if ($j > 0) { // If some words match continue
      $books[] = [
        "title" => $title,
        "author" => $fname . $lname,
        "image" => $image,
        "desc" => $desc,
        "path" => $path,
        "matches" => $j
      ]; // Store the file and number of matches seprated by a pipe
    }
  }
}

print(json_encode($books));
