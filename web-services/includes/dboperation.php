<?php
class DbOperation{
    private $conn;
 
    function __construct() {
        require_once dirname(__FILE__) . '/config.php';
        require_once dirname(__FILE__) . '/dbconnect.php';
        
        $db = new DbConnect();
        $this->conn = $db->connect();
    }
 
    public function get_messages($places_id) {
        $stmt = $this->conn->prepare("SELECT * FROM messages WHERE places_id = ?");
        $stmt->bind_param(1, $places_id, PDO::PARAM_INT);
        $result = $stmt->execute();
        $stmt->close();
        if ($result) {
            return true;
        } else {
            return false;
        }
    }
}

