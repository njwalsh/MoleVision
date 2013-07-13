//
//  FirstViewController.h
//  loginAndProfile
//
//  Created by xin ji on 2013-06-21.
//  Copyright (c) 2013 Team UP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordText;
- (IBAction)signInButton:(id)sender;
- (IBAction)signUpButton:(id)sender;
-(IBAction)tapBackground:(id)sender;





@end
