//
//  CameraViewController.h
//  MoleVision
//
//  Created by Dawn Walsh on 2013-06-23.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    
    UIImagePickerController *picker;
    UIImage *image;
    IBOutlet UIImageView *imageView;
}

-(IBAction)ChooseExisting;

@end
