<?php
$response = array();
 
if($_SERVER['REQUEST_METHOD']=='POST'){

    $location_id = $_POST['location_id'];
    $user_id = $_POST['user_id'];
 
    require_once '../includes/dboperation.php';

    $db = new DbOperation();
    $result = $db->insert_bump($location_id, $user_id);
    if($result) {
        $response['error'] = false;
        $response['message'] = 'Bump successfully added';
        
    } else { 
        $response['error'] = true;
        $response['message'] = 'Bump was unsuccessful';       
    }
} else {
    $response['error'] = true;
    $response['message'] = 'You are not authorized';
}
echo json_encode($response);

