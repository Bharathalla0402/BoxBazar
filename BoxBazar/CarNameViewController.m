//
//  CarNameViewController.m
//  BoxBazar
//
//  Created by bharat on 05/08/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "CarNameViewController.h"
#import "ApiRequest.h"
#import "MotorCategeoryTableViewCell.h"
#import "MotorCategeoryTableViewCell2.h"
#import "MARKRangeSlider.h"
#import "CarDescriptionViewController.h"
#import "UIImageView+WebCache.h"
#import "DejalActivityView.h"
#import "BoxBazarUrl.pch"
#import "DropDownViewCell2.h"

@interface CarNameViewController ()<ApiRequestdelegate>
{
     UILabel *label,*label1,*label2;
    ApiRequest *requested;
    UIView *topview;
    
     int x;
    int count,lastCount;
    
    int scrool;
    
    UIView *popview;
    UIView *footerview;
    UIView *footerview2;
    UIView *filterview;
    
    UILabel *loadLbl;
    
    UIView *premiumAdsView,*pricerangeView,*yearrangeView,*kmsrangeView;
    UILabel *switchstatuslab;
  
    MotorCategeoryTableViewCell *cell;
    MotorCategeoryTableViewCell *cell1;
    
    MotorCategeoryTableViewCell2 *cell2;
    MotorCategeoryTableViewCell2 *cell3;
    
    UIActivityIndicatorView * actInd;
    
    NSString *imagena;
    UIButton *sortbyDatebutt,*sortrecentitemsbutt,*sortrecentitems2butt;
    
    NSArray *arrfueltype;
    NSArray *arrfueltype1;
    NSString *strid;
    int b;
    NSString *stridforpost;
    NSMutableDictionary *carpostdict;
    NSString *jsonStringOptions;
    
    NSString *strids;
    NSArray *arrmake,*arrmodel;
    
    NSString *strmakeids,*strmodelids;
    NSMutableArray *arrMotorList;
    UILabel *labvali;
  //  UILabel *dotlabel;
    
    int arrcarcount;
    
    NSMutableArray *arrPriceRange,*arrYearRange,*arrKmsRange;
    NSString *arrJsonPrice,*arrJsonYear,*arrJsonKms;
    NSString *stroptions,*strSort;
    
    
    NSIndexPath *index,*checkindex;
    NSMutableArray *arrcheckindex;
    
    CLLocationCoordinate2D coordinate;
    
    int m;
}
@property (nonatomic, strong) MARKRangeSlider *rangeSlider;
@property (nonatomic, strong) MARKRangeSlider *rangeSlider1;
@property (nonatomic, strong) MARKRangeSlider *rangeSlider2;

@end

@implementation CarNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    x=1;
    m=1;
    count=1;
    scrool=1;
    lastCount=1;
    carpostdict=[[NSMutableDictionary alloc]init];
    arrcheckindex=[[NSMutableArray alloc]init];
    strids=@"1";
    arrcarcount=1;
    
    self.arryDatalistids=[[NSMutableArray alloc]init];
    
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"pricerange"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"pricerange1"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"pricerange2"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
//    arrJsonPrice=[[NSMutableArray alloc]init];
//    arrJsonYear=[[NSMutableArray alloc]init];
//    arrJsonKms=[[NSMutableArray alloc]init];

    if ([_strmodule isEqualToString:@"car"])
    {
        arrPriceRange=[[NSMutableArray alloc]init];
        arrYearRange=[[NSMutableArray alloc]init];
        arrKmsRange=[[NSMutableArray alloc]init];
        
        NSData *jsonData = [_strPrice dataUsingEncoding:NSUTF8StringEncoding];
        NSError *localError;
        arrPriceRange = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&localError];
        NSLog(@"%@", arrPriceRange);
        
        
        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrPriceRange options:NSJSONWritingPrettyPrinted error:nil ];
        arrJsonPrice = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Price %@",arrJsonPrice);
        
        NSData *jsonData2 = [_strYear dataUsingEncoding:NSUTF8StringEncoding];
        NSError *localError2;
        arrYearRange = [NSJSONSerialization JSONObjectWithData:jsonData2 options: NSJSONReadingMutableContainers error:&localError2];
        NSLog(@"%@", arrYearRange);
        
        NSData* data2 = [ NSJSONSerialization dataWithJSONObject:arrYearRange options:NSJSONWritingPrettyPrinted error:nil ];
        arrJsonYear = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        NSLog(@"Json Year %@",arrJsonYear);
        
        NSData *jsonData3 = [_strKMS dataUsingEncoding:NSUTF8StringEncoding];
        NSError *localError3;
        arrKmsRange = [NSJSONSerialization JSONObjectWithData:jsonData3 options: NSJSONReadingMutableContainers error:&localError3];
        NSLog(@"%@", arrKmsRange);
        
        NSData* data3 = [ NSJSONSerialization dataWithJSONObject:arrKmsRange options:NSJSONWritingPrettyPrinted error:nil ];
        arrJsonKms = [[NSString alloc] initWithData:data3 encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",arrJsonKms);
        
        [[NSUserDefaults standardUserDefaults]setObject:@"sorted" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrPriceRange forKey:@"pricerange"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrYearRange forKey:@"pricerange1"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrKmsRange forKey:@"pricerange2"];
        [[NSUserDefaults standardUserDefaults]synchronize];

    }
    else if ([_strmodule isEqualToString:@"jobs"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"sorted" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else if ([_strmodule isEqualToString:@"community"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"sorted" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else
    {
         arrPriceRange=[[NSMutableArray alloc]init];
        NSData *jsonData = [_strPrice dataUsingEncoding:NSUTF8StringEncoding];
        NSError *localError;
        arrPriceRange = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&localError];
        NSLog(@"%@", arrPriceRange);
        
        [[NSUserDefaults standardUserDefaults]setObject:arrPriceRange forKey:@"pricerange"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"sorted" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    self.definesPresentationContext = NO;
    self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    
    arrCarslist=[[NSMutableArray alloc]init];
    [arrCarslist addObjectsFromArray:_arrDataList];
     self.arryData=[[NSMutableArray alloc]init];
    
    self.searchController.searchBar.delegate = self;
    if ([_strmodule isEqualToString:@"car"])
    {
        arrcategeoryfilterby=[[NSMutableArray alloc]initWithObjects:@"Price",@"year",@"Kilometers Driven",@"Make",@"Model", nil];
    }
    else if ([_strmodule isEqualToString:@"jobs"])
    {
        arrcategeoryfilterby=[[NSMutableArray alloc]init];
    }
    else if ([_strmodule isEqualToString:@"community"])
    {
        arrcategeoryfilterby=[[NSMutableArray alloc]init];
    }
    else
    {
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            if ([_strmodule isEqualToString:@"numberplate"])
            {
                 arrcategeoryfilterby=[[NSMutableArray alloc]initWithObjects:@"Price", nil];
            }
            else if ([_strmodule isEqualToString:@"jobs"])
            {
                arrcategeoryfilterby=[[NSMutableArray alloc]init];
            }
            else if ([_strmodule isEqualToString:@"community"])
            {
                arrcategeoryfilterby=[[NSMutableArray alloc]init];
            }
            else
            {
                  arrcategeoryfilterby=[[NSMutableArray alloc]initWithObjects:@"Price", nil];
            }
        }
        else
        {
            arrcategeoryfilterby=[[NSMutableArray alloc]initWithObjects:@"Price", nil];
        }
    }
   
   
//    arrcategeoryfilterby=[[NSMutableArray alloc]initWithObjects:@"Premium Ads",@"Price Range",@"Brand Name",@"Model",@"Fuel Type",@"Transmission",@"Number of Owners",@"Kms Driven",@"Year of Reg.",@"Localities",@"Car Type",@"Color",@"Posted by",@"Used/New", nil];
    [self customView];
  //  [self initFooterView];
    
     [self setupAlertCtrl];
}
- (void)setupAlertCtrl
{
    
    if ([_strmodule isEqualToString:@"jobs"])
    {
        self.alertCtrl = [UIAlertController alertControllerWithTitle:@"Sort By"
                                                             message:nil
                                                      preferredStyle:UIAlertControllerStyleActionSheet];
        //Create an action
//        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Lowest Price"
//                                                         style:UIAlertActionStyleDefault
//                                                       handler:^(UIAlertAction *action)
//                                 {
//                                     [self LowToHigh];
//                                 }];
//        UIAlertAction *imageGallery = [UIAlertAction actionWithTitle:@"Highest Price"
//                                                               style:UIAlertActionStyleDefault
//                                                             handler:^(UIAlertAction *action)
//                                       {
//                                           [self HighToLow];
//                                       }];
        UIAlertAction *imageGallery1 = [UIAlertAction actionWithTitle:@"Newest"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action)
                                        {
                                            [self Oldest];
                                        }];
        UIAlertAction *imageGallery2 = [UIAlertAction actionWithTitle:@"Oldest"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action)
                                        {
                                            [self Newest];
                                        }];
        UIAlertAction *imageGallery3 = [UIAlertAction actionWithTitle:@"Nearest"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action)
                                        {
                                            [self Nearest];
                                        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction *action)
                                 {
                                     [self dismissViewControllerAnimated:YES completion:nil];
                                 }];
        
//        [self.alertCtrl addAction:camera];
//        [self.alertCtrl addAction:imageGallery];
        [self.alertCtrl addAction:imageGallery1];
        [self.alertCtrl addAction:imageGallery2];
        [self.alertCtrl addAction:imageGallery3];
        [self.alertCtrl addAction:cancel];
    }
    else if ([_strmodule isEqualToString:@"community"])
    {
        self.alertCtrl = [UIAlertController alertControllerWithTitle:@"Sort By"
                                                             message:nil
                                                      preferredStyle:UIAlertControllerStyleActionSheet];
        //Create an action
//        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Lowest Price"
//                                                         style:UIAlertActionStyleDefault
//                                                       handler:^(UIAlertAction *action)
//                                 {
//                                     [self LowToHigh];
//                                 }];
//        UIAlertAction *imageGallery = [UIAlertAction actionWithTitle:@"Highest Price"
//                                                               style:UIAlertActionStyleDefault
//                                                             handler:^(UIAlertAction *action)
//                                       {
//                                           [self HighToLow];
//                                       }];
        UIAlertAction *imageGallery1 = [UIAlertAction actionWithTitle:@"Newest"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action)
                                        {
                                            [self Oldest];
                                        }];
        UIAlertAction *imageGallery2 = [UIAlertAction actionWithTitle:@"Oldest"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action)
                                        {
                                            [self Newest];
                                        }];
        UIAlertAction *imageGallery3 = [UIAlertAction actionWithTitle:@"Nearest"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action)
                                        {
                                            [self Nearest];
                                        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction *action)
                                 {
                                     [self dismissViewControllerAnimated:YES completion:nil];
                                 }];
        
//        [self.alertCtrl addAction:camera];
//        [self.alertCtrl addAction:imageGallery];
        [self.alertCtrl addAction:imageGallery1];
        [self.alertCtrl addAction:imageGallery2];
        [self.alertCtrl addAction:imageGallery3];
        [self.alertCtrl addAction:cancel];
    }
    else
    {
        self.alertCtrl = [UIAlertController alertControllerWithTitle:@"Sort By"
                                                             message:nil
                                                      preferredStyle:UIAlertControllerStyleActionSheet];
        //Create an action
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Lowest Price"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action)
                                 {
                                     [self LowToHigh];
                                 }];
        UIAlertAction *imageGallery = [UIAlertAction actionWithTitle:@"Highest Price"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action)
                                       {
                                           [self HighToLow];
                                       }];
        UIAlertAction *imageGallery1 = [UIAlertAction actionWithTitle:@"Newest"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action)
                                        {
                                            [self Oldest];
                                        }];
        UIAlertAction *imageGallery2 = [UIAlertAction actionWithTitle:@"Oldest"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action)
                                        {
                                            [self Newest];
                                        }];
        UIAlertAction *imageGallery3 = [UIAlertAction actionWithTitle:@"Nearest"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action)
                                        {
                                            [self Nearest];
                                        }];

        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction *action)
                                 {
                                     [self dismissViewControllerAnimated:YES completion:nil];
                                 }];
        
        [self.alertCtrl addAction:camera];
        [self.alertCtrl addAction:imageGallery];
        [self.alertCtrl addAction:imageGallery1];
        [self.alertCtrl addAction:imageGallery2];
        [self.alertCtrl addAction:imageGallery3];
        [self.alertCtrl addAction:cancel];
        
    }
}




- (void)Nearest
{
    [locationManager requestWhenInUseAuthorization];
    locationManager = [[CLLocationManager alloc] init];
    ceo = [[CLGeocoder alloc] init];
    locationManager.delegate = self;

    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locationManager requestWhenInUseAuthorization];
    }
   
    
    coordinate.latitude=locationManager.location.coordinate.latitude;
    coordinate.longitude=locationManager.location.coordinate.longitude;
    
    NSLog(@"%f",coordinate.latitude);
    NSLog(@"%f",coordinate.longitude);
    
    NSString *str1=[NSString stringWithFormat:@"%f",coordinate.latitude];
    
    
    if (str1 == (id)[NSNull null] || str1.length == 0 )
    {
        [requested showMessage:@"location Not Found. Try after some time" withTitle:@""];
    }
    else
    {
    
    [self.arryDatalistids removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kk"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if ([_strmodule isEqualToString:@"car"])
    {
        lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"location",@"ASC", nil];
        NSData* data = [NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
        
        
        
        if (strmakeids == (id)[NSNull null] || strmakeids.length == 0 )
        {
            if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *post = [NSString stringWithFormat:@"price=%@&year=%@&kilometer=%@&option=%@&sort=%@&user_id=%@&lat=%f&long=%f",arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,strSort,struseridnum,coordinate.latitude,coordinate.longitude];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }
        }
        else
        {
            if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *post = [NSString stringWithFormat:@"make=%@&price=%@&year=%@&kilometer=%@&option=%@&sort=%@&user_id=%@&lat=%f&long=%f",strmakeids,arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,strSort,struseridnum,coordinate.latitude,coordinate.longitude];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }
            else
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *post = [NSString stringWithFormat:@"make=%@&model=%@&option=%@&price=%@&year=%@&kilometer=%@&sort=%@&user_id=%@&lat=%f&long=%f",strmakeids,strmodelids,stroptions,arrJsonPrice,arrJsonYear,arrJsonKms,strSort,struseridnum,coordinate.latitude,coordinate.longitude];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
                
            }
        }
    }
    else if ([_strmodule isEqualToString:@"jobs"])
    {
        lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"location",@"ASC", nil];
        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
        
        
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&option=%@&user_id=%@&lat=%f&long=%f",_strmodule,strSort,stroptions,struseridnum,coordinate.latitude,coordinate.longitude];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
        else
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&option=%@&category=%@&user_id=%@&lat=%f&long=%f",_strmodule,strSort,stroptions,_strCategeoryid,struseridnum,coordinate.latitude,coordinate.longitude];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
    }
    else if ([_strmodule isEqualToString:@"community"])
    {
        lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"location",@"ASC", nil];
        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
        
        
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&option=%@&user_id=%@&lat=%f&long=%f",_strmodule,strSort,stroptions,struseridnum,coordinate.latitude,coordinate.longitude];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
        else
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&option=%@&category=%@&user_id=%@&lat=%f&long=%f",_strmodule,strSort,stroptions,_strCategeoryid,struseridnum,coordinate.latitude,coordinate.longitude];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
        
    }
    else
    {
        lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"location",@"ASC", nil];
        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSObject * object = [prefs objectForKey:@"pricerange"];
        if(object != nil)
        {
            NSMutableArray *arrprice2=[[NSMutableArray alloc] init];
            arrprice2=[[NSUserDefaults standardUserDefaults]objectForKey:@"pricerange"];
            
            NSData* data2 = [ NSJSONSerialization dataWithJSONObject:arrprice2 options:NSJSONWritingPrettyPrinted error:nil ];
            arrJsonPrice = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        }
        else
        {
            NSData* data2 = [ NSJSONSerialization dataWithJSONObject:arrPriceRange options:NSJSONWritingPrettyPrinted error:nil ];
            arrJsonPrice = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        }
        
        
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&price=%@&option=%@&user_id=%@&lat=%f&long=%f",_strmodule,strSort,arrJsonPrice,stroptions,struseridnum,coordinate.latitude,coordinate.longitude];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
        else
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&price=%@&option=%@&category=%@&user_id=%@&lat=%f&long=%f",_strmodule,strSort,arrJsonPrice,stroptions,_strCategeoryid,struseridnum,coordinate.latitude,coordinate.longitude];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
        }
    }
}





- (void)LowToHigh
{
    [self.arryDatalistids removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kk"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if ([_strmodule isEqualToString:@"car"])
    {
        lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"price",@"ASC", nil];
        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
        
        
        
        if (strmakeids == (id)[NSNull null] || strmakeids.length == 0 )
        {
            if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *post = [NSString stringWithFormat:@"price=%@&year=%@&kilometer=%@&option=%@&sort=%@&user_id=%@",arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,strSort,struseridnum];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
                
            }
        }
        else
        {
            if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
            {
                 NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *post = [NSString stringWithFormat:@"make=%@&price=%@&year=%@&kilometer=%@&option=%@&sort=%@&user_id=%@",strmakeids,arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,strSort,struseridnum];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }
            else
            {
                 NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *post = [NSString stringWithFormat:@"make=%@&model=%@&option=%@&price=%@&year=%@&kilometer=%@&sort=%@&user_id=%@",strmakeids,strmodelids,stroptions,arrJsonPrice,arrJsonYear,arrJsonKms,strSort,struseridnum];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
                
            }
        }
    }
    else
    {
       lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"price",@"ASC", nil];
        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
        
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSObject * object = [prefs objectForKey:@"pricerange"];
        if(object != nil)
        {
            NSMutableArray *arrprice2=[[NSMutableArray alloc] init];
            arrprice2=[[NSUserDefaults standardUserDefaults]objectForKey:@"pricerange"];
            
            NSData* data2 = [ NSJSONSerialization dataWithJSONObject:arrprice2 options:NSJSONWritingPrettyPrinted error:nil ];
            arrJsonPrice = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        }
        else
        {
            NSData* data2 = [ NSJSONSerialization dataWithJSONObject:arrPriceRange options:NSJSONWritingPrettyPrinted error:nil ];
            arrJsonPrice = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        }
        
       
        
        
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
             NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&price=%@&option=%@&user_id=%@",_strmodule,strSort,arrJsonPrice,stroptions,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
        else
        {
             NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&price=%@&option=%@&category=%@&user_id=%@",_strmodule,strSort,arrJsonPrice,stroptions,_strCategeoryid,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
    }
}


- (void)HighToLow
{
    [self.arryDatalistids removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kk"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if ([_strmodule isEqualToString:@"car"])
    {
        lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
       
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"price",@"DESC", nil];
        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
        
        
        
        if (strmakeids == (id)[NSNull null] || strmakeids.length == 0 )
        {
            if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
            {
                 NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *post = [NSString stringWithFormat:@"price=%@&year=%@&kilometer=%@&option=%@&sort=%@&user_id=%@",arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,strSort,struseridnum];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
                
            }
        }
        else
        {
            if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
            {
                 NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *post = [NSString stringWithFormat:@"make=%@&price=%@&year=%@&kilometer=%@&option=%@&sort=%@&user_id=%@",strmakeids,arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,strSort,struseridnum];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }
            else
            {
                 NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *post = [NSString stringWithFormat:@"make=%@&model=%@&option=%@&price=%@&year=%@&kilometer=%@&sort=%@&user_id=%@",strmakeids,strmodelids,stroptions,arrJsonPrice,arrJsonYear,arrJsonKms,strSort,struseridnum];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
                
            }
        }
    }
    else
    {
        lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"price",@"DESC", nil];
        NSData* data = [NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSObject * object = [prefs objectForKey:@"pricerange"];
        if(object != nil)
        {
            NSMutableArray *arrprice2=[[NSMutableArray alloc] init];
            arrprice2=[[NSUserDefaults standardUserDefaults]objectForKey:@"pricerange"];
            
            NSData* data2 = [ NSJSONSerialization dataWithJSONObject:arrprice2 options:NSJSONWritingPrettyPrinted error:nil ];
            arrJsonPrice = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        }
        else
        {
            NSData* data2 = [ NSJSONSerialization dataWithJSONObject:arrPriceRange options:NSJSONWritingPrettyPrinted error:nil ];
            arrJsonPrice = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        }
        

        
        
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&price=%@&option=%@&user_id=%@",_strmodule,strSort,arrJsonPrice,stroptions,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
        else
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&price=%@&option=%@&category=%@&user_id=%@",_strmodule,strSort,arrJsonPrice,stroptions,_strCategeoryid,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
    }
}


- (void)Newest
{
    [self.arryDatalistids removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kk"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if ([_strmodule isEqualToString:@"car"])
    {
        lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"date",@"ASC", nil];
        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
        
        
        
        if (strmakeids == (id)[NSNull null] || strmakeids.length == 0 )
        {
            if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *post = [NSString stringWithFormat:@"price=%@&year=%@&kilometer=%@&option=%@&sort=%@&user_id=%@",arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,strSort,struseridnum];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }
        }
        else
        {
            if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *post = [NSString stringWithFormat:@"make=%@&price=%@&year=%@&kilometer=%@&option=%@&sort=%@&user_id=%@",strmakeids,arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,strSort,struseridnum];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }
            else
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *post = [NSString stringWithFormat:@"make=%@&model=%@&option=%@&price=%@&year=%@&kilometer=%@&sort=%@&user_id=%@",strmakeids,strmodelids,stroptions,arrJsonPrice,arrJsonYear,arrJsonKms,strSort,struseridnum];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
                
            }
        }
    }
    else if ([_strmodule isEqualToString:@"jobs"])
    {
        lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"date",@"ASC", nil];
        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
    
        
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&option=%@&user_id=%@",_strmodule,strSort,stroptions,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
        else
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&option=%@&category=%@&user_id=%@",_strmodule,strSort,stroptions,_strCategeoryid,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
    }
    else if ([_strmodule isEqualToString:@"community"])
    {
        lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"date",@"ASC", nil];
        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
        
        
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&option=%@&user_id=%@",_strmodule,strSort,stroptions,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
        else
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&option=%@&category=%@&user_id=%@",_strmodule,strSort,stroptions,_strCategeoryid,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }

    }
    else
    {
        lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"date",@"ASC", nil];
        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSObject * object = [prefs objectForKey:@"pricerange"];
        if(object != nil)
        {
            NSMutableArray *arrprice2=[[NSMutableArray alloc] init];
            arrprice2=[[NSUserDefaults standardUserDefaults]objectForKey:@"pricerange"];
            
            NSData* data2 = [ NSJSONSerialization dataWithJSONObject:arrprice2 options:NSJSONWritingPrettyPrinted error:nil ];
            arrJsonPrice = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        }
        else
        {
            NSData* data2 = [ NSJSONSerialization dataWithJSONObject:arrPriceRange options:NSJSONWritingPrettyPrinted error:nil ];
            arrJsonPrice = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        }
        
        
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&price=%@&option=%@&user_id=%@",_strmodule,strSort,arrJsonPrice,stroptions,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
        else
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&price=%@&option=%@&category=%@&user_id=%@",_strmodule,strSort,arrJsonPrice,stroptions,_strCategeoryid,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
    }
}


- (void)Oldest
{
    [self.arryDatalistids removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kk"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if ([_strmodule isEqualToString:@"car"])
    {
        lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"date",@"DESC", nil];
        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
        
        
        if (strmakeids == (id)[NSNull null] || strmakeids.length == 0 )
        {
            if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *post = [NSString stringWithFormat:@"price=%@&year=%@&kilometer=%@&option=%@&sort=%@&user_id=%@",arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,strSort,struseridnum];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
                
            }
        }
        else
        {
            if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *post = [NSString stringWithFormat:@"make=%@&price=%@&year=%@&kilometer=%@&option=%@&sort=%@&user_id=%@",strmakeids,arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,strSort,struseridnum];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }
            else
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *post = [NSString stringWithFormat:@"make=%@&model=%@&option=%@&price=%@&year=%@&kilometer=%@&sort=%@&user_id=%@",strmakeids,strmodelids,stroptions,arrJsonPrice,arrJsonYear,arrJsonKms,strSort,struseridnum];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
                
            }
        }
        
    }
    else if ([_strmodule isEqualToString:@"jobs"])
    {
        lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"date",@"DESC", nil];
        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
        
        
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&option=%@&user_id=%@",_strmodule,strSort,stroptions,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
        else
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&option=%@&category=%@&user_id=%@",_strmodule,strSort,stroptions,_strCategeoryid,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }

    }
    else if ([_strmodule isEqualToString:@"community"])
    {
        lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"date",@"DESC", nil];
        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
        
        
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&option=%@&user_id=%@",_strmodule,strSort,stroptions,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
        else
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&option=%@&category=%@&user_id=%@",_strmodule,strSort,stroptions,_strCategeoryid,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }

    }
    else
    {
        lastCount=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        
        NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:@"date",@"DESC", nil];
        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
        strSort = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Json Kms %@",strSort);
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSObject * object = [prefs objectForKey:@"pricerange"];
        if(object != nil)
        {
            NSMutableArray *arrprice2=[[NSMutableArray alloc] init];
            arrprice2=[[NSUserDefaults standardUserDefaults]objectForKey:@"pricerange"];
            
            NSData* data2 = [ NSJSONSerialization dataWithJSONObject:arrprice2 options:NSJSONWritingPrettyPrinted error:nil ];
            arrJsonPrice = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        }
        else
        {
            NSData* data2 = [ NSJSONSerialization dataWithJSONObject:arrPriceRange options:NSJSONWritingPrettyPrinted error:nil ];
            arrJsonPrice = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        }
        
        
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&price=%@&option=%@&user_id=%@",_strmodule,strSort,arrJsonPrice,stroptions,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
        else
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&price=%@&option=%@&category=%@&user_id=%@",_strmodule,strSort,arrJsonPrice,stroptions,_strCategeoryid,struseridnum];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }
    }
}


-(void)customView
{
    topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    topview.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [self.view addSubview:topview];
    
    UIButton *Backbutt=[[UIButton alloc] initWithFrame:CGRectMake(10, topview.frame.size.height/2-5, 25, 25)];
    [Backbutt setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    Backbutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [Backbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Backbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Backbutt addTarget:self action:@selector(BackbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt];
    
    UIButton *Backbutt2=[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
    [Backbutt2 addTarget:self action:@selector(BackbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt2.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt2];
    
    UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(topview.frame.size.width/2-120, topview.frame.size.height/2-5, 240, 25)];
    lbltitle.text=_strname;
    lbltitle.textColor=[UIColor whiteColor];
    lbltitle.textAlignment=NSTextAlignmentCenter;
    lbltitle.font=[UIFont boldSystemFontOfSize:17];
    [topview addSubview:lbltitle];
    
    UIButton *SearchButt=[[UIButton alloc] initWithFrame:CGRectMake(topview.frame.size.width-35, topview.frame.size.height/2-5, 25, 25)];
    [SearchButt setImage:[UIImage imageNamed:@"musica-searcher.png"] forState:UIControlStateNormal];
    SearchButt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [SearchButt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    SearchButt.titleLabel.font = [UIFont systemFontOfSize:15];
    [SearchButt addTarget:self action:@selector(SearchbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    SearchButt.hidden=YES;
    SearchButt.backgroundColor=[UIColor clearColor];
    [topview addSubview:SearchButt];
    
    
    
    UIButton *SortButt=[[UIButton alloc] initWithFrame:CGRectMake(0, topview.frame.size.height+topview.frame.origin.y, self.view.frame.size.width/2-1, 40)];
    [SortButt setTitle:@"Sort" forState:UIControlStateNormal];
    SortButt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [SortButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    SortButt.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [SortButt addTarget:self action:@selector(SortbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    SortButt.backgroundColor=[UIColor grayColor];
    [self.view addSubview:SortButt];
    
    UIButton *FilterButt=[[UIButton alloc] initWithFrame:CGRectMake(SortButt.frame.size.width+SortButt.frame.origin.x+2, topview.frame.size.height+topview.frame.origin.y, self.view.frame.size.width/2-1, 40)];
    [FilterButt setTitle:@"Filter" forState:UIControlStateNormal];
    FilterButt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [FilterButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    FilterButt.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [FilterButt addTarget:self action:@selector(FilterbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    FilterButt.backgroundColor=[UIColor grayColor];
    [self.view addSubview:FilterButt];
    
    tabl=[[UITableView alloc] init];
    tabl.frame = CGRectMake(0,FilterButt.frame.origin.y+FilterButt.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-110);
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.tag=1;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:tabl];
}


#pragma mark - Search butt Clicked

-(IBAction)SearchbuttClicked:(id)sender
{
    [requested showMessage:@"Search Clicked" withTitle:@"Search butt"];
}

#pragma mark - Sort butt Clicked

-(IBAction)SortbuttClicked:(id)sender
{
    
    if ([_strmodule isEqualToString:@"jobs"])
    {
      //  [requested showMessage:@"Currently Sorting Not Available for this Categeory" withTitle:@"Jobs"];
        
        self.alertCtrl.popoverPresentationController.sourceView = self.view;
        [self presentViewController:self.alertCtrl animated:YES completion:^{}];
    }
    else if ([_strmodule isEqualToString:@"community"])
    {
      //  [requested showMessage:@"Currently Sorting Not Available for this Categeory" withTitle:@"Community"];
        
        self.alertCtrl.popoverPresentationController.sourceView = self.view;
        [self presentViewController:self.alertCtrl animated:YES completion:^{}];
    }
    else
    {
    self.alertCtrl.popoverPresentationController.sourceView = self.view;
    [self presentViewController:self.alertCtrl animated:YES completion:^{}];
    }
    
   // [requested showMessage:@"link will update soon" withTitle:@"Sort"];
  //  [self sortClicked];
}




#pragma mark - Table view Delegate Methods


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==2)
    {
        return 50;
    }
    else if (tableView.tag==3)
    {
        return 50;
    }
    else if (tableView.tag==4)
    {
        return 50;
    }
    else
    {
         return 141;
    }
    return 141;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==2)
    {
        return arrcategeoryfilterby.count;
    }
    else if (tableView.tag==3)
    {
        return arrcategeoryfilterby.count;
    }
    else if (tableView.tag==4)
    {
        return arrcategeoryfilterby.count;
    }
    else
    {
        return arrCarslist.count;
    }
    return 6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  static NSString *CellIdentifier1 = @"Cell1";
    static NSString *cellIdentity = @"DropDownViewCell2";
    
   // UITableViewCell *cell5;
    if (tableView.tag==2)
    {
        UITableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        cell5 = [[DropDownViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        

        
        UIImageView *imgarrow=[[UIImageView alloc]init ];
        imgarrow.frame=CGRectMake(cell5.frame.size.width-20, cell5.frame.size.height/2-3, 6, 6);
        imgarrow.image=[UIImage imageNamed:@"dots-clear.png"];
        
        if (indexPath.row<5)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if([self.arryData containsObject:indexPath])
                {
                    NSLog(@"%@",self.arryData);
                    imgarrow.frame=CGRectMake(cell5.frame.size.width-20, cell5.frame.size.height/2-3, 6, 6);
                    //   imgarrow.image=[UIImage imageNamed:@"dot.png"];
                    
                    
                    [imgarrow sd_setImageWithURL:[NSURL URLWithString:@""]
                                placeholderImage:[UIImage imageNamed:@"dot.png"]];
                }
                else
                {
                     imgarrow.image=nil;
                }

                });
      
            
            [cell5 addSubview:imgarrow];
           
            cell5.textLabel.text=[arrcategeoryfilterby objectAtIndex:indexPath.row];
            cell5.textLabel.font=[UIFont systemFontOfSize:14];
            cell5.textLabel.numberOfLines=2;
        }
        else
        {
          //  NSString *strid2=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            dispatch_async(dispatch_get_main_queue(), ^{
                if([self.arryData containsObject:indexPath])
                {
                    NSLog(@"%@",self.arryData);
                    imgarrow.frame=CGRectMake(cell5.frame.size.width-20, cell5.frame.size.height/2-3, 6, 6);
                    //   imgarrow.image=[UIImage imageNamed:@"dot.png"];
                    
                    
                    [imgarrow sd_setImageWithURL:[NSURL URLWithString:@""]
                                placeholderImage:[UIImage imageNamed:@"dot.png"]];
                }
                else
                {
                    imgarrow.image=nil;
                }
                
            });
             [cell5 addSubview:imgarrow];
            
            cell5.textLabel.text=[[arrcategeoryfilterby objectAtIndex:indexPath.row] valueForKey:@"name"];
            cell5.textLabel.font=[UIFont systemFontOfSize:14];
            cell5.textLabel.numberOfLines=2;
        }
       
        return cell5;
    }
    else if (tableView.tag==3)
    {
        UITableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        cell5 = [[DropDownViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        
        UIImageView *imgarrow=[[UIImageView alloc]init ];
        imgarrow.frame=CGRectMake(cell5.frame.size.width-20, cell5.frame.size.height/2-3, 6, 6);
        imgarrow.image=[UIImage imageNamed:@"dots-clear.png"];
        
        if (indexPath.row<1)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if([self.arryData containsObject:indexPath])
                {
                    NSLog(@"%@",self.arryData);
                    imgarrow.frame=CGRectMake(cell5.frame.size.width-20, cell5.frame.size.height/2-3, 6, 6);
                    //   imgarrow.image=[UIImage imageNamed:@"dot.png"];
                    
                    
                    [imgarrow sd_setImageWithURL:[NSURL URLWithString:@""]
                                placeholderImage:[UIImage imageNamed:@"dot.png"]];
                }
                else
                {
                    imgarrow.image=nil;
                }
                
            });
            
            
            [cell5 addSubview:imgarrow];
            
            cell5.textLabel.text=[arrcategeoryfilterby objectAtIndex:indexPath.row];
            cell5.textLabel.font=[UIFont systemFontOfSize:14];
            cell5.textLabel.numberOfLines=2;
        }
        else
        {
            //  NSString *strid2=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            dispatch_async(dispatch_get_main_queue(), ^{
                if([self.arryData containsObject:indexPath])
                {
                    NSLog(@"%@",self.arryData);
                    imgarrow.frame=CGRectMake(cell5.frame.size.width-20, cell5.frame.size.height/2-3, 6, 6);
                    //   imgarrow.image=[UIImage imageNamed:@"dot.png"];
                    
                    
                    [imgarrow sd_setImageWithURL:[NSURL URLWithString:@""]
                                placeholderImage:[UIImage imageNamed:@"dot.png"]];
                }
                else
                {
                    imgarrow.image=nil;
                }
                
            });
            [cell5 addSubview:imgarrow];
            
            cell5.textLabel.text=[[arrcategeoryfilterby objectAtIndex:indexPath.row] valueForKey:@"name"];
            cell5.textLabel.font=[UIFont systemFontOfSize:14];
            cell5.textLabel.numberOfLines=2;
        }
        
        return cell5;
    }
    else if (tableView.tag==4)
    {
        UITableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        cell5 = [[DropDownViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        
        UIImageView *imgarrow=[[UIImageView alloc]init ];
        imgarrow.frame=CGRectMake(cell5.frame.size.width-20, cell5.frame.size.height/2-3, 6, 6);
        imgarrow.image=[UIImage imageNamed:@"dots-clear.png"];
        
        
                   //  NSString *strid2=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            dispatch_async(dispatch_get_main_queue(), ^{
                if([self.arryData containsObject:indexPath])
                {
                    NSLog(@"%@",self.arryData);
                    imgarrow.frame=CGRectMake(cell5.frame.size.width-20, cell5.frame.size.height/2-3, 6, 6);
                    //   imgarrow.image=[UIImage imageNamed:@"dot.png"];
                    
                    
                    [imgarrow sd_setImageWithURL:[NSURL URLWithString:@""]
                                placeholderImage:[UIImage imageNamed:@"dot.png"]];
                }
                else
                {
                    imgarrow.image=nil;
                }
                
            });
            [cell5 addSubview:imgarrow];
            
            cell5.textLabel.text=[[arrcategeoryfilterby objectAtIndex:indexPath.row] valueForKey:@"name"];
            cell5.textLabel.font=[UIFont systemFontOfSize:14];
            cell5.textLabel.numberOfLines=2;
        
        
        return cell5;
    }
    else
    {
        if ([_strmodule isEqualToString:@"car"])
        {
            static NSString *CellClassName = @"MotorCategeoryTableViewCell2";
            cell2 = (MotorCategeoryTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
            if (cell2 == nil)
            {
                cell2 = [[MotorCategeoryTableViewCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MotorCategeoryTableViewCell2"
                                                             owner:self options:nil];
                cell2 = [nib objectAtIndex:0];
                cell2.backgroundColor=[UIColor blackColor];
                cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            UIImageView *Carimage=(UIImageView*)[cell2 viewWithTag:1];
            favoritebutt=(UIButton *)[cell2 viewWithTag:2];
            favoritebutt2=(UIButton *)[cell2 viewWithTag:11];
            UILabel *CarName=(UILabel *)[cell2 viewWithTag:3];
            UILabel *CarRate=(UILabel *)[cell2 viewWithTag:7];
            UILabel *Deslab=(UILabel *)[cell2 viewWithTag:9];
            UILabel *Makelab=(UILabel *)[cell2 viewWithTag:12];
            
            Carimage.contentMode = UIViewContentModeScaleAspectFill;
            Carimage.clipsToBounds = YES;
            Carimage.layer.borderWidth = 1.0;
            Carimage.layer.borderColor = [UIColor lightGrayColor].CGColor;
            Carimage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
           // Carimage.backgroundColor=[UIColor colorWithRed:255.0/255.0f green:174.0/255.0f blue:185.0/255.0f alpha:1.0];
            imagena=[[arrCarslist objectAtIndex:indexPath.row]valueForKey:@"pic"];
            [Carimage sd_setImageWithURL:[NSURL URLWithString:imagena]
                    placeholderImage:[UIImage imageNamed:@"upload-empty.png"]];
            
            
            NSString *strname=[[arrCarslist valueForKey:@"name"]objectAtIndex:indexPath.row];
            NSString *strYear=[[[arrCarslist valueForKey:@"detail"] valueForKey:@"year"]objectAtIndex:indexPath.row];
            if (strname == (id)[NSNull null] || strname.length == 0 )
            {
                CarName.text=@"";
            }
            else
            {
                CarName.text=[NSString stringWithFormat:@"%@ (%@)",strname,strYear];
            }
            
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSObject * object = [prefs objectForKey:@"userid"];
            if(object != nil)
            {
                favoritebutt.hidden=NO;
                
                NSString *strfav=[NSString stringWithFormat:@"%@",[[arrCarslist valueForKey:@"favorite"] objectAtIndex:indexPath.row]];
                
                if ([strfav isEqualToString:@"0"])
                {
                    
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    NSObject * object = [prefs objectForKey:@"kk"];
                    if(object != nil)
                    {
                        if([self.arryDatalistids containsObject:indexPath])
                        {
                             [favoritebutt setImage:[UIImage imageNamed:@"hearts.png"] forState:UIControlStateNormal];
                        }
                        else
                        {
                            [favoritebutt setImage:[UIImage imageNamed:@"favorite-2.png"] forState:UIControlStateNormal];
                            
                        }
                        
                    }else
                    {
                        if([self.arryDatalistids containsObject:indexPath])
                        {
                            
                        }
                        else
                        {
                            [favoritebutt setImage:[UIImage imageNamed:@"favorite-2.png"] forState:UIControlStateNormal];
                            
                        }

                    }
                    
                }
                else
                {
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    NSObject * object = [prefs objectForKey:@"kk"];
                    if(object != nil)
                    {
                        
                        
                    }else
                    {
                        if([self.arryDatalistids containsObject:indexPath])
                        {
                            
                        } else {
                            [self.arryDatalistids addObject:indexPath];
                        }
                    }

                    
                    if([self.arryDatalistids containsObject:indexPath])
                    {
                      
                        [favoritebutt setImage:[UIImage imageNamed:@"hearts.png"] forState:UIControlStateNormal];
                    }
                    else
                    {
                        
                        [favoritebutt setImage:[UIImage imageNamed:@"favorite-2.png"] forState:UIControlStateNormal];
                    }
                }
                
                
                [favoritebutt2 addTarget:self action:@selector(favoritelistClicked:) forControlEvents:UIControlEventTouchUpInside];
                favoritebutt2.tag=indexPath.row;
            }
            else
            {
                favoritebutt.hidden=YES;
                [favoritebutt2 addTarget:self action:@selector(favoritelistClicked:) forControlEvents:UIControlEventTouchUpInside];
                favoritebutt2.tag=indexPath.row;
            }
            
            
         
            
            
            NSString *strlist=[[[arrCarslist valueForKey:@"detail"] valueForKey:@"price"]objectAtIndex:indexPath.row];
            if (strlist == (id)[NSNull null] || strlist.length == 0 )
            {
                CarRate.text=@"";
            }
            else
            {
                CarRate.text=[NSString stringWithFormat:@"%@ AED",strlist];
            }
            
            
            NSString *strDes=[[[arrCarslist valueForKey:@"detail"] valueForKey:@"kilometer"]objectAtIndex:indexPath.row];
            if (strDes == (id)[NSNull null] || strDes.length == 0 )
            {
                Deslab.text=@"";
            }
            else
            {
                Deslab.text=[NSString stringWithFormat:@"%@ Kms",strDes];
            }
            
            
            NSString *strMake=[[[arrCarslist valueForKey:@"detail"] valueForKey:@"make"]objectAtIndex:indexPath.row];
            NSString *strModel=[[[arrCarslist valueForKey:@"detail"] valueForKey:@"model"]objectAtIndex:indexPath.row];
            if ((strMake == (id)[NSNull null] || strMake.length == 0) && (strModel == (id)[NSNull null] || strModel.length == 0))
            {
                Makelab.text=@"";
            }
            else
            {
                Makelab.text=[NSString stringWithFormat:@"%@ %@ %@",strMake,@"|",strModel];
            }

            return cell2;
        }
        else
        {
            static NSString *CellClassName = @"MotorCategeoryTableViewCell";
            cell = (MotorCategeoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
            if (cell == nil)
            {
                cell = [[MotorCategeoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MotorCategeoryTableViewCell"
                                                             owner:self options:nil];
                cell = [nib objectAtIndex:0];
                cell.backgroundColor=[UIColor blackColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            UIImageView *Carimage=(UIImageView*)[cell viewWithTag:1];
            favoritebutt=(UIButton *)[cell viewWithTag:2];
            favoritebutt2=(UIButton *)[cell viewWithTag:11];
            UILabel *CarName=(UILabel *)[cell viewWithTag:3];
            UILabel *CarRate=(UILabel *)[cell viewWithTag:7];
            UILabel *Deslab=(UILabel *)[cell viewWithTag:9];
            
            Carimage.contentMode = UIViewContentModeScaleAspectFill;
            Carimage.clipsToBounds = YES;
            Carimage.layer.borderWidth = 1.0;
            Carimage.layer.borderColor = [UIColor lightGrayColor].CGColor;
            Carimage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
          //  Carimage.backgroundColor=[UIColor colorWithRed:255.0/255.0f green:174.0/255.0f blue:185.0/255.0f alpha:1.0];
            NSArray *imageName=[[arrCarslist objectAtIndex:indexPath.row]valueForKey:@"pic"];
            imagena=[imageName componentsJoinedByString:@","];
            [Carimage sd_setImageWithURL:[NSURL URLWithString:imagena]
                        placeholderImage:[UIImage imageNamed:@"upload-empty.png"]];
            
            
            NSString *strname=[[arrCarslist valueForKey:@"name"]objectAtIndex:indexPath.row];
            if (strname == (id)[NSNull null] || strname.length == 0 )
            {
                CarName.text=@"";
            }
            else
            {
                CarName.text=strname;
            }
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSObject * object = [prefs objectForKey:@"userid"];
            if(object != nil)
            {
                favoritebutt.hidden=NO;
                
                NSString *strfav=[NSString stringWithFormat:@"%@",[[arrCarslist valueForKey:@"favorite"] objectAtIndex:indexPath.row]];
                
                if ([strfav isEqualToString:@"0"])
                {
                    
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    NSObject * object = [prefs objectForKey:@"kk"];
                    if(object != nil)
                    {
                        if([self.arryDatalistids containsObject:indexPath])
                        {
                            [favoritebutt setImage:[UIImage imageNamed:@"hearts.png"] forState:UIControlStateNormal];
                        }
                        else
                        {
                            [favoritebutt setImage:[UIImage imageNamed:@"favorite-2.png"] forState:UIControlStateNormal];
                            
                        }
                        
                    }else
                    {
                        if([self.arryDatalistids containsObject:indexPath])
                        {
                            
                        }
                        else
                        {
                            [favoritebutt setImage:[UIImage imageNamed:@"favorite-2.png"] forState:UIControlStateNormal];
                            
                        }
                        
                    }
                    
                }
                else
                {
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    NSObject * object = [prefs objectForKey:@"kk"];
                    if(object != nil)
                    {
                        
                        
                    }else
                    {
                        if([self.arryDatalistids containsObject:indexPath])
                        {
                            
                        } else {
                            [self.arryDatalistids addObject:indexPath];
                        }
                    }
                    
                    
                    if([self.arryDatalistids containsObject:indexPath])
                    {
                        
                        [favoritebutt setImage:[UIImage imageNamed:@"hearts.png"] forState:UIControlStateNormal];
                    }
                    else
                    {
                        
                        [favoritebutt setImage:[UIImage imageNamed:@"favorite-2.png"] forState:UIControlStateNormal];
                    }
                }
                
                
                [favoritebutt2 addTarget:self action:@selector(favoritelistClicked:) forControlEvents:UIControlEventTouchUpInside];
                favoritebutt2.tag=indexPath.row;
            }
            else
            {
                favoritebutt.hidden=YES;
                [favoritebutt2 addTarget:self action:@selector(favoritelistClicked:) forControlEvents:UIControlEventTouchUpInside];
                favoritebutt2.tag=indexPath.row;
            }
            
            

            
            
            NSString *strlist=[[arrCarslist valueForKey:@"price"]objectAtIndex:indexPath.row];
            if (strlist == (id)[NSNull null] || strlist.length == 0 )
            {
                CarRate.text=@"";
            }
            else
            {
                CarRate.text=[NSString stringWithFormat:@"%@ AED",strlist];
            }
            
            
            NSString *strDes=[[arrCarslist valueForKey:@"description"]objectAtIndex:indexPath.row];
            if (strDes == (id)[NSNull null] || strDes.length == 0 )
            {
                Deslab.text=@"";
            }
            else
            {
                Deslab.text=strDes;
            }
            return cell;
        }
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1)
    {
//        CarDescriptionViewController *carDes=[self.storyboard instantiateViewControllerWithIdentifier:@"CarDescriptionViewController"];
//        carDes.strtitle=@"BMW 5 Series";
//        carDes.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:carDes animated:YES];
        
        if ([_strmodule isEqualToString:@"car"])
        {
            NSString *postid=[[arrCarslist valueForKey:@"id"]objectAtIndex:indexPath.row];
             NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *post = [NSString stringWithFormat:@"module=%@&post_id=%@&user_id=%@",_strmodule,postid,struseridnum];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPost,english,strCityId];
            [requested RegistrationRequest:post withUrl:strurl];
        }
        else
        {
            NSString *postid=[[arrCarslist valueForKey:@"id"]objectAtIndex:indexPath.row];
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *post = [NSString stringWithFormat:@"module=%@&post_id=%@&user_id=%@",_strmodule,postid,struseridnum];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Post,english,strCityId];
            [requested RegistrationRequest:post withUrl:strurl];
        }
    }
    else if (tableView.tag==3)
    {
        if (indexPath.row==0)
        {
            pricerangeView.hidden=NO;
            
            [Dropobj fadeOut];
            [popview endEditing:YES];
            [footerview endEditing:YES];
            [filterview endEditing:YES];
            [self.view endEditing:YES];
        }
        else
        {
            pricerangeView.hidden=YES;
           
            
            [popview endEditing:YES];
            [footerview endEditing:YES];
            [filterview endEditing:YES];
            [self.view endEditing:YES];
           
            NSString *strindex=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            NSInteger myInt = [strindex intValue];
            
            index= [NSIndexPath indexPathForRow:myInt inSection:0];

            [[NSUserDefaults standardUserDefaults]setObject:@"Check" forKey:@"checking"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            labvali.hidden=YES;
            premiumAdsView.hidden=YES;
            pricerangeView.hidden=YES;
            
            arrfueltype=[[[arrcategeoryfilterby objectAtIndex:indexPath.row] valueForKey:@"values"] valueForKey:@"name"];
            
            strids=@"2";
            
            strid=[NSString stringWithFormat:@"%lu",(long)indexPath.row];
            stridforpost=[[arrcategeoryfilterby objectAtIndex:indexPath.row] valueForKey:@"id"];
            b=(int)indexPath.row+1;
            
            
            [arrcheckindex removeAllObjects];
            
            if ([carpostdict objectForKey:stridforpost] != nil)
            {
                NSString *arrcou=[NSString stringWithFormat:@"%@",[carpostdict valueForKey:stridforpost]];
                NSArray *arrcount= [arrcou componentsSeparatedByString:@","];
                NSArray *arrlistcou=[[[arrcategeoryfilterby objectAtIndex:indexPath.row] valueForKey:@"values"] valueForKey:@"id"];
                for (int i=0; i<arrcount.count; i++)
                {
                    NSString *stridscheck=[NSString stringWithFormat:@"%@",[arrcount objectAtIndex:i]];
                    for (int j=0; j<arrlistcou.count; j++)
                    {
                        NSString *strchek2=[NSString stringWithFormat:@"%@",[arrlistcou objectAtIndex:j]];
                        if ([stridscheck isEqualToString:strchek2])
                        {
                            checkindex= [NSIndexPath indexPathForRow:j inSection:0];
                            [arrcheckindex addObject:checkindex];
                            
                            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrcheckindex];
                            
                            [[NSUserDefaults standardUserDefaults]setValue:data forKey:@"indexcheck"];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                        }
                    }
                    
                }
            }
            else
            {
                //                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"indexcheck"];
                //                [[NSUserDefaults standardUserDefaults]synchronize];
                
            }
            
            NSLog(@"arr checks for check: %@",arrcheckindex);
            
            //            NSMutableArray *arrcheck=[[NSMutableArray alloc]init];
            //            [arrcheck addObjectsFromArray:arrcheckindex];
            
            

            
            NSString *strname =[[arrcategeoryfilterby objectAtIndex:indexPath.row] valueForKey:@"name"];
            
            [Dropobj fadeOut];
            
            if ([UIScreen mainScreen].bounds.size.width < 350 )
            {
                [self showPopUpWithTitle:strname withOption:arrfueltype xy:CGPointMake(0, 0) size:CGSizeMake(self.view.frame.size.width-170,  self.view.frame.size.height-110) isMultiple:YES];
            }
            else
            {
                [self showPopUpWithTitle:strname withOption:arrfueltype xy:CGPointMake(0, 0) size:CGSizeMake(self.view.frame.size.width-170,  self.view.frame.size.height-110) isMultiple:YES];
            }

        }
    }
    else if (tableView.tag==4)
    {
        [popview endEditing:YES];
        [footerview endEditing:YES];
        [filterview endEditing:YES];
        [self.view endEditing:YES];
            
        NSString *strindex=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        NSInteger myInt = [strindex intValue];
        
        index= [NSIndexPath indexPathForRow:myInt inSection:0];
            
        [[NSUserDefaults standardUserDefaults]setObject:@"Check" forKey:@"checking"];
        [[NSUserDefaults standardUserDefaults] synchronize];
            
        labvali.hidden=YES;
        premiumAdsView.hidden=YES;
        pricerangeView.hidden=YES;
        
        arrfueltype=[[[arrcategeoryfilterby objectAtIndex:indexPath.row] valueForKey:@"values"] valueForKey:@"name"];
            
        strids=@"2";
            
        strid=[NSString stringWithFormat:@"%lu",(long)indexPath.row];
        stridforpost=[[arrcategeoryfilterby objectAtIndex:indexPath.row] valueForKey:@"id"];
        b=(int)indexPath.row+1;
            
            
        [arrcheckindex removeAllObjects];
        
        if ([carpostdict objectForKey:stridforpost] != nil)
        {
            NSString *arrcou=[NSString stringWithFormat:@"%@",[carpostdict valueForKey:stridforpost]];
            NSArray *arrcount= [arrcou componentsSeparatedByString:@","];
            NSArray *arrlistcou=[[[arrcategeoryfilterby objectAtIndex:indexPath.row] valueForKey:@"values"] valueForKey:@"id"];
            for (int i=0; i<arrcount.count; i++)
            {
                NSString *stridscheck=[NSString stringWithFormat:@"%@",[arrcount objectAtIndex:i]];
                for (int j=0; j<arrlistcou.count; j++)
                {
                    NSString *strchek2=[NSString stringWithFormat:@"%@",[arrlistcou objectAtIndex:j]];
                    if ([stridscheck isEqualToString:strchek2])
                    {
                        checkindex= [NSIndexPath indexPathForRow:j inSection:0];
                        [arrcheckindex addObject:checkindex];
                        
                        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrcheckindex];
                            
                        [[NSUserDefaults standardUserDefaults]setValue:data forKey:@"indexcheck"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                    }
                }
                    
            }
        }
        else
        {
                //                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"indexcheck"];
                //                [[NSUserDefaults standardUserDefaults]synchronize];
                
        }
        
        NSLog(@"arr checks for check: %@",arrcheckindex);
            
            //            NSMutableArray *arrcheck=[[NSMutableArray alloc]init];
            //            [arrcheck addObjectsFromArray:arrcheckindex];
        
            
        NSString *strname =[[arrcategeoryfilterby objectAtIndex:indexPath.row] valueForKey:@"name"];
            
        [Dropobj fadeOut];
            
        if ([UIScreen mainScreen].bounds.size.width < 350 )
        {
            [self showPopUpWithTitle:strname withOption:arrfueltype xy:CGPointMake(0, 0) size:CGSizeMake(self.view.frame.size.width-170,  self.view.frame.size.height-110) isMultiple:YES];
        }
        else
        {
            [self showPopUpWithTitle:strname withOption:arrfueltype xy:CGPointMake(0, 0) size:CGSizeMake(self.view.frame.size.width-170,  self.view.frame.size.height-110) isMultiple:YES];
        }
    }
    else if (tableView.tag==2)
    {
        if (indexPath.row==0)
        {
            pricerangeView.hidden=NO;
            yearrangeView.hidden=YES;
            kmsrangeView.hidden=YES;
            
             [Dropobj fadeOut];
            labvali.hidden=YES;
            
            [popview endEditing:YES];
            [footerview endEditing:YES];
            [filterview endEditing:YES];
            [self.view endEditing:YES];
        }
        else if (indexPath.row==1)
        {
            pricerangeView.hidden=YES;
            yearrangeView.hidden=NO;
            kmsrangeView.hidden=YES;
            
            [Dropobj fadeOut];
            labvali.hidden=YES;
            
            [popview endEditing:YES];
            [footerview endEditing:YES];
            [filterview endEditing:YES];
            [self.view endEditing:YES];
           
            
        }
        else if (indexPath.row==2)
        {
            pricerangeView.hidden=YES;
            yearrangeView.hidden=YES;
            kmsrangeView.hidden=NO;
            
            [Dropobj fadeOut];
            labvali.hidden=YES;
            
            [popview endEditing:YES];
            [footerview endEditing:YES];
            [filterview endEditing:YES];
            [self.view endEditing:YES];
           // [self.searchController resignFirstResponder];
            
        }
        else if (indexPath.row==3)
        {
            pricerangeView.hidden=YES;
            yearrangeView.hidden=YES;
             kmsrangeView.hidden=YES;
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"checking"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"Check1" forKey:@"checking"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
           
            
            labvali.hidden=YES;
            strids=@"1";
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@",BaseUrl,strtoken,carSubModule,english,strCityId,@"1"];
            [requested motorsEngRequest:nil withUrl:strurl];
        }
        else if (indexPath.row==4)
        {
           pricerangeView.hidden=YES;
            yearrangeView.hidden=YES;
            kmsrangeView.hidden=YES;
            
            [popview endEditing:YES];
            [footerview endEditing:YES];
            [filterview endEditing:YES];
            [self.view endEditing:YES];
          //  [self.searchController resignFirstResponder];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"Check2" forKey:@"checking"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            if (strmakeids == (id)[NSNull null] || strmakeids.length == 0 )
            {
                [Dropobj fadeOut];
                labvali=[[UILabel alloc] initWithFrame:CGRectMake(5, filterview.frame.size.height/2-80, filterview.frame.size.width-10, 160)];
                labvali.text=@"Please Select Make First";
                labvali.textAlignment=NSTextAlignmentCenter;
                labvali.numberOfLines=4;
                [filterview addSubview:labvali];
            }
            else
            {
//                [self.arryData addObject:@"1"];
//                 [tableView reloadData];
                
                 labvali.hidden=YES;
                [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?make=%@",BaseUrl,strtoken,carModel,english,strCityId,strmakeids];
                [requested OptionRequest2:nil withUrl:strurl];
            }
        }
        else
        {
            if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
            {
                
            }
            else
            {
//             [self.arryData addObject:@"2"];
//                [tableView reloadData];
            }
            
            pricerangeView.hidden=YES;
            yearrangeView.hidden=YES;
            kmsrangeView.hidden=YES;
            
            [popview endEditing:YES];
            [footerview endEditing:YES];
            [filterview endEditing:YES];
            [self.view endEditing:YES];
           // [self.searchController resignFirstResponder];
            
            
            NSString *strindex=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            NSInteger myInt = [strindex intValue];
            
            index= [NSIndexPath indexPathForRow:myInt inSection:0];
            
            
            
            
            
            NSLog(@"%@",carpostdict);
            
            [[NSUserDefaults standardUserDefaults]setObject:@"Check" forKey:@"checking"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
             labvali.hidden=YES;
            premiumAdsView.hidden=YES;
            pricerangeView.hidden=YES;
        
            arrfueltype=[[[arrcategeoryfilterby objectAtIndex:indexPath.row] valueForKey:@"values"] valueForKey:@"name"];
        
            strids=@"2";
        
            strid=[NSString stringWithFormat:@"%lu",(long)indexPath.row];
            stridforpost=[[arrcategeoryfilterby objectAtIndex:indexPath.row] valueForKey:@"id"];
            b=(int)indexPath.row+1;
            
            
            [arrcheckindex removeAllObjects];
            
            if ([carpostdict objectForKey:stridforpost] != nil)
            {
                NSString *arrcou=[NSString stringWithFormat:@"%@",[carpostdict valueForKey:stridforpost]];
                NSArray *arrcount= [arrcou componentsSeparatedByString:@","];
                NSArray *arrlistcou=[[[arrcategeoryfilterby objectAtIndex:indexPath.row] valueForKey:@"values"] valueForKey:@"id"];
                for (int i=0; i<arrcount.count; i++)
                {
                    NSString *stridscheck=[NSString stringWithFormat:@"%@",[arrcount objectAtIndex:i]];
                    for (int j=0; j<arrlistcou.count; j++)
                    {
                        NSString *strchek2=[NSString stringWithFormat:@"%@",[arrlistcou objectAtIndex:j]];
                        if ([stridscheck isEqualToString:strchek2])
                        {
                             checkindex= [NSIndexPath indexPathForRow:j inSection:0];
                             [arrcheckindex addObject:checkindex];
                            
                             NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrcheckindex];
                            
                            [[NSUserDefaults standardUserDefaults]setValue:data forKey:@"indexcheck"];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                        }
                    }
                    
                }
            }
            else
            {
//                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"indexcheck"];
//                [[NSUserDefaults standardUserDefaults]synchronize];

            }
            
            NSLog(@"arr checks for check: %@",arrcheckindex);
            
//            NSMutableArray *arrcheck=[[NSMutableArray alloc]init];
//            [arrcheck addObjectsFromArray:arrcheckindex];
            
          
            
            
        
            NSString *strname =[[arrcategeoryfilterby objectAtIndex:indexPath.row] valueForKey:@"name"];
        
            [Dropobj fadeOut];
        
            if ([UIScreen mainScreen].bounds.size.width < 350 )
            {
                [self showPopUpWithTitle:strname withOption:arrfueltype xy:CGPointMake(0, 0) size:CGSizeMake(self.view.frame.size.width-170,  self.view.frame.size.height-110) isMultiple:YES];
            }
            else
            {
                [self showPopUpWithTitle:strname withOption:arrfueltype xy:CGPointMake(0, 0) size:CGSizeMake(self.view.frame.size.width-170,  self.view.frame.size.height-110) isMultiple:YES];
            }
        }
    }
}


-(void)responseRegistration:(NSMutableDictionary *)responseDict
{
     NSLog(@"Dict Response: %@",responseDict);
    
    NSArray *strname=[[responseDict valueForKey:@"data"] valueForKey:@"name"];
    NSString *strn=[strname componentsJoinedByString:@""];
    NSDictionary *strurls=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"pic"];
    NSArray *strls=[strurls valueForKey:@"url"];
    
    NSLog(@"%@",strurls);
    
    CarDescriptionViewController *des=[self.storyboard instantiateViewControllerWithIdentifier:@"CarDescriptionViewController"];
    des.strDataArray=[[responseDict valueForKey:@"data"] objectAtIndex:0];
    des.strtitle=strn;
    des.strUrls=strls;
    des.strurlparameter=_strmodule;
    [self.navigationController pushViewController:des animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==2)
    {
        
    }
    else
    {
        NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
        NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
    
        if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex))
        {
        
            if ([_strpage isEqualToString:@"0"])
            {
                loadLbl.text=@"No More List";
                [actInd stopAnimating];
            }
            else
            {
            
                if ([_strmodule isEqualToString:@"car"])
                {
                    // x+=1;
                    
                    NSString *strtype=[[NSUserDefaults standardUserDefaults] objectForKey:@"Carssec"];
                    
                    
                    if ([strtype isEqualToString:@"sort"])
                    {
                        if (strmakeids == (id)[NSNull null] || strmakeids.length == 0 )
                        {
                            if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
                            {
                                 NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                                NSString *post = [NSString stringWithFormat:@"price=%@&year=%@&kilometer=%@&option=%@&sort=%@&page=%@&user_id=%@&lat=%f&long=%f",arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,strSort,_strpage,struseridnum,coordinate.latitude,coordinate.longitude];
                                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                                [requested loginRequest:post withUrl:strurl];
                                [self initFooterView];
                                loadLbl.text=@"loading...";
                            }
                        }
                        else
                        {
                            if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
                            {
                                 NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                                NSString *post = [NSString stringWithFormat:@"make=%@&price=%@&year=%@&kilometer=%@&option=%@&sort=%@&page=%@&user_id=%@&lat=%f&long=%f",strmakeids,arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,strSort,_strpage,struseridnum,coordinate.latitude,coordinate.longitude];
                                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                                [requested loginRequest:post withUrl:strurl];
                                [self initFooterView];
                                loadLbl.text=@"loading...";
                            }
                            else
                            {
                                 NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                                NSString *post = [NSString stringWithFormat:@"make=%@&model=%@&option=%@&price=%@&year=%@&kilometer=%@&sort=%@&page=%@&user_id=%@&lat=%f&long=%f",strmakeids,strmodelids,stroptions,arrJsonPrice,arrJsonYear,arrJsonKms,strSort,_strpage,struseridnum,coordinate.latitude,coordinate.longitude];
                                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                                [requested loginRequest:post withUrl:strurl];
                                [self initFooterView];
                                loadLbl.text=@"loading...";
                            }
                        }
                    }
                    else
                    {
                        
                        if (m==1)
                        {
                            
                            //   [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                            //  NSString *post = [NSString stringWithFormat:@"module=%@&page=%@",_strmodule,_strpage];
                            NSString *post = [NSString stringWithFormat:@"page=%@&user_id=%@",_strpage,struseridnum];
                            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                            [requested loginRequest:post withUrl:strurl];
                            [self initFooterView];
                            loadLbl.text=@"loading...";
                            
                        }
                        else
                        {
                        
                            if (strmakeids == (id)[NSNull null] || strmakeids.length == 0 )
                            {
                                if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
                                {
                                    NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                                    NSString *post = [NSString stringWithFormat:@"price=%@&year=%@&kilometer=%@&option=%@&page=%@&user_id=%@&lat=%f&long=%f",arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,_strpage,struseridnum,coordinate.latitude,coordinate.longitude];
                                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                                    [requested loginRequest:post withUrl:strurl];
                                    [self initFooterView];
                                    loadLbl.text=@"loading...";
                                }
                            }
                            else
                            {
                                if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
                                {
                                    NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                                    NSString *post = [NSString stringWithFormat:@"make=%@&price=%@&year=%@&kilometer=%@&option=%@&page=%@&user_id=%@&lat=%f&long=%f",strmakeids,arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,_strpage,struseridnum,coordinate.latitude,coordinate.longitude];
                                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                                    [requested loginRequest:post withUrl:strurl];
                                    [self initFooterView];
                                    loadLbl.text=@"loading...";
                                }
                                else
                                {
                                    NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                                    NSString *post = [NSString stringWithFormat:@"make=%@&model=%@&option=%@&price=%@&year=%@&kilometer=%@&page=%@&user_id=%@&lat=%f&long=%f",strmakeids,strmodelids,stroptions,arrJsonPrice,arrJsonYear,arrJsonKms,_strpage,struseridnum,coordinate.latitude,coordinate.longitude];
                                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                                    [requested loginRequest:post withUrl:strurl];
                                    [self initFooterView];
                                    loadLbl.text=@"loading...";
                                    
                                }
                            }
                        }
                    }
                }
                else if ([_strmodule isEqualToString:@"jobs"])
                {
                    NSString *strtype=[[NSUserDefaults standardUserDefaults] objectForKey:@"Carssec"];
                    
                    if ([strtype isEqualToString:@"sort"])
                    {
                        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
                        {
                            // x+=1;
                            //   [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                            NSString *post = [NSString stringWithFormat:@"module=%@&page=%@&user_id=%@&sort=%@&option=%@&lat=%f&long=%f",_strmodule,_strpage,struseridnum,strSort,stroptions,coordinate.latitude,coordinate.longitude];
                            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                            [requested loginRequest:post withUrl:strurl];
                            [self initFooterView];
                            loadLbl.text=@"loading...";
                        }
                        else
                        {
                            // x+=1;
                            //   [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                            NSString *post = [NSString stringWithFormat:@"module=%@&page=%@&category=%@&user_id=%@&sort=%@&option=%@&lat=%f&long=%f",_strmodule,_strpage,_strCategeoryid,struseridnum,strSort,stroptions,coordinate.latitude,coordinate.longitude];
                            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                            [requested loginRequest:post withUrl:strurl];
                            [self initFooterView];
                            loadLbl.text=@"loading...";
                        }

                    }
                    else
                    {
                        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
                        {
                            // x+=1;
                            //   [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                            NSString *post = [NSString stringWithFormat:@"module=%@&page=%@&user_id=%@&option=%@",_strmodule,_strpage,struseridnum,stroptions];
                            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                            [requested loginRequest:post withUrl:strurl];
                            [self initFooterView];
                            loadLbl.text=@"loading...";
                        }
                        else
                        {
                            // x+=1;
                            //   [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                            NSString *post = [NSString stringWithFormat:@"module=%@&page=%@&category=%@&user_id=%@&option=%@",_strmodule,_strpage,_strCategeoryid,struseridnum,stroptions];
                            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                            [requested loginRequest:post withUrl:strurl];
                            [self initFooterView];
                            loadLbl.text=@"loading...";
                        }

                    
                    }
                    
                }
                else if ([_strmodule isEqualToString:@"community"])
                {
                    
                    NSString *strtype=[[NSUserDefaults standardUserDefaults] objectForKey:@"Carssec"];
                    
                    if ([strtype isEqualToString:@"sort"])
                    {
                        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
                        {
                            // x+=1;
                            //   [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                            NSString *post = [NSString stringWithFormat:@"module=%@&page=%@&user_id=%@&sort=%@&option=%@&lat=%f&long=%f",_strmodule,_strpage,struseridnum,strSort,stroptions,coordinate.latitude,coordinate.longitude];
                            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                            [requested loginRequest:post withUrl:strurl];
                            [self initFooterView];
                            loadLbl.text=@"loading...";
                        }
                        else
                        {
                            // x+=1;
                            //   [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                            NSString *post = [NSString stringWithFormat:@"module=%@&page=%@&category=%@&user_id=%@&sort=%@&option=%@&lat=%f&long=%f",_strmodule,_strpage,_strCategeoryid,struseridnum,strSort,stroptions,coordinate.latitude,coordinate.longitude];
                            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                            [requested loginRequest:post withUrl:strurl];
                            [self initFooterView];
                            loadLbl.text=@"loading...";
                        }
 
                    }
                    else
                    {
                        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
                        {
                            // x+=1;
                            //   [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                            NSString *post = [NSString stringWithFormat:@"module=%@&page=%@&user_id=%@&option=%@",_strmodule,_strpage,struseridnum,stroptions];
                            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                            [requested loginRequest:post withUrl:strurl];
                            [self initFooterView];
                            loadLbl.text=@"loading...";
                        }
                        else
                        {
                            // x+=1;
                            //   [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                            NSString *post = [NSString stringWithFormat:@"module=%@&page=%@&category=%@&user_id=%@&option=%@",_strmodule,_strpage,_strCategeoryid,struseridnum,stroptions];
                            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                            [requested loginRequest:post withUrl:strurl];
                            [self initFooterView];
                            loadLbl.text=@"loading...";
                        }

                    }
                   
                }
                else
                {
                    
                    NSString *strtype=[[NSUserDefaults standardUserDefaults] objectForKey:@"Carssec"];
                    
                    if ([strtype isEqualToString:@"sort"])
                    {
                        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
                        {
                            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                             NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&price=%@&option=%@&page=%@&user_id=%@&lat=%f&long=%f",_strmodule,strSort,arrJsonPrice,stroptions,_strpage,struseridnum,coordinate.latitude,coordinate.longitude];
                            
                            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                            [requested loginRequest:post withUrl:strurl];
                            [self initFooterView];
                            loadLbl.text=@"loading...";
                        }
                        else
                        {
                            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                            NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&price=%@&option=%@&page=%@&category=%@&user_id=%@&lat=%f&long=%f",_strmodule,strSort,arrJsonPrice,stroptions,_strpage,_strCategeoryid,struseridnum,coordinate.latitude,coordinate.longitude];
                            
                            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                            [requested loginRequest:post withUrl:strurl];
                            [self initFooterView];
                            loadLbl.text=@"loading...";
                        }
                    }
                    else
                    {
                        
                        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
                        {
                            // x+=1;
                            //   [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                            NSString *post = [NSString stringWithFormat:@"module=%@&page=%@&user_id=%@&price=%@&option=%@",_strmodule,_strpage,struseridnum,arrJsonPrice,stroptions];
                            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                            [requested loginRequest:post withUrl:strurl];
                            [self initFooterView];
                            loadLbl.text=@"loading...";
                        }
                        else
                        {
                            // x+=1;
                            //   [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                            NSString *post = [NSString stringWithFormat:@"module=%@&page=%@&category=%@&user_id=%@&option=%@&price=%@",_strmodule,_strpage,_strCategeoryid,struseridnum,stroptions,arrJsonPrice];
                            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                            [requested loginRequest:post withUrl:strurl];
                            [self initFooterView];
                            loadLbl.text=@"loading...";
                        }
                    }
                }
            }
        }
    }
}



-(void)responseLogin:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Dict Response: %@",responseDictionary);
    
    if (count==1)
    {
         count=2;
        if ([_strpage isEqualToString:@"2"])
        {
            NSArray *arr=[responseDictionary valueForKey:@"data"];
            
            arrCarslist=[[arrCarslist arrayByAddingObjectsFromArray:arr] mutableCopy];
            
            [tabl reloadData];
        }
        else
        {
            
        }
        
        _strpage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"nextPage"]];
    }
    else
    {
        
        _strpage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"nextPage"]];
        
        if ([_strpage isEqualToString:@"0"])
        {
            if (lastCount==1)
            {
                NSArray *arr=[responseDictionary valueForKey:@"data"];
                
                arrCarslist=[[arrCarslist arrayByAddingObjectsFromArray:arr] mutableCopy];
                
                [tabl reloadData];
                lastCount=2;
            }
        }
        else
        {
            NSArray *arr=[responseDictionary valueForKey:@"data"];
            
            arrCarslist=[[arrCarslist arrayByAddingObjectsFromArray:arr] mutableCopy];
            
            [tabl reloadData];
        }
    }
}


#pragma mark  ActivityIndicator At Bottom:

-(void)initFooterView
{
    footerview2 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 50.0)];
    actInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    actInd.tag = 10;
    actInd.frame = CGRectMake(self.view.frame.size.width/2-10, 5.0, 20.0, 20.0);
    actInd.hidden=YES;
    [actInd performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:30.0];
    [footerview2 addSubview:actInd];
    loadLbl=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 25, 200, 20)];
    loadLbl.textAlignment=NSTextAlignmentCenter;
    loadLbl.textColor=[UIColor lightGrayColor];
    // [loadLbl setFont:[UIFont fontWithName:@"System" size:2]];
    [loadLbl setFont:[UIFont systemFontOfSize:12]];
    [footerview2 addSubview:loadLbl];
    actInd = nil;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrool==1)
    {
        BOOL endOfTable = (scrollView.contentOffset.y >= 0);
        if ( endOfTable && !scrollView.dragging && !scrollView.decelerating)
        {
            if ([_strpage isEqualToString:@"0"])
            {
                tabl.tableFooterView = footerview2;
                [(UIActivityIndicatorView *)[footerview2 viewWithTag:10] stopAnimating];
                loadLbl.text=@"No More List";
                [actInd stopAnimating];
            }
            else
            {
                tabl.tableFooterView = footerview2;
                [(UIActivityIndicatorView *)[footerview2 viewWithTag:10] startAnimating];
            }
        }

    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrool==1)
    {
        footerview2.hidden=YES;
        loadLbl.hidden=YES;
    }
}


#pragma mark - Favorite list Clicked

-(void)favoritelistClicked:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:@"k" forKey:@"kk"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero
                                           toView:tabl];
    NSIndexPath *tappedIP = [tabl indexPathForRowAtPoint:buttonPosition];
    cell1 = [tabl cellForRowAtIndexPath: tappedIP];
    
    NSString *driverID= [NSString stringWithFormat:@"%@",[[arrCarslist objectAtIndex:sender.tag] valueForKey:@"id"]];
  //  NSString *faviD= [NSString stringWithFormat:@"%@",[[arrCarslist objectAtIndex:sender.tag] valueForKey:@"favorite"]];
    
    if([self.arryDatalistids containsObject:tappedIP])
    {
         [self.arryDatalistids removeObject:tappedIP];
        
         [self nextwithDriverid:driverID favid:@"1"];
        
    } else {
        [self.arryDatalistids addObject:tappedIP];
        
         [self nextwithDriverid:driverID favid:@"0"];
    }
    [tabl reloadData];
    
//    if ([faviD isEqualToString:@"0"])
//    {
//        [cell1.favoritebutt setImage:[UIImage imageNamed:@"hearts.png"] forState:UIControlStateNormal];
//        [cell1.favoritebutt setBackgroundImage:[UIImage imageNamed:@"hearts.png"] forState:UIControlStateNormal];
//    }
//    else
//    {
//         [cell1.favoritebutt setImage:[UIImage imageNamed:@"favorite-2.png"] forState:UIControlStateNormal];
//        [cell1.favoritebutt setBackgroundImage:[UIImage imageNamed:@"favorite-2.png"] forState:UIControlStateNormal];
//    }
    
   // [requested showMessage:[NSString stringWithFormat:@"Clicked button index %@",tappedIP] withTitle:@"Favorites"];
}

-(void)nextwithDriverid:(NSString *)dId favid:(NSString *)fid
{
    if ([fid isEqualToString:@"0"])
    {
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *post = [NSString stringWithFormat:@"post_id=%@&post_type=%@&user_id=%@",dId,_strmodule,struseridnum];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,addFavorites,english,strCityId];
        [requested sendRequest3:post withUrl:strurl];
    }
    else
    {
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *post = [NSString stringWithFormat:@"post_id=%@&post_type=%@&user_id=%@",dId,_strmodule,struseridnum];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,removeFavorites,english,strCityId];
        [requested sendRequest3:post withUrl:strurl];
    }
}


-(void)responsewithToken3:(NSMutableDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    
}


#pragma mark - Back Clicked

-(IBAction)BackbuttClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Makeids"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Modelids"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"indexcheck"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"kk"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
    
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Makeids"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Modelids"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.arryData removeAllObjects];
    strmakeids=@"";
    strmodelids=@"";
    [carpostdict removeAllObjects];
    
    NSIndexPath *myIP0 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *myIP1 = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *myIP2 = [NSIndexPath indexPathForRow:2 inSection:0];
    
    
    if ([_strmodule isEqualToString:@"car"])
    {
        if([self.arryData containsObject:myIP0]){
            
        } else {
            [self.arryData addObject:myIP0];
        }
        
        if([self.arryData containsObject:myIP1]){
            
        } else {
            [self.arryData addObject:myIP1];
        }
        
        if([self.arryData containsObject:myIP2]){
            
        } else {
            [self.arryData addObject:myIP2];
        }
        
        pricerangeView.hidden=NO;
        yearrangeView.hidden=YES;
        kmsrangeView.hidden=YES;
        
        [Dropobj fadeOut];
        labvali.hidden=YES;
        
        [popview endEditing:YES];
        [footerview endEditing:YES];
        [filterview endEditing:YES];
        [self.view endEditing:YES];
        
        [label removeFromSuperview];
        [self.rangeSlider removeFromSuperview];
        
        [label1 removeFromSuperview];
        [self.rangeSlider1 removeFromSuperview];
        
        [label2 removeFromSuperview];
        [self.rangeSlider2 removeFromSuperview];
        
        NSData *jsonData = [_strPrice dataUsingEncoding:NSUTF8StringEncoding];
        NSError *localError;
        arrPriceRange = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&localError];
        NSLog(@"%@", arrPriceRange);
        
        NSData *jsonData2 = [_strYear dataUsingEncoding:NSUTF8StringEncoding];
        NSError *localError2;
        arrYearRange = [NSJSONSerialization JSONObjectWithData:jsonData2 options: NSJSONReadingMutableContainers error:&localError2];
        NSLog(@"%@", arrYearRange);
        
        NSData *jsonData3 = [_strKMS dataUsingEncoding:NSUTF8StringEncoding];
        NSError *localError3;
        arrKmsRange = [NSJSONSerialization JSONObjectWithData:jsonData3 options: NSJSONReadingMutableContainers error:&localError3];
        NSLog(@"%@", arrKmsRange);
        
        [[NSUserDefaults standardUserDefaults]setObject:arrPriceRange forKey:@"pricerange"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrYearRange forKey:@"pricerange1"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrKmsRange forKey:@"pricerange2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self setUpViewComponents];
        [self setUpViewComponents1];
        [self setUpViewComponents2];
        
        
        [tablf reloadData];
    }
    else if ([_strmodule isEqualToString:@"jobs"])
    {
        [Dropobj fadeOut];
        [popview endEditing:YES];
        [footerview endEditing:YES];
        [filterview endEditing:YES];
        [self.view endEditing:YES];
        
        [tablf reloadData];
    }
    else if ([_strmodule isEqualToString:@"community"])
    {
        [Dropobj fadeOut];
        [popview endEditing:YES];
        [footerview endEditing:YES];
        [filterview endEditing:YES];
        [self.view endEditing:YES];
        
        [tablf reloadData];
    }
    else
    {
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            if ([_strmodule isEqualToString:@"numberplate"])
            {
                pricerangeView.hidden=NO;
                
                [label removeFromSuperview];
                [self.rangeSlider removeFromSuperview];
                [Dropobj fadeOut];
                
                
                [popview endEditing:YES];
                [footerview endEditing:YES];
                [filterview endEditing:YES];
                [self.view endEditing:YES];
                
                arrPriceRange=[[NSMutableArray alloc]init];
                NSData *jsonData = [_strPrice dataUsingEncoding:NSUTF8StringEncoding];
                NSError *localError;
                arrPriceRange = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&localError];
                NSLog(@"%@", arrPriceRange);
                
                [[NSUserDefaults standardUserDefaults]setObject:arrPriceRange forKey:@"pricerange"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [self setUpViewComponents];
                if([self.arryData containsObject:myIP0]){
                    
                } else {
                    [self.arryData addObject:myIP0];
                }
                [tablf reloadData];
            }
            else if ([_strmodule isEqualToString:@"jobs"])
            {
                [Dropobj fadeOut];
                [popview endEditing:YES];
                [footerview endEditing:YES];
                [filterview endEditing:YES];
                [self.view endEditing:YES];
                
                [tablf reloadData];
            }
            else if ([_strmodule isEqualToString:@"community"])
            {
                [Dropobj fadeOut];
                [popview endEditing:YES];
                [footerview endEditing:YES];
                [filterview endEditing:YES];
                [self.view endEditing:YES];
                
                [tablf reloadData];
            }
            else
            {
                pricerangeView.hidden=NO;
                
                
                [Dropobj fadeOut];
                [label removeFromSuperview];
                [self.rangeSlider removeFromSuperview];
                
                [popview endEditing:YES];
                [footerview endEditing:YES];
                [filterview endEditing:YES];
                [self.view endEditing:YES];
                
                arrPriceRange=[[NSMutableArray alloc]init];
                NSData *jsonData = [_strPrice dataUsingEncoding:NSUTF8StringEncoding];
                NSError *localError;
                arrPriceRange = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&localError];
                NSLog(@"%@", arrPriceRange);
                
                [[NSUserDefaults standardUserDefaults]setObject:arrPriceRange forKey:@"pricerange"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [self setUpViewComponents];
                
                if([self.arryData containsObject:myIP0]){
                    
                } else {
                    [self.arryData addObject:myIP0];
                }
                [tablf reloadData];
                
            }
            
        }
        else
        {
            pricerangeView.hidden=NO;
            
            
            [Dropobj fadeOut];
            [label removeFromSuperview];
            [self.rangeSlider removeFromSuperview];
            
            [popview endEditing:YES];
            [footerview endEditing:YES];
            [filterview endEditing:YES];
            [self.view endEditing:YES];
            
            arrPriceRange=[[NSMutableArray alloc]init];
            NSData *jsonData = [_strPrice dataUsingEncoding:NSUTF8StringEncoding];
            NSError *localError;
            arrPriceRange = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&localError];
            NSLog(@"%@", arrPriceRange);
            
            [[NSUserDefaults standardUserDefaults]setObject:arrPriceRange forKey:@"pricerange"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [self setUpViewComponents];
            
            if([self.arryData containsObject:myIP0]){
                
            } else {
                [self.arryData addObject:myIP0];
            }
            [tablf reloadData];
        }
    }
    


}


#pragma mark - Sort Clicked


-(void)sortClicked
{

    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height)];
    footerview.backgroundColor = [UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    [popview addSubview:footerview];
    
    
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 10)];
    lab1.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:lab1];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, footerview.frame.size.width, 50)];
    lab.text=@"Sort";
    lab.textColor=[UIColor whiteColor];
    lab.backgroundColor=[UIColor darkGrayColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont boldSystemFontOfSize:19];
    [footerview addSubview:lab];
    
    UIButton *butt11=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    [butt11 setTitle:@"Cancel" forState:UIControlStateNormal];
    butt11.titleLabel.font = [UIFont systemFontOfSize:15];
    butt11.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [butt11 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butt11 addTarget:self action:@selector(Cancelclickedf:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt11];
    
    
    
    sortbyDatebutt=[[UIButton alloc]initWithFrame:CGRectMake(0, lab.frame.size.height+lab.frame.origin.y+50, self.view.frame.size.width, 50)];
    [sortbyDatebutt setTitle:@"Sort By Date" forState:UIControlStateNormal];
    sortbyDatebutt.titleLabel.font = [UIFont systemFontOfSize:20];
    sortbyDatebutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [sortbyDatebutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sortbyDatebutt.backgroundColor=[UIColor lightGrayColor];
    [sortbyDatebutt addTarget:self action:@selector(SortbyDateClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:sortbyDatebutt];
    
    sortrecentitemsbutt=[[UIButton alloc]initWithFrame:CGRectMake(0, sortbyDatebutt.frame.size.height+sortbyDatebutt.frame.origin.y+10, self.view.frame.size.width, 50)];
    [sortrecentitemsbutt setTitle:@"Sort Recent Items" forState:UIControlStateNormal];
    sortrecentitemsbutt.titleLabel.font = [UIFont systemFontOfSize:20];
    sortrecentitemsbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [sortrecentitemsbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sortrecentitemsbutt.backgroundColor=[UIColor lightGrayColor];
    [sortrecentitemsbutt addTarget:self action:@selector(SortbyrecentItemsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:sortrecentitemsbutt];
    
    sortrecentitems2butt=[[UIButton alloc]initWithFrame:CGRectMake(0, sortrecentitemsbutt.frame.size.height+sortrecentitemsbutt.frame.origin.y+10, self.view.frame.size.width, 50)];
    [sortrecentitems2butt setTitle:@"Sort Recent Items" forState:UIControlStateNormal];
    sortrecentitems2butt.titleLabel.font = [UIFont systemFontOfSize:20];
    sortrecentitems2butt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [sortrecentitems2butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sortrecentitems2butt.backgroundColor=[UIColor lightGrayColor];
    [sortrecentitems2butt addTarget:self action:@selector(Sortbyrecentitems2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:sortrecentitems2butt];

}



#pragma mark - Sort By Date Clicked

-(IBAction)SortbyDateClicked:(id)sender
{
    sortbyDatebutt.backgroundColor=[UIColor redColor];
    sortrecentitemsbutt.backgroundColor=[UIColor lightGrayColor];
    sortrecentitems2butt.backgroundColor=[UIColor lightGrayColor];
}


-(IBAction)SortbyrecentItemsClicked:(id)sender
{
    sortbyDatebutt.backgroundColor=[UIColor lightGrayColor];
    sortrecentitemsbutt.backgroundColor=[UIColor redColor];
    sortrecentitems2butt.backgroundColor=[UIColor lightGrayColor];
}


-(IBAction)Sortbyrecentitems2Clicked:(id)sender
{
    sortbyDatebutt.backgroundColor=[UIColor lightGrayColor];
    sortrecentitemsbutt.backgroundColor=[UIColor lightGrayColor];
    sortrecentitems2butt.backgroundColor=[UIColor redColor];
    
    [footerview removeFromSuperview];
     popview.hidden = YES;
}


#pragma mark - Filter butt Clicked

-(IBAction)FilterbuttClicked:(id)sender
{
    if ([_strmodule isEqualToString:@"car"])
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,caroption,english,strCityId];
        [requested motorsMakeRequest:nil withUrl:strurl];
        
        
      //   [requested showMessage:@"Almost Finished.Little Changes Going On" withTitle:@"Car Filter"];
    }
    else
    {
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            if ([_strmodule isEqualToString:@"numberplate"])
            {
               arrcarcount=2;
                scrool=2;
                [self FilterClicked];
            }
            else
            {
//                if ([_strmodule isEqualToString:@"classified"]||[_strmodule isEqualToString:@"classified"]||[_strmodule isEqualToString:@"classified"])
//                {
                    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&category=%@",BaseUrl,strtoken,CategoryOption,english,strCityId,_strmodule,@"0"];
                    [requested CategoryOptionRequest:nil withUrl:strurl];
//                }
//                else
//                {
//                 [requested showMessage:@"Currently No Options are available for the Filter for this Categeory" withTitle:@""];
//                }
            }
        }
        else
        {
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&category=%@",BaseUrl,strtoken,CategoryOption,english,strCityId,_strmodule,_strCategeoryid];
            [requested CategoryOptionRequest:nil withUrl:strurl];
        }
    }
}


#pragma mark - Motor Delegate Response for Car Category


-(void)responsewithDataMakeMotor:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Motor Model English Response: %@",responseDictionary);
    NSArray *arrdata=[responseDictionary valueForKey:@"data"];
    
    if (arrcarcount==1)
    {
        arrcategeoryfilterby=[[arrcategeoryfilterby arrayByAddingObjectsFromArray:arrdata] mutableCopy];
        arrcarcount=2;
    }
    scrool=2;
    [self FilterClicked];
}


-(void)responseCategoryOption:(NSMutableDictionary *)responseDict
{
    NSLog(@" Category Option Response : %@",responseDict);
    
    NSString *message=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([message isEqualToString:@"0"])
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@",BaseUrl,strtoken,Option,english,strCityId,_strmodule];
        [requested OptionRequest:nil withUrl:strurl];
    }
    else
    {
        NSArray *arrdata=[responseDict valueForKey:@"data"];
        NSString *strdata=[arrdata componentsJoinedByString:@","];
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&optionId=%@",BaseUrl,strtoken,Option,english,strCityId,_strmodule,strdata];
        [requested OptionRequest:nil withUrl:strurl];
    }
}

-(void)responseOption:(NSMutableDictionary *)responseDict
{
    
    NSLog(@"Option list Response: %@",responseDict);
    
    NSString *stropt=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([stropt isEqualToString:@"0"])
    {
        [requested showMessage:@"Currently No Options are available for the Filter for this Categeory" withTitle:@""];
    }
    else
    {
    
        NSArray *arrdata=[responseDict valueForKey:@"data"];
    
        if (arrcarcount==1)
        {
            arrcategeoryfilterby=[[arrcategeoryfilterby arrayByAddingObjectsFromArray:arrdata] mutableCopy];
            arrcarcount=2;
        }
        scrool=2;
    
        if (arrcategeoryfilterby.count==0)
        {
            [requested showMessage:@"Currently No Options are available for the Filter for this Categeory" withTitle:@""];
        }
        else
        {
            [self FilterClicked];
        }
    }
}


#pragma mark - Filter By Clicked

-(void)FilterClicked
{
    self.hidesBottomBarWhenPushed = YES;
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height)];
    footerview.backgroundColor = [UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    [popview addSubview:footerview];
    
    
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 10)];
    lab1.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:lab1];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, footerview.frame.size.width, 50)];
    lab.text=@"Filter By";
    lab.textColor=[UIColor whiteColor];
    lab.backgroundColor=[UIColor darkGrayColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont boldSystemFontOfSize:19];
    [footerview addSubview:lab];
    
    UIButton *butt11=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    [butt11 setTitle:@"Cancel" forState:UIControlStateNormal];
    butt11.titleLabel.font = [UIFont systemFontOfSize:15];
    butt11.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [butt11 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butt11 addTarget:self action:@selector(Cancelclickedf:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt11];
    
    
//    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(1, lab.frame.origin.y+lab.frame.size.height, footerview.frame.size.width-2, 1)];
//    labeunder.backgroundColor=[UIColor lightGrayColor];
//    [footerview addSubview:labeunder];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(0,footerview.frame.size.height-50 ,160,50)];
    [butt setTitle:@"Reset" forState:UIControlStateNormal];
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    butt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt.backgroundColor=[UIColor grayColor];
    [butt addTarget:self action:@selector(ResetButtclickedf:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width, footerview.frame.size.height-50, footerview.frame.size.width-160, 50)];
    [butt1 setTitle:@"Apply" forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    butt1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.backgroundColor=[UIColor darkGrayColor];
    [butt1 addTarget:self action:@selector(ApplyButtclickedf:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt1];
    
    
//    UIButton *make=[[UIButton alloc] initWithFrame:CGRectMake(10, lab.frame.origin.y+lab.frame.size.height, 150, 50)];
//    [make setTitle:@"Make" forState:UIControlStateNormal];
//    make.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//    make.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [make setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    make.backgroundColor=[UIColor lightTextColor];
//    [make addTarget:self action:@selector(MakeButtClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [footerview addSubview:make];
//    
//    UIButton *model=[[UIButton alloc] initWithFrame:CGRectMake(10, lab.frame.origin.y+lab.frame.size.height+50, 150, 50)];
//    [model setTitle:@"Model" forState:UIControlStateNormal];
//    model.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//    model.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [model setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    model.backgroundColor=[UIColor lightTextColor];
//    [model addTarget:self action:@selector(ModelButtClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [footerview addSubview:model];
    
    if ([_strmodule isEqualToString:@"car"])
    {
        tablf=[[UITableView alloc] init];
        tablf.frame = CGRectMake(0,lab.frame.origin.y+lab.frame.size.height, 160, self.view.frame.size.height-110);
        [tablf setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        tablf.backgroundColor=[UIColor lightGrayColor];
        tablf.delegate=self;
        tablf.dataSource=self;
        tablf.tag=2;
        tablf.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [footerview addSubview:tablf];
        
        
        filterview=[[UIView alloc]initWithFrame:CGRectMake(160, lab.frame.origin.y+lab.frame.size.height, footerview.frame.size.width-160, self.view.frame.size.height-110)];
        filterview.backgroundColor=[UIColor clearColor];
        [footerview addSubview:filterview];
        
        
        pricerangeView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, filterview.frame.size.width-20, 100)];
        [self setUpViewComponents];
        //  pricerangeView.hidden=YES;
        [filterview addSubview:pricerangeView];
        
        
        yearrangeView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, filterview.frame.size.width-20, 100)];
        [self setUpViewComponents1];
        yearrangeView.hidden=YES;
        [filterview addSubview:yearrangeView];
        
        
        kmsrangeView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, filterview.frame.size.width-20, 100)];
        [self setUpViewComponents2];
        kmsrangeView.hidden=YES;
        [filterview addSubview:kmsrangeView];
    }
    else if ([_strmodule isEqualToString:@"jobs"])
    {
        tablf=[[UITableView alloc] init];
        tablf.frame = CGRectMake(0,lab.frame.origin.y+lab.frame.size.height, 160, self.view.frame.size.height-110);
        [tablf setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        tablf.backgroundColor=[UIColor lightGrayColor];
        tablf.delegate=self;
        tablf.dataSource=self;
        tablf.tag=4;
        tablf.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [footerview addSubview:tablf];
        
        
        filterview=[[UIView alloc]initWithFrame:CGRectMake(160, lab.frame.origin.y+lab.frame.size.height, footerview.frame.size.width-160, self.view.frame.size.height-110)];
        filterview.backgroundColor=[UIColor clearColor];
        [footerview addSubview:filterview];
    }
    else if ([_strmodule isEqualToString:@"community"])
    {
        tablf=[[UITableView alloc] init];
        tablf.frame = CGRectMake(0,lab.frame.origin.y+lab.frame.size.height, 160, self.view.frame.size.height-110);
        [tablf setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        tablf.backgroundColor=[UIColor lightGrayColor];
        tablf.delegate=self;
        tablf.dataSource=self;
        tablf.tag=4;
        tablf.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [footerview addSubview:tablf];
        
        
        filterview=[[UIView alloc]initWithFrame:CGRectMake(160, lab.frame.origin.y+lab.frame.size.height, footerview.frame.size.width-160, self.view.frame.size.height-110)];
        filterview.backgroundColor=[UIColor clearColor];
        [footerview addSubview:filterview];
    }
    else
    {
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            if ([_strmodule isEqualToString:@"numberplate"])
            {
                tablf=[[UITableView alloc] init];
                tablf.frame = CGRectMake(0,lab.frame.origin.y+lab.frame.size.height, 160, self.view.frame.size.height-110);
                [tablf setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                tablf.backgroundColor=[UIColor lightGrayColor];
                tablf.delegate=self;
                tablf.dataSource=self;
                tablf.tag=3;
                tablf.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                [footerview addSubview:tablf];
                
                
                filterview=[[UIView alloc]initWithFrame:CGRectMake(160, lab.frame.origin.y+lab.frame.size.height, footerview.frame.size.width-160, self.view.frame.size.height-110)];
                filterview.backgroundColor=[UIColor clearColor];
                [footerview addSubview:filterview];
                
                
                pricerangeView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, filterview.frame.size.width-20, 100)];
                [self setUpViewComponents];
                //  pricerangeView.hidden=YES;
                [filterview addSubview:pricerangeView];
            }
            else if ([_strmodule isEqualToString:@"jobs"])
            {
                tablf=[[UITableView alloc] init];
                tablf.frame = CGRectMake(0,lab.frame.origin.y+lab.frame.size.height, 160, self.view.frame.size.height-110);
                [tablf setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                tablf.backgroundColor=[UIColor lightGrayColor];
                tablf.delegate=self;
                tablf.dataSource=self;
                tablf.tag=4;
                tablf.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                [footerview addSubview:tablf];
                
                
                filterview=[[UIView alloc]initWithFrame:CGRectMake(160, lab.frame.origin.y+lab.frame.size.height, footerview.frame.size.width-160, self.view.frame.size.height-110)];
                filterview.backgroundColor=[UIColor clearColor];
                [footerview addSubview:filterview];
            }
            else if ([_strmodule isEqualToString:@"community"])
            {
                tablf=[[UITableView alloc] init];
                tablf.frame = CGRectMake(0,lab.frame.origin.y+lab.frame.size.height, 160, self.view.frame.size.height-110);
                [tablf setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                tablf.backgroundColor=[UIColor lightGrayColor];
                tablf.delegate=self;
                tablf.dataSource=self;
                tablf.tag=4;
                tablf.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                [footerview addSubview:tablf];
                
                
                filterview=[[UIView alloc]initWithFrame:CGRectMake(160, lab.frame.origin.y+lab.frame.size.height, footerview.frame.size.width-160, self.view.frame.size.height-110)];
                filterview.backgroundColor=[UIColor clearColor];
                [footerview addSubview:filterview];
            }
            else
            {
                tablf=[[UITableView alloc] init];
                tablf.frame = CGRectMake(0,lab.frame.origin.y+lab.frame.size.height, 160, self.view.frame.size.height-110);
                [tablf setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                tablf.backgroundColor=[UIColor lightGrayColor];
                tablf.delegate=self;
                tablf.dataSource=self;
                tablf.tag=3;
                tablf.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                [footerview addSubview:tablf];
                
                
                filterview=[[UIView alloc]initWithFrame:CGRectMake(160, lab.frame.origin.y+lab.frame.size.height, footerview.frame.size.width-160, self.view.frame.size.height-110)];
                filterview.backgroundColor=[UIColor clearColor];
                [footerview addSubview:filterview];
                
                
                pricerangeView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, filterview.frame.size.width-20, 100)];
                [self setUpViewComponents];
                //  pricerangeView.hidden=YES;
                [filterview addSubview:pricerangeView];
            }
        }
        else
        {
            tablf=[[UITableView alloc] init];
            tablf.frame = CGRectMake(0,lab.frame.origin.y+lab.frame.size.height, 160, self.view.frame.size.height-110);
            [tablf setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            tablf.backgroundColor=[UIColor lightGrayColor];
            tablf.delegate=self;
            tablf.dataSource=self;
            tablf.tag=3;
            tablf.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [footerview addSubview:tablf];
            
            
            filterview=[[UIView alloc]initWithFrame:CGRectMake(160, lab.frame.origin.y+lab.frame.size.height, footerview.frame.size.width-160, self.view.frame.size.height-110)];
            filterview.backgroundColor=[UIColor clearColor];
            [footerview addSubview:filterview];
            
            
            pricerangeView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, filterview.frame.size.width-20, 100)];
            [self setUpViewComponents];
            //  pricerangeView.hidden=YES;
            [filterview addSubview:pricerangeView];
        }
    }
}


-(IBAction)MakeButtClicked:(id)sender
{
    strids=@"1";
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@",BaseUrl,strtoken,carSubModule,english,strCityId,@"1"];
    [requested motorsEngRequest:nil withUrl:strurl];
}

-(void)responsewithDataEng:(NSMutableDictionary *)responseDict
{
    
    NSMutableArray *arrMotorList2=[[NSMutableArray alloc]init];
    arrMotorList2=[responseDict valueForKey:@"data"];
    
    arrmake=[arrMotorList2 valueForKey:@"make"];
    
    arrfueltype=[arrmake  valueForKey:@"name"];
    
    NSString *strname =@"Make";
    
    [Dropobj fadeOut];
    
    
    if ([UIScreen mainScreen].bounds.size.width < 350 )
    {
        [self showPopUpWithTitle:strname withOption:arrmake xy:CGPointMake(0, 0) size:CGSizeMake(self.view.frame.size.width-170,  self.view.frame.size.height-110) isMultiple:YES];
    }
    else
    {
        [self showPopUpWithTitle:strname withOption:arrmake xy:CGPointMake(0, 0) size:CGSizeMake(self.view.frame.size.width-170,  self.view.frame.size.height-110) isMultiple:YES];
    }
}

-(IBAction)ModelButtClicked:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?make=%@",BaseUrl,strtoken,carModel,english,strCityId,strmakeids];
    [requested OptionRequest2:nil withUrl:strurl];
}

-(void)responseOption2:(NSMutableDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    
    strids=@"3";
    arrMotorList=[[NSMutableArray alloc]init];
    arrMotorList=[responseDict valueForKey:@"data"];
    
    arrmodel=[arrMotorList valueForKey:@"make"];
    
    arrfueltype=[arrMotorList  valueForKey:@"name"];
    
    NSString *strname =@"Model";
    
    [Dropobj fadeOut];
    
    
    if ([UIScreen mainScreen].bounds.size.width < 350 )
    {
        [self showPopUpWithTitle:strname withOption:arrMotorList xy:CGPointMake(0, 0) size:CGSizeMake(self.view.frame.size.width-170,  self.view.frame.size.height-110) isMultiple:YES];
    }
    else
    {
        [self showPopUpWithTitle:strname withOption:arrMotorList xy:CGPointMake(0, 0) size:CGSizeMake(self.view.frame.size.width-170,  self.view.frame.size.height-110) isMultiple:YES];
    }
    
}


#pragma mark - Price Range Slider

- (void)setUpViewComponents
{
    // Text label
    label= [[UILabel alloc] initWithFrame:CGRectMake(5, 5, pricerangeView.frame.size.width-10, 35)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 2;
    label.font=[UIFont systemFontOfSize:12];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    
    // Init slider
    self.rangeSlider = [[MARKRangeSlider alloc] initWithFrame:CGRectMake(5, 50, pricerangeView.frame.size.width-10, 40)];
    self.rangeSlider.backgroundColor = [UIColor clearColor];
    self.rangeSlider.tintColor=[UIColor blackColor];
    [self.rangeSlider addTarget:self
                         action:@selector(rangeSliderValueDidChange:)
               forControlEvents:UIControlEventValueChanged];
    
    NSData *jsonData = [_strPrice dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError;
    arrPriceRange = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&localError];
    
    NSMutableArray *arrprice2=[[NSMutableArray alloc] init];
    arrprice2=[[NSUserDefaults standardUserDefaults]objectForKey:@"pricerange"];
    
   
    
    CGFloat p1 = [arrPriceRange[0] doubleValue];
    CGFloat p2 = [arrPriceRange[1] doubleValue];
    
    CGFloat p3 = [arrprice2[0] doubleValue];
    CGFloat p4 = [arrprice2[1] doubleValue];
    
    [self.rangeSlider setMinValue:p1 maxValue:p2];
    [self.rangeSlider setLeftValue:p3 rightValue:p4];
   
    
    self.rangeSlider.minimumDistance = 1000;
    
    [self updateRangeText];
    
    [pricerangeView addSubview:label];
    [pricerangeView addSubview:self.rangeSlider];
    
    
    NSData* data = [ NSJSONSerialization dataWithJSONObject:arrprice2 options:NSJSONWritingPrettyPrinted error:nil ];
    arrJsonPrice = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"Json Price %@",arrJsonPrice);
}


- (void)rangeSliderValueDidChange:(MARKRangeSlider *)slider
{
    [self updateRangeText];
}

- (void)updateRangeText
{
    //  NSLog(@"%0.2f - %0.2f", self.rangeSlider.leftValue, self.rangeSlider.rightValue);
    NSString *a=[NSString stringWithFormat:@"%f",self.rangeSlider.leftValue];
    NSString *bd=[NSString stringWithFormat:@"%f",self.rangeSlider.rightValue];
    
    int avalue=(int)[a integerValue];
    int bvalue=(int)[bd integerValue];
    
    strminRange=[NSString stringWithFormat:@"%d",avalue];
    strmaxrange=[NSString stringWithFormat:@"%d",bvalue];
    
    NSLog(@"%@",strminRange);
    NSLog(@"%@",strmaxrange);
    
    
    NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:strminRange,strmaxrange, nil];
    NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
    arrJsonPrice = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Json Price %@",arrJsonPrice);
    
    [[NSUserDefaults standardUserDefaults]setObject:arrdata forKey:@"pricerange"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSIndexPath *myIP0 = [NSIndexPath indexPathForRow:0 inSection:0];
    
    
    if([self.arryData containsObject:myIP0]){
        
    } else {
        [self.arryData addObject:myIP0];
    }
    [tablf reloadData];
    
//    [self.arryData addObject:@"0"];
//     [tablf reloadData];
    // tempIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    label.text = [NSString stringWithFormat:@"%d AED - %d AED",avalue, bvalue];
}


#pragma mark - Year Range Slider

- (void)setUpViewComponents1
{
    // Text label
    label1= [[UILabel alloc] initWithFrame:CGRectMake(5, 5, yearrangeView.frame.size.width-10, 35)];
    label1.backgroundColor = [UIColor clearColor];
    label1.numberOfLines = 2;
    label1.font=[UIFont systemFontOfSize:12];
    label1.textAlignment=NSTextAlignmentCenter;
    label1.textColor = [UIColor blackColor];
    
    // Init slider
    self.rangeSlider1 = [[MARKRangeSlider alloc] initWithFrame:CGRectMake(5, 50, yearrangeView.frame.size.width-10, 40)];
    self.rangeSlider1.backgroundColor = [UIColor clearColor];
    self.rangeSlider1.tintColor=[UIColor blackColor];
    [self.rangeSlider1 addTarget:self
                         action:@selector(rangeSliderValueDidChange1:)
               forControlEvents:UIControlEventValueChanged];
    
    
    NSMutableArray *arrprice2=[[NSMutableArray alloc] init];
    arrprice2=[[NSUserDefaults standardUserDefaults]objectForKey:@"pricerange1"];
    
    CGFloat p3 = [arrprice2[0] doubleValue];
    CGFloat p4 = [arrprice2[1] doubleValue];
    
    
    
    CGFloat p1 = [arrYearRange[0] doubleValue];
    CGFloat p2 = [arrYearRange[1] doubleValue];
    
    [self.rangeSlider1 setMinValue:p1 maxValue:p2];
    [self.rangeSlider1 setLeftValue:p3 rightValue:p4];
    
    self.rangeSlider1.minimumDistance = 1;
    
    [self updateRangeText1];
    
    [yearrangeView addSubview:label1];
    [yearrangeView addSubview:self.rangeSlider1];
    
    NSData* data = [ NSJSONSerialization dataWithJSONObject:arrprice2 options:NSJSONWritingPrettyPrinted error:nil ];
    arrJsonYear = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"Json Year %@",arrJsonYear);
}


- (void)rangeSliderValueDidChange1:(MARKRangeSlider *)slider
{
    [self updateRangeText1];
}

- (void)updateRangeText1
{
    //  NSLog(@"%0.2f - %0.2f", self.rangeSlider.leftValue, self.rangeSlider.rightValue);
    NSString *a=[NSString stringWithFormat:@"%f",self.rangeSlider1.leftValue];
    NSString *bd=[NSString stringWithFormat:@"%f",self.rangeSlider1.rightValue];
    
    int avalue=(int)[a integerValue];
    int bvalue=(int)[bd integerValue];
    
    strminRange=[NSString stringWithFormat:@"%d",avalue];
    strmaxrange=[NSString stringWithFormat:@"%d",bvalue];
    
    NSLog(@"Year %@",strminRange);
    NSLog(@"Year %@",strmaxrange);
    
    //    [self.arryData addObject:@"0"];
    //     [tablf reloadData];
    // tempIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    NSIndexPath *myIP0 = [NSIndexPath indexPathForRow:1 inSection:0];
    
    
    if([self.arryData containsObject:myIP0]){
       
    } else {
        [self.arryData addObject:myIP0];
    }
    [tablf reloadData];
    
    NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:strminRange,strmaxrange, nil];
    NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
    arrJsonYear = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Json Year %@",arrJsonYear);
    
    [[NSUserDefaults standardUserDefaults]setObject:arrdata forKey:@"pricerange1"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    label1.text = [NSString stringWithFormat:@"%d  - %d ",avalue, bvalue];
}



#pragma mark - KMS Range Slider

- (void)setUpViewComponents2
{
    // Text label
    label2= [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kmsrangeView.frame.size.width-10, 35)];
    label2.backgroundColor = [UIColor clearColor];
    label2.numberOfLines = 2;
    label2.font=[UIFont systemFontOfSize:12];
    label2.textAlignment=NSTextAlignmentCenter;
    label2.textColor = [UIColor blackColor];
    
    // Init slider
    self.rangeSlider2 = [[MARKRangeSlider alloc] initWithFrame:CGRectMake(5, 50, kmsrangeView.frame.size.width-10, 40)];
    self.rangeSlider2.backgroundColor = [UIColor clearColor];
    self.rangeSlider2.tintColor=[UIColor blackColor];
    [self.rangeSlider2 addTarget:self
                         action:@selector(rangeSliderValueDidChange2:)
               forControlEvents:UIControlEventValueChanged];
    
    NSMutableArray *arrprice2=[[NSMutableArray alloc] init];
    arrprice2=[[NSUserDefaults standardUserDefaults]objectForKey:@"pricerange2"];
    
    CGFloat p3 = [arrprice2[0] doubleValue];
    CGFloat p4 = [arrprice2[1] doubleValue];
    
    CGFloat p1 = [arrKmsRange[0] doubleValue];
    CGFloat p2 = [arrKmsRange[1] doubleValue];
    
    [self.rangeSlider2 setMinValue:p1 maxValue:p2];
    [self.rangeSlider2 setLeftValue:p3 rightValue:p4];
    
    self.rangeSlider2.minimumDistance = 1000;
    
    [self updateRangeText2];
    
    [kmsrangeView addSubview:label2];
    [kmsrangeView addSubview:self.rangeSlider2];
    
    NSData* data = [ NSJSONSerialization dataWithJSONObject:arrprice2 options:NSJSONWritingPrettyPrinted error:nil ];
    arrJsonKms = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"Json Kms %@",arrJsonKms);
}


- (void)rangeSliderValueDidChange2:(MARKRangeSlider *)slider
{
    [self updateRangeText2];
}

- (void)updateRangeText2
{
    //  NSLog(@"%0.2f - %0.2f", self.rangeSlider.leftValue, self.rangeSlider.rightValue);
    NSString *a=[NSString stringWithFormat:@"%f",self.rangeSlider2.leftValue];
    NSString *bd=[NSString stringWithFormat:@"%f",self.rangeSlider2.rightValue];
    
    int avalue=(int)[a integerValue];
    int bvalue=(int)[bd integerValue];
    
    strminRange=[NSString stringWithFormat:@"%d",avalue];
    strmaxrange=[NSString stringWithFormat:@"%d",bvalue];
    
    NSLog(@"%@",strminRange);
    NSLog(@"%@",strmaxrange);
    
    //    [self.arryData addObject:@"0"];
    //     [tablf reloadData];
    // tempIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    
    NSIndexPath *myIP0 = [NSIndexPath indexPathForRow:2 inSection:0];
    
    
    if([self.arryData containsObject:myIP0]){
        
    } else {
        [self.arryData addObject:myIP0];
    }
    [tablf reloadData];
    
    NSMutableArray *arrdata=[[NSMutableArray alloc]initWithObjects:strminRange,strmaxrange, nil];
    NSData* data = [ NSJSONSerialization dataWithJSONObject:arrdata options:NSJSONWritingPrettyPrinted error:nil ];
    arrJsonKms = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Json Kms %@",arrJsonKms);
    
    [[NSUserDefaults standardUserDefaults]setObject:arrdata forKey:@"pricerange2"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    label2.text = [NSString stringWithFormat:@"%d KMS - %d KMS",avalue, bvalue];
}





-(IBAction)ResetButtclickedf:(id)sender
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Makeids"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Modelids"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self.arryData removeAllObjects];
    strmakeids=@"";
    strmodelids=@"";
    [carpostdict removeAllObjects];
    
    NSIndexPath *myIP0 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *myIP1 = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *myIP2 = [NSIndexPath indexPathForRow:2 inSection:0];
   
    
    if ([_strmodule isEqualToString:@"car"])
    {
        if([self.arryData containsObject:myIP0]){
            
        } else {
            [self.arryData addObject:myIP0];
        }
        
        if([self.arryData containsObject:myIP1]){
            
        } else {
            [self.arryData addObject:myIP1];
        }

        if([self.arryData containsObject:myIP2]){
            
        } else {
            [self.arryData addObject:myIP2];
        }
        
        pricerangeView.hidden=NO;
        yearrangeView.hidden=YES;
        kmsrangeView.hidden=YES;
        
        [Dropobj fadeOut];
        labvali.hidden=YES;
        
        [popview endEditing:YES];
        [footerview endEditing:YES];
        [filterview endEditing:YES];
        [self.view endEditing:YES];
        
        [label removeFromSuperview];
        [self.rangeSlider removeFromSuperview];
        
        [label1 removeFromSuperview];
        [self.rangeSlider1 removeFromSuperview];
        
        [label2 removeFromSuperview];
        [self.rangeSlider2 removeFromSuperview];
        
        NSData *jsonData = [_strPrice dataUsingEncoding:NSUTF8StringEncoding];
        NSError *localError;
        arrPriceRange = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&localError];
        NSLog(@"%@", arrPriceRange);
        
        NSData *jsonData2 = [_strYear dataUsingEncoding:NSUTF8StringEncoding];
        NSError *localError2;
        arrYearRange = [NSJSONSerialization JSONObjectWithData:jsonData2 options: NSJSONReadingMutableContainers error:&localError2];
        NSLog(@"%@", arrYearRange);
        
        NSData *jsonData3 = [_strKMS dataUsingEncoding:NSUTF8StringEncoding];
        NSError *localError3;
        arrKmsRange = [NSJSONSerialization JSONObjectWithData:jsonData3 options: NSJSONReadingMutableContainers error:&localError3];
        NSLog(@"%@", arrKmsRange);
        
        [[NSUserDefaults standardUserDefaults]setObject:arrPriceRange forKey:@"pricerange"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrYearRange forKey:@"pricerange1"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrKmsRange forKey:@"pricerange2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
         [self setUpViewComponents];
         [self setUpViewComponents1];
         [self setUpViewComponents2];


        [tablf reloadData];
    }
    else if ([_strmodule isEqualToString:@"jobs"])
    {
        [Dropobj fadeOut];
        [popview endEditing:YES];
        [footerview endEditing:YES];
        [filterview endEditing:YES];
        [self.view endEditing:YES];
        
        [tablf reloadData];
    }
    else if ([_strmodule isEqualToString:@"community"])
    {
        [Dropobj fadeOut];
        [popview endEditing:YES];
        [footerview endEditing:YES];
        [filterview endEditing:YES];
        [self.view endEditing:YES];
        
        [tablf reloadData];
    }
    else
    {
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            if ([_strmodule isEqualToString:@"numberplate"])
            {
                pricerangeView.hidden=NO;
                
                [label removeFromSuperview];
                [self.rangeSlider removeFromSuperview];
                [Dropobj fadeOut];
                
                
                [popview endEditing:YES];
                [footerview endEditing:YES];
                [filterview endEditing:YES];
                [self.view endEditing:YES];
                
                arrPriceRange=[[NSMutableArray alloc]init];
                NSData *jsonData = [_strPrice dataUsingEncoding:NSUTF8StringEncoding];
                NSError *localError;
                arrPriceRange = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&localError];
                NSLog(@"%@", arrPriceRange);
                
                [[NSUserDefaults standardUserDefaults]setObject:arrPriceRange forKey:@"pricerange"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                 [self setUpViewComponents];
                if([self.arryData containsObject:myIP0]){
                    
                } else {
                    [self.arryData addObject:myIP0];
                }
                [tablf reloadData];
            }
            else
            {
                if ([_strmodule isEqualToString:@"numberplate"])
                {
                    [Dropobj fadeOut];
                    [popview endEditing:YES];
                    [footerview endEditing:YES];
                    [filterview endEditing:YES];
                    [self.view endEditing:YES];
                    
                    [tablf reloadData];
                }
                else if ([_strmodule isEqualToString:@"community"])
                {
                    [Dropobj fadeOut];
                    [popview endEditing:YES];
                    [footerview endEditing:YES];
                    [filterview endEditing:YES];
                    [self.view endEditing:YES];
                    
                    [tablf reloadData];
                }
                else
                {
                    pricerangeView.hidden=NO;
                    
                    
                    [Dropobj fadeOut];
                    [label removeFromSuperview];
                    [self.rangeSlider removeFromSuperview];
                    
                    [popview endEditing:YES];
                    [footerview endEditing:YES];
                    [filterview endEditing:YES];
                    [self.view endEditing:YES];
                    
                    arrPriceRange=[[NSMutableArray alloc]init];
                    NSData *jsonData = [_strPrice dataUsingEncoding:NSUTF8StringEncoding];
                    NSError *localError;
                    arrPriceRange = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&localError];
                    NSLog(@"%@", arrPriceRange);
                    
                    [[NSUserDefaults standardUserDefaults]setObject:arrPriceRange forKey:@"pricerange"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    [self setUpViewComponents];
                    
                    if([self.arryData containsObject:myIP0]){
                        
                    } else {
                        [self.arryData addObject:myIP0];
                    }
                    [tablf reloadData];
                }
            }
        }
        else
        {
            pricerangeView.hidden=NO;
          

            [Dropobj fadeOut];
            [label removeFromSuperview];
            [self.rangeSlider removeFromSuperview];
            
            [popview endEditing:YES];
            [footerview endEditing:YES];
            [filterview endEditing:YES];
            [self.view endEditing:YES];
            
            arrPriceRange=[[NSMutableArray alloc]init];
            NSData *jsonData = [_strPrice dataUsingEncoding:NSUTF8StringEncoding];
            NSError *localError;
            arrPriceRange = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&localError];
            NSLog(@"%@", arrPriceRange);
            
            [[NSUserDefaults standardUserDefaults]setObject:arrPriceRange forKey:@"pricerange"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [self setUpViewComponents];
            
            if([self.arryData containsObject:myIP0]){
                
            } else {
                [self.arryData addObject:myIP0];
            }
            [tablf reloadData];
        }
    }
    
    scrool=1;
//    self.hidesBottomBarWhenPushed = NO;
//    [footerview removeFromSuperview];
//    popview.hidden = YES;
}


-(IBAction)ApplyButtclickedf:(id)sender
{
    m=2;
    
    [self.arryDatalistids removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kk"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    lastCount=1;
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
//    jsonStringOptions = [jsonStringOptions stringByReplacingOccurrencesOfString:@"\\/" withString:@""];
   
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:carpostdict
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
         stroptions = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonString: %@",jsonStringOptions);
    }
//    NSString *stroptions=[jsonStringOptions stringByReplacingOccurrencesOfString:@"\\" withString:@""];
//    [[NSUserDefaults standardUserDefaults]setObject:@"sort" forKey:@"Carssec"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    if ([_strmodule isEqualToString:@"car"])
    {
        
        
        NSString *strtype=[[NSUserDefaults standardUserDefaults] objectForKey:@"Carssec"];
        
        
        if ([strtype isEqualToString:@"sort"])
        {
            
            if (strmakeids == (id)[NSNull null] || strmakeids.length == 0 )
            {
                if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
                {
                     NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                    NSString *post = [NSString stringWithFormat:@"price=%@&year=%@&kilometer=%@&option=%@&sort=%@&user_id=%@",arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,strSort,struseridnum];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                    [requested sendRequest2:post withUrl:strurl];
                    
                }
            }
            else
            {
                if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
                {
                     NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                    NSString *post = [NSString stringWithFormat:@"make=%@&price=%@&year=%@&kilometer=%@&option=%@&sort=%@&user_id=%@",strmakeids,arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,strSort,struseridnum];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                    [requested sendRequest2:post withUrl:strurl];
                }
                else
                {
                     NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                    NSString *post = [NSString stringWithFormat:@"make=%@&model=%@&option=%@&price=%@&year=%@&kilometer=%@&sort=%@&user_id=%@",strmakeids,strmodelids,stroptions,arrJsonPrice,arrJsonYear,arrJsonKms,strSort,struseridnum];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                    [requested sendRequest2:post withUrl:strurl];
                    
                }
            }

        }
        else
        {
            if (strmakeids == (id)[NSNull null] || strmakeids.length == 0 )
            {
                if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
                {
                     NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                    NSString *post = [NSString stringWithFormat:@"price=%@&year=%@&kilometer=%@&option=%@&user_id=%@",arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,struseridnum];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                    [requested sendRequest2:post withUrl:strurl];
                    
                }
            }
            else
            {
                if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
                {
                     NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                    NSString *post = [NSString stringWithFormat:@"make=%@&price=%@&year=%@&kilometer=%@&option=%@&user_id=%@",strmakeids,arrJsonPrice,arrJsonYear,arrJsonKms,stroptions,struseridnum];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                    [requested sendRequest2:post withUrl:strurl];
                }
                else
                {
                     NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                    NSString *post = [NSString stringWithFormat:@"make=%@&model=%@&option=%@&price=%@&year=%@&kilometer=%@&user_id=%@",strmakeids,strmodelids,stroptions,arrJsonPrice,arrJsonYear,arrJsonKms,struseridnum];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                    [requested sendRequest2:post withUrl:strurl];
                    
                }
            }

        }
    }
    else if ([_strmodule isEqualToString:@"jobs"])
    {
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            NSString *strtype=[[NSUserDefaults standardUserDefaults] objectForKey:@"Carssec"];
            if ([strtype isEqualToString:@"sort"])
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *post = [NSString stringWithFormat:@"module=%@&option=%@&category=%@&user_id=%@&sort=%@",_strmodule,stroptions,@"0",struseridnum,strSort];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }
            else
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *post = [NSString stringWithFormat:@"module=%@&option=%@&user_id=%@",_strmodule,stroptions,struseridnum];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }

        }
        else
        {
            NSString *strtype=[[NSUserDefaults standardUserDefaults] objectForKey:@"Carssec"];
            if ([strtype isEqualToString:@"sort"])
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *post = [NSString stringWithFormat:@"module=%@&option=%@&category=%@&user_id=%@&sort=%@",_strmodule,stroptions,_strCategeoryid,struseridnum,strSort];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }
            else
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *post = [NSString stringWithFormat:@"module=%@&option=%@&category=%@&user_id=%@",_strmodule,stroptions,_strCategeoryid,struseridnum];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }
           
        }
    }
    else if ([_strmodule isEqualToString:@"community"])
    {
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            NSString *strtype=[[NSUserDefaults standardUserDefaults] objectForKey:@"Carssec"];
            if ([strtype isEqualToString:@"sort"])
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *post = [NSString stringWithFormat:@"module=%@&option=%@&category=%@&user_id=%@&sort=%@",_strmodule,stroptions,@"0",struseridnum,strSort];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }
            else
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *post = [NSString stringWithFormat:@"module=%@&option=%@&user_id=%@",_strmodule,stroptions,struseridnum];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }

        }
        else
        {
            NSString *strtype=[[NSUserDefaults standardUserDefaults] objectForKey:@"Carssec"];
            if ([strtype isEqualToString:@"sort"])
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *post = [NSString stringWithFormat:@"module=%@&option=%@&category=%@&user_id=%@&sort=%@",_strmodule,stroptions,_strCategeoryid,struseridnum,strSort];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }
            else
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *post = [NSString stringWithFormat:@"module=%@&option=%@&category=%@&user_id=%@",_strmodule,stroptions,_strCategeoryid,struseridnum];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }
            
        }
    }
    else
    {
        if (_strCategeoryid == (id)[NSNull null] || _strCategeoryid.length == 0 )
        {
            if ([_strmodule isEqualToString:@"numberplate"])
            {
                NSString *strtype=[[NSUserDefaults standardUserDefaults] objectForKey:@"Carssec"];
                
                if ([strtype isEqualToString:@"sort"])
                {
                     NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&price=%@&option=%@&user_id=%@",_strmodule,strSort,arrJsonPrice,stroptions,struseridnum];
                    
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                    [requested sendRequest2:post withUrl:strurl];
                }
                else
                {
                     NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *post = [NSString stringWithFormat:@"module=%@&price=%@&option=%@&user_id=%@",_strmodule,arrJsonPrice,stroptions,struseridnum];
                    
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                    [requested sendRequest2:post withUrl:strurl];
                }

            }
            else
            {
                NSString *strtype=[[NSUserDefaults standardUserDefaults] objectForKey:@"Carssec"];
                
                
                if ([strtype isEqualToString:@"sort"])
                {
                    NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&price=%@&option=%@&user_id=%@",_strmodule,strSort,arrJsonPrice,stroptions,struseridnum];
                    
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                    [requested sendRequest2:post withUrl:strurl];
                }
                else
                {
                    NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *post = [NSString stringWithFormat:@"module=%@&price=%@&option=%@&user_id=%@",_strmodule,arrJsonPrice,stroptions,struseridnum];
                    
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                    [requested sendRequest2:post withUrl:strurl];
                }

            }
        }
        else
        {
            
            NSString *strtype=[[NSUserDefaults standardUserDefaults] objectForKey:@"Carssec"];
            
            
            if ([strtype isEqualToString:@"sort"])
            {
                 NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *post = [NSString stringWithFormat:@"module=%@&sort=%@&price=%@&option=%@&category=%@&user_id=%@",_strmodule,strSort,arrJsonPrice,stroptions,_strCategeoryid,struseridnum];
                
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                [requested sendRequest2:post withUrl:strurl];
            }
            else
            {
                 NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *post = [NSString stringWithFormat:@"module=%@&price=%@&option=%@&category=%@&user_id=%@",_strmodule,arrJsonPrice,stroptions,_strCategeoryid,struseridnum];
                
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
               [requested sendRequest2:post withUrl:strurl];
            }
           
        }
    }
}

-(void)responsewithToken2:(NSMutableDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"0"])
    {
        [requested showMessage:[responseDict valueForKey:@"message"] withTitle:@""];
    }
    else
    {
    
    [arrCarslist removeAllObjects];
    
    
    
    
//    if ([_strmodule isEqualToString:@"car"])
//    {
//        NSString *strp=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"price"]];
//        NSString *stry=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"year"]];
//        NSString *strk=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"kilometer"]];
//        
//        
//        NSData *jsonData = [strp dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *localError;
//        arrPriceRange = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&localError];
//        NSLog(@"%@", arrPriceRange);
//        
//        
//        NSData* data = [ NSJSONSerialization dataWithJSONObject:arrPriceRange options:NSJSONWritingPrettyPrinted error:nil ];
//        arrJsonPrice = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"Json Price %@",arrJsonPrice);
//        
//        NSData *jsonData2 = [stry dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *localError2;
//        arrYearRange = [NSJSONSerialization JSONObjectWithData:jsonData2 options: NSJSONReadingMutableContainers error:&localError2];
//        NSLog(@"%@", arrYearRange);
//        
//        NSData* data2 = [ NSJSONSerialization dataWithJSONObject:arrYearRange options:NSJSONWritingPrettyPrinted error:nil ];
//        arrJsonYear = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
//        NSLog(@"Json Year %@",arrJsonYear);
//        
//        NSData *jsonData3 = [strk dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *localError3;
//        arrKmsRange = [NSJSONSerialization JSONObjectWithData:jsonData3 options: NSJSONReadingMutableContainers error:&localError3];
//        NSLog(@"%@", arrKmsRange);
//        
//        NSData* data3 = [ NSJSONSerialization dataWithJSONObject:arrKmsRange options:NSJSONWritingPrettyPrinted error:nil ];
//        arrJsonKms = [[NSString alloc] initWithData:data3 encoding:NSUTF8StringEncoding];
//        NSLog(@"Json Kms %@",arrJsonKms);
//        
//    }
//    else if ([_strmodule isEqualToString:@"jobs"])
//    {
//      
//    }
//    else if ([_strmodule isEqualToString:@"community"])
//    {
//       
//    }
//    else
//    {
//       
//    }

    
    
    
    _arrDataList=[responseDict valueForKey:@"data"];
    _strpage=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"nextPage"]];
    
    count=1;
    [arrCarslist addObjectsFromArray:_arrDataList];
    
    [tabl reloadData];
    
    scrool=1;
    self.hidesBottomBarWhenPushed = NO;
    [footerview removeFromSuperview];
    popview.hidden = YES;
    }
}






- (void) switchIsChanged:(UISwitch *)paramSender
{
    if ([paramSender isOn])
    {
         switchstatuslab.text=@"ON";
    }
    else
    {
        switchstatuslab.text=@"OFF";
    }
}



-(IBAction)Cancelclickedf:(id)sender
{
    scrool=1;
    self.hidesBottomBarWhenPushed = NO;
    [footerview removeFromSuperview];
    
    popview.hidden = YES;
    
    scrool=1;

}


#pragma mark - View Controller life Cycle


-(void)viewWillAppear:(BOOL)animated
{
      [[NSNotificationCenter defaultCenter] postNotificationName:@"Midhun" object:nil];
    self.hidesBottomBarWhenPushed=YES;
}


#pragma mark - DropDown Menu Delegates

-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple
{
//    popview = [[UIView alloc]init];
//    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
//    [self.view addSubview:popview];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"filter" forKey:@"Options"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:filterview animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    // [Dropobj SetBackGroundDropDown_R:0.0 G:108.0 B:194.0 alpha:0.70];
    Dropobj.backgroundColor=[UIColor lightGrayColor];
}


//- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex
//{
//    /*----------------Get Selected Value[Single selection]-----------------*/
//    
//    UILabel *fCopyWidthLabel = (UILabel *)[motorView viewWithTag:b];
//    
//    fCopyWidthLabel.text=[arrfueltype objectAtIndex:anIndex];
//    
//    popview.hidden = YES;
//    
//    
//    //   NSMutableArray *arr=[[NSMutableArray alloc]init];
//    
//    NSArray *arr1=[[[DataMotorOptions objectAtIndex:b-1] valueForKey:@"values"] objectAtIndex:anIndex];
//    
//    NSString *strrep=[NSString stringWithFormat:@"%@",[arr1 valueForKey:@"id"]];
//    
//    if (carpostdict[stridforpost])
//    {
//        [carpostdict removeObjectForKey:stridforpost];
//        [carpostdict setObject:strrep forKey:stridforpost];
//    }
//    else
//    {
//        [carpostdict setObject:strrep forKey:stridforpost];
//    }
//    
//    NSLog(@"Car post Dictionary: %@",carpostdict);
//    
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:carpostdict
//                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
//                                                         error:&error];
//    
//    if (! jsonData) {
//        NSLog(@"Got an error: %@", error);
//    } else {
//        jsonStringOptions = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        NSLog(@"jsonString: %@",jsonStringOptions);
//    }
//    
//    
//    
//}

-(void)DropDownListView2:(DropDownListView *)dropdownListView Datalist:(NSMutableArray *)ArryData
{
    
    if (ArryData.count>0)
    {
        if ([strids isEqualToString:@"2"])
        {
            NSMutableArray *arrids=[[NSMutableArray alloc]init];
            
            for (int i=0; i<ArryData.count; i++)
            {
                NSMutableArray *arr=[[NSMutableArray alloc]init];
                
                NSArray *arr1=[[arrcategeoryfilterby objectAtIndex:b-1] valueForKey:@"values"];
                
                NSString *str1=[ArryData objectAtIndex:i];
                int j=(int)[str1 integerValue];
                
                [arr addObject:[[arr1 objectAtIndex:j]valueForKey:@"id"]];
                
                arrids=[[arrids arrayByAddingObjectsFromArray:arr] mutableCopy];
            }
            
            NSLog(@"%@",arrids);
            
            NSString *result = [arrids  componentsJoinedByString:@","];
            
            if (carpostdict[stridforpost])
            {
                [carpostdict removeObjectForKey:stridforpost];
                [carpostdict setObject:result forKey:stridforpost];
            }
            else
            {
                [carpostdict setObject:result forKey:stridforpost];
            }
            
            NSLog(@"Car post Dictionary: %@",carpostdict);
            
            if([self.arryData containsObject:index])
            {
                
            } else
            {
                [self.arryData addObject:index];
            }
            [tablf reloadData];
            
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:carpostdict
                                                               options:0 // Pass 0 if you don't care about the readability of the generated string
                                                                 error:&error];
            
            if (! jsonData) {
                NSLog(@"Got an error: %@", error);
            } else {
                jsonStringOptions = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                NSLog(@"jsonString: %@",jsonStringOptions);
            }

        }
        else if([strids isEqualToString:@"1"])
        {
            NSMutableArray *arrids=[[NSMutableArray alloc]init];
            
            for (int i=0; i<ArryData.count; i++)
            {
                NSMutableArray *arr=[[NSMutableArray alloc]init];
                NSString *str1=[ArryData objectAtIndex:i];
                int j=(int)[str1 integerValue];
                
                [arr addObject:[[arrmake objectAtIndex:j]valueForKey:@"id"]];
                
                arrids=[[arrids arrayByAddingObjectsFromArray:arr] mutableCopy];
            }
            
            NSLog(@"%@",arrids);
            
            strmakeids = [arrids  componentsJoinedByString:@","];
            
            NSLog(@"%@",strmakeids);
        }
        else
        {
            NSMutableArray *arrids=[[NSMutableArray alloc]init];
            
            for (int i=0; i<ArryData.count; i++)
            {
                NSMutableArray *arr=[[NSMutableArray alloc]init];
                NSString *str1=[ArryData objectAtIndex:i];
                int j=(int)[str1 integerValue];
                
                [arr addObject:[[arrMotorList objectAtIndex:j]valueForKey:@"id"]];
                
                arrids=[[arrids arrayByAddingObjectsFromArray:arr] mutableCopy];
            }
            
            NSLog(@"%@",arrids);
            
            strmodelids = [arrids  componentsJoinedByString:@","];
            
            NSLog(@"%@",strmodelids);
        }
    }
    else
    {
        if ([strids isEqualToString:@"2"])
        {
            [carpostdict removeObjectForKey:stridforpost];
            [self.arryData removeObject:index];
             [tablf reloadData];
        }
    }
    
}

-(void)DropDownListView3:(DropDownListView *)dropdownListView Datalist:(NSMutableArray *)ArryData
{
    
    if (ArryData.count>0)
    {
        if([strids isEqualToString:@"1"])
        {
            strmakeids = [ArryData  componentsJoinedByString:@","];
            
            NSLog(@"Make id: %@",strmakeids);
            
            
            if (strmakeids == (id)[NSNull null] || strmakeids.length == 0 )
            {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Makeids"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Modelids"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                NSIndexPath *myIP0 = [NSIndexPath indexPathForRow:3 inSection:0];
                [self.arryData removeObject:myIP0];
                
                NSIndexPath *myIP1 = [NSIndexPath indexPathForRow:4 inSection:0];
                [self.arryData removeObject:myIP1];
                
                 [tablf reloadData];
            }
            else
            {
                strmodelids=nil;
                
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Modelids"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
                NSIndexPath *myIP1 = [NSIndexPath indexPathForRow:4 inSection:0];
                [self.arryData removeObject:myIP1];
                
                
                [[NSUserDefaults standardUserDefaults]setObject:ArryData forKey:@"Makeids"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                NSIndexPath *myIP0 = [NSIndexPath indexPathForRow:3 inSection:0];
                
                
                if([self.arryData containsObject:myIP0])
                {
                    
                } else
                {
                    [self.arryData addObject:myIP0];
                }
                [tablf reloadData];
            }
            
        }
        else
        {
            strmodelids = [ArryData  componentsJoinedByString:@","];
            
            NSLog(@"Model Id: %@",strmodelids);
            
            
            if (strmodelids == (id)[NSNull null] || strmodelids.length == 0 )
            {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Modelids"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                NSIndexPath *myIP1 = [NSIndexPath indexPathForRow:4 inSection:0];
                [self.arryData removeObject:myIP1];
                
                [tablf reloadData];
            }
            else
            {
                
                [[NSUserDefaults standardUserDefaults]setObject:ArryData forKey:@"Modelids"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                NSIndexPath *myIP0 = [NSIndexPath indexPathForRow:4 inSection:0];
                
                
                if([self.arryData containsObject:myIP0])
                {
                    
                } else
                {
                    [self.arryData addObject:myIP0];
                }
                [tablf reloadData];
            }
        }

    }
    else
    {
        if([strids isEqualToString:@"1"])
        {
            strmakeids =nil;
            strmodelids=nil;
            
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Makeids"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Modelids"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSIndexPath *myIP0 = [NSIndexPath indexPathForRow:3 inSection:0];
            [self.arryData removeObject:myIP0];
                
            NSIndexPath *myIP1 = [NSIndexPath indexPathForRow:4 inSection:0];
            [self.arryData removeObject:myIP1];
                
            [tablf reloadData];
        }
        else
        {
             strmodelids=nil;
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Modelids"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            NSIndexPath *myIP1 = [NSIndexPath indexPathForRow:4 inSection:0];
            [self.arryData removeObject:myIP1];
                
            [tablf reloadData];
        }
    }
}

- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData
{
    /*----------------Get Selected Value[Multiple selection]-----------------*/
    
    if (ArryData.count>0)
    {
//        UILabel *fCopyWidthLabel = (UILabel *)[motorView viewWithTag:b];
//        
//        fCopyWidthLabel.text=[ArryData componentsJoinedByString:@", "];
        
        
    }
    else
    {
        
    }
    
//    [footerview removeFromSuperview];
//    popview.hidden = YES;
}

- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex
{
    
}

- (void)DropDownListViewDidCancel
{
    
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    
//    if ([touch.view isKindOfClass:[UIView class]]) {
//        [Dropobj fadeOut];
//       // popview.hidden = YES;
//    }
//}

-(CGSize)GetHeightDyanamic:(UILabel*)lbl
{
    NSRange range = NSMakeRange(0, [lbl.text length]);
    CGSize constraint;
    constraint= CGSizeMake(280 ,MAXFLOAT);
    CGSize size;
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)) {
        NSDictionary *attributes = [lbl.attributedText attributesAtIndex:0 effectiveRange:&range];
        CGSize boundingBox = [lbl.text boundingRectWithSize:constraint options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    }
    else
    {
        CGRect textRect = [lbl.text boundingRectWithSize:size
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:14]}
                                                 context:nil];
        size = textRect.size;
    }
    return size;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
