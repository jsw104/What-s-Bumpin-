<?php
$response = array();
 
if($_SERVER['REQUEST_METHOD']=='POST'){

    $places_id = $_POST['places_id'];
 
    require_once '../includes/DbOperation.php';
 
    $db = new DbOperation();
    $messages = $db->get_messages($places_id);
    if(!$messages) {
        $response['error']=false;
        $response['message']=var_dump($messages);
    } else { 
        $response['error']=true;
        $response['message']='Messages from ' . $places_id . ' were not retrieved';
    }
} else {
    $response['error']=true;
    $response['message']='You are not authorized';
}
echo json_encode($response);

