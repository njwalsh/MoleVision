//
//  SignUpViewController.m
//  loginAndProfile
//
//  Created by xin ji on 2013-06-22.
//  Copyright (c) 2013 Team UP. All rights reserved.
//

#import "SignUpViewController.h"
#import "FirstViewController.h"

@interface SignUpViewController (){
    NSFileManager *fileManager;
    NSString *fullpath;
    NSFileHandle *filehandle;
}

@end

@implementation SignUpViewController

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
    self.setPassword.secureTextEntry = YES;
    self.confirmPassword.secureTextEntry = YES;    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath=[paths objectAtIndex:0];
    
    fileManager =[NSFileManager defaultManager];
    filehandle =[NSFileHandle fileHandleForUpdatingAtPath:[filePath stringByAppendingPathComponent:@"userLogin.txt"]];
    
    [fileManager changeCurrentDirectoryPath:filePath];
    fullpath = [NSString stringWithFormat:@"%@",[filePath stringByAppendingPathComponent:@"userLogin.txt"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)validateEmail:(NSString *)emailStr{
    NSString *emailegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailegex];
    return [emailTest evaluateWithObject:emailStr];
}

- (IBAction)signUpButton:(id)sender {
    BOOL fileExist = [[NSFileManager defaultManager]fileExistsAtPath:fullpath];
    
    if (!fileExist) {
        [fileManager createFileAtPath:fullpath contents:nil attributes:nil];
    }
    NSString *password = self.setPassword.text;
    NSString *userName = self.setUserName.text;
    
    //if ([userName isEqualToString:@""]) {
    if(![self validateEmail:userName]){
        UIAlertView *noUserName = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please enter Correct Email Address" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [noUserName show];
        _setUserName.text = @"";
        _setPassword.text = @"";
        _confirmPassword.text = @"";
        
    }else{
        if([password isEqualToString:self.confirmPassword.text]&&([password length]>=7)){
            
            NSString *userNameAndPasswordString = [NSString stringWithFormat:@"%@\n%@",self.setUserName.text,self.setPassword.text];
            filehandle = [NSFileHandle fileHandleForUpdatingAtPath:fullpath];
            NSData *data;
            const char *bytesOfUserNameAndPassword = [userNameAndPasswordString UTF8String];
            data = [NSData dataWithBytes:bytesOfUserNameAndPassword length:strlen(bytesOfUserNameAndPassword)];
            [data writeToFile:fullpath atomically:YES];
            
            UIAlertView *infor = [[UIAlertView alloc]initWithTitle:@"Finished Setting" message:@"Thank you for Signing Up" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [infor show];
            [self performSegueWithIdentifier:@"SignUpToProflie" sender:nil];
           
        }
        else if ([password length]<7){
            UIAlertView *infor1 = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Password must have a length greater than 7" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [infor1 show];
            _setPassword.text = @"";
            _confirmPassword.text = @"";
        
        }
        else{
            
            UIAlertView *warning = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Password doesn't match,Please enter again!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [warning show];
            
            _setPassword.text = @"";
            _confirmPassword.text = @"";
            
            
            
            
        }}
}


@end
