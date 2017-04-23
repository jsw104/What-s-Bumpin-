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
    
    public function testInsertABumpWithInvalidUser() {
        $db = new DbOperation();
        $this->assertFalse($db->insert_bump('test_location_1001', 1999));
    }
    
    public function testGetBumpCountFromOneValidLocation() {
        $db = new DbOperation();
        $testArray = array(
            "test_location_1002" => 2
        );
        $this->assertEquals($testArray, $db->get_bump_count_by_locations('test_location_1002|'));
    }
    
    /*public function testInsertABump() {
        $db = new DbOperation();
        $this->assertTrue($db->insert_bump(998, 1));
    }
    
    public function testInsertABumpAtSamePlaceDifferentPerson() {
        $db = new DbOperation();
        $this->assertTrue($db->insert_bump(998, 2));
        $this->assertTrue($db->insert_bump(998, 3));
    }
    
    public function testInsertTwoBumpsAtSamePlaceSamePersonInARow() {
        $db = new DbOperation();
        $db->insert_bump(998, 4);
        $this->assertFalse($db->insert_bump(998, 4));
    }
    
    public function testInsertTwoBumpsAtSamePlaceSamePersonAfter59Seconds() {
        $db = new DbOperation();
        $db->insert_bump(998, 5);
        sleep(59);
        $this->assertFalse($db->insert_bump(998, 5));
    }
    
    public function testInsertTwoBumpsAtSamePlaceSamePersonAfter61Seconds() {
        $db = new DbOperation();
        $db->insert_bump(998, 6);
        sleep(61);
        $this->assertTrue($db->insert_bump(998, 6));
    }
    
    public function testInsertABumpWithInvalidUser() {
        $db = new DbOperation();
        $this->assertFalse($db->insert_bump(998, 7));
    }
    
    public function testGetAllBumps(){
        $db = new DbOperation();
        $this->assertNotEmpty($db->get_all_bumps());
    }
    
    public function testNoMessagesAtLocation() {
        $db = new DbOperation();
        $this->assertEmpty($db->get_messages(999));
    }
    
    public function testGetOneMessageAtLocation() {
        $db = new DbOperation();
        $this->assertCount(1, $db->get_messages(24));
    }
    
    public function testGetTwoMessagesAtLocation() {
        $db = new DbOperation();
        $this->assertCount(2, $db->get_messages(23));
    }
    
    public function testGetBumpsByDayOfWeekAtPlaceWithNoBumps() {
        $db = new DbOperation();
        $bumps_by_day_of_week = $db->get_bumps_by_day_of_week(996);
        $this->assertEquals(0, $bumps_by_day_of_week[1]);
        $this->assertEquals(0, $bumps_by_day_of_week[2]);
        $this->assertEquals(0, $bumps_by_day_of_week[3]);
        $this->assertEquals(0, $bumps_by_day_of_week[4]);
        $this->assertEquals(0, $bumps_by_day_of_week[5]);
        $this->assertEquals(0, $bumps_by_day_of_week[6]);
        $this->assertEquals(0, $bumps_by_day_of_week[7]);
    }
    
    public function testGetBumpsByDayOfWeek0OnThursday() {
        $db = new DbOperation();
        $bumps_by_day_of_week = $db->get_bumps_by_day_of_week(22);
        $this->assertEquals(0, $bumps_by_day_of_week[5]);
    }
    
    public function testGetBumpsByDayOfWeek1OnFriday() {
        $db = new DbOperation();
        $bumps_by_day_of_week = $db->get_bumps_by_day_of_week(22);
        $this->assertEquals(1, $bumps_by_day_of_week[6]);
    }*/
}

