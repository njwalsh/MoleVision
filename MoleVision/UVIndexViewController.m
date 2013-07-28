//
//  UVIndexViewController.m
//  UVIndex
//
//  Created by Adrienne Copping on 2013-07-06 TeamUp.
//  Copyright (c) 2013 Adrienne Copping. All rights reserved.
//  Does not yet handel errors such as network error or unable to find location?
//

#import "UVIndexViewController.h"

@interface UVIndexViewController ()

@end


@implementation UVIndexViewController
{
    CLLocationManager *locationManager; //declares instance var named locationManager
    CLGeocoder *geocoder; //initialized in viewDidLoad
    CLPlacemark *placemark;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any latadditional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    
    miniLocationsArray = [[NSArray alloc] initWithObjects: @"Vancouver", @"Victoria", @"Yellowknife", @"Kamloops", @"Banff",nil];
    
    miniWeatherArray = [[NSArray alloc] initWithObjects: @"http://www.theweathernetwork.com/forecasts/uv/canada/british-columbia/vancouver", @"http://www.theweathernetwork.com/forecasts/uv/canada/british-columbia/victoria", @"http://www.theweathernetwork.com/forecasts/uv/canada/northwest-territories/yellowknife" @"http://www.theweathernetwork.com/forecasts/uv/canada/british-columbia/kamloops", @"http://www.theweathernetwork.com/forecasts/uv/canada/alberta/banff", nil];
    
    /*
    //works!
    locationsArray = [[NSArray alloc]initWithObjects: @"Iqaluit", @"Resolute", @"Inuvik", @"Rankin Inlet", @"Whitehorse", @"Nanimo", @"Port Hardy", @"Prince Rupert", @"Kelowna", @"Prince George", @"Cranbrook", @"Caslegar", @"Edmonton", @"Calgary", @"Lethbridge", @"Red Deer", @"Medicine Hat", @"Grande Prairie", @"Saskatoon", @"Regina", @"Yorkton", @"Thompson", @"Windsor", @"Toronto", @"Barrie", @"London", @"Ottawa", @"Kingstong", @"Montreal", @"Sherbrooke", @"Quebec", @"Ste-Adele", @"Fredericton", @"Saint John NB", @"Sydney", @"Halifax", @"Charlottetown", @"St. John's NF", @"Goose Bay", nil];
    }*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCurrentUVIndex:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    // Stop Location Manager
    [locationManager stopUpdatingLocation];
    
    // Reverse Geocoding, sends to server which contains code to get address
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            _addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@",
                                 placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country];
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
       
        float minDistance = 1000000000.00;
        
        
       // initialize the latitude and longitude arrays
        
        float *latArray;
        latArray = (float *)malloc(5 * sizeof(float));
        latArray[0] = 49.28;
        latArray[1] = 48.43;
        latArray[2] = 62.46;
        latArray[3] = 50.68;
        latArray[4] = 51.17;
        
        
        float *lonArray;
        lonArray = (float *)malloc(5 * sizeof(float));
        lonArray[0] = -123.10;
        lonArray[1] = -123.40;
        lonArray[2] = -114.40;
        lonArray[3] = -120.30;
        lonArray[4] = -115.60;

        //for(int i = 0; i < 45; i++){
        
        for(int i = 0; i < 5; i++){
            latitude = latArray[i];
            longitude = lonArray[i];
            CLLocation *cityLocation = [[CLLocation alloc] initWithLatitude: latitude longitude: longitude];
            
            CLLocationDistance calculatedDistance = [currentLocation distanceFromLocation:cityLocation];
            NSLog(@"%f", calculatedDistance);
            if(calculatedDistance < minDistance){
                minDistance = calculatedDistance;
                indexOfMin = i;
            }
        }
        
        NSLog(@"%f", minDistance);
        NSLog(@"%d", indexOfMin);
        
        //print the city at minIndex in the console log
        NSLog(@"%@",[miniLocationsArray objectAtIndex:indexOfMin]);
        
        //displays the name of the closest Canadian city that has UV info
        _closestUVLabel.text = [miniLocationsArray objectAtIndex:indexOfMin];
        
        //frees the array of latitudes and longitudes
        free(latArray);
        free(lonArray);
        
    } ];
}

- (IBAction)weatherButton:(id)sender {
    if(indexOfMin >= 0){
        NSString *city = [miniWeatherArray objectAtIndex:indexOfMin];
        [[UIApplication sharedApplication] openURL:
         [NSURL URLWithString:city]];
    }
}

@end
