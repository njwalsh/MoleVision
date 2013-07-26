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
@property (weak, nonatomic) IBOutlet UIImageView *checkUserName;
@property (weak, nonatomic) IBOutlet UIImageView *chechPassWord;

-(IBAction)tapBackground:(id)sender;

- (IBAction)FirstSign:(id)sender;

- (IBAction)FirstUp:(id)sender;
- (IBAction)LoginButton:(id)sender;

@end
