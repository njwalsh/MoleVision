//
//  AlarmViewController.m
//  MoleVision
//
//  Created by Matthew Chow on 2013-07-11.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import "AlarmViewController.h"

@interface AlarmViewController ()

@end

@implementation AlarmViewController

-(void) presentMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reminder" message: message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
}

-(IBAction)alarmSetButtonTap:(id)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale systemLocale];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    
    NSString *dateTimeString = [dateFormatter stringFromDate: dateTimePicker.date];
    NSLog(@"Alarm set : %@", dateTimeString);
    
    [self scheduleLocalNotificationsWithDate: dateTimePicker.date];
    
    [self presentMessage: @"Alarm set."];
}

-(IBAction)alarmCancelButtonTap:(id)sender  {
    NSLog(@"Alarm canceled.");
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [self presentMessage: @"Alarm canceled."];
}

-(void)scheduleLocalNotificationsWithDate:(NSDate *)fireDate {
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.fireDate = fireDate;
    notification.alertBody = @"Please remember to take your monthly photo.";
    notification.soundName = UILocalNotificationDefaultSoundName; // Custom alarm clock sound
    notification.applicationIconBadgeNumber++;
    
    [[UIApplication sharedApplication] scheduleLocalNotification: notification];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    dateTimePicker.date = [NSDate date];    // Gets the current date
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
