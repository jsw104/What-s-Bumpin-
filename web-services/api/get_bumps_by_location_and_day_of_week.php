<?php
$response = array();
 
if($_SERVER['REQUEST_METHOD']=='POST'){
    
    $location_id = $_POST['location_id'];
 
    require_once '../includes/dboperation.php';

    $db = new DbOperation();
    $bumps = $db->get_bumps_by_location_and_day_of_week($location_id);
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

