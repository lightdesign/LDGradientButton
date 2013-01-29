//
//  LDViewController.m
//  LDGradientButtonExample
//
//  Created by Christian Di Lorenzo on 1/28/13.
//  Copyright (c) 2013 Light Design. All rights reserved.
//

#import "LDViewController.h"
#import "LDGradientButton.h"

@interface LDViewController ()
@end

@implementation LDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.15f green:0.57f blue:0.84f alpha:1.00f];
    LDGradientButton *destroyButton = [[LDGradientButton alloc] initWithFrame:CGRectMake(10, 10, 60, 31)];
    destroyButton.title = @"Start";
    
    LDGradientButton *christmasButton = [[LDGradientButton alloc] initWithFrame:CGRectMake(10, 10, 120, 31)];
    christmasButton.title = @"It's Christmas";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:christmasButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:destroyButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
