//
//  Mole.m
//  Mole Vision
//
//  Created by Nick Walsh on 2013-06-22.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import "Mole.h"

@implementation Mole

@synthesize name;
@synthesize imagesArray;
//@synthesize risk;
@synthesize comments;
@synthesize countOpen;

- (id) init{
    
    self = [super init];
    imagesArray = [[NSMutableArray alloc] init];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.imagesArray forKey:@"images"];
    //[encoder encodeObject:self.risk forKey:@"risk"];
    [encoder encodeObject:self.comments forKey:@"comments"];
    [encoder encodeObject:[NSNumber numberWithInt:self.countOpen] forKey:@"destinationCode"];
    
}

@end
