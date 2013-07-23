//
//  EditViewController.h
//  Mole Vision
//
//  Created by Nick Walsh on 2013-06-22.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsViewController.h"

@interface EditViewController : UIViewController <UITextFieldDelegate> {
    UITextField *label;
    NSString *sendMoleLabel;
    NSString *moleLabel;
    NSString *moleComments;
    UITextView *comments;
}

@property (nonatomic, retain) IBOutlet UITextField *label;
@property (strong, nonatomic) NSString *sendMoleLabel;
@property (strong, nonatomic) NSString *moleLabel;
@property (strong, nonatomic) NSString *moleComments;
@property (nonatomic, retain) IBOutlet UITextView *comments;
@property (nonatomic) NSInteger moleIndex;

-(IBAction)tapBackground:(id)sender;


@end
