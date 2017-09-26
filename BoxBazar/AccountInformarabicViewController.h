//
//  AccountInformarabicViewController.h
//  BoxBazar
//
//  Created by bharat on 29/08/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AccountInformarabicViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *ceo;
    CLPlacemark *currentLocPlacemark;
    
    NSString *strcountrycode;
}

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (strong, nonatomic) UIAlertController *alertCtrl;
@property (strong, nonatomic) UIImagePickerController *imagePicker;

@end
