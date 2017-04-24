//
//  MessagesTableViewController.m
//  WhatsBumpin
//
//  Created by Alex Lucas on 13/4/2017.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "MessagesTableViewController.h"
#import "Message.h"
#import "MessageCell.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "MessageBoard.h"


@interface MessagesTableViewController ()
@property (strong) GMSPlacesClient *placesClient;
@end

@implementation MessagesTableViewController

CGFloat heights[];


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _placesClient = [[GMSPlacesClient alloc] init];
    
    [GMSPlacesClient provideAPIKey:@"AIzaSyAXtLf-_lGIafvi3Nqrc4m24I0ehPp5ekU"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [self lighterGray];
    self.refreshControl.tintColor = [UIColor darkGrayColor];
    [self.refreshControl addTarget:self
                            action:@selector(getNewestMessages)
                  forControlEvents:UIControlEventValueChanged];
    
    //self.messages = [NSMutableArray arrayWithCapacity:2];
    
    /////get facebook friends
    [self.refreshControl beginRefreshing];
    //__block NSMutableArray *array = [[NSMutableArray alloc] init];
    [self getFacebookFriendsWithCompletion:^(NSMutableArray *friendIDs) {
        
        MessageBoard *mb = [[MessageBoard alloc] init];
        [mb loadMessagesFromFriends:friendIDs withCompletion:^(NSMutableArray * messages){
            self.messages = messages;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
                [self.tableView setNeedsDisplay];
                [self.refreshControl endRefreshing];
            });
        }];
        
        
    }];
    
}


-(void) getFacebookFriendsWithCompletion: (void(^)(NSMutableArray* response))completion {
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             long user_id;
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 NSDictionary *resultDict = (NSDictionary *) result;
                 
                 user_id = [[resultDict valueForKey:@"id"] longLongValue];
                 
                 dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                     [self.view setNeedsDisplay];
                     
                     
                 });
                 
                 NSString *friendPath = [NSString stringWithFormat:@"me/friends"];
                 NSLog(@"friend path %@", friendPath);
                 
                 
                 
                 FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                               initWithGraphPath:friendPath
                                               parameters:@{@"fields": @"id, name"}
                                               HTTPMethod:@"GET"];
                 [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                       id result,
                                                       NSError *error) {
                     // Handle the result
                     NSMutableArray<NSString *> *idArray = [[NSMutableArray alloc] init];
                     if(!error){
                         NSArray * arrData = result[@"data"];
                         for (NSDictionary * dict in arrData)
                         {
                             NSString * strID = dict[@"id"];
                             NSLog(@"STRID:  %@", strID);
                             
                             [idArray addObject:strID];
                         }
                         
                     }
                     
                     
                     completion(idArray);
                     
                 }];
                 
             }
         }];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

-(void) getLocationNameFromID: (NSString *)locationID withCompletion: (void(^)(NSString* response))completion{
    
    
    [_placesClient lookUpPlaceID:locationID callback:^(GMSPlace *place, NSError *error) {
        if (error != nil) {
            NSLog(@"Place Details error %@", [error localizedDescription]);
            return;
        }
        
        if (place != nil) {
            NSLog(@"Place name %@", place.name);
            NSLog(@"Place address %@", place.formattedAddress);
            NSLog(@"Place placeID %@", place.placeID);
            NSLog(@"Place attributions %@", place.attributions);
            completion( place.name);
        } else {
            NSLog(@"No place details for %@", locationID);
        }
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    Message *message = (self.messages)[indexPath.row];
    cell.nameLabel.text = message.name;
    cell.messageLabel.text = message.message_text;
    [cell.messageLabel sizeToFit];
    cell.timeLabel.text = message.date;
    
    //    cell.locationLabel.text = @"Jolly";
    //    [cell.locationLabel sizeToFit];
    
    
    cell.locationIcon.image = [cell.locationIcon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    Boolean bumped = TRUE;
    if(bumped){
        
        [cell.locationIcon setTintColor:[UIColor colorWithRed:0x4c/255.0 green:0xd9/255.0 blue:0x64/255.0 alpha:1]];
    }
    
    [self getLocationNameFromID:message.locationID withCompletion:^(NSString *name) {
        NSLog(@"NAME %@", name);
        [self setLocationLabel:cell.locationLabel withText:name adjustIcon:cell.locationIcon];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell setNeedsDisplay];
        });
    }];
    
    if ([indexPath row] %2 == 0) {
        
        [cell setBackgroundColor: [self darkerGray]];
    }
    else {
        [cell setBackgroundColor: [self lighterGray]];
    }
    
    heights[indexPath.row] = cell.messageLabel.frame.size.height + 60;
    
    CGRect newTimeFrame = cell.timeLabel.frame;
    newTimeFrame.origin.y = cell.messageLabel.frame.origin.y + cell.messageLabel.frame.size.height - 7;
    cell.timeLabel.frame = newTimeFrame;
    
    return cell;
}

- (void) setLocationLabel: (UILabel *) label withText: (NSString *) text adjustIcon: (UIImageView *) icon {
    
    CGFloat oldX = label.frame.origin.x;
    CGFloat oldY = label.frame.origin.y;
    CGFloat oldH = label.frame.size.height;
    CGFloat oldW = label.frame.size.width;
    
    [label setText: text];
    
    [label sizeToFit];
    CGFloat width = label.frame.size.width;
    CGFloat height = label.frame.size.height;
    
    CGFloat deltaH = height - oldH;
    CGFloat deltaW = width - oldW;
    
    CGFloat newX = oldX - deltaW;
    CGFloat newY = oldY - (0.5 * deltaH);
    
    [label setFrame:CGRectMake(newX, newY, width, height)];
    
    [icon setCenter:CGPointMake(newX - 15, newY + (0.5 * height))];
}


- (void) getNewestMessages {
    //query for messages
    
    NSLog(@"Querying for messages");
    [self.refreshControl endRefreshing];
}

- (UIColor *)lighterGray {
    return [UIColor colorWithRed:0xEA/255.0 green:0xEA/255.0 blue:0xEA/255.0 alpha:0.45];
    
}
- (UIColor *)darkerGray {
    return [UIColor colorWithRed:0xEB/255.0 green:0xEB/255.0 blue:0xEB/255.0 alpha:1];
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return heights[indexPath.row];
}




@end
