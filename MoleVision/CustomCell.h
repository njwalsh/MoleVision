//
//  CustomCell.h
//  SearchBarTutorial
//
//  Created by Nick Walsh on 2013-06-22.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *moleLable;
@property (weak, nonatomic) IBOutlet UILabel *numOfImages;
@property (weak, nonatomic) IBOutlet UIImageView *moleImageView;

@end
