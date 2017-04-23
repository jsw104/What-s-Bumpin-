//
//  PostMessageViewController.m
//  WhatsBumpin
//
//  Created by Elle Zadina on 4/23/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "PostMessageViewController.h"
#import "Location.h"
#import "Message.h"

@interface PostMessageViewController ()
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UIImageView *locationIcon;
@property (strong, nonatomic) IBOutlet UITextView *messageText;

@end

@implementation PostMessageViewController

- (IBAction)postMessageClicked:(id)sender {
    long fb_id = [User getCurrentUser].facebookID;
    Message *newMessage =[[Message alloc] initWithUserID: fb_id locationID: _location.googlePlacesID andMessage: _messageText.text];
    [newMessage saveInBackgroundWithCompletionBlock:^(NSError* error){
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _locationLabel.text = _location.name;
    _locationIcon.image = [_locationIcon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_locationIcon setTintColor:[UIColor colorWithRed:0x4c/255.0 green:0xd9/255.0 blue:0x64/255.0 alpha:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
