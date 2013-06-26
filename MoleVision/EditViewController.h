//
//  EditViewController.h
//  Mole Vision
//
//  Created by Nick Walsh on 2013-06-22.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyDataDelegate

-(void)receiveData:(NSString *)theData;

@end

@interface EditViewController : UIViewController{
    UITextField *label;
    NSString *sendMoleLabel;
    UITextView *comments;
}

@property (nonatomic, retain) IBOutlet UITextField *label;
@property (strong, nonatomic) NSString *sendMoleLabel;
@property (nonatomic, retain) IBOutlet UITextView *comments;
@property (nonatomic) NSInteger moleIndex;

@property (nonatomic) id<MyDataDelegate> delegate;


@end
