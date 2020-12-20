<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('localhost', 'root', '', "treeshop");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
			
		$idShop = $_GET['idShop'];	
		$NameTree = $_GET['NameTree'];	
		$PathImage = $_GET['PathImage'];	
		$Price = $_GET['Price'];	
		$Detail = $_GET['Detail'];		
		
		
							
		$sql = "INSERT INTO `treetable`(`id`, `idShop`, `NameTree`, `PathImage`, `Price`, `Detail`) VALUES (Null,'$idShop','$NameTree','$PathImage','$Price','$Detail')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome RestarDEV";
   
}
	mysqli_close($link);
?>