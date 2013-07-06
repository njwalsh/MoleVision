//
//  FirstViewController.m
//  loginAndProfile
//
//  Created by xin ji on 2013-06-21.
//  Copyright (c) 2013 Team UP. All rights reserved.
//

#import "FirstViewController.h"
#import "ViewController.h"
#import "SignUpViewController.h"

@interface FirstViewController (){
    NSFileManager *fileManager;
    NSString *fullPath;
    NSFileHandle *fileHandle;
}

@end

@implementation FirstViewController

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
    // Do any additional setup after loading the view from its nib.
    self.userPasswordText.secureTextEntry = YES;
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath=[paths objectAtIndex:0];
    fileManager =[NSFileManager defaultManager];
    fileHandle =[NSFileHandle fileHandleForUpdatingAtPath:[filePath stringByAppendingPathComponent:@"userLogin.txt"]];
    
    [fileManager changeCurrentDirectoryPath:filePath];
    fullPath = [NSString stringWithFormat:@"%@",[filePath stringByAppendingPathComponent:@"userLogin.txt"]];}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInButton:(id)sender {
    BOOL fileExist = [[NSFileManager defaultManager]fileExistsAtPath:fullPath];
    if (!fileExist) {
        UIAlertView *infor=[[UIAlertView alloc]initWithTitle:@"Vaild username or password" message:@"Please try again or set your username and password" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [infor show];
    }
    else{
        fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:fullPath];
        NSString *stringFromFile = [NSString stringWithContentsOfFile:fullPath encoding:NSASCIIStringEncoding error:nil];
        const char *charsFromFile = [stringFromFile UTF8String];
        
        NSString *userNameFromFile = [[NSString alloc]init];
        NSString *userPasswordFromFile = [[NSString alloc]init];
        
        int count=0;
        for (int i = 0; i< strlen(charsFromFile); i++) {
            if (charsFromFile[i]=='\n') {
                count++;
            }
            else if (count==0)
            {
                userNameFromFile = [userNameFromFile stringByAppendingString:[NSString stringWithFormat:@"%c",charsFromFile[i]]];
            }
            else
            {
                userPasswordFromFile = [userPasswordFromFile stringByAppendingString:[NSString stringWithFormat:@"%c",charsFromFile[i]]];
                
            }
            
            
        }
        //NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
        
        //BOOL isAccepted = [standardUserDefaults boolForKey:@"iHaveAcceptedTheTerms"];
        
        if ([userNameFromFile isEqualToString:self.userNameText.text] && [userPasswordFromFile isEqualToString:self.userPasswordText.text]) {
            
            //if (!isAccepted) {
            ViewController *pvc=[[ViewController alloc]init];
            [self presentViewController:pvc animated:YES completion:nil];
            //[standardUserDefaults setBool:YES forKey:@"iHaveAcceptedTheTerms"];
            // }
            //else{
            //   SignUpViewController *svc = [[SignUpViewController alloc]init];
            //
            //    [self presentViewController:svc animated:YES completion:nil];
            // }
            
            
        }
        else
        {
            UIAlertView *infor = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Username or password is incorrect" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [infor show];
            _userNameText.text = @"";
            _userPasswordText.text = @"";
            
        }
        
        
    }

}

- (IBAction)signUpButton:(id)sender {SignUpViewController *svc = [[SignUpViewController alloc]init];
    [self presentViewController:svc animated:YES completion:nil];

}


@end
