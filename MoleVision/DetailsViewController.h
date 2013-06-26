//
//  DetailsViewController.h
//  SearchBarTutorial
//
//  Created by Nick Walsh on 2013-06-21.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"

@interface DetailsViewController : UIViewController <MyDataDelegate>{
    
    UIBarButtonItem * editMoleButton;
    
}

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) NSString *sendLabel;
@property (nonatomic) NSInteger moleRow;
@property (nonatomic, retain) IBOutlet UIBarButtonItem * editMoleButton;

- (IBAction) doEditMoleButton;

@end
