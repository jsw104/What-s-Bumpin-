<?php

use PHPUnit\Framework\TestCase;

include_once(dirname(__FILE__). "/../includes/dboperation.php");


final class DbOperationTest extends TestCase {
    public function testCreateNewConnection() {
        $db = new DbOperation();
        $this->assertInstanceOf(DbOperation::class, $db);
    }
    
    public function testInsertABumpWithValidUser() {
        $db = new DbOperation();
        $this->assertTrue($db->insert_bump('test_location_1001', 1001));
    }
    
    public function testInsertingABumpBacktoBack() {
        $db = new DbOperation();
        $this->assertTrue($db->insert_bump('test_location_1005', 1002));
        $this->assertFalse($db->insert_bump('test_location_1005', 1002));
    }
    
    public function testInsertABumpWithInvalidUser() {
        $db = new DbOperation();
        $this->assertFalse($db->insert_bump('test_location_1001', 1999));
    }
    
    public function testGetBumpCountFromOneLocation() {
        $db = new DbOperation();
        $testArray = array(
            "test_location_1002" => 2
        );
        $this->assertEquals($testArray, $db->get_bump_count_by_locations('test_location_1002|'));
    }
    
    public function testGetBumpCountFromTwoLocations() {
        $db = new DbOperation();
        $testArray = array(
            "test_location_1002" => 2,
            "test_location_1003" => 1
        );
        $this->assertEquals($testArray, $db->get_bump_count_by_locations('test_location_1002|test_location_1003|'));
    }
    
    public function testGetBumpCountFromLocationWithNoBumps() {
        $db = new DbOperation();
        $this->assertEmpty($db->get_bump_count_by_locations('test_location_1004|'));
    }
    
    public function testGetMessagesFromLocation() {
        $db = new DbOperation();
        $testArray = $db->get_messages_by_location('test_location_1001');
        $this->assertEquals("Test message", $testArray[0]['message_field']);
    }
    
    public function testInsertMessage() {
        $db = new DbOperation();
        $this->assertTrue($db->insert_message('test_location_1002', 1002, 'Test message'));
    }
    
    public function testInsertTwoMessagesBackToBack() {
        $db = new DbOperation();
        $this->assertTrue($db->insert_message('test_location_1004', 1004, 'Test message'));
        $this->assertFalse($db->insert_message('test_location_1004', 1004, 'Test message'));
    }
    
    public function testGetMessagesBySomeFriends() {
        $db = new DbOperation();
        $testArray = $db->get_messages_by_friends('1001|1003|');
        $this->assertEquals(4, $testArray['message_count']);
    }
    
    public function testGetNoMessagesByFriends() {
        $db = new DbOperation();
        $testArray = $db->get_messages_by_friends('1005|');
        $this->assertEquals(0, $testArray['message_count']);
    }
    
    public function testGetBumpsByDayOfWeekAtPlaceWithBumpOnSunday() {
        $db = new DbOperation();
        $bumps_by_day_of_week = $db->get_bumps_by_location_and_day_of_week('test_location_1003');
        $this->assertEquals(1, $bumps_by_day_of_week[1]);
        $this->assertEquals(0, $bumps_by_day_of_week[2]);
        $this->assertEquals(0, $bumps_by_day_of_week[3]);
        $this->assertEquals(0, $bumps_by_day_of_week[4]);
        $this->assertEquals(0, $bumps_by_day_of_week[5]);
        $this->assertEquals(0, $bumps_by_day_of_week[6]);
        $this->assertEquals(0, $bumps_by_day_of_week[7]);
    }
    
    public function testGetBumpsByDayOfWeekAtPlaceWithTwoBumpOnSaturday() {
        $db = new DbOperation();
        $bumps_by_day_of_week = $db->get_bumps_by_location_and_day_of_week('test_location_1002');
        $this->assertEquals(0, $bumps_by_day_of_week[1]);
        $this->assertEquals(0, $bumps_by_day_of_week[2]);
        $this->assertEquals(0, $bumps_by_day_of_week[3]);
        $this->assertEquals(0, $bumps_by_day_of_week[4]);
        $this->assertEquals(0, $bumps_by_day_of_week[5]);
        $this->assertEquals(0, $bumps_by_day_of_week[6]);
        $this->assertEquals(2, $bumps_by_day_of_week[7]);
    }
    
    public function testGetBumpsByDayOfWeekAtPlaceWithNoBumps() {
        $db = new DbOperation();
        $bumps_by_day_of_week = $db->get_bumps_by_location_and_day_of_week('test_location_1004');
        $this->assertEquals(0, $bumps_by_day_of_week[1]);
        $this->assertEquals(0, $bumps_by_day_of_week[2]);
        $this->assertEquals(0, $bumps_by_day_of_week[3]);
        $this->assertEquals(0, $bumps_by_day_of_week[4]);
        $this->assertEquals(0, $bumps_by_day_of_week[5]);
        $this->assertEquals(0, $bumps_by_day_of_week[6]);
        $this->assertEquals(0, $bumps_by_day_of_week[7]);
    }
    
    public function testInsertAUser() {
        $db = new DbOperation();
        $this->assertTrue($db->insert_user(1005, 'test person 5'));
        $db->remove_user(1005);
    }
    
    public function testInsertAnExistingUser() {
        $db = new DbOperation();
        $this->assertFalse($db->insert_user(1001, 'test person 1'));
    }
}

