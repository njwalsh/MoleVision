//
//  AlarmViewController.h
//  MoleVision
//
//  Created by Matthew Chow on 2013-07-11.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import <UIKit/UIKit.h>
NSString *AlarmTime;

@interface AlarmViewController : UIViewController
{
    IBOutlet UIDatePicker *dateTimePicker;
}
-(void) presentMessage: (NSString *) message;
-(void) scheduleLocalNotificationsWithDate: (NSDate *) fireDate;
-(IBAction) alarmSetButtonTap:(id)sender;
-(IBAction) alarmCancelButtonTap:(id)sender;

@end
