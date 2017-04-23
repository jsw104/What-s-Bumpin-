<?php
$response = array();
 
if($_SERVER['REQUEST_METHOD']=='POST'){

    $friends_facebook_ids = $_POST['friends_facebook_ids'];
 
    require_once '../includes/dboperation.php';

    $db = new DbOperation();
    $messages = $db->get_messages_by_friends($friends_facebook_ids);
    if(!empty($messages)) {
        $response['error'] = false;
        $response = $response + $messages;
        
    } else { 
        $response['error'] = true;
        $response['message'] = 'No messages from friends';       
    }
} else {
    $response['error'] = true;
    $response['message'] = 'You are not authorized';
}
echo json_encode($response);