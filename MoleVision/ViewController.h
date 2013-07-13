//
//  ViewController.h
//  MoleVision
//
//  Created by Dawn Walsh on 2013-06-23.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
IBOutlet UISegmentedControl *segmentGender;
    IBOutlet UISegmentedControl *segmentSkin;
//IBOutlet UIImageView *image;
   

    
   
    
}
@property (weak, nonatomic) IBOutlet UITextField *userGenderTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *userAgeTextFiled;

@property (weak, nonatomic) IBOutlet UITextField *userSkintypeTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *userEyeColorTextFiled;
@property (weak, nonatomic) IBOutlet UIImageView *skinType;


- (IBAction)submitProfielButton:(id)sender;
//@property (weak, nonatomic) IBOutlet UIImageView *view111;


- (IBAction)genderSelect:(id)sender;
//- (IBAction)skinSelect:(id)sender;
- (IBAction)skinTypeSelect:(id)sender;


@end
