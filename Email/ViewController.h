//
//  ViewController.h
//  Email
//
//  Created by Matthew Chow on 2013-06-28.
//  Copyright (c) 2013 Matthew Chow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate>

- (IBAction)openMail:(id)sender;

@end
