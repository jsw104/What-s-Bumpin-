<?php
class DbOperation{
    private $conn;
 
    function __construct() {
        require_once dirname(__FILE__) . '/config.php';
        require_once dirname(__FILE__) . '/dbconnect.php';
        date_default_timezone_set('America/New_York');
        $db = new DbConnect();
        $this->conn = $db->connect();
    }
 
    public function get_messages($location_id_p) {
        $query = "SELECT * FROM message WHERE location_id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('i', $location_id_p);
        $stmt->execute();
        $stmt->bind_result($id, $location_id_r, $user_id, $message_field, $time_stamp);

        while($stmt->fetch()) {
            $messages[$id]['location_id'] = $location_id_r;
            $messages[$id]['user_id'] = $user_id;
            $messages[$id]['message_field'] = $message_field;
            $messages[$id]['time_stamp'] = $time_stamp;
        }
        $stmt->close();
        return $messages;
    }

    public function insert_bump($location_id, $user_id) {
        $query = "INSERT INTO bump(location_id, user_id, time_stamp) VALUES(?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        $time_stamp = date("Y-m-d H:i:s");
        $stmt->bind_param('iis', $location_id, $user_id, $time_stamp);
        $result = $stmt->execute();
        $stmt->close();
        if($result) {
            return true;
        } else {
            return false;
        }
    } 
}

