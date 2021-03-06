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
#import <TSMessages/TSMessageView.h>
#import "LocationMessageViewController.h"

@interface PostMessageViewController()
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UIImageView *locationIcon;
@property (strong, nonatomic) IBOutlet UITextView *messageText;

@end

@implementation PostMessageViewController

- (IBAction)postMessageClicked:(id)sender {
    long fb_id = [User getCurrentUser].facebookID;
    Message *newMessage =[[Message alloc] initWithUserID: fb_id locationID: _location.googlePlacesID andMessage: _messageText.text];
    [newMessage saveInBackgroundWithCompletionBlock:^(BOOL success){
        dispatch_async(dispatch_get_main_queue(), ^{
        if(success){
            [(LocationMessageViewController *)[[[self navigationController] viewControllers] objectAtIndex:([self.navigationController.viewControllers indexOfObject:self] - 1)]  sendLocalBumpNotification:[NSString stringWithFormat:@"You have successfully posted at %@", _location.name] successful:YES];
            [self.navigationController popViewControllerAnimated:true];
        }else{
            [self sendLocalBumpNotification:[NSString stringWithFormat:@"Post to %@ was unsuccessful", _location.name] successful:NO];
        }
            });
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _locationLabel.text = _location.name;
    _locationIcon.image = [_locationIcon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_locationIcon setTintColor:[UIColor colorWithRed:0x4c/255.0 green:0xd9/255.0 blue:0x64/255.0 alpha:1]];
    _messageText.delegate = self;
    _messageText.text = @"Write your message here...";
    _messageText.textColor = [UIColor lightGrayColor];
    _messageText.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (_messageText.textColor == [UIColor lightGrayColor]){
    _messageText.text = @"";
    _messageText.textColor = [UIColor blackColor];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if(_messageText.text.length == 0){
        _messageText.textColor = [UIColor lightGrayColor];
        _messageText.text = @"Write your message here...";
    }
}

- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}

- (void) sendLocalBumpNotification: (NSString *) message successful:(bool)success{
    if(success)
    {
        [TSMessage showNotificationInViewController:self title:@"Post Successful!" subtitle:message type:TSMessageNotificationTypeSuccess];
    }
    else{
        [TSMessage showNotificationInViewController:self title:@"Post Failed!" subtitle:message type:TSMessageNotificationTypeError];
    }
    
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
