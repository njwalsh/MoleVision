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

@interface ViewController (){
    NSFileManager *fileManager;
    NSString *fullpath;
    NSFileHandle *filehandle;
    NSString *userGender;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)submitProfielButton:(id)sender {
    
    
    BOOL fileExist = [[NSFileManager defaultManager]fileExistsAtPath:fullpath];
    NSString *userAge = self.userAgeTextFiled.text;
    NSString *userSkinType = self.userSkintypeTextFiled.text;
    if ([userAge isEqualToString:@""]||[userSkinType isEqualToString:@""]) {
        UIAlertView *noUserName = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"There is at least a blank" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [noUserName show];
        
    }else{
        
        if (!fileExist) {
            [fileManager createFileAtPath:fullpath contents:nil attributes:nil];
        }
        NSString *userProfile = [NSString stringWithFormat:@"%@\n%@\n%@",userGender,self.userAgeTextFiled.text,self.userSkintypeTextFiled.text];
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
        //skinType.image=nil;
        
        
    }
    if(segmentSkin.selectedSegmentIndex == 1){
        
        [skinType setImage:[UIImage imageNamed:@"skintype_2.jpg"]];
        
        
    }
    if(segmentSkin.selectedSegmentIndex == 2){
        
        [skinType setImage:[UIImage imageNamed:@"skintype_3.jpg"]];
        
        
    }
    if(segmentSkin.selectedSegmentIndex == 3){
    
        [skinType setImage:[UIImage imageNamed:@"skintype_4.jpg"]];
        
    }
    if(segmentSkin.selectedSegmentIndex == 4){
       
        [skinType setImage:[UIImage imageNamed:@"skintype_5.jpg"]];
        
        
    }
    if(segmentSkin.selectedSegmentIndex == 5){
        
        [skinType setImage:[UIImage imageNamed:@"skintype_6.jpg"]];
        
        
    }
    
}
@end


