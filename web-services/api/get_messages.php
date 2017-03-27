<?php
$response = array();
 
if($_SERVER['REQUEST_METHOD']=='POST'){

    $location_id = $_POST['location_id'];
 
    require_once '../includes/dboperation.php';

    $db = new DbOperation();
    $messages = $db->get_messages($location_id);
    if(!empty($messages)) {
        $response['error'] = false;
        $response = $response + $messages;
        
    } else { 
        $response['error'] = true;
        $response['message'] = 'No messages for this location';       
    }
} else {
    $response['error'] = true;
    $response['message'] = 'You are not authorized';
}
echo json_encode($response);

