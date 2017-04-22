//
//  LocationInformationViewController.h
//  What's Bumpin'
//
//  Created by Justin Wang on 2/13/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface LocationInformationViewController : UIViewController

@property (strong, nonatomic) Location *location;
@property (strong, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UIButton *graphButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UILabel *locationAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationOpenLabel;
@property (weak, nonatomic) IBOutlet UILabel *bumpLabel;


@end
