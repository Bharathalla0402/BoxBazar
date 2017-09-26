//
//  LoginandRegisterViewController.h
//  BoxBazar
//
//  Created by bharat on 27/07/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>
@class GPPSignIn;
@class GPPSignInButton;
@class GIDSignInButton;
#import <GoogleSignIn/GoogleSignIn.h>
@interface LoginandRegisterViewController : UIViewController<UITextFieldDelegate,GIDSignInDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *ceo;
    CLPlacemark *currentLocPlacemark;
    CLLocation *currentLocation;
    
    GPPSignIn *signIng;
    
    UIImage *Image_Google;
    
    NSString *First_Name_Google;
    
    NSString *Last_Name_Google;
    
    NSString *Email_Google;
    
    GIDSignInButton *signInButton;
}
@property (strong, nonatomic)NSString *str,*strNmae;
@property(nonatomic,retain) NSString *strccode;

//@property(weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@end
