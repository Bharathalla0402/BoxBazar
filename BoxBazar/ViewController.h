//
//  ViewController.h
//  BoxBazar
//
//  Created by bharat on 20/07/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate,NSURLSessionDelegate,UISearchBarDelegate,CLLocationManagerDelegate>
{
    NSMutableArray *DataArray,*DataArray1,*DataArray2;
    NSMutableArray *AmountArray,*AmountArray1,*AmountArray2;
    UIScrollView *categoryScrollView;
    
    NSMutableArray *arrCitys;
    NSString *isInternetConnectionAvailable;
    
    
    CLLocationManager *locationManager;
    CLGeocoder *ceo;
    CLPlacemark *currentLocPlacemark;
}

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
@property NSUInteger pageIndex;
@property NSString *titleText;

@property (weak, nonatomic) IBOutlet UIButton *SearchButt;
@property (weak, nonatomic) IBOutlet UISearchBar *CustomSearchbar;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *CrossButt;

@property (weak, nonatomic) IBOutlet UIView *leftview;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *dohaButt;
@property (strong, nonatomic) UIWindow *window;

@end

