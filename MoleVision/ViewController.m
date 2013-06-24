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
    NSFileHandle *filehandle;}

@end

@implementation ViewController

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
	/*NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath=[paths objectAtIndex:0];
    
    fileManager =[NSFileManager defaultManager];
    filehandle =[NSFileHandle fileHandleForUpdatingAtPath:[filePath stringByAppendingPathComponent:@"userProfile.txt"]];
    
    [fileManager changeCurrentDirectoryPath:filePath];
    fullpath = [NSString stringWithFormat:@"%@",[filePath stringByAppendingPathComponent:@"userProfile.txt"]];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*- (IBAction)submitProfielButton:(id)sender {
    
    BOOL fileExist = [[NSFileManager defaultManager]fileExistsAtPath:fullpath];
    NSString *userGender = self.userGenderTextFiled.text;
    NSString *userAge = self.userAgeTextFiled.text;
    NSString *userSkinType = self.userSkintypeTextFiled.text;
    NSString *userEyeColor = self.userEyeColorTextFiled.text;
    if ([userGender isEqualToString:@""]||[userAge isEqualToString:@""]||[userEyeColor isEqualToString:@""]||[userSkinType isEqualToString:@""]) {
        UIAlertView *noUserName = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"There is at least a blank" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [noUserName show];
    }else{
        
        if (!fileExist) {
            [fileManager createFileAtPath:fullpath contents:nil attributes:nil];
        }
        NSString *userProfile = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",self.userGenderTextFiled.text,self.userAgeTextFiled.text,self.userSkintypeTextFiled.text,self.userEyeColorTextFiled.text];
        filehandle = [NSFileHandle fileHandleForUpdatingAtPath:fullpath];
        NSData * data;
        const char *bytesofUserProfile = [userProfile UTF8String];
        data = [NSData dataWithBytes:bytesofUserProfile length:strlen(bytesofUserProfile)];
        [data writeToFile:fullpath atomically:YES];
        
        UIAlertView *infor = [[UIAlertView alloc]initWithTitle:@"Profile Created" message:@"Completed" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [infor show];
        
        
        
        
    }
    
}*/


@end

