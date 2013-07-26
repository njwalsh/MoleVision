//
//  DetailsViewController.h
//  SearchBarTutorial
//
//  Created by Nick Walsh on 2013-06-21.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"
#import "CompareViewController.h"
#import "Mole.h"

@interface DetailsViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate> {
    
    UIBarButtonItem * editMoleButton;
    int pageCount;
    NSArray * tmpImagesArray;
    
    UIButton * addPictureButton;
    UIImagePickerController *picker;
    UIImage *image;
    UIScrollView * scroller;
    
}

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;
@property (strong, nonatomic) NSString *sendLabel;
@property (nonatomic) NSInteger moleRow;
@property (nonatomic, retain) IBOutlet UIBarButtonItem * editMoleButton;
@property (nonatomic) int pageCount;
@property (nonatomic, retain) IBOutlet UIButton * addPictureButton;
@property (strong, nonatomic) UIScrollView * scroller;
@property (nonatomic, retain) NSArray * tmpImagesArray;

//- (IBAction) doEditMoleButton;
-(IBAction)ChooseExisting;
-(IBAction)showCameraUI;
- (void) displayMoleImages:(Mole *)tmpMole;
-(IBAction)emailPhotos;

@end
