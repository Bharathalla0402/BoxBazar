//
//  ClassifiedlistViewController.m
//  BoxBazar
//
//  Created by bharat on 23/11/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "ClassifiedlistViewController.h"
#import "ApiRequest.h"
#import "DejalActivityView.h"
#import "BoxBazarUrl.pch"
#import "UIView+RNActivityView.h"
#import "CarNameViewController.h"
#import "SubCategeorylistViewController.h"

@interface ClassifiedlistViewController ()<ApiRequestdelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating>
{
    ApiRequest *requested;
    NSString *strnameUrlparameter,*strNmaeOfModule;
    
    UIView *topview;
    
    IBOutlet UITableView *tabl;
    UITableViewCell *cell;
    
    NSString *strModuleId,*strModuleName,*strModuleUrlParameter,*strHasChild;
    
    NSMutableArray *searchResults,*data;
    
    UISearchBar * theSearchBar;
}
@property (strong, nonatomic) UISearchController *searchController;
@end

@implementation ClassifiedlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performTask:) name:@"Midhun" object:nil];
     self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    
  //  NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:@"0",@"haschaild",@"0",@"id",@"All Classifieds",@"name", nil];
    
  //  NSLog(@"%@",dict);
    
  //  _arrChildCategory=[[NSMutableArray alloc]initWithObjects:dict, nil];
      [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    searchResults=[[NSMutableArray alloc]init];
    [self customtoggleview];
}

-(void)customtoggleview
{
    [requested checkNetworkStatus];
    
    isInternetConnectionAvailable=[[NSUserDefaults standardUserDefaults]objectForKey:@"internet"];
    
    if ([isInternetConnectionAvailable isEqualToString:@"NO"])
    {
        [requested showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again" withTitle:@"Message"];
    }
    else
    {
        
       // [self.navigationController.view showActivityViewWithLabel:@"Please Wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?category=%@",BaseUrl,strtoken,module,english,strCityId,@"2"];
        //  [requested OptionRequest4:nil withUrl:strurl];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:strurl]];
        [request setHTTPMethod:@"GET"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data1, NSURLResponse *response, NSError *error) {
            dispatch_async (dispatch_get_main_queue(), ^{
                
                if (error)
                {
                    
                } else
                {
                    if(data1 != nil) {
                        NSError *err;
                        NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data1 options:kNilOptions error:&err];
                        [self responseOption4:responseJSON];
                        [DejalBezelActivityView removeView];
                    }
                }
            });
        }] resume];

    }
 }

-(void)responseOption4:(NSMutableDictionary *)responseDict
{
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        [requested checkNetworkStatus];
        
        isInternetConnectionAvailable=[[NSUserDefaults standardUserDefaults]objectForKey:@"internet"];
        
        if ([isInternetConnectionAvailable isEqualToString:@"NO"])
        {
            [requested showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again" withTitle:@"Message"];
        }
        else
        {
            NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
            responseDictionary=responseDict;
          //  NSLog(@"Dict Response: %@",responseDictionary);
            
            strnameUrlparameter=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"url_parameter"];
            strNmaeOfModule=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"name"];
            
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,english,strCityId,strnameUrlparameter,@"category",@"0"];
            //  [requested SubCategoryRequest4:nil withUrl:strurl];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:strurl]];
            [request setHTTPMethod:@"GET"];
            [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request completionHandler:^(NSData *data1, NSURLResponse *response, NSError *error) {
                dispatch_async (dispatch_get_main_queue(), ^{
                    
                    if (error)
                    {
                        
                    } else
                    {
                        if(data1 != nil) {
                            NSError *err;
                            NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data1 options:kNilOptions error:&err];
                            [self responseSubCategory4:responseJSON];
                            [DejalBezelActivityView removeView];
                        }
                    }
                });
            }] resume];

        }
        
    }
    else
    {
        [requested showMessage:[responseDict valueForKey:@"message"] withTitle:@""];
    }
}

-(void)responseSubCategory4:(NSMutableDictionary *)responseDict
{
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        
     //   NSArray *arr=[responseDict valueForKey:@"data"];
        [theSearchBar resignFirstResponder];
        
        [_arrChildCategory removeAllObjects];
        [tabl reloadData];
        [theSearchBar removeFromSuperview];
        
        data=[responseDict valueForKey:@"data"];
        
        NSString *strna=[NSString stringWithFormat:@"All %@",@"Classifieds"];
        NSString *result = [[data valueForKey:@"id"] componentsJoinedByString:@","];
        
        
        NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:@"2",@"haschild",result,@"id",strna,@"name", nil];
        
        _arrChildCategory=[[NSMutableArray alloc] initWithObjects:dict, nil];
        
      //  NSLog(@"%@",_arrChildCategory);
        
        _arrChildCategory=[[_arrChildCategory arrayByAddingObjectsFromArray:data] mutableCopy];

        
        
        
      //  _arrChildCategory=[[_arrChildCategory arrayByAddingObjectsFromArray:arr] mutableCopy];
        
      //  _arrChildCategory=[responseDict valueForKey:@"data"];
        _strtitle=strNmaeOfModule;
        _strModule=strnameUrlparameter;
        
        [self customView];
        
        theSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)]; // frame has no effect.
        theSearchBar.delegate = self;
        theSearchBar.placeholder = @"Search Classifieds";
        theSearchBar.showsCancelButton = NO;
        
        
        tabl.tableHeaderView=theSearchBar;
        theSearchBar.userInteractionEnabled=YES;
        
        
        //        self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        //        self.searchController.searchResultsUpdater = self;
        //        self.searchController.dimsBackgroundDuringPresentation = NO;
        //        self.searchController.searchBar.delegate = self;
        //        self.searchController.navigationController.navigationBarHidden=YES;
        //        [[self.searchController navigationController] setNavigationBarHidden:YES animated:YES];
        //
        //        tabl.tableHeaderView = self.searchController.searchBar;

    }
    else
    {
        [requested showMessage:[responseDict valueForKey:@"message"] withTitle:@""];
    }
    
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchResults.count != 0)
    {
        [searchResults removeAllObjects];
        tabl.tag=1;
    }
    for (int i=0; i< [_arrChildCategory count]; i++)
    {
        // [searchResults removeAllObjects];
        NSString *string = [[_arrChildCategory objectAtIndex:i] valueForKey:@"name"];
        NSRange rangeValue = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (rangeValue.length > 0)
        {
            //  NSLog(@"string contains bla!");
            
            tabl.tag=2;
            [searchResults addObject:[_arrChildCategory objectAtIndex:i]];
        }
        else
        {
            //  NSLog(@"string does not contain bla");
        }
    }
    [tabl reloadData];
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}

- (void)searchBarCancelButtonClicked:(id)arg1;
{
    [theSearchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
}




- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    NSString *searchString = searchController.searchBar.text;
  //  NSLog(@"%@",searchString);
    [self filterContentForSearchText:searchString
                               scope:[[self.searchController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchController.searchBar
                                                     selectedScopeButtonIndex]]];
    [tabl reloadData];
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    if (searchResults.count != 0)
    {
        [searchResults removeAllObjects];
        tabl.tag=1;
    }
    for (int i=0; i< [_arrChildCategory count]; i++)
    {
        // [searchResults removeAllObjects];
        NSString *string = [[_arrChildCategory objectAtIndex:i] valueForKey:@"name"];
        NSRange rangeValue = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (rangeValue.length > 0)
        {
         //   NSLog(@"string contains bla!");
            
            tabl.tag=2;
            [searchResults addObject:[_arrChildCategory objectAtIndex:i]];
        }
        else
        {
          //  NSLog(@"string does not contain bla");
        }
    }
  //  NSLog(@"fiilterArray : %@",searchResults);
}


-(void)customView
{
    topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    topview.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [self.view addSubview:topview];
    topview.hidden=YES;
    
    UIButton *Backbutt=[[UIButton alloc] initWithFrame:CGRectMake(10, topview.frame.size.height/2-3, 20, 20)];
    [Backbutt setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    Backbutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [Backbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Backbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Backbutt addTarget:self action:@selector(BackbuttClickedjf:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt];
    
    UIButton *Backbutt2=[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 55, 55)];
    [Backbutt2 addTarget:self action:@selector(BackbuttClickedjf:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt2.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt2];
    
    UILabel *labtitle=[[UILabel alloc]initWithFrame:CGRectMake(topview.frame.size.width/2-120, topview.frame.size.height/2-10, 240, 30)];
    labtitle.text=_strtitle;
    labtitle.font=[UIFont boldSystemFontOfSize:17];
    labtitle.textColor=[UIColor whiteColor];
    labtitle.textAlignment=NSTextAlignmentCenter;
    [topview addSubview:labtitle];
    
     [tabl removeFromSuperview];
    
    tabl=[[UITableView alloc] init];
    tabl.frame = CGRectMake(0,5, self.view.frame.size.width, self.view.frame.size.height);
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tabl.backgroundColor=[UIColor clearColor];
    //  [tabl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tabl];
}

#pragma mark - Table View Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tabl.tag==2) {
        return [searchResults count];
        
    } else {
        return [_arrChildCategory count];
        
    }
    return _arrChildCategory.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    static NSString *cellIdetifier = @"Cell";
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
    
    
    if (tabl.tag==2)
    {
        NSString *strname=[[searchResults valueForKey:@"name"] objectAtIndex:indexPath.row];
        
        if ([strname isEqualToString:@"All Classifieds"])
        {
            cell.textLabel.text=strname;
            cell.textLabel.font=[UIFont boldSystemFontOfSize:18];
        }
        else
        {
            cell.textLabel.text = [[searchResults valueForKey:@"name"] objectAtIndex:indexPath.row];
        }
       // cell.textLabel.text =[[searchResults valueForKey:@"name"] objectAtIndex:indexPath.row];
    }
    else
    {
        
        NSString *strname=[[_arrChildCategory valueForKey:@"name"] objectAtIndex:indexPath.row];
        
        if ([strname isEqualToString:@"All Classifieds"])
        {
            cell.textLabel.text=strname;
            cell.textLabel.font=[UIFont boldSystemFontOfSize:18];
        }
        else
        {
         cell.textLabel.text = [[_arrChildCategory valueForKey:@"name"] objectAtIndex:indexPath.row];
        }
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tabl.tag==2) {
        strModuleId=[[searchResults valueForKey:@"id"]objectAtIndex:indexPath.row];
        strModuleName=[[searchResults valueForKey:@"name"]objectAtIndex:indexPath.row];
        strHasChild=[NSString stringWithFormat:@"%@",[[searchResults valueForKey:@"haschild"]objectAtIndex:indexPath.row]];
    } else {
        strModuleId=[[_arrChildCategory valueForKey:@"id"]objectAtIndex:indexPath.row];
        strModuleName=[[_arrChildCategory valueForKey:@"name"]objectAtIndex:indexPath.row];
        strHasChild=[NSString stringWithFormat:@"%@",[[_arrChildCategory valueForKey:@"haschild"]objectAtIndex:indexPath.row]];
    }
    //    strModuleId=[[_arrChildCategory valueForKey:@"id"]objectAtIndex:indexPath.row];
    //    strModuleName=[[_arrChildCategory valueForKey:@"name"]objectAtIndex:indexPath.row];
    strModuleUrlParameter=_strModule;
    
  //  NSLog(@"%@",strModuleId);
  //  NSLog(@"%@",strModuleName);
  //  NSLog(@"%@",strModuleUrlParameter);
  //  NSLog(@"%@",strHasChild);
    
    
    if ([strHasChild isEqualToString:@"1"])
    {
        [requested checkNetworkStatus];
        
        isInternetConnectionAvailable=[[NSUserDefaults standardUserDefaults]objectForKey:@"internet"];
        
        if ([isInternetConnectionAvailable isEqualToString:@"NO"])
        {
            [requested showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again" withTitle:@"Message"];
        }
        else
        {
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,english,strCityId,strModuleUrlParameter,@"category",strModuleId];
            [requested OtpVerifyRequest:nil withUrl:strurl];
        }
    }
    else
    {
        [requested checkNetworkStatus];
        
        isInternetConnectionAvailable=[[NSUserDefaults standardUserDefaults]objectForKey:@"internet"];
        
        if ([isInternetConnectionAvailable isEqualToString:@"NO"])
        {
            [requested showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again" withTitle:@"Message"];
        }
        else
        {
            if ([strModuleName isEqualToString:@"All Classifieds"])
            {
                [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *post = [NSString stringWithFormat:@"module=%@&user_id=%@",strModuleUrlParameter,struseridnum];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                [requested sendRequest1:post withUrl:strurl];
            }
            else
            {
                [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                //    NSString *strmodule=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"url_parameter"];
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *post = [NSString stringWithFormat:@"module=%@&category=%@&user_id=%@",strModuleUrlParameter,strModuleId,struseridnum];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
                [requested sendRequest1:post withUrl:strurl];
            }
        }
    }
}

-(void)responseRegistrationotp:(NSMutableDictionary *)responseDict
{
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
      //  NSLog(@"Jobs list Response: %@",responseDict);
        
        data=[responseDict valueForKey:@"data"];
        
        NSString *strname=[NSString stringWithFormat:@"All %@",strModuleName];
        NSString *result = [[data valueForKey:@"id"] componentsJoinedByString:@","];
      
        
        NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:@"2",@"haschild",result,@"id",strname,@"name", nil];
        
        NSMutableArray *arrdata=[[NSMutableArray alloc] initWithObjects:dict, nil];
        
         arrdata=[[arrdata arrayByAddingObjectsFromArray:data] mutableCopy];
        
        [self.navigationController.view hideActivityView];
        
        [self.searchController dismissViewControllerAnimated:YES completion:nil];
        [self.view endEditing:YES];
        
        SubCategeorylistViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"SubCategeorylistViewController"];
        post.arrChildCategory=arrdata;
        post.strModule=strModuleUrlParameter;
        post.strtitle=strModuleName;
        post.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:post animated:YES];

    }
    else
    {
        [requested showMessage:[responseDict valueForKey:@"message"] withTitle:@""];
    }

}


-(void)responsewithToken1:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
  //  NSLog(@"Dict Response: %@",responseDictionary);
    
    NSString *strmessage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"status"]];
    
    NSString *strpage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"nextPage"]];
    
    if ([strmessage isEqualToString:@"0"])
    {
        [requested showMessage:[NSString stringWithFormat:@"There is no More Data found for this category"] withTitle:@""];
    }
    else
    {
        if ([strModuleName isEqualToString:@"All Classifieds"])
        {
            [self.searchController dismissViewControllerAnimated:YES completion:nil];
            [self.view endEditing:YES];
            CarNameViewController *car=[self.storyboard instantiateViewControllerWithIdentifier:@"CarNameViewController"];
            car.arrDataList=[responseDictionary valueForKey:@"data"];
            car.strPrice=[responseDictionary valueForKey:@"price"];
            car.hidesBottomBarWhenPushed = YES;
            car.strmodule=strModuleUrlParameter;
            car.strname=strModuleName;
            car.strpage=strpage;
          //  car.strCategeoryid=strModuleId;
            [self.navigationController pushViewController:car animated:YES];
        }
        else
        {
        [self.searchController dismissViewControllerAnimated:YES completion:nil];
        [self.view endEditing:YES];
        CarNameViewController *car=[self.storyboard instantiateViewControllerWithIdentifier:@"CarNameViewController"];
        car.arrDataList=[responseDictionary valueForKey:@"data"];
        car.strPrice=[responseDictionary valueForKey:@"price"];
        car.hidesBottomBarWhenPushed = YES;
        car.strmodule=strModuleUrlParameter;
        car.strname=strModuleName;
        car.strpage=strpage;
        car.strCategeoryid=strModuleId;
        [self.navigationController pushViewController:car animated:YES];
        }
        //  self.searchController.active=false;
    }
}


#pragma mark - Back Clicked

-(IBAction)BackbuttClickedjf:(id)sender
{
    [self.searchController dismissViewControllerAnimated:YES completion:nil];
    
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    //   self.searchController.active=false;
}


#pragma mark - view will appear

-(IBAction)viewWillAppear:(BOOL)animated
{
    theSearchBar.userInteractionEnabled=NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Midhun" object:nil];
    [theSearchBar resignFirstResponder];
    [self customtoggleview];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.searchController setActive:YES];
    [self.searchController.searchBar becomeFirstResponder];
    [super viewDidAppear:animated];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

-(IBAction)performTask:(id)sender
{
    [theSearchBar resignFirstResponder];
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
