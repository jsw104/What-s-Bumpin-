<?php
$response = array();
 
if($_SERVER['REQUEST_METHOD']=='POST'){

    $place_id = $_POST['place_id'];
 
    require_once '../includes/dboperation.php';

    $db = new DbOperation();
    $messages = $db->get_messages($place_id);
    if(!empty($messages)) {
        $response = $messages;
    } else { 
        $response = false;
    }
} else {
    $response['error']=true;
    $response['message']=$_SERVER['REQUEST_METHOD'];
}
echo json_encode($response);

