<?php
$response = array();
 
if($_SERVER['REQUEST_METHOD']=='POST'){

    $location_id = $_POST['location_id'];
    $facebook_id = $_POST['facebook_id'];
    $message_field = $_POST['message_field'];
 
    require_once '../includes/dboperation.php';

    $db = new DbOperation();
    $result = $db->insert_message($location_id, $facebook_id, $message_field);
    if($result) {
        $response['error'] = false;
        $response['message'] = 'Message successfully added';
        
    } else { 
        $response['error'] = true;
        $response['message'] = 'Message was unsuccessful';       
    }
} else {
    $response['error'] = true;
    $response['message'] = 'You are not authorized';
}
echo json_encode($response);