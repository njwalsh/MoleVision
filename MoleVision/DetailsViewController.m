//
//  DetailsViewController.m
//  SearchBarTutorial
//
//  Created by Nick Walsh on 2013-06-21.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import "DetailsViewController.h"
#import <ImageIO/ImageIO.h>
#import "ZipArchive.h"

@interface ImageView : UIImageView

@property (strong, nonatomic) UIImage * imageToCompare;

@end

@implementation ImageView
@synthesize imageToCompare;

- (void)viewDidLoad{
    imageToCompare = [[UIImage alloc] init];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [[event allTouches] anyObject];
    ImageView * tempImgView = (ImageView *)touch.view;
    imageToCompare = (UIImage *)tempImgView.image;
    NSLog(@"selected image: %@", imageToCompare);
}
@end

@interface DetailsViewController ()
@property (strong, nonatomic) ImageView *imgView;
@end


@implementation DetailsViewController
@synthesize label, comment;
@synthesize timeStamp;
@synthesize moleRow;
@synthesize pageCount;
@synthesize editMoleButton;
@synthesize addPictureButton;
@synthesize scroller;
@synthesize tmpImagesArray;
@synthesize imgView;

-(IBAction)emailPhotos{
    // Zipping files function: begin
    // Gets temporary mole information
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"moleArray"]];
    NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    Mole *tempMole = [decodedArray objectAtIndex:moleRow];
    
    // Getting directory paths
    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [documentPath objectAtIndex:0];  // Getting Documents folder
    NSLog(@"documentFolder: %@", documentFolder);
    NSString *filePath = [documentFolder stringByAppendingPathComponent:tempMole.folderName];      // Getting Documents/tempMole.folderName folder
    NSLog(@"tempMole.folderName: %@", tempMole.folderName);
    
    // Getting all foldters
    NSString *bundleRoot = [[NSBundle bundleWithPath:filePath] bundlePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:bundleRoot error:nil];
    NSLog(@"dirContents: %@", dirContents);    // Shows ALL files in tempMole.folder
    
    // Finding files with .jpeg extension
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"self ENDSWITH '.jpeg'"];
    NSArray *jpegs = [dirContents filteredArrayUsingPredicate:filter];
    NSLog(@"%@", jpegs);        // Shows ONLY files with .jpeg extension in tempMole.folder
    
    NSString *folderTitle = [filePath stringByAppendingPathComponent:tempMole.folderName];
    NSString *zipFile = [folderTitle stringByAppendingPathComponent:@".zip"];
    
    ZipArchive *za = [[ZipArchive alloc] init];
    [za CreateZipFile2:zipFile];
    
    for (int i = 0; i < [jpegs count]; i++) {
        NSString *data = [jpegs objectAtIndex:i];
        NSString *imagePath = [filePath stringByAppendingPathComponent:data];
        //NSLog(@"%d", i);
        [za addFileToZip:imagePath newname:data];
    }
    
    BOOL success = [za CloseZipFile2];
    NSLog(@"Zipped file with result %d",success);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Zipped." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
    // Zipping files function: end
    
    
    // Emailing files
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    [composer setMailComposeDelegate:self];
    if ([MFMailComposeViewController canSendMail])
    {
        // Basic email fields
        [composer setToRecipients: [NSArray arrayWithObjects:@"abc@123.com", nil]];
        [composer setSubject:@"Subject here"];
        [composer setMessageBody:@"Message here" isHTML:NO];
        [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:composer animated:YES completion:nil];
        
        // Attaching .zip file to email
        NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentFolder = [documentPath objectAtIndex:0];      // Documents folder
        NSString *filePath = [documentFolder stringByAppendingPathComponent:tempMole.folderName];       // Documents/folderName folder
        NSString *zipName = [filePath stringByAppendingPathComponent:@".zip"];                          // folderName.zip
        [composer addAttachmentData:[NSData dataWithContentsOfFile:filePath] mimeType:@"application/zip" fileName:zipName]; // Writes folderName.zip to folderName folder
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
    
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Result: sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: failed");
            break;
        default:
            NSLog(@"Result: not sent");
            break;
    }
}

-(IBAction)ChooseExisting{
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)showCameraUI {
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.delegate = self;
    cameraUI.allowsEditing = YES;
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:cameraUI animated:YES completion:NULL];
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"moleArray"]];
    NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    Mole *tempMole = [decodedArray objectAtIndex:moleRow];
    
    // Creating date format
    NSDate *myDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    NSString *dateString = [dateFormatter stringFromDate:myDate];
    
    // Create name of photo using current timestamp
    NSString *photoName = [dateString stringByAppendingString:@".jpeg"];
    
    // Getting folder within Documents
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:tempMole.folderName];
    
    // Save picture to existing folder
    NSString *savedImagePath = [dataPath stringByAppendingPathComponent:photoName];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    [imageData writeToFile:savedImagePath atomically:NO];
    
    NSError * error = nil;
    [imageData writeToFile:savedImagePath options:NSDataWritingAtomic error:&error];
    
    if (error != nil) {
        NSLog(@"Error: %@", error);
        return;
    }

    
    //add image to mole imageArray
    [tempMole.imagesArray addObject:image];
    
    //calculate time stamp and add
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    [tempMole.timeStamps addObject:components];
    
    //save mole
    NSMutableArray * tempArr = [[NSMutableArray alloc] initWithArray:decodedArray];
    [tempArr replaceObjectAtIndex:moleRow withObject:tempMole];
    
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:tempArr];
    [userDefault setObject:myEncodedObject forKey:[NSString stringWithFormat:@"moleArray"]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        
        addPictureButton.enabled = NO; // 'Add Picture' button disabled if camera is not available.
        
    }
	
    self.label.text = [NSString stringWithFormat:@"%@", self.sendLabel];
    
    /*//How many pages do we want
    pageCount = 3;
    
    //set up scroll view
    UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    scroller.backgroundColor = [UIColor clearColor];
    scroller.pagingEnabled = YES;
    scroller.contentSize = CGSizeMake(pageCount * scroller.bounds.size.width, scroller.bounds.size.height);
    
    //set up each view size
    CGRect viewSize = scroller.bounds;
    
    //set up and add images
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:viewSize];
    [imgView setImage:[UIImage imageNamed:@"photo(11).JPG"]];
    [scroller addSubview:imgView];
    
    //offset view size
    viewSize = CGRectOffset(viewSize, scroller.bounds.size.width, 0);
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:viewSize];
    [imgView2 setImage:[UIImage imageNamed:@"pic2.jpg"]];
    [scroller addSubview:imgView2];
    
    //offset view size
    viewSize = CGRectOffset(viewSize, scroller.bounds.size.width, 0);
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:viewSize];
    [imgView3 setImage:[UIImage imageNamed:@"pic3.jpg"]];
    [scroller addSubview:imgView3];
    
    [self.view addSubview:scroller];*/
}

- (void) viewDidAppear:(BOOL)animated{
    
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"moleArray"]];
    NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    
    Mole *tempMole = [decodedArray objectAtIndex:moleRow];
    label.text = tempMole.name;
    comment.text = tempMole.comments;
    
    NSString *year = [NSString stringWithFormat:@"%ld", (long)[[tempMole.timeStamps objectAtIndex:0] year]];
    NSString *month = [NSString stringWithFormat:@"%ld", (long)[[tempMole.timeStamps objectAtIndex:0] month]];
    NSString *day = [NSString stringWithFormat:@"%ld", (long)[[tempMole.timeStamps objectAtIndex:0] day]];
    NSString *strFromComponents = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    timeStamp.text = strFromComponents;
    
    [self displayMoleImages:tempMole];
    
    [imgView setImageToCompare:[tempMole.imagesArray objectAtIndex:0]];
}

- (void)displayMoleImages:(Mole *)tmpMole{
    tmpImagesArray = [[NSArray alloc] initWithArray:tmpMole.imagesArray];
    [scroller removeFromSuperview];
    pageCount = [tmpMole.imagesArray count];
    
    //set up scroll view
    scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    scroller.delegate = self;
    scroller.backgroundColor = [UIColor clearColor];
    scroller.pagingEnabled = YES;
    scroller.contentSize = CGSizeMake(pageCount * scroller.bounds.size.width, scroller.bounds.size.height);
    [scroller setDelaysContentTouches:YES];
    
    CGRect viewSize = scroller.bounds;
    
    for (int i = 0; i < [tmpImagesArray count]; i++) {
        if(i != 0){
            viewSize = CGRectOffset(viewSize, scroller.bounds.size.width, 0);
        }
        
        UIImage * tempImage = [tmpImagesArray objectAtIndex:i];
        
        /*//get timestamp from image if possible
        NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(tempImage, 0.0)];
        CFDataRef imgDataRef = (__bridge CFDataRef)imageData;
        CGImageSourceRef *imageSource = CGImageSourceCreateWithData(imgDataRef, NULL);
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], (NSString *)kCGImageSourceShouldCache,nil];
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, (CFDictionaryRef)CFBridgingRetain(options));
        CFDictionaryRef exifDic = CFDictionaryGetValue(imageProperties, kCGImagePropertyExifDictionary);
        if(exifDic){
            NSString *timestamp = (NSString *)CFBridgingRelease(CFDictionaryGetValue(exifDic, kCGImagePropertyExifDateTimeOriginal));
            if(timestamp){
                NSLog(@"timestamp: %@", timestamp);
            }else{
                NSLog(@"timestamp not found in the exif dic %@", exifDic);
            }
        }else{
            NSLog(@"exifDic nil for imageProperties %@", imageProperties);
        }
        CFRelease(imageProperties);*/
        
        //initialize ImageView to pass to ComapreView
        imgView = [[ImageView alloc] initWithFrame:viewSize];
        [imgView setImage:tempImage];
        [imgView setUserInteractionEnabled:YES];
        
        [scroller addSubview:imgView];
    }
    
    [self.view addSubview:scroller];
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scroller.contentOffset.x / scroller.frame.size.width;
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"moleArray"]];
    NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    
    Mole *tempMole = [decodedArray objectAtIndex:moleRow];
    NSString *year = [NSString stringWithFormat:@"%ld", (long)[[tempMole.timeStamps objectAtIndex:page] year]];
    NSString *month = [NSString stringWithFormat:@"%ld", (long)[[tempMole.timeStamps objectAtIndex:page] month]];
    NSString *day = [NSString stringWithFormat:@"%ld", (long)[[tempMole.timeStamps objectAtIndex:page] day]];
    NSString *strFromComponents = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    timeStamp.text = strFromComponents;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    /*NSLog(@"touch");
    UITouch * touch = [[event allTouches] anyObject];
    for (int i = 0; i < [tmpImagesArray count]; i++) {
        if([touch view] == [tmpImagesArray objectAtIndex:i]){
            NSLog(@"%@", [tmpImagesArray objectAtIndex:i]);
        }
    }*/
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"edit"]){
        EditViewController *evc = segue.destinationViewController;
        //NSIndexPath *indexPath = nil;
        
        evc.sendMoleLabel = self.sendLabel;
        evc.moleIndex = self.moleRow;
    }else if ([segue.identifier isEqualToString:@"compare"]){
        CompareViewController *cvc = segue.destinationViewController;
        
        NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
        NSData *myDecodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"moleArray"]];
        NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
        
        Mole *tempMole = [decodedArray objectAtIndex:moleRow];
        
        cvc.image1 = [tempMole.imagesArray objectAtIndex:0];
        NSLog(@"imageToCompare: %@", cvc.image1);
        NSLog(@"imageToCompare: %@", imgView.imageToCompare);
        cvc.image2 = imgView.imageToCompare;
    }
}

@end
