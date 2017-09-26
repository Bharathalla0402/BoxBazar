//
//  CarDescriptionViewController.h
//  BoxBazar
//
//  Created by bharat on 02/09/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"
@import GoogleMaps;

@interface CarDescriptionViewController : UIViewController<MKMapViewDelegate,GMSMapViewDelegate>
{
    GMSMapView *mapview;
    float			latitude;
    float			longitude;
    GMSMarker *marker;
}
@property(nonatomic,retain) NSDictionary *strDataArray;
@property(nonatomic,retain) NSString *strtitle;
@property(nonatomic,retain) NSArray *strUrls;
@property(nonatomic,retain) NSString *strurlparameter;

@end
