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
@synthesize label;

@synthesize editMOleBUtton;

- (IBAction) doEditMOleButton {
    NSLog(@"edit mole");
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
    
    //How many oages do we want
    int pageCount = 3;
    
    //set up scroll view
    UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    scroller.backgroundColor = [UIColor clearColor];
    scroller.pagingEnabled = YES;
    scroller.contentSize = CGSizeMake(pageCount * scroller.bounds.size.width, scroller.bounds.size.height);
    
    //set up each view size
    CGRect viewSize = scroller.bounds;
    
    //set up and add images
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:viewSize];
    [imgView setImage:[UIImage imageNamed:@"pic1.jpg"]];
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
    
    [self.view addSubview:scroller];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
