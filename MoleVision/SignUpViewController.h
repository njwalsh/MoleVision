//
//  SignUpViewController.h
//  loginAndProfile
//
//  Created by xin ji on 2013-06-22.
//  Copyright (c) 2013 Team UP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *setUserName;
@property (weak, nonatomic) IBOutlet UITextField *setPassword;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;

- (IBAction)signUpButton:(id)sender;



@end
