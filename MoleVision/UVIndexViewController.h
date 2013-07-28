//
//  UVIndexViewController.h
//  UVIndex
//
//  Created by Adrienne Copping on 2013-07-06 on TeamUp.
//  Copyright (c) 2013 Adrienne C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
float latitude;
float longitude;
int indexOfMin = -1;

@interface UVIndexViewController : UIViewController <CLLocationManagerDelegate>{
   // NSArray *locationsArray;  //add to create the array variable
    NSArray *miniLocationsArray;
    NSArray *miniWeatherArray;
}

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *closestUVLabel;

- (IBAction)getCurrentUVIndex:(id)sender;
- (IBAction)weatherButton:(id)sender;



@end
