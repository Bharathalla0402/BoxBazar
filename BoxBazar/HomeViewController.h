//
//  HomeViewController.h
//  BoxBazar
//
//  Created by bharat on 26/08/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface HomeViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate,NSURLSessionDelegate,UISearchBarDelegate>
{
    NSMutableArray *DataArray,*DataArray1,*DataArray2;
    NSMutableArray *AmountArray,*AmountArray1,*AmountArray2;
    UIScrollView *categoryScrollView;
    
    NSMutableArray *arrCitys;
     NSString *isInternetConnectionAvailable;
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


@end
