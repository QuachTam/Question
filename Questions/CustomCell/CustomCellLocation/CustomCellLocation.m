//
//  CustomCellLocation.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/25/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "CustomCellLocation.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "Common.h"

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface CustomCellLocation()<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    CLLocationCoordinate2D oldCoordinate2D;
}

@end
@implementation CustomCellLocation

- (void)awakeFromNib {
    // Initialization code
    if (!locationManager) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        geocoder = [[CLGeocoder alloc] init];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)actionGetLocation:(id)sender {
    if (SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(@"8.0")) {
        [locationManager requestWhenInUseAuthorization];
    }
    locationManager.delegate = self;
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
    if (currentLocation != nil) {
        self.stringLong.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.stringLat.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            NSMutableArray *arrayAddress = [NSMutableArray new];
            [self addObject:placemark.subThoroughfare array:arrayAddress];
            [self addObject:placemark.thoroughfare array:arrayAddress];
            [self addObject:placemark.postalCode array:arrayAddress];
            [self addObject:placemark.locality array:arrayAddress];
            [self addObject:placemark.administrativeArea array:arrayAddress];
            [self addObject:placemark.country array:arrayAddress];
            
            self.address.text = [arrayAddress componentsJoinedByString:@" - "];
            [self.address sizeToFit];
            
            if (self.didClickGetCurrentLocation) {
                self.didClickGetCurrentLocation(nil, nil, self.address.text);
            }
        } else {
            NSLog(@"%@", error.debugDescription);
        }
        locationManager.delegate = nil;
    } ];
    if (self.didClickGetCurrentLocation) {
        self.didClickGetCurrentLocation(self.stringLat.text, self.stringLong.text, nil);
    }
}

- (NSMutableArray*)addObject:(id)object array:(NSMutableArray*)array{
    if (object) {
        [array addObject:object];
    }
    return array;
}
@end
