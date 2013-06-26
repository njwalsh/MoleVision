//
//  EditViewController.m
//  Mole Vision
//
//  Created by Nick Walsh on 2013-06-22.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import "EditViewController.h"
#import "Mole.h"

@interface EditViewController ()

@end

@implementation EditViewController

@synthesize label, comments;
@synthesize sendMoleLabel;
@synthesize moleIndex;

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
    
    label.text = self.sendMoleLabel;
    label.text = @"new Name";
    [self.delegate receiveData:label.text];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
