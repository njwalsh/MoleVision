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
    
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"moleArray"]];
    NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    
    NSMutableArray * tempArr = [[NSMutableArray alloc] initWithArray:decodedArray];
    Mole *tempMole = [[Mole alloc] init];
    tempMole.name = label.text;
    [tempArr replaceObjectAtIndex:moleIndex withObject:tempMole];
    
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:tempArr];
    [userDefault setObject:myEncodedObject forKey:[NSString stringWithFormat:@"moleArray"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
