//
//  PickTextViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 14/09/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVPlaceSearchTextField.h"
#import <CoreLocation/CoreLocation.h>

@interface PickTextViewController : UIViewController<PlaceSearchTextFieldDelegate,CLLocationManagerDelegate>
{
     CLLocationManager *locationManager;
    float			latitude;
    float			longitude;
}

@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *searchDropRef;

@end
