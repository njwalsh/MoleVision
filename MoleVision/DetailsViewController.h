//
//  DetailsViewController.h
//  SearchBarTutorial
//
//  Created by Nick Walsh on 2013-06-21.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController{
    
    UIBarButtonItem * editMoleButton;
    
}

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) NSString *sendLabel;
@property (nonatomic, retain) IBOutlet UIBarButtonItem * editMOleBUtton;

- (IBAction) doEditMOleButton;

@end
