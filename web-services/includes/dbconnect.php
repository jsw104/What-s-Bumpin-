<?php
class DbConnect {
    private $conn;
 
    function __construct() {}
 
    function connect() {
        $conn = new mysqli(db_host, db_username, db_password, db_name);
         
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }         
        
        return $conn;
    }
}

