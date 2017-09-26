//
//  CarNameViewController.h
//  BoxBazar
//
//  Created by bharat on 05/08/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
#import <CoreLocation/CoreLocation.h>

@interface CarNameViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,kDropDownListViewDelegate,UISearchBarDelegate,CLLocationManagerDelegate>
{
    NSMutableArray *arrCarslist;
    IBOutlet UITableView *tabl;
    IBOutlet UITableView *tablf;
    
     IBOutlet UIButton *favoritebutt;
    IBOutlet UIButton *favoritebutt2;
    
    NSString *strminRange;
    NSString *strmaxrange;
    
    NSMutableArray *arrcategeoryfilterby;
    
    DropDownListView * Dropobj;
    
    CLLocationManager *locationManager;
    CLGeocoder *ceo;
    CLPlacemark *currentLocPlacemark;

}
@property(nonatomic,strong)NSMutableArray *arryDatalistids;

@property (strong, nonatomic) UIAlertController *alertCtrl;
@property(nonatomic,strong)NSMutableArray *arryData;
@property (strong, nonatomic) UISearchController *searchController;
@property(nonatomic,retain) NSArray *arrDataList;
@property(nonatomic,retain) NSString *strmodule;
@property(nonatomic,retain) NSString *strname;
@property(nonatomic,retain) NSString *strpage;
@property(nonatomic,retain) NSString *strKMS;
@property(nonatomic,retain) NSString *strPrice;
@property(nonatomic,retain) NSString *strYear;
@property(nonatomic,retain) NSString *strCategeoryid;
@end
