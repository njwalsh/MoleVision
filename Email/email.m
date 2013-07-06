//
//  ViewController.m
//  Email
//
//  Created by Matthew Chow on 2013-06-28.
//  Copyright (c) 2013 Matthew Chow. All rights reserved.
//

#import "email.h"

@implementation email

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openMail:(id)sender {
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    [composer setMailComposeDelegate:self];
    if ([MFMailComposeViewController canSendMail])
    {
        //[composer setToRecipients: [NSArray arrayWithObjects:@"abc@123.com", nil]];
        //[composer setSubject:@"Subject here"];
        //[composer setMessageBody:@"Message here" isHTML:NO];
        //[composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:composer animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message: [NSString stringWithFormat:@"error %@", [error description]] delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
        [self dismissViewControllerAnimated:YES completion:nil];
}

@end
