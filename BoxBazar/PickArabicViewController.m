//
//  PickArabicViewController.m
//  BoxBazar
//
//  Created by bharat on 13/02/17.
//  Copyright © 2017 Bharat. All rights reserved.
//

#import "PickArabicViewController.h"
#import "MVPlaceSearchTextField.h"
#import "DejalActivityView.h"
static NSString * const KMapPlacesApiKey = @"AIzaSyAdGRX5tONL2jVRCHDuNv5BZjuW-vLMwF4";
@interface PickArabicViewController ()

@end

@implementation PickArabicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"PickUp Location";
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}


-(void)viewDidAppear:(BOOL)animated
{
    _searchDropRef.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    
    _searchDropRef.autoCompleteBoldFontName = @"HelveticaNeue";
    
    _searchDropRef.autoCompleteTableCornerRadius=0.0;
    
    _searchDropRef.autoCompleteRowHeight=35;
    
    _searchDropRef.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
    
    _searchDropRef.autoCompleteFontSize=14;
    
    _searchDropRef.autoCompleteTableBorderWidth=1.0;
    
    _searchDropRef.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    
    _searchDropRef.autoCompleteShouldHideOnSelection=YES;
    
    _searchDropRef.autoCompleteShouldHideClosingKeyboard=YES;
    
    _searchDropRef.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    
    _searchDropRef.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_searchDropRef.frame.size.width)*0.01, _searchDropRef.frame.size.height+105.0, self.view.frame.size.width-0.1, 200.0);
}

#pragma mark - Place search Textfield Delegates

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict
{
    [self.view endEditing:YES];
    
    // NSString *strdata=_searchDropAddRef.text;
    [[NSUserDefaults standardUserDefaults]setObject:_searchDropRef.text forKey:@"latlong"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSDictionary *date=[[NSDictionary alloc] initWithObjectsAndKeys:_searchDropRef.text,@"Data", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"anyname" object:self userInfo:date];
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)placeSearchWillShowResult:(MVPlaceSearchTextField*)textField
{
    
}

-(void)placeSearchWillHideResult:(MVPlaceSearchTextField*)textField
{
    
}

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(UITableViewCell*)cell withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index
{
    
    if(index%2==0){
        
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        
    }else{
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    _searchDropRef.placeSearchDelegate                 = self;
    
    _searchDropRef.strApiKey                           = KMapPlacesApiKey;
    
    _searchDropRef.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    
    _searchDropRef.autoCompleteShouldHideOnSelection   = YES;
    
    _searchDropRef.maximumNumberOfAutoCompleteRows     = 5;
    
}




-(void)viewWillDisappear:(BOOL)animated
{
    //    NSDictionary *date=[[NSDictionary alloc] initWithObjectsAndKeys:_searchDropRef.text,@"Data", nil];
    //
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"anyname" object:self userInfo:date];
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}


- (IBAction)CurrentLocationClick:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    locationManager = [[CLLocationManager alloc] init];
    latitude = locationManager.location.coordinate.latitude;
    longitude =locationManager.location.coordinate.longitude;
    
    NSString *currentLatLong = [NSString stringWithFormat:@"%f,%f",latitude,longitude];
    [self getAddressFromLatLong:currentLatLong];
    
    NSLog(@"%f",latitude);
    NSLog(@"%f",longitude);
}

-(NSString*)getAddressFromLatLong : (NSString *)latLng
{
    NSString *esc_addr =  [latLng stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@&sensor=true", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    NSMutableDictionary *data = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding]options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *dataArray = (NSMutableArray *)[data valueForKey:@"results" ];
    if (dataArray.count == 0)
    {
        [DejalBezelActivityView removeView];
        NSString *message =@"Please enter a valid Address";
        UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
        [toast show];
        int duration = 1; // in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [toast dismissWithClickedButtonIndex:0 animated:YES];
        });
        
        
    }
    else
    {
        for (id firstTime in dataArray) {
            NSString *jsonStr1 = [firstTime valueForKey:@"formatted_address"];
            _searchDropRef.text=jsonStr1;
            [DejalBezelActivityView removeView];
            [[NSUserDefaults standardUserDefaults]setObject:_searchDropRef.text forKey:@"latlong"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.navigationController popViewControllerAnimated:YES];
            return jsonStr1;
        }
    }
    return nil;
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
