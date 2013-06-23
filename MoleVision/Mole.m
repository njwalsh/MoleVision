//
//  Mole.m
//  Mole Vision
//
//  Created by Nick Walsh on 2013-06-22.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import "Mole.h"

@implementation Mole

@synthesize imagesArray;
@synthesize risk;
@synthesize comments;

- (id) init{
    
    self = [super init];
    imagesArray = [[NSMutableArray alloc] init];
    return self;
}

@end
