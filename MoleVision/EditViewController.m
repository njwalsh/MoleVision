//
//  EditViewController.m
//  Mole Vision
//
//  Created by Nick Walsh on 2013-06-22.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import "EditViewController.h"
#import "Mole.h"
#import "AppDelegate.h"

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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Mole *temp = [appDelegate.moleArray objectAtIndex:moleIndex];
    temp.name = label.text;
    [appDelegate.moleArray replaceObjectAtIndex:moleIndex withObject:temp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
