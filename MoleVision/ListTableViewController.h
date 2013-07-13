//
//  ListTableViewController.h
//  SearchBarTutorial
//
//  Created by Nick Walsh on 2013-06-21.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CameraViewController;

@interface ListTableViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    
    UIBarButtonItem * moleButton;
    NSMutableArray *moleArray;
    NSMutableArray *dataArray;
    
    UIImagePickerController *picker;
    UIImage *image;
    
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem * moleButton;
@property (nonatomic, retain) UIImagePickerController *picker;
@property (nonatomic, retain) UIImage *image;

- (void) addMole;

-(IBAction)ChooseExisting;

@end
