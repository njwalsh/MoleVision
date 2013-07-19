//
//  ABCDEViewController.m
//  ABCDE Tutorial
//
//  Created by Adrienne C on 2013-06-21.
//  Copyright (c) 2013 Adrienne C. All rights reserved.
//

#import "ABCDEViewController.h"

@interface ABCDEViewController ()

@end

@implementation ABCDEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)skinCancerFoundation {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.skincancer.org"]];
}

-(IBAction)canadianCancerSociety {
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString:@"http://www.webmd.com/melanoma-skin-cancer/default.htm"]];
}

-(IBAction)webMD {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.webmd.com/melanoma-skin-cancer/default.htm"]];
}

@end
