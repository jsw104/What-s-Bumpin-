<?php
$response = array();
 
if($_SERVER['REQUEST_METHOD']=='POST'){

    $location_ids = $_POST['location_ids'];
 
    require_once '../includes/dboperation.php';

    $db = new DbOperation();
    $bumps = $db->get_bump_count_by_locations($location_ids);
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

