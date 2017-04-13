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

@interface MessagesTableViewController ()

@end

@implementation MessagesTableViewController

CGFloat heights[];


- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    self.messages = [NSMutableArray arrayWithCapacity:2];
    
    Message *message = [[Message alloc] init];
    message.username = @"Elle Zadina";
    message.message_text = @"I would totally recommend this place it is fantastic and wonderful and there's singing on Thursday night and it's super close and the food is good";
    [self.messages addObject:message];
    
    message = [[Message alloc] init];
    message.username = @"Justin Wang";
    message.message_text = @"I would totally recommend this place it is fantastic and wonderful and there's singing on Thursday night";
    [self.messages addObject:message];

    
    //messageboard get messages
    //use the message board array to populate data table
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
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    Message *message = (self.messages)[indexPath.row];
    cell.nameLabel.text = message.username;
    cell.messageLabel.text = message.message_text;
    [cell.messageLabel sizeToFit];
    cell.timeLabel.text = @"11:45";
    
//    cell.locationLabel.text = @"Jolly";
//    [cell.locationLabel sizeToFit];
    
    
    cell.locationIcon.image = [cell.locationIcon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    Boolean bumped = TRUE;
    if(bumped){
        
        [cell.locationIcon setTintColor:[UIColor colorWithRed:0x4c/255.0 green:0xd9/255.0 blue:0x64/255.0 alpha:1]];
    }
    
    
    if ([indexPath row] %2 == 0) {
        [self setLocationLabel:cell.locationLabel withText:@"The Jolly Scholar" adjustIcon:cell.locationIcon];

        [cell setBackgroundColor: [self darkerGray]];
    }
    else {
        [self setLocationLabel:cell.locationLabel withText:@"Jolly" adjustIcon:cell.locationIcon];

        [cell setBackgroundColor: [self lighterGray]];
    }
    
    heights[indexPath.row] = cell.messageLabel.frame.size.height + 60;

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
