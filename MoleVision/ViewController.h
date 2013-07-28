//
//  ViewController.h
//  MoleVision
//
//  Created by Dawn Walsh on 2013-06-23.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import <UIKit/UIKit.h>
NSString *profileAlarm;
@interface ViewController : UIViewController{
IBOutlet UISegmentedControl *segmentGender;
    IBOutlet UISegmentedControl *segmentSkin;
//IBOutlet UIImageView *image;
   

    
   
    
}
- (IBAction)refresh:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPhotoLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmDateLabel;



@property (weak, nonatomic) IBOutlet UITextField *userAgeTextFiled;
@property (weak, nonatomic) IBOutlet UIImageView *skinType;
- (IBAction)tap:(id)sender;


- (IBAction)submitProfielButton:(id)sender;
//@property (weak, nonatomic) IBOutlet UIImageView *view111;


- (IBAction)genderSelect:(id)sender;
//- (IBAction)skinSelect:(id)sender;
- (IBAction)skinTypeSelect:(id)sender;

//buttons for the user tutoriasl
- (IBAction)featuresButton:(id)sender;
- (IBAction)walkthroughButton:(id)sender;



@end
