//
//  EditViewController.h
//  Mole Vision
//
//  Created by Nick Walsh on 2013-06-22.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController{
    UITextField *label;
    NSString *sendMoleLabel;
    UITextView *comments;
}

@property (nonatomic, retain) IBOutlet UITextField *label;
@property (strong, nonatomic) NSString *sendMoleLabel;
@property (nonatomic, retain) IBOutlet UITextView *comments;


@end
