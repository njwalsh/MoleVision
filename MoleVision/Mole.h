//
//  Mole.h
//  Mole Vision
//
//  Created by Nick Walsh on 2013-06-22.
//  Modified by
//  Copyright (c) 2013 Team Up. All rights reserved.
//
//  Changes made:
//
//
//
//  Bugs:
//
//
//

#import <Foundation/Foundation.h>

@interface Mole : NSObject{
    
    NSString *name;
    NSString *folderName;
    NSMutableArray *imagesArray;
    NSMutableArray *timeStamps;
    //NSInteger *risk;
    NSString *comments;
    int countOpen;
    
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *folderName;
@property (nonatomic, retain) NSMutableArray *imagesArray;
@property (nonatomic, retain) NSMutableArray *timeStamps;
@property (nonatomic) NSInteger *risk;
@property (nonatomic, retain) NSString *comments;
@property (nonatomic) int countOpen;

@end
