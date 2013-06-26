//
//  ListTableViewController.h
//  SearchBarTutorial
//
//  Created by Nick Walsh on 2013-06-21.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class CameraViewController;

@interface ListTableViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    
    UIBarButtonItem * moleButton;
    NSMutableArray *moleArray;
    NSMutableArray *dataArray;
    
    UIImagePickerController *picker;
    UIImage *image;
    
    AppDelegate *appDelegate;
    
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem * moleButton;
@property (strong, nonatomic) AppDelegate *appDelegate;

- (IBAction) doMoleButton;
- (void) addMole;
- (void) saveMoleData;

-(IBAction)ChooseExisting;

@end
