//
//  PickArabicViewController.h
//  BoxBazar
//
//  Created by bharat on 13/02/17.
//  Copyright © 2017 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVPlaceSearchTextField.h"
#import <CoreLocation/CoreLocation.h>

@interface PickArabicViewController : UIViewController<PlaceSearchTextFieldDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    float			latitude;
    float			longitude;
}

@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *searchDropRef;
@end
