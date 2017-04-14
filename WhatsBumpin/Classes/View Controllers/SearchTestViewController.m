//
//  SearchTestViewController.m
//  WhatsBumpin
//
//  Created by Alex Lucas on 14/4/2017.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "SearchTestViewController.h"

@interface SearchTestViewController ()
@property (weak, nonatomic) IBOutlet UIButton *dayNightButton;

@end

@implementation SearchTestViewController

- (IBAction)filterButtonPressed:(UIButton *)sender {
    [sender setSelected: !sender.isSelected];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
