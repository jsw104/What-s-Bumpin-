//
//  FirstViewController.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/12/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "FirstViewController.h"
#import "ImageConverter.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTabBarIcon];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) configureTabBarIcon
{
    UIImage *image = [UIImage imageNamed:@"Earth.png"];
    self.tabBarItem.image = [ImageConverter imageWithImage:image scaledToSize:CGSizeMake(30, 30)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
