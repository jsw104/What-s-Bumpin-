<?php
$response = array();
 
if($_SERVER['REQUEST_METHOD']=='POST'){

    if(isset($_POST['facebook_id'])) {
        $facebook_id = $_POST['facebook_id'];
    } else {
        $facebook_id = null;
    }
    
    if(isset($_POST['facebook_name'])) {
        $facebook_name = $_POST['facebook_name'];
    } else {
        $facebook_name = null;
    }
    
    require_once '../includes/dboperation.php';

    $db = new DbOperation();
    $result = $db->insert_user($facebook_id, $facebook_name);
    if($result) {
        $response['error'] = false;
        $response['message'] = 'Adding user was successful';    
    } else { 
        $response['error'] = true;
        $response['message'] = 'Adding user was unsuccessful';       
    }
} else {
    $response['error'] = true;
    $response['message'] = 'You are not authorized';
}
echo json_encode($response);

