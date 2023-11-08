<?php
$validUsername = "admin";
$validPassword = "admin";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $enteredUsername = $_POST["username"];
    $enteredPassword = $_POST["password"];

    
    if ($enteredUsername === $validUsername && $enteredPassword === $validPassword) {
        echo "Are you serious ?";
    } else {
        echo "Invalid username or password.";
    }
}
?>
