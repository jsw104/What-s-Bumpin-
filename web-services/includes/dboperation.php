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
    
    public function get_messages_by_friends($friends_facebook_ids) {
        if(empty($friends_facebook_ids)) return false;
        $friends_facebook_ids_array = explode('|', $friends_facebook_ids);
        $friends_facebook_ids_string = $friends_facebook_ids_array[0];
        for($i = 1; $i < count($friends_facebook_ids_array); $i++) {
            $friends_facebook_ids_string .= ' OR facebook_id = ' . $friends_facebook_ids_array[$i];
        }
        $query = "SELECT message_id, location_id, facebook_name, message_field, time_stamp
                  FROM message NATURAL JOIN user
                  WHERE facebook_id = " . $friends_facebook_ids_string . "
                  ORDER BY time_stamp DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $stmt->bind_result($message_id, $location_id, $facebook_name, $message_field, $time_stamp);
        
        $messages = [];
        $k = 0;
        while($stmt->fetch()) {
            $messages[$k]['location_id'] = $location_id;
            $messages[$k]['facebook_name'] = $facebook_name;
            $messages[$k]['message_field'] = $message_field;
            $messages[$k]['time_stamp'] = $time_stamp;
            $k++;
        }
        $messages['message_count'] = $k;
        $stmt->close();
        return $messages;
    }
 
    public function get_messages_by_location($location_id) {
        $query = "SELECT message_id, facebook_name, message_field, time_stamp
                  FROM message NATURAL JOIN user
                  WHERE location_id = ? 
                  ORDER BY time_stamp DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('s', $location_id);
        $stmt->execute();
        $stmt->bind_result($message_id, $facebook_name, $message_field, $time_stamp);

        $messages = [];
        $k = 0;
        while($stmt->fetch()) {
            $messages[$k]['facebook_name'] = $facebook_name;
            $messages[$k]['message_field'] = $message_field;
            $messages[$k]['time_stamp'] = $time_stamp;
            $k++;
        }
        $messages['message_count'] = $k;
        $stmt->close();
        return $messages;
    }
    
    public function insert_message($location_id, $facebook_id, $message_field) {
        $query = "INSERT INTO message(location_id, facebook_id, message_field)
                  VALUES(?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('sis', $location_id, $facebook_id, $message_field);
        $result = $stmt->execute();
        $stmt->close();
        if($result) {
            return true;
        } else {
            return false;
        }
    } 

    public function insert_bump($location_id, $facebook_id) {
        $query = "INSERT INTO bump(location_id, facebook_id)
                  VALUES(?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('si', $location_id, $facebook_id);
        $result = $stmt->execute();
        $stmt->close();
        if($result) {
            return true;
        } else {
            return false;
        }
    } 
    
    public function get_bump_count_by_locations($location_ids) {
        if(empty($location_ids)) return false;
        $location_ids_array = explode('|', $location_ids);
        $location_ids_string = "'" . $location_ids_array[0] . "'";
        for($i = 1; $i < count($location_ids_array); $i++) {
            $location_ids_string .= " OR location_id = '" . $location_ids_array[$i] ."'";
        }
        $query = "SELECT location_id, COUNT(*) as bump_count
                  FROM bump
                  WHERE time_stamp >= NOW() - INTERVAL 1 DAY AND (location_id = " . $location_ids_string . " )
                  GROUP BY location_id";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $stmt->bind_result($location_id, $bump_count);
        $bumps = [];
        while($stmt->fetch()) {
            $bumps[$location_id] = $bump_count;
        }
        $stmt->close();
        return $bumps;
    }
    
    public function get_bumps_by_location_and_day_of_week($location_id) {
        $query = "SELECT DAYOFWEEK(time_stamp) as day_of_week, COUNT(*) as count
                  FROM bump
                  WHERE time_stamp >= NOW() - INTERVAL 1 WEEK AND location_id = ?
                  GROUP BY DAYOFWEEK(time_stamp)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('s', $location_id);
        $stmt->execute();
        $stmt->bind_result($day_of_week, $count);
        
        $bumps = array_fill(1, 7, 0);

        while($stmt->fetch()) {
            $bumps[$day_of_week] = $count;
        }
        $stmt->close();
        return $bumps;
    }
    
    public function insert_user($facebook_id, $facebook_name) {
        $query = "INSERT INTO user(facebook_id, facebook_name)
                  VALUES(?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('is', $facebook_id, $facebook_name);
        $result = $stmt->execute();
        $stmt->close();
        if($result) {
            return true;
        } else {
            return false;
        }
    }
}

