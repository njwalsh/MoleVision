//
//  ListTableViewController.h
//  SearchBarTutorial
//
//  Created by Nick Walsh on 2013-06-21.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewController : UITableViewController{
    
    UIBarButtonItem * moleButton;
    NSMutableArray *moleArray;
    NSMutableArray *dataArray;
    
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem * moleButton;

@property (strong, nonatomic) NSArray *dataArray;

- (IBAction) doMoleButton;

@end
