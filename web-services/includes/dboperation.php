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

        $messages = [];
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
        $query = "INSERT INTO bump(location_id, user_id) VALUES(?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('ii', $location_id, $user_id);
        $result = $stmt->execute();
        $stmt->close();
        if($result) {
            return true;
        } else {
            return false;
        }
    } 
    
    public function get_all_bumps() {
        $query = "SELECT * FROM bump";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $stmt->bind_result($id, $location_id, $user_id, $time_stamp);

        $bumps = [];
        while($stmt->fetch()) {
            $bumps[$id]['location_id'] = $location_id;
            $bumps[$id]['user_id'] = $user_id;
            $bumps[$id]['time_stamp'] = $time_stamp;
        }
        $stmt->close();
        return $bumps;
    }
    
    public function get_bumps_by_day_of_week($location_id) {
        $query = "SELECT DAYOFWEEK(time_stamp) as dayofweek, COUNT(*) as count
                    FROM bump
                    WHERE time_stamp >= NOW() - INTERVAL 1 WEEK AND location_id = ?
                    GROUP BY DAYOFWEEK(time_stamp)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('i', $location_id);
        $stmt->execute();
        $stmt->bind_result($day_of_week, $count);
        
        $bumps = array_fill(1, 7, 0);

        while($stmt->fetch()) {
            $bumps[$day_of_week] = $count;
        }
        $stmt->close();
        return $bumps;
    }
}

