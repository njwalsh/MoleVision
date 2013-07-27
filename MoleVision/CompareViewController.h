//
//  CompareViewController.h
//  Mole Vision
//
//  Created by Nick Walsh on 2013-06-22.
//  Modified by
//  Copyright (c) 2013 Team Up. All rights reserved.
//
//  Changes made
//
//
//
//  Bugs:
//
//
//

#import <UIKit/UIKit.h>

@interface CompareViewController : UIViewController{

    UIImage * image1;
    UIImage * image2;
    
}

@property (strong, nonatomic) UIImage * image1;
@property (strong, nonatomic) UIImage * image2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@end
