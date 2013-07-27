//
//  EditViewController.m
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
//  - fields might not save when user changes comment field (it is not a textfield)
//
//

#import "EditViewController.h"
#import "ListTableViewController.h"
#import "Mole.h"

@interface EditViewController ()

@end

@implementation EditViewController

@synthesize label, comments;
@synthesize sendMoleLabel;
@synthesize moleIndex;
@synthesize moleLabel;
@synthesize moleComments;

-(IBAction)tapBackground:(id)sender{
    // save fields when users taps background and remove keyboard
    [label resignFirstResponder];
    [comments resignFirstResponder];
    
    moleLabel = label.text;
    moleComments = comments.text;
    
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"moleArray"]];
    NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    
    NSMutableArray * tempArr = [[NSMutableArray alloc] initWithArray:decodedArray];
    Mole *tempMole = [tempArr objectAtIndex:moleIndex];
    tempMole.name = moleLabel;
    tempMole.comments = moleComments;
    [tempArr replaceObjectAtIndex:moleIndex withObject:tempMole];
    
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:tempArr];
    [userDefault setObject:myEncodedObject forKey:[NSString stringWithFormat:@"moleArray"]];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // save fields when user changes a textfield
    moleLabel = label.text;
    moleComments = comments.text;
    
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"moleArray"]];
    NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    
    NSMutableArray * tempArr = [[NSMutableArray alloc] initWithArray:decodedArray];
    Mole *tempMole = [tempArr objectAtIndex:moleIndex];
    tempMole.name = moleLabel;
    tempMole.comments = moleComments;
    [tempArr replaceObjectAtIndex:moleIndex withObject:tempMole];
    
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:tempArr];
    [userDefault setObject:myEncodedObject forKey:[NSString stringWithFormat:@"moleArray"]];
    return YES;
}

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
    label.delegate = self;
    
    //get mole comments
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"moleArray"]];
    NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    
    Mole *tempMole = [decodedArray objectAtIndex:moleIndex];
    label.text = tempMole.name;
    comments.text = tempMole.comments;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
