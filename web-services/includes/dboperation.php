<?php
class DbOperation{
    private $conn;
 
    function __construct() {
        require_once dirname(__FILE__) . '/config.php';
        require_once dirname(__FILE__) . '/dbconnect.php';
        
        $db = new DbConnect();
        $this->conn = $db->connect();
    }
 
    public function get_messages($location_id) {
        $query = "SELECT * FROM message WHERE location_id = '" . $location_id . "'";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $stmt->bind_result($id, $location_id, $user_id, $message_field, $time_stamp);

        while($stmt->fetch()) {
            $messages[$id]['location_id'] = $location_id;
            $messages[$id]['user_id'] = $user_id;
            $messages[$id]['message_field'] = $message_field;
            $messages[$id]['time_stamp'] = $time_stamp;
        }
        $stmt->close();
        return $messages;
    }

}

