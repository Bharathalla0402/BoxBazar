//
//  AppDelegate.h
//  BoxBazar
//
//  Created by bharat on 20/07/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *ceo;
    CLPlacemark *currentLocPlacemark;
    CLLocation *currentLocation;
}
@property (strong, nonatomic) UIWindow *window;

@end

    
