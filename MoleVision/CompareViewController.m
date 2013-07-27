//
//  CompareViewController.m
//  Mole Vision
//
//  Created by Nick Walsh on 2013-06-22.
//  Modified by
//  Copyright (c) 2013 Team Up. All rights reserved.
//
//  Changes made
//
//
//
//  Bugs:
//
//
//

#import "CompareViewController.h"

@interface CompareViewController ()

@end

@implementation CompareViewController

@synthesize image1, image2;
@synthesize imageView1, imageView2;

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
	// Do any additional setup after loading the view.
    
    NSLog(@"compare view");
    [imageView1 setImage:image1];
    [imageView2 setImage:image2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
