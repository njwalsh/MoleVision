//
//  DetailsViewController.m
//  SearchBarTutorial
//
//  Created by Nick Walsh on 2013-06-21.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import "DetailsViewController.h"
#import <ImageIO/ImageIO.h>

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

-(IBAction)ChooseExisting{
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //add image to mole imageArray
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"moleArray"]];
    NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    Mole *tempMole = [decodedArray objectAtIndex:moleRow];
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
