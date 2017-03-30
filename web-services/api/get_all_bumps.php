<?php
$response = array();
 
if($_SERVER['REQUEST_METHOD']=='POST'){
 
    require_once '../includes/dboperation.php';

    $db = new DbOperation();
    $bumps = $db->get_all_bumps();
    if(!empty($bumps)) {
        $response['error'] = false;
        $response = $response + $bumps;
        
    } else { 
        $response['error'] = true;
        $response['message'] = 'No bumps';       
    }
} else {
    $response['error'] = true;
    $response['message'] = 'You are not authorized';
}
echo json_encode($response);

