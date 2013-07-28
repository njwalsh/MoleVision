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
@synthesize checkConfirm;
@synthesize checkSetPass;
@synthesize checkSetUser;

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
        UIImage * no = [UIImage imageNamed:@"xxx.png"];
        [checkSetUser setImage:no];
        _setUserName.text = @"";
        _setPassword.text = @"";
        _confirmPassword.text = @"";
        
    }else{
        UIImage * yes = [UIImage imageNamed:@"yyy.png"];
        [checkSetUser setImage:yes];
        if([password isEqualToString:self.confirmPassword.text]&&([password length]>=7)){
            NSDate *now = [NSDate date];
            NSLog(@"now: %@", now); // now: 2011-02-28 09:57:49 +0000
            NSString *strDate = [[NSString alloc] initWithFormat:@"%@",now];
            NSArray *arr = [strDate componentsSeparatedByString:@" "];
            NSString *str;
            str = [arr objectAtIndex:0];
            alarmData111 = [[NSString alloc]initWithString:str];
            NSLog(@"Set Start date :%@",alarmData111);

            NSString *userNameAndPasswordString = [NSString stringWithFormat:@"%@\n%@\n%@",self.setUserName.text,self.setPassword.text,alarmData111];
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
            UIImage * yes = [UIImage imageNamed:@"yyy.png"];
            UIImage * no = [UIImage imageNamed:@"xxx.png"];
            [checkSetUser setImage:yes];
            [checkSetPass setImage:no];
            [checkConfirm setImage:no];
            _setPassword.text = @"";
            _confirmPassword.text = @"";
        
        }
        else{
            
            UIAlertView *warning = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Password doesn't match,Please enter again!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [warning show];
            UIImage * yes = [UIImage imageNamed:@"yyy.png"];
            UIImage * no = [UIImage imageNamed:@"xxx.png"];
            [checkSetUser setImage:yes];
            [checkSetPass setImage:no];
            [checkConfirm setImage:no];

            
            _setPassword.text = @"";
            _confirmPassword.text = @"";
            
            
            
            
        }}
}


- (IBAction)tapp:(id)sender {
    [_setUserName resignFirstResponder];
    [_setPassword resignFirstResponder];
    [_confirmPassword resignFirstResponder];

}


@end
