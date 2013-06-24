//
//  Mole.h
//  Mole Vision
//
//  Created by Nick Walsh on 2013-06-22.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mole : NSObject{
    
    NSString *name;
    NSMutableArray *imagesArray;
    NSInteger *risk;
    NSString *comments;
    
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *imagesArray;
@property (nonatomic) NSInteger *risk;
@property (nonatomic, retain) NSString *comments;

@end
