//
//  MotorFindsPerfectViewController.m
//  BoxBazar
//
//  Created by bharat on 04/08/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "MotorFindsPerfectViewController.h"
#import "ApiRequest.h"
#import "UIImageView+WebCache.h"
#import "FindCarViewController.h"
#import "DejalActivityView.h"
#import "BoxBazarUrl.pch"
#import "CarNameViewController.h"
#import "JobsListViewController.h"
#import "SubCategeorylistViewController.h"

@interface MotorFindsPerfectViewController ()<ApiRequestdelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating>
{
    ApiRequest *requested;
    UIView *topview;
    UITextField *txtCity;
    
    UIView *viewdas,*carslistView;
    
    UIView *popview;
    UIView *footerview;
    IBOutlet UITableView *tabl;
    UITableViewCell *cell;
    
    UIButton *btnSelected;
    
    NSMutableArray *arrCitys;
    
    UIScrollView *scrollMainView,*scrollSliderView,*scrollPopularbyYou;
    UIScrollView *Scrollview;
    
    UILabel *popularnearbyyoulab,*recentAddedinlab;
    
    NSString *strModuleId,*strModuleName,*strModuleUrlParameter;
    
    UIImageView *imageDis;
    UIButton *FindPerfectCarbutt;
    NSString *StrimageName;
    
     NSMutableArray *searchResults,*data;
    
    UISearchBar * theSearchBar;
}
typedef enum{
    buttontag1= 0,
    imageTAg = 100
}buttontag;
@property (strong, nonatomic) UISearchController *searchController;
@end

@implementation MotorFindsPerfectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performTask:) name:@"Midhun" object:nil];
    _citylistView.hidden=YES;
   
    
     searchResults=[[NSMutableArray alloc]init];
    arrCitys=[[NSMutableArray alloc]init];
    NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
    NSData *datalist = [defaults2 objectForKey:@"Citys"];
    arrCitys=[NSKeyedUnarchiver unarchiveObjectWithData:datalist];
    _topView.hidden=YES;
    _dohaButt.hidden=YES;
    _backbutton.hidden=YES;
    
    _topView.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    
  //  _topView.hidden=YES;
    
    _CustomSearchbar.barTintColor=[UIColor clearColor];
    _CustomSearchbar.searchBarStyle = UISearchBarStyleMinimal;
    _crossbutt.hidden=YES;
    _CustomSearchbar.hidden=YES;
    
  
    
  //  DataArray=[[NSMutableArray alloc]initWithObjects:@"Heavy",@"Car",@"bike", nil];
    
    imageArray=[[NSMutableArray alloc]initWithObjects:@"volkswagen-car-side-view.png",@"clutch.png",@"ship.png",@"truck.png",@"all-terrain-vehicle-motorbike.png",@"price-match.jpg", nil];
    
    NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];
    NSObject *object2 = [prefs2 objectForKey:@"City"];
    if(object2!= nil)
    {
        // txtCity.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"City"];
        [_dohaButt setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"City"] forState:UIControlStateNormal];
    }
    else
    {
        [_dohaButt setTitle:@"Select City" forState:UIControlStateNormal];
    }

 //   [_dohaButt setTitle:@"Ajman" forState:UIControlStateNormal];
    
 //   [tabl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
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
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?category=%@",BaseUrl,strtoken,module,english,strCityId,@"1"];
       // [requested emptyOptionRequest:nil withUrl:strurl];
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:strurl]];
        [request setHTTPMethod:@"GET"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *datas, NSURLResponse *response, NSError *error) {
            dispatch_async (dispatch_get_main_queue(), ^{
                
                if (error)
                {
                    
                } else
                {
                    if(datas != nil) {
                        NSError *err;
                        NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:datas options:kNilOptions error:&err];
                        [self emptyresponseOption:responseJSON];
                        [DejalBezelActivityView removeView];
                    }
                }
            });
        }] resume];
    }
    
  
    
    
    
 //   [self customView];
    
//    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
//    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
//    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
//    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,citylist,english,strCityId];
//    [requested CitysRequest:nil withUrl:strurl];
}

-(void)responsewithCitylist:(NSMutableDictionary *)responseDict
{
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
        responseDictionary=responseDict;
       // NSLog(@"City list Response: %@",responseDictionary);
        arrCitys=[responseDict valueForKey:@"data"];

    }
    else
    {
        [requested showMessage:[responseDict valueForKey:@"message"] withTitle:@""];
    }
}

-(void)emptyresponseOption:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
  //  NSLog(@"Motor English Response: %@",responseDictionary);
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        
        [DataArray removeAllObjects];
         [tabl reloadData];
        [theSearchBar removeFromSuperview];

        
        NSArray *arr=[responseDictionary valueForKey:@"data"];
        
        NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"module_id",@"All Motors",@"name",@"car",@"url_parameter", nil];
        
        //  NSLog(@"%@",dict);
        
        DataArray=[[NSMutableArray alloc]initWithObjects:dict, nil];
        
        DataArray=[[DataArray arrayByAddingObjectsFromArray:arr] mutableCopy];
        
//        NSMutableArray *arrMotorList=[[NSMutableArray alloc]init];
//        arrMotorList=[responseDictionary valueForKey:@"data"];
//        
//        NSData *datah = [NSKeyedArchiver archivedDataWithRootObject:arrMotorList];
//        
//        [[NSUserDefaults standardUserDefaults]setObject:datah forKey:@"MotorEng"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        
//        
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSData *datas = [defaults objectForKey:@"MotorEng"];
//        
//        DataArray = [NSKeyedUnarchiver unarchiveObjectWithData:datas];
        
        [self customview21];
        
    }
    else
    {
        [requested showMessage:[responseDictionary valueForKey:@"message"] withTitle:@"Message"];
    }
}




-(void)customview21
{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 70, self.view.frame.size.width-20, 30)];
    label.text=@"More Export With...";
    label.hidden=YES;
    [label setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:label];
    
    UIView *viewback=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    viewback.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    [self.view addSubview:viewback];
    
    [tabl removeFromSuperview];
    
    tabl=[[UITableView alloc] init];
    tabl.frame = CGRectMake(0,5, self.view.frame.size.width, self.view.frame.size.height-10);
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.tag=2;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tabl.backgroundColor=[UIColor clearColor];
  //  [tabl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tabl];
    
    theSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)]; // frame has no effect.
    theSearchBar.delegate = self;
    theSearchBar.placeholder = @"Search Motors";
    theSearchBar.showsCancelButton = NO;
    
    
    tabl.tableHeaderView=theSearchBar;
    theSearchBar.userInteractionEnabled=YES;

    
//    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//    self.searchController.searchResultsUpdater = self;
//    self.searchController.dimsBackgroundDuringPresentation = NO;
//    self.searchController.searchBar.delegate = self;
//    self.searchController.navigationController.navigationBarHidden=YES;
//    [[self.searchController navigationController] setNavigationBarHidden:YES animated:YES];
//    
//    tabl.tableHeaderView = self.searchController.searchBar;
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchResults.count != 0)
    {
        [searchResults removeAllObjects];
        tabl.tag=1;
    }
    for (int i=0; i< [DataArray count]; i++)
    {
        // [searchResults removeAllObjects];
        NSString *string = [[DataArray objectAtIndex:i] valueForKey:@"name"];
        NSRange rangeValue = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (rangeValue.length > 0)
        {
            //   NSLog(@"string contains bla!");
            
            tabl.tag=3;
            [searchResults addObject:[DataArray objectAtIndex:i]];
        }
        else
        {
            // NSLog(@"string does not contain bla");
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
    for (int i=0; i< [DataArray count]; i++)
    {
        // [searchResults removeAllObjects];
        NSString *string = [[DataArray objectAtIndex:i] valueForKey:@"name"];
        NSRange rangeValue = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (rangeValue.length > 0)
        {
         //   NSLog(@"string contains bla!");
            
            tabl.tag=3;
            [searchResults addObject:[DataArray objectAtIndex:i]];
        }
        else
        {
           // NSLog(@"string does not contain bla");
        }
    }
  //  NSLog(@"fiilterArray : %@",searchResults);
}




-(void)customView
{
    topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    topview.backgroundColor=[UIColor darkGrayColor];
    [self.view addSubview:topview];
    
    UIButton *Backbutt=[[UIButton alloc] initWithFrame:CGRectMake(10, topview.frame.size.height/2-5, 25, 25)];
    [Backbutt setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    Backbutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [Backbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Backbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Backbutt addTarget:self action:@selector(BackbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt];
    
    UIButton *SearchButt=[[UIButton alloc] initWithFrame:CGRectMake(topview.frame.size.width-35, topview.frame.size.height/2-5, 25, 25)];
    [SearchButt setImage:[UIImage imageNamed:@"musica-searcher.png"] forState:UIControlStateNormal];
    SearchButt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [SearchButt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    SearchButt.titleLabel.font = [UIFont systemFontOfSize:15];
    [SearchButt addTarget:self action:@selector(SearchbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    SearchButt.backgroundColor=[UIColor clearColor];
    [topview addSubview:SearchButt];
    
    txtCity=[[UITextField alloc]initWithFrame:CGRectMake(topview.frame.size.width/2-40, topview.frame.size.height/2-5, 60, 24)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Select City" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    txtCity.attributedPlaceholder = str;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"City"];
    if(object != nil)
    {
        txtCity.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"City"];
    }
    else
    {
        txtCity.text=@"Select City";
    }
    [txtCity sizeToFit];
    txtCity.textAlignment=NSTextAlignmentCenter;
    txtCity.textColor=[UIColor whiteColor];
    txtCity.font = [UIFont boldSystemFontOfSize:17];
    txtCity.backgroundColor=[UIColor clearColor];
    [topview addSubview:txtCity];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(txtCity.frame.size.width+txtCity.frame.origin.x,topview.frame.size.height/2-3, 24, 24)];
    image3.image=[UIImage imageNamed:@"down-arrow-2.png"];
    [topview addSubview:image3];
    
    
//    UIButton *CityButt = [UIButton buttonWithType:UIButtonTypeCustom];
//    [CityButt setFrame:CGRectMake(topview.frame.size.width/2-65, topview.frame.size.height/2-5, 160, 24)];
//    [CityButt setTitle:@"Dubai" forState:UIControlStateNormal];
//      CityButt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    [CityButt setBackgroundImage:[[UIImage imageNamed:@"down-arrow-2.png"]
//                                      stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
//    [CityButt setImage:[UIImage imageNamed:@"down-arrow-2.png"] forState:UIControlStateNormal];
//    [CityButt addTarget:self action:@selector(CitybuttClicked:)
//           forControlEvents:UIControlEventTouchUpInside];
//    [topview addSubview:CityButt];
    
    UIButton *CityButt=[[UIButton alloc] initWithFrame:CGRectMake(topview.frame.size.width/2-65, topview.frame.size.height/2-5, 160, 24)];
    [CityButt addTarget:self action:@selector(CitybuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    CityButt.backgroundColor=[UIColor clearColor];
    [topview addSubview:CityButt];
    
    topview.hidden=YES;
    
    scrollMainView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height)];
    scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 680);
    [self.view addSubview:scrollMainView];
    
    [self vehicleView];
    
    popularnearbyyoulab=[[UILabel alloc]initWithFrame:CGRectMake(5, carslistView.frame.size.height+carslistView.frame.origin.y+10, self.view.frame.size.width-30, 30)];
    popularnearbyyoulab.text=@"Popular Near You";
    popularnearbyyoulab.textColor=[UIColor blackColor];
    popularnearbyyoulab.textAlignment=NSTextAlignmentLeft;
    popularnearbyyoulab.font=[UIFont boldSystemFontOfSize:17];
    [scrollMainView addSubview:popularnearbyyoulab];
    
    [self PopularNearbyYou];
    
    
    recentAddedinlab=[[UILabel alloc]initWithFrame:CGRectMake(5, carslistView.frame.size.height+carslistView.frame.origin.y+180, self.view.frame.size.width-30, 30)];
    NSString *strlist=[NSString stringWithFormat:@"Recent Added in %@",txtCity.text];
    recentAddedinlab.text=strlist;
    recentAddedinlab.textColor=[UIColor blackColor];
    recentAddedinlab.textAlignment=NSTextAlignmentLeft;
    recentAddedinlab.font=[UIFont boldSystemFontOfSize:17];
    [scrollMainView addSubview:recentAddedinlab];
    
    [self RecentAdded];
}

-(void)vehicleView
{
    carslistView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    carslistView.backgroundColor=[UIColor lightGrayColor];
    [scrollMainView addSubview:carslistView];

    scrollSliderView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    scrollSliderView.contentSize=CGSizeMake((DataArray.count)*(120), 120);
    scrollSliderView.backgroundColor=[UIColor clearColor];
    scrollSliderView.showsHorizontalScrollIndicator=NO;
    scrollSliderView.scrollEnabled=YES;
    scrollSliderView.userInteractionEnabled=YES;
    
    int x=0;
    for (int i=0; i<DataArray.count; i++)
    {
        viewdas=[[UIView alloc]initWithFrame:CGRectMake(x, 0, 120, 120)];
        viewdas.backgroundColor=[UIColor clearColor];
       
        
        UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(viewdas.frame.size.width/2-25, viewdas.frame.size.height/2-50 , 50, 50)];
       // [image sd_setImageWithURL:[NSURL URLWithString:@""]
           //      placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
        NSString *imageName=[imageArray objectAtIndex:i];
        image.image=[UIImage imageNamed:imageName];
        [viewdas addSubview:image];
        
        UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(viewdas.frame.size.width/2-60, viewdas.frame.size.height/2-5, 120, 25)];
        
        NSString *abc =[[DataArray objectAtIndex:i] valueForKey:@"url_parameter"];
        abc = [NSString stringWithFormat:@"%@%@",[[abc substringToIndex:1] uppercaseString],[abc substringFromIndex:1] ];
        lbltitle.text=abc;
        lbltitle.textColor=[UIColor whiteColor];
        lbltitle.textAlignment=NSTextAlignmentCenter;
        lbltitle.numberOfLines=2;
        lbltitle.font=[UIFont boldSystemFontOfSize:17];
        [viewdas addSubview:lbltitle];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.selected = !i;
        btnSelected = btn.selected?btn:btnSelected;
        btn.frame = CGRectMake(0, 0, viewdas.frame.size.width, viewdas.frame.size.height);
        btn.backgroundColor=[UIColor clearColor];
        //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-white.png"] forState:UIControlStateNormal];
        //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-voilet.png"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(TypeoflistCarsclicked:) forControlEvents:UIControlEventTouchUpInside];
        [viewdas addSubview:btn];
        
        [scrollSliderView addSubview:viewdas];
        
        x+=120;
    }
    
    [carslistView addSubview:scrollSliderView];
    
    
    
    imageDis=[[UIImageView alloc] initWithFrame:CGRectMake(20, viewdas.frame.size.height+viewdas.frame.origin.y, 40, 40)];
    NSString *imageName=[imageArray objectAtIndex:0];
    imageDis.image=[UIImage imageNamed:imageName];
    [carslistView addSubview:imageDis];
    
    
    FindPerfectCarbutt=[[UIButton alloc]initWithFrame:CGRectMake(imageDis.frame.size.width+imageDis.frame.origin.x+10, viewdas.frame.size.height+viewdas.frame.origin.y, carslistView.frame.size.width-70, 40)];
    NSString *strtile=[NSString stringWithFormat:@"Find Perfect %@",[[DataArray objectAtIndex:0]valueForKey:@"url_parameter"]];
    [FindPerfectCarbutt setTitle:strtile forState:UIControlStateNormal];
    FindPerfectCarbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [FindPerfectCarbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    FindPerfectCarbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [FindPerfectCarbutt addTarget:self action:@selector(FindperfectcarButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    FindPerfectCarbutt.backgroundColor=[UIColor clearColor];
    [carslistView addSubview:FindPerfectCarbutt];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(carslistView.frame.size.width-40,viewdas.frame.size.height+viewdas.frame.origin.y+8, 24, 24)];
    image3.image=[UIImage imageNamed:@"right-arrow-3.png"];
    [carslistView addSubview:image3];
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(20, FindPerfectCarbutt.frame.origin.y+FindPerfectCarbutt.frame.size.height+4, carslistView.frame.size.width-40, 3)];
    label1.backgroundColor=[UIColor whiteColor];
    [carslistView addSubview:label1];
}


-(void)PopularNearbyYou
{
    scrollPopularbyYou=[[UIScrollView alloc]initWithFrame:CGRectMake(0, popularnearbyyoulab.frame.size.height+popularnearbyyoulab.frame.origin.y+10, self.view.frame.size.width, 120)];
    scrollPopularbyYou.contentSize=CGSizeMake((DataArray.count)*(106), 120);
    scrollPopularbyYou.backgroundColor=[UIColor clearColor];
    scrollPopularbyYou.showsHorizontalScrollIndicator=NO;
    scrollPopularbyYou.scrollEnabled=YES;
    scrollPopularbyYou.userInteractionEnabled=YES;
    

    
    int x=0;
    for (int i=0; i<DataArray.count; i++)
    {
        viewdas=[[UIView alloc]initWithFrame:CGRectMake(x+10, 0, 98, 120)];
        viewdas.backgroundColor=[UIColor clearColor];
        viewdas.layer.borderColor = [UIColor lightGrayColor].CGColor;
        viewdas.layer.borderWidth = 1.0f;
        
        UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
         [image sd_setImageWithURL:[NSURL URLWithString:@""]
              placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
//        NSString *imageName=[imageArray objectAtIndex:i];
//        image.image=[UIImage imageNamed:imageName];
        [viewdas addSubview:image];
        
        UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(10, image.frame.size.height+image.frame.origin.y, 80, 30)];
        lbltitle.text=@"Cars";
        lbltitle.textColor=[UIColor blackColor];
        lbltitle.textAlignment=NSTextAlignmentCenter;
        lbltitle.numberOfLines=2;
        lbltitle.font=[UIFont boldSystemFontOfSize:15];
        [viewdas addSubview:lbltitle];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.selected = !i;
        btnSelected = btn.selected?btn:btnSelected;
        btn.frame = CGRectMake(0, 0, 100, 120);
        btn.backgroundColor=[UIColor clearColor];
        //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-white.png"] forState:UIControlStateNormal];
        //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-voilet.png"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(PopularnearbyyouCarsclicked:) forControlEvents:UIControlEventTouchUpInside];
        [viewdas addSubview:btn];
        
        [scrollPopularbyYou addSubview:viewdas];
        
        x+=105;
    }
    
    [scrollMainView addSubview:scrollPopularbyYou];
}


-(void)RecentAdded
{
    
    scrollPopularbyYou=[[UIScrollView alloc]initWithFrame:CGRectMake(0, recentAddedinlab.frame.size.height+recentAddedinlab.frame.origin.y+10, self.view.frame.size.width, 120)];
    scrollPopularbyYou.contentSize=CGSizeMake((DataArray.count)*(106), 120);
    scrollPopularbyYou.backgroundColor=[UIColor clearColor];
    scrollPopularbyYou.showsHorizontalScrollIndicator=NO;
    scrollPopularbyYou.scrollEnabled=YES;
    scrollPopularbyYou.userInteractionEnabled=YES;
    
    int x=0;
    for (int i=0; i<DataArray.count; i++)
    {
        viewdas=[[UIView alloc]initWithFrame:CGRectMake(x+10, 0, 98, 120)];
        viewdas.backgroundColor=[UIColor clearColor];
        viewdas.layer.borderColor = [UIColor lightGrayColor].CGColor;
        viewdas.layer.borderWidth = 1.0f;
        
        UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
        [image sd_setImageWithURL:[NSURL URLWithString:@""]
                 placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
        //        NSString *imageName=[imageArray objectAtIndex:i];
        //        image.image=[UIImage imageNamed:imageName];
        [viewdas addSubview:image];
        
        UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(10, image.frame.size.height+image.frame.origin.y, 80, 30)];
        lbltitle.text=@"Cars";
        lbltitle.textColor=[UIColor blackColor];
        lbltitle.textAlignment=NSTextAlignmentCenter;
        lbltitle.numberOfLines=2;
        lbltitle.font=[UIFont boldSystemFontOfSize:15];
        [viewdas addSubview:lbltitle];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.selected = !i;
        btnSelected = btn.selected?btn:btnSelected;
        btn.frame = CGRectMake(0, 0, 100, 120);
        btn.backgroundColor=[UIColor clearColor];
        //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-white.png"] forState:UIControlStateNormal];
        //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-voilet.png"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(RecentlyAddedCarsclicked:) forControlEvents:UIControlEventTouchUpInside];
        [viewdas addSubview:btn];
        
        [scrollPopularbyYou addSubview:viewdas];
        
        x+=105;
    }
    
    [scrollMainView addSubview:scrollPopularbyYou];
    
}



#pragma mark - Categeory Wise list of Items Clicked

-(IBAction)TypeoflistCarsclicked:(UIButton *)sender
{
    [DataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if (sender.tag== buttontag1+idx)
         {
             //     NSString *strname =[DataArray objectAtIndex:idx];
             NSString *strprice=[[DataArray objectAtIndex:idx] valueForKey:@"name"];
             
             strtilelab=[NSString stringWithFormat:@"Find Perfect %@",[[DataArray objectAtIndex:idx]valueForKey:@"url_parameter"]];
             [FindPerfectCarbutt setTitle:strtilelab forState:UIControlStateNormal];
             
            Strcarsubmodule=[NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:idx]valueForKey:@"module_id"]];
             
             StrimageName=[imageArray objectAtIndex:idx];
             imageDis.image=[UIImage imageNamed:StrimageName];
             
             [requested showMessage:strprice withTitle:@"Categeory"];
             
             for(UIButton *btn in Scrollview.subviews)
                 if([btn isKindOfClass:[UIButton class]])
                     btn.selected = NO;
             
             sender.selected = YES;
             
             btnSelected = sender;
         }
     }];
}



#pragma mark - Popular Near by You list of Items Clicked

-(IBAction)PopularnearbyyouCarsclicked:(UIButton *)sender
{
    [DataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if (sender.tag== buttontag1+idx)
         {
             //     NSString *strname =[DataArray objectAtIndex:idx];
             NSString *strprice=[[DataArray objectAtIndex:idx] valueForKey:@"name"];
             
             [requested showMessage:strprice withTitle:@"Popular near by you List"];
             
             for(UIButton *btn in Scrollview.subviews)
                 if([btn isKindOfClass:[UIButton class]])
                     btn.selected = NO;
             
             sender.selected = YES;
             
             btnSelected = sender;
         }
     }];
}


#pragma mark - Recently added list of Items Clicked

-(IBAction)RecentlyAddedCarsclicked:(UIButton *)sender
{
    [DataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if (sender.tag== buttontag1+idx)
         {
             //     NSString *strname =[DataArray objectAtIndex:idx];
             NSString *strprice=[DataArray objectAtIndex:idx];
             
             [requested showMessage:strprice withTitle:@"Recently Added List"];
             
             for(UIButton *btn in Scrollview.subviews)
                 if([btn isKindOfClass:[UIButton class]])
                     btn.selected = NO;
             
             sender.selected = YES;
             
             btnSelected = sender;
         }
     }];
}





#pragma mark - Find Perfect Car Clicked

-(IBAction)FindperfectcarButtClicked:(id)sender
{
    FindCarViewController *findcar=[self.storyboard instantiateViewControllerWithIdentifier:@"FindCarViewController"];
    findcar.strtitle=strtilelab;
    findcar.strCarSubModule=Strcarsubmodule;
    findcar.strimage=StrimageName;
    [self.navigationController pushViewController:findcar animated:YES];
}




- (IBAction)CrossbuttClicked:(id)sender
{
    _crossbutt.hidden=YES;
    _CustomSearchbar.hidden=YES;
    _citylistView.hidden=NO;
     _backbutton.hidden=NO;
}

- (IBAction)backbuttClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)searchbuttClicked:(id)sender
{
    _citylistView.hidden=YES;
    _backbutton.hidden=YES;
    _crossbutt.hidden=NO;
    _CustomSearchbar.hidden=NO;
}






#pragma mark - Back Clicked

-(IBAction)BackbuttClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Search Clicked

-(IBAction)SearchbuttClicked:(id)sender
{
    [requested showMessage:@"Search Clicked" withTitle:@"Search butt"];
}


#pragma mark - Perticular City Clicked


-(IBAction)CitybuttClicked:(id)sender
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-150, 300, 300)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-50, 40)];
    lab.text=@"Select City";
    lab.textColor=[UIColor blackColor];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentLeft+10;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60, 0, 50, 40)];
    [butt1 setTitle:@"Cancel" forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont systemFontOfSize:15];
    butt1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [butt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt1 addTarget:self action:@selector(Cancelclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt1];
    
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(1, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width-2, 1)];
    labeunder.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:labeunder];
    
    
    tabl=[[UITableView alloc] init];
    tabl.frame = CGRectMake(0,labeunder.frame.origin.y+labeunder.frame.size.height+10, footerview.frame.size.width, 257);
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [tabl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [footerview addSubview:tabl];
}


-(IBAction)Cancelclicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}


#pragma mark - Table View Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==2)
    {
        return DataArray.count;
    }
    else if (tableView.tag==3)
    {
        return searchResults.count;
    }
    else
    {
       // return arrCitys.count;
        
        return DataArray.count;
    }
 //   return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==2)
    {
        return 60;
    }
   else if (tableView.tag==3)
    {
        return 60;
    }
    else
    {
       // return 40;
        
        return 60;
    }
   // return 40;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)celle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([celle respondsToSelector:@selector(setSeparatorInset:)]) {
       // [celle setSeparatorInset:UIEdgeInsetsZero];
        [tabl setSeparatorInset:UIEdgeInsetsMake(self.view.frame.origin.x, 0, 0, 0)];
    }
    
    if ([celle respondsToSelector:@selector(setLayoutMargins:)]) {
      //  [celle setLayoutMargins:UIEdgeInsetsZero];
        [tabl setSeparatorInset:UIEdgeInsetsMake(self.view.frame.origin.x, 0, 0, 0)];
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if ([tabl respondsToSelector:@selector(setSeparatorInset:)]) {
       // [tabl setSeparatorInset:UIEdgeInsetsZero];
        [tabl setSeparatorInset:UIEdgeInsetsMake(self.view.frame.origin.x, 0, 0, 0)];
    }
    
    if ([tabl respondsToSelector:@selector(setLayoutMargins:)]) {
       // [tabl setLayoutMargins:UIEdgeInsetsZero];
        [tabl setSeparatorInset:UIEdgeInsetsMake(self.view.frame.origin.x, 0, 0, 0)];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    static NSString *cellIdetifier = @"Cell";
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
    
    
    if (tableView.tag==2)
    {
      //  cell.backgroundColor=[UIColor lightGrayColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 59, self.view.frame.size.width, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:lineView];
        
        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, cell.frame.size.width-40, 40)];
        NSString *strname=[[DataArray valueForKey:@"name"]objectAtIndex:indexPath.row];
        
        if ([strname isEqualToString:@"All Motors"])
        {
           namel.text=[[DataArray valueForKey:@"name"]objectAtIndex:indexPath.row];
            namel.lineBreakMode = NSLineBreakByWordWrapping;
            namel.textColor=[UIColor blackColor];
            namel.numberOfLines = 1;
            [namel setFont:[UIFont boldSystemFontOfSize:18]];
        }
        else
        {
            namel.text=[[DataArray valueForKey:@"name"]objectAtIndex:indexPath.row];
            namel.lineBreakMode = NSLineBreakByWordWrapping;
            namel.textColor=[UIColor blackColor];
            namel.numberOfLines = 1;
            [namel setFont:[UIFont systemFontOfSize:17]];
        }
        [cell addSubview:namel];
        
        UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-26,22, 16, 16)];
        image4.image=[UIImage imageNamed:@"right-arrow-2.png"];
        [cell addSubview:image4];
    }
   else if (tableView.tag==3)
    {
        //  cell.backgroundColor=[UIColor lightGrayColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 59, self.view.frame.size.width, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:lineView];
        
        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, cell.frame.size.width-40, 40)];
        NSString *strname=[[searchResults valueForKey:@"name"]objectAtIndex:indexPath.row];
        
        if ([strname isEqualToString:@"All Motors"])
        {
            namel.text=[[searchResults valueForKey:@"name"]objectAtIndex:indexPath.row];
            namel.lineBreakMode = NSLineBreakByWordWrapping;
            namel.textColor=[UIColor blackColor];
            namel.numberOfLines = 1;
            [namel setFont:[UIFont boldSystemFontOfSize:18]];
        }
        else
        {
            namel.text=[[searchResults valueForKey:@"name"]objectAtIndex:indexPath.row];
            namel.lineBreakMode = NSLineBreakByWordWrapping;
            namel.textColor=[UIColor blackColor];
            namel.numberOfLines = 1;
            [namel setFont:[UIFont systemFontOfSize:17]];
        }
        [cell addSubview:namel];
        
        UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-26,22, 16, 16)];
        image4.image=[UIImage imageNamed:@"right-arrow-2.png"];
        [cell addSubview:image4];
    }

    else
    {
//        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width, 40)];
//        namel.text=[[arrCitys valueForKey:@"name"]objectAtIndex:indexPath.row];
//        namel.lineBreakMode = NSLineBreakByWordWrapping;
//        namel.textColor=[UIColor blackColor];
//        namel.numberOfLines = 1;
//        [namel setFont:[UIFont boldSystemFontOfSize:15]];
//        [cell addSubview:namel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 59, self.view.frame.size.width, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:lineView];
        
        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, cell.frame.size.width-40, 40)];
        NSString *strname=[[DataArray valueForKey:@"name"]objectAtIndex:indexPath.row];
        
        if ([strname isEqualToString:@"All Motors"])
        {
            namel.text=[[DataArray valueForKey:@"name"]objectAtIndex:indexPath.row];
            namel.lineBreakMode = NSLineBreakByWordWrapping;
            namel.textColor=[UIColor blackColor];
            namel.numberOfLines = 1;
            [namel setFont:[UIFont boldSystemFontOfSize:18]];
        }
        else
        {
            namel.text=[[DataArray valueForKey:@"name"]objectAtIndex:indexPath.row];
            namel.lineBreakMode = NSLineBreakByWordWrapping;
            namel.textColor=[UIColor blackColor];
            namel.numberOfLines = 1;
            [namel setFont:[UIFont systemFontOfSize:17]];
        }

        [cell addSubview:namel];
        
        UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-26,22, 16, 16)];
        image4.image=[UIImage imageNamed:@"right-arrow-2.png"];
        [cell addSubview:image4];

    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==2)
    {
        strModuleId=[[DataArray valueForKey:@"module_id"]objectAtIndex:indexPath.row];
        strModuleName=[[DataArray valueForKey:@"name"]objectAtIndex:indexPath.row];
        strModuleUrlParameter=[[DataArray valueForKey:@"url_parameter"]objectAtIndex:indexPath.row];
        
      //  NSLog(@"%@",strModuleId);
       // NSLog(@"%@",strModuleName);
      //  NSLog(@"%@",strModuleUrlParameter);
        
        if ([strModuleUrlParameter isEqualToString:@"car"])
        {
             NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            //    NSString *strmodule=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"url_parameter"];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"user_id=%@",struseridnum];
         //   NSString *post = @"";
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
            [requested sendRequest1:post withUrl:strurl];
            
//            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
//            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
//            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
//            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@",BaseUrl,strtoken,carSubModule,english,strCityId,@"1"];
//            [requested motorsEngRequest:nil withUrl:strurl];
        }
        else
        {
            
            
            NSString *strname=[[DataArray valueForKey:@"name"]objectAtIndex:indexPath.row];
            
            if ([strname isEqualToString:@"All Motors"])
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                //    NSString *strmodule=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"url_parameter"];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *post = [NSString stringWithFormat:@"user_id=%@",struseridnum];
                //   NSString *post = @"";
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest1:post withUrl:strurl];

            }
            else
            {
            
            
            
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            //    NSString *strmodule=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"url_parameter"];
//            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
//            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
//            NSString *post = [NSString stringWithFormat:@"module=%@",strModuleUrlParameter];
//            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
//            [requested sendRequest1:post withUrl:strurl];
            
            
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,english,strCityId,strModuleUrlParameter,@"category",@"0"];
            [requested OtpVerifyRequest:nil withUrl:strurl];
            }
        }
    }
    else if (tableView.tag==3)
    {
        strModuleId=[[searchResults valueForKey:@"module_id"]objectAtIndex:indexPath.row];
        strModuleName=[[searchResults valueForKey:@"name"]objectAtIndex:indexPath.row];
        strModuleUrlParameter=[[searchResults valueForKey:@"url_parameter"]objectAtIndex:indexPath.row];
        
     //   NSLog(@"%@",strModuleId);
    //    NSLog(@"%@",strModuleName);
     //   NSLog(@"%@",strModuleUrlParameter);
        
        if ([strModuleUrlParameter isEqualToString:@"car"])
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            //    NSString *strmodule=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"url_parameter"];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"user_id=%@",struseridnum];
            //   NSString *post = @"";
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
            [requested sendRequest1:post withUrl:strurl];
            
            //            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            //            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            //            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            //            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@",BaseUrl,strtoken,carSubModule,english,strCityId,@"1"];
            //            [requested motorsEngRequest:nil withUrl:strurl];
        }
        else
        {
            NSString *strname=[[DataArray valueForKey:@"name"]objectAtIndex:indexPath.row];
            
            if ([strname isEqualToString:@"All Motors"])
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                //    NSString *strmodule=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"url_parameter"];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *post = [NSString stringWithFormat:@"user_id=%@",struseridnum];
                //   NSString *post = @"";
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest1:post withUrl:strurl];

            }
            else
            {
                
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            //    NSString *strmodule=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"url_parameter"];
            //            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            //            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            //            NSString *post = [NSString stringWithFormat:@"module=%@",strModuleUrlParameter];
            //            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            //            [requested sendRequest1:post withUrl:strurl];
            
            
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,english,strCityId,strModuleUrlParameter,@"category",@"0"];
            [requested OtpVerifyRequest:nil withUrl:strurl];
            }
        }
    }
    else
    {
//        NSString *strcity=[[arrCitys valueForKey:@"name"]objectAtIndex:indexPath.row];
//        [_dohaButt setTitle:strcity forState:UIControlStateNormal];
//    
//        NSString *strlist=[NSString stringWithFormat:@"Recent Added in %@",strcity];
//        recentAddedinlab.text=strlist;
//    
//        [[NSUserDefaults standardUserDefaults]setObject:strcity forKey:@"City"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        [footerview removeFromSuperview];
//    
//        NSString *strcityId=[[arrCitys valueForKey:@"city_id"]objectAtIndex:indexPath.row];
//        NSLog(@"%@",strcityId);
//    
//        [[NSUserDefaults standardUserDefaults]setObject:strcityId forKey:@"CityId"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//    
//        popview.hidden = YES;
        
        
        strModuleId=[[DataArray valueForKey:@"module_id"]objectAtIndex:indexPath.row];
        strModuleName=[[DataArray valueForKey:@"name"]objectAtIndex:indexPath.row];
        strModuleUrlParameter=[[DataArray valueForKey:@"url_parameter"]objectAtIndex:indexPath.row];
        
    //    NSLog(@"%@",strModuleId);
    //    NSLog(@"%@",strModuleName);
    //    NSLog(@"%@",strModuleUrlParameter);
        
        if ([strModuleUrlParameter isEqualToString:@"car"])
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            //    NSString *strmodule=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"url_parameter"];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *post = [NSString stringWithFormat:@"user_id=%@",struseridnum];
            //   NSString *post = @"";
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
            [requested sendRequest1:post withUrl:strurl];
            
            //            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            //            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            //            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            //            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@",BaseUrl,strtoken,carSubModule,english,strCityId,@"1"];
            //            [requested motorsEngRequest:nil withUrl:strurl];
        }
        else
        {
            NSString *strname=[[DataArray valueForKey:@"name"]objectAtIndex:indexPath.row];
            
            if ([strname isEqualToString:@"All Motors"])
            {
                NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                //    NSString *strmodule=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"url_parameter"];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *post = [NSString stringWithFormat:@"user_id=%@",struseridnum];
                //   NSString *post = @"";
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPosts,english,strCityId];
                [requested sendRequest1:post withUrl:strurl];

            }
            else
            {
                
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            //    NSString *strmodule=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"url_parameter"];
            //            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            //            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            //            NSString *post = [NSString stringWithFormat:@"module=%@",strModuleUrlParameter];
            //            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
            //            [requested sendRequest1:post withUrl:strurl];
            
            
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,english,strCityId,strModuleUrlParameter,@"category",@"0"];
            [requested OtpVerifyRequest:nil withUrl:strurl];
            }
        }
    }
}

-(void)responsewithDataEng:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
  //  NSLog(@"Motor SubModule English Response: %@",responseDictionary);
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        NSMutableArray *arrMotorList=[[NSMutableArray alloc]init];
        arrMotorList=[responseDictionary valueForKey:@"data"];
        
    //    NSArray *arrmake=[arrMotorList valueForKey:@"make"];
        
//        CarMakeViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"CarMakeViewController"];
//        post.arrChildCategory=arrmake;
//        post.strModule=strModuleUrlParameter;
//        post.strtitle=strModuleName;
//        post.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:post animated:YES];
    }
    else
    {
        [requested showMessage:[responseDictionary valueForKey:@"message"] withTitle:@"Message"];
    }
}

-(void)responseRegistrationotp:(NSMutableDictionary *)responseDict
{
  //  NSLog(@"Jobs list Response: %@",responseDict);
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"0"])
    {
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *post = [NSString stringWithFormat:@"module=%@&user_id=%@",strModuleUrlParameter,struseridnum];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
        [requested sendRequest1:post withUrl:strurl];
    }
    else
    {
        
        data=[responseDict valueForKey:@"data"];
        
        NSString *strname=[NSString stringWithFormat:@"All %@",strModuleName];
        NSString *result = [[data valueForKey:@"id"] componentsJoinedByString:@","];
        
        
        NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:@"2",@"haschild",result,@"id",strname,@"name", nil];
        
        NSMutableArray *arrdata=[[NSMutableArray alloc] initWithObjects:dict, nil];
        
        arrdata=[[arrdata arrayByAddingObjectsFromArray:data] mutableCopy];
        
    //    [self.navigationController.view hideActivityView];
        
        [self.searchController dismissViewControllerAnimated:YES completion:nil];
        [self.view endEditing:YES];
        
        SubCategeorylistViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"SubCategeorylistViewController"];
        post.arrChildCategory=arrdata;
        post.strModule=strModuleUrlParameter;
        post.strtitle=strModuleName;
        post.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:post animated:YES];

        
//        JobsListViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsListViewController"];
//        post.arrChildCategory=[responseDict valueForKey:@"data"];
//        post.strModule=strModuleUrlParameter;
//        post.strtitle=strModuleName;
//        post.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:post animated:YES];
    }
}


-(void)responsewithToken1:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
 //   NSLog(@"Dict Response: %@",responseDictionary);
    
    NSString *strmessage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"status"]];
    
    NSString *strpage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"nextPage"]];
    
    if ([strmessage isEqualToString:@"0"])
    {
        [requested showMessage:[NSString stringWithFormat:@"There is no More Data found for this category"] withTitle:@""];
    }
    else
    {
        CarNameViewController *car=[self.storyboard instantiateViewControllerWithIdentifier:@"CarNameViewController"];
        if([strModuleUrlParameter isEqualToString:@"car"])
        {
            car.strKMS=[responseDictionary valueForKey:@"kilometer"];
            car.strPrice=[responseDictionary valueForKey:@"price"];
            car.strYear=[responseDictionary valueForKey:@"year"];
        }
        else
        {
             car.strPrice=[responseDictionary valueForKey:@"price"];
        }
        car.arrDataList=[responseDictionary valueForKey:@"data"];
        car.hidesBottomBarWhenPushed = YES;
        car.strmodule=strModuleUrlParameter;
        car.strname=strModuleName;
        car.strpage=strpage;
        [self.navigationController pushViewController:car animated:YES];
    }
}




#pragma mark - View Controller life Cycle


-(void)viewWillAppear:(BOOL)animated
{
    theSearchBar.userInteractionEnabled=NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Midhun" object:nil];

    
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?category=%@",BaseUrl,strtoken,module,english,strCityId,@"1"];
    // [requested emptyOptionRequest:nil withUrl:strurl];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strurl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *datas, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(datas != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:datas options:kNilOptions error:&err];
                    [self emptyresponseOption:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];

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
