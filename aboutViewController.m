//
//  aboutViewController.m
//  BullsEye
//
//  Created by yiye on 14-10-16.
//  Copyright (c) 2014年 yiye. All rights reserved.
//

#import "aboutViewController.h"

@interface aboutViewController ()

- (IBAction)close:(id)sender;

@end

@implementation aboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}


@end
