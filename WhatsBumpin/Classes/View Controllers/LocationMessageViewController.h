//
//  LocationMessageViewController.h
//  
//
//  Created by Alex Lucas on 21/4/2017.
//
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface LocationMessageViewController : UITableViewController
@property (strong, nonatomic) Location *location;
@property (nonatomic, strong) NSMutableArray *messages;

- (void) sendLocalBumpNotification: (NSString *) message successful:(bool)success;

@end
