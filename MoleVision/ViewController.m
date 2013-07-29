//
//  ViewController.m
//  MoleVision
//
//  Created by Dawn Walsh on 2013-06-23.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import "ViewController.h"
#import "EditViewController.h"
#import "FirstViewController.h"
#import "AlarmViewController.h"
#import "SignUpViewController.h"

@interface ViewController (){
    NSFileManager *fileManager;
    NSString *fullpath;
    NSFileHandle *filehandle;
    NSFileManager *fileManager1;
    NSString *fullPath1;
    NSFileHandle *fileHandle1;
    NSString *userGender;
    NSString *userSkin;
    }



@end

@implementation ViewController
@synthesize skinType;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath=[paths objectAtIndex:0];
    
    fileManager =[NSFileManager defaultManager];
    filehandle =[NSFileHandle fileHandleForUpdatingAtPath:[filePath stringByAppendingPathComponent:@"userProfile.txt"]];
    
    [fileManager changeCurrentDirectoryPath:filePath];
    fullpath = [NSString stringWithFormat:@"%@",[filePath stringByAppendingPathComponent:@"userProfile.txt"]];
    self.startDateLabel.text = alarmData111;
    //NSLog(@"start date :%@",alarmData111);
    
    self.alarmDateLabel.text = AlarmTime;
    //NSLog(@"alarm time :%@",AlarmTime);
    
    
   // NSArray *paths1=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath1=[paths objectAtIndex:0];
    fileManager1 =[NSFileManager defaultManager];
    fileHandle1 =[NSFileHandle fileHandleForUpdatingAtPath:[filePath1 stringByAppendingPathComponent:@"userLogin.txt"]];
    
    [fileManager1 changeCurrentDirectoryPath:filePath];
    fullPath1 = [NSString stringWithFormat:@"%@",[filePath stringByAppendingPathComponent:@"userLogin.txt"]];
    
    fileHandle1 = [NSFileHandle fileHandleForUpdatingAtPath:fullPath1];
    NSString *stringFromFile = [NSString stringWithContentsOfFile:fullPath1 encoding:NSASCIIStringEncoding error:nil];
    const char *charsFromFile = [stringFromFile UTF8String];
    
    
    NSString *userDate = [[NSString alloc]init];
    
    int count=0;
    for (int i = 0; i< strlen(charsFromFile); i++) {
        if (charsFromFile[i]=='\n') {
            count++;
        }
        else if (count==2)
        {
            
            userDate = [userDate stringByAppendingString:[NSString stringWithFormat:@"%c",charsFromFile[i]]];
        }
        
        
    }
    NSLog(@"Data is : %@",userDate);
    self.startDateLabel.text = userDate;
    self.alarmDateLabel.text = AlarmTime;
    NSString *numberOfPhotos = [NSString stringWithFormat:@"%d", photosTaken];
    self.numberOfPhotoLabel.text = numberOfPhotos;


    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)tap:(id)sender {
    [_userAgeTextFiled resignFirstResponder];
}

- (IBAction)submitProfielButton:(id)sender {
    
    
    BOOL fileExist = [[NSFileManager defaultManager]fileExistsAtPath:fullpath];
    NSString *userAge = self.userAgeTextFiled.text;
  
    if ([userAge isEqualToString:@""]) {
        UIAlertView *noUserName = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"There is at least a blank" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [noUserName show];
        
    }else{
        
        if (!fileExist) {
            [fileManager createFileAtPath:fullpath contents:nil attributes:nil];
        }
        NSString *userProfile = [NSString stringWithFormat:@"%@\n%@\n%@",userGender,self.userAgeTextFiled.text,userSkin];
        filehandle = [NSFileHandle fileHandleForUpdatingAtPath:fullpath];
        NSData * data;
        const char *bytesofUserProfile = [userProfile UTF8String];
        data = [NSData dataWithBytes:bytesofUserProfile length:strlen(bytesofUserProfile)];
        [data writeToFile:fullpath atomically:YES];
        
        UIAlertView *infor = [[UIAlertView alloc]initWithTitle:@"Profile Created" message:@"Completed" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [infor show];
        [self performSegueWithIdentifier:@"ProfileToHome" sender:self];
        
        
        
        
    }
    
    /* UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"mainStoryBoard" bundle:nil];
     UIViewController * nextStoryBoard = [mainStoryBoard instantiateInitialViewController];
     nextStoryBoard.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
     [self pres
     */
    
}




- (IBAction)genderSelect:(id)sender {
    if(segmentGender.selectedSegmentIndex == 0){
        userGender =@"male";}
    if(segmentGender.selectedSegmentIndex == 1){
        userGender =@"famale";
    }
}


- (IBAction)skinTypeSelect:(id)sender {
    if(segmentSkin.selectedSegmentIndex == 0){
        UIImage *img1 = [UIImage imageNamed:@"skintype_1.jpg"];
        
        [skinType setImage:img1];
        userSkin = @"Type 1";
        //skinType.image=nil;
        
        
    }
    if(segmentSkin.selectedSegmentIndex == 1){
        
        [skinType setImage:[UIImage imageNamed:@"skintype_2.jpg"]];
        userSkin = @"Type 2";
        
        
    }
    if(segmentSkin.selectedSegmentIndex == 2){
        
        [skinType setImage:[UIImage imageNamed:@"skintype_3.jpg"]];
        userSkin = @"Type 3";
        
        
    }
    if(segmentSkin.selectedSegmentIndex == 3){
    
        [skinType setImage:[UIImage imageNamed:@"skintype_4.jpg"]];
        userSkin = @"Type 4";
        
    }
    if(segmentSkin.selectedSegmentIndex == 4){
       
        [skinType setImage:[UIImage imageNamed:@"skintype_5.jpg"]];
        userSkin = @"Type 5";
        
        
    }
    if(segmentSkin.selectedSegmentIndex == 5){
        
        [skinType setImage:[UIImage imageNamed:@"skintype_6.jpg"]];
        userSkin = @"Type 6";
        
        
    }
    
}
- (IBAction)refresh:(id)sender {
    self.alarmDateLabel.text = AlarmTime;
    NSString *numberOfPhotos = [NSString stringWithFormat:@"%d", photosTaken];
    self.numberOfPhotoLabel.text = numberOfPhotos;
}
- (IBAction)featuresButton:(id)sender {
}

- (IBAction)walkthroughButton:(id)sender {
}

- (IBAction)feedbackEmail:(id)sender {
    // Email
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    [composer setMailComposeDelegate:self];
    if ([MFMailComposeViewController canSendMail])
    {
        [composer setToRecipients: [NSArray arrayWithObjects:@"molevision.sfu@gmail.com", nil]];
        [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:composer animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message: [NSString stringWithFormat:@"error %@", [error description]] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        if (result == MFMailComposeResultSent) {    // If email is sent successfully, notify the user
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Message sent!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end


