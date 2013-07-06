//
//  DetailsViewController.m
//  SearchBarTutorial
//
//  Created by Nick Walsh on 2013-06-21.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController
@synthesize label, comment;
@synthesize moleRow;
@synthesize pageCount;
@synthesize editMoleButton;
@synthesize addPictureButton;

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
    NSLog(@"imgpicker %lu", (unsigned long)[tempMole.imagesArray count]);
    
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
    
    [self displayMoleImages:tempMole];
    NSLog(@"%lu", (unsigned long)[tempMole.imagesArray count]);
}

- (void)displayMoleImages:(Mole *)tmpMole{
    NSArray * tmpImagesArray = [[NSArray alloc] initWithArray:tmpMole.imagesArray];
    
    pageCount = [tmpMole.imagesArray count];
    
    //set up scroll view
    UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    scroller.backgroundColor = [UIColor clearColor];
    scroller.pagingEnabled = YES;
    scroller.contentSize = CGSizeMake(pageCount * scroller.bounds.size.width, scroller.bounds.size.height);
    
    CGRect viewSize = scroller.bounds;
    
    for (int i = 0; i < [tmpImagesArray count]; i++) {
        if(i != 0){
            viewSize = CGRectOffset(viewSize, scroller.bounds.size.width, 0);
        }
        
        UIImage * tempImage = [tmpImagesArray objectAtIndex:i];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:viewSize];
        [imgView setImage:tempImage];
        [scroller addSubview:imgView];
    }
    
    [self.view addSubview:scroller];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"edit"]){
        EditViewController *evc = segue.destinationViewController;
        //NSIndexPath *indexPath = nil;
        
        evc.sendMoleLabel = self.sendLabel;
        evc.moleIndex = self.moleRow;
    }
}

@end
