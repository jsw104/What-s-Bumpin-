//
//  PostMessageViewController.h
//  WhatsBumpin
//
//  Created by Elle Zadina on 4/23/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface PostMessageViewController : UIViewController<UITextViewDelegate>

@property (strong, nonatomic) Location *location;

@end
