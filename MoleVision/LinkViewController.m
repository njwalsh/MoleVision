//
//  LinkViewController.m
//  MoleVision
//
//  Created by Ivy Dong on 13-07-29.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import "LinkViewController.h"

@interface LinkViewController ()

@end

@implementation LinkViewController

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
     [NSURL URLWithString:@"http://www.cancer.ca/"]];
}

-(IBAction)webMD {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.webmd.com/melanoma-skin-cancer/default.htm"]];
}


@end
