//
//  SearchTestViewController.m
//  WhatsBumpin
//
//  Created by Alex Lucas on 14/4/2017.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "SearchTestViewController.h"

@interface SearchTestViewController ()
<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIButton *dayNightButton;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation SearchTestViewController

- (IBAction)filterButtonPressed:(UIButton *)sender {
    [sender setSelected: !sender.isSelected];

}
- (IBAction)searchButtonPressed:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations: ^{
        [sender setAlpha:0];
    
        [_searchView setFrame:CGRectMake(0, 0, _searchView.frame.size.width, _searchView.frame.size.height)];
        [_searchBar becomeFirstResponder];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_searchBar setDelegate: self];
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    [_searchBar setBarTintColor:[UIColor clearColor]]; //this is what you want

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    CGFloat height = _searchView.frame.size.height;
    CGFloat width = _searchView.frame.size.width;
    
    [UIView animateWithDuration:0.3 animations: ^{

    [_searchView setFrame:CGRectMake(0, 20-height, width, height)];
    
    [_searchButton setAlpha:1];
        [_searchView resignFirstResponder];
        
    }];
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
