//
//  LocationMessageViewController.m
//  
//
//  Created by Alex Lucas on 21/4/2017.
//
//

#import "LocationMessageViewController.h"
#import "PostMessageViewController.h"
#import "MessageBoard.h"
#import "MessageCell.h"
#import "Message.h"

@interface LocationMessageViewController ()
@property MessageBoard *messageBoard;
@property NSMutableArray<NSNumber *> *heights;

@end

@implementation LocationMessageViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.heights = [[NSMutableArray alloc] init];
    self.messages = [[NSMutableArray alloc] init];
    NSLog(@"Location: %@", self.location);

    
    MessageBoard *mb = [[MessageBoard alloc] init];
    [mb loadMessagesForLocation:self.location.googlePlacesID withCompletion:^(NSMutableArray * messages){
        self.messages = messages;
        
        NSLog(@"messages :%@", messages);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"blah");

            
            [self.tableView reloadData];
            [self.tableView setNeedsDisplay];
            [self.refreshControl endRefreshing];
        });
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
   
    
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"IN cellf or row at index path");
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
    
    
    [cell.locationLabel setText: self.location.name];
    
    if ([indexPath row] %2 == 0) {
        
        [cell setBackgroundColor: [self darkerGray]];
    }
    else {
        [cell setBackgroundColor: [self lighterGray]];
    }

    [self.heights insertObject:[NSNumber numberWithDouble: cell.messageLabel.frame.size.height + 70] atIndex:indexPath.row];
    NSLog(@"is the height %@", [self.heights objectAtIndex:indexPath.row]);
    
    CGRect newTimeFrame = cell.timeLabel.frame;
    newTimeFrame.origin.y = cell.messageLabel.frame.origin.y + cell.messageLabel.frame.size.height - 7;
    cell.timeLabel.frame = newTimeFrame;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.heights.count > indexPath.row) {
        return [self.heights objectAtIndex:indexPath.row].doubleValue;
    }
    else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}


- (UIColor *)lighterGray {
    return [UIColor colorWithRed:0xEA/255.0 green:0xEA/255.0 blue:0xEA/255.0 alpha:0.45];
    
}
- (UIColor *)darkerGray {
    return [UIColor colorWithRed:0xEB/255.0 green:0xEB/255.0 blue:0xEB/255.0 alpha:1];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"postMessageSegue"]) {
        ((PostMessageViewController *)[segue destinationViewController]).location = self.location;
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

@end
