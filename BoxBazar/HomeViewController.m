//
//  HomeViewController.m
//  BoxBazar
//
//  Created by bharat on 26/08/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "HomeViewController.h"
#import "ApiRequest.h"
#import "UIImageView+WebCache.h"
#import "BoxBazarUrl.pch"
#import "DejalActivityView.h"
#import "MotorFindsPerfectViewController.h"
#import "LCBannerView.h"
#import "JobTypeViewController.h"
#import "CarNameViewController.h"
#import "CarDescriptionArabicViewController.h"
#import "RNActivityView.h"
#import <unistd.h>
#import "UIView+RNActivityView.h"
#import "JobsInitialViewController.h"
#import "JobslistArabicViewController.h"
#import "JobsListsArabicViewController.h"
#import "SLCountryPickerViewController.h"
#import "HMDiallingCode.h"
#import "MotorListArabicViewController.h"
#import "SubCategeorylistArabicViewController.h"

#define SCREENSHOT_MODE 0
typedef enum{
    
    buttontag1= 0,
    imageTAg = 100
    
}buttontag;

@interface HomeViewController ()<ApiRequestdelegate,LCBannerViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *txtCountryName,*txtSelectCity,*txtLanguage;
    int set;
    
    LCBannerView *bannerView;
    
    UIView *viewForPageContent;
    UIView *imageTopView;
    UIView *headerview;
    UIButton *butt;
    BOOL isClick;
    
    UIScrollView *Scrollview;
    UIScrollView *scrollView;
    
    IBOutlet UITableView *tabl;
    UITableViewCell *cell;
    
    UIButton *btnSelected;
    
    ApiRequest *requested;
    
    UIView *view7,*view8,*view9,*view10,*view11,*view12;
    
    UILabel *carslabel,*carslabel1,*propertyforSalelab,*propertyforSalelab1,*ElectronicsApplianceslab,*ElectronicsApplianceslab1;
    
    UIImageView *imagecar,*imagecar1,*imageProperty,*imageProperty1,*imageElectronic,*imageElectronic1;
    
    UILabel *SeeAlllabel,*SeeAlllabel1,*seeallpropertylab,*seeallpropertylab1,*seeAllElectroniclab,*seeAllElectroniclab1;
    
    UIButton *CarsSellAllbutt,*CarsSellAllbutt1,*Propertyforsalebutt,*Propertyforsalebutt1,*Electronicappliancesbutt,*Electronicappliancesbutt1;
    
    UIScrollView *scrollCarAll,*scrollCarAll1,*scrollPropertyforSale,*scrollPropertyforSale1,*scrollElectronics,*scrollElectronics1;
    
    UIView *footerview,*footerview1,*footerview2;
    
    UIView *viewdas,*viewdas1,*viewdas3,*viewdas4,*viewdas5,*viewdas6;
    
    NSTimer *imageTimer;
    
    UIView *popview,*popview2;
    NSArray *urls;
    NSArray *URLs;
    
    NSMutableArray *homelistarray,*data;
    
    NSString *strnameUrlparameter,*strNmaeOfModule;
    
    UIView *categeory1,*category2,*categeory3;
    UICollectionView *collectionView;
    
    NSString *countryCo;
}

@property (strong, nonatomic) HMDiallingCode *diallingCode;
@property (nonatomic, weak) LCBannerView *bannerView1;
@property (nonatomic, weak) LCBannerView *bannerView2;


@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _SearchButt.hidden=YES;
    
    data=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"CityId"];
    if(object != nil)
    {
        
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"CityId"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    homelistarray=[[NSMutableArray alloc]init];
    
    _CustomSearchbar.barTintColor=[UIColor clearColor];
    _CustomSearchbar.searchBarStyle = UISearchBarStyleMinimal;
    _CustomSearchbar.hidden=YES;
    _CrossButt.hidden=YES;
    
    _topView.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTextColor:[UIColor whiteColor]];
    
    isClick=NO;
    categoryScrollView.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    
    arrCitys=[[NSMutableArray alloc]init];
    
    NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
    NSObject * objects = [prefss objectForKey:@"Cit2"];
    if(objects != nil)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *datalist = [defaults objectForKey:@"Cit2"];
        arrCitys=[NSKeyedUnarchiver unarchiveObjectWithData:datalist];
    }
    else
    {
        
    }
    
    
    categoryScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height)];
    categoryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 480);
    [self.view addSubview:categoryScrollView];
    
    DataArray=[[NSMutableArray alloc]initWithObjects:@"Maruthi Suzuki 2012, Grey",@"2",@"3",@"4",@"5", nil];
    AmountArray=[[NSMutableArray alloc]initWithObjects:@"765678",@"2",@"3",@"4",@"5", nil];
    
    DataArray1=[[NSMutableArray alloc]initWithObjects:@"Good Homes 2010,Sai apartments, Grey",@"23",@"33",@"43",@"53", nil];
    AmountArray1=[[NSMutableArray alloc]initWithObjects:@"7656",@"332",@"31223",@"433",@"5333", nil];
    
    DataArray2=[[NSMutableArray alloc]initWithObjects:@"Samsung 2011,Ultra tech model",@"2rt",@"3tt",@"4fgf",@"5ffh", nil];
    AmountArray2=[[NSMutableArray alloc]initWithObjects:@"76567890",@"2234",@"344",@"444",@"555", nil];
    
    
    
    _pageTitles = @[@"Contacts",@"favourites",@"Requests", @"Global friends",@"start Run", @"History",@"Settings",@"About App",@"Logout"];
    _pageImages = @[@"contact.png",@"favourite.png", @"request.png",@"global_friends.png",@"start-run.png", @"steps.png",@"setting.png",@"about.png",@"logout.png"];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:_pageViewController];
    [viewForPageContent addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    
    isInternetConnectionAvailable=[[NSUserDefaults standardUserDefaults]objectForKey:@"internet"];
    
    NSLog(@"Internet %@",isInternetConnectionAvailable);
    
    [self homeview];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    UIView *content = [[self.view subviews] objectAtIndex:0];
    ((UIScrollView *)self.view).contentSize = content.bounds.size;
}


-(void)responsewithToken:(NSMutableDictionary *)responseToken
{
    NSString *stringtoken=[[responseToken valueForKey:@"data"] valueForKey:@"token"];
    NSLog(@"Token: %@",stringtoken);
    
    [[NSUserDefaults standardUserDefaults]setObject:stringtoken forKey:@"Token"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSLog(@"Token Response :%@",responseToken);
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,gethomecategeory,arabic,strCityId];
        [requested motorsMakeRequest:nil withUrl:strurl];
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,gethomecategeory,arabic,strCityId];
        [requested motorsMakeRequest:nil withUrl:strurl];
    }
    else
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,gethomecategeory,arabic,strCityId];
        [requested motorsMakeRequest:nil withUrl:strurl];
    }
}


-(void)responsewithDataMakeMotor:(NSMutableDictionary *)responseDict
{
    homelistarray=[responseDict valueForKey:@"data"];
    NSLog(@"home Response: %@",homelistarray);
    
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        
        NSString *strurl1=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,homeSlider,arabic,strCityId];
        [requested HomeSliderRequest:nil withUrl:strurl1];
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        
        NSString *strurl1=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,homeSlider,arabic,strCityId];
        [requested HomeSliderRequest:nil withUrl:strurl1];
        
    }
    else
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        
        NSString *strurl1=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,homeSlider,arabic,strCityId];
        [requested HomeSliderRequest:nil withUrl:strurl1];
    }
}


-(void)responsewithHomeSlider:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Slider Response: %@",responseDictionary);
    
    NSArray *urls2=[responseDictionary valueForKey:@"data"];
    
    NSLog(@"URL's%@",urls2);
    
    NSData *datal = [NSKeyedArchiver archivedDataWithRootObject:urls2];
    
    [[NSUserDefaults standardUserDefaults]setObject:datal forKey:@"URL"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    //   [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,citylist,arabic,strCityId];
        [requested CitysRequest:nil withUrl:strurl];
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,citylist,arabic,strCityId];
        [requested CitysRequest:nil withUrl:strurl];
    }
    else
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,citylist,arabic,strCityId];
        [requested CitysRequest:nil withUrl:strurl];
    }
    
}

-(void)responsewithCitylist:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"City list Response: %@",responseDictionary);
    NSMutableArray *arrCitys1=[[NSMutableArray alloc]init];
    arrCitys1=[responseDict valueForKey:@"data"];
    
    NSData *datal = [NSKeyedArchiver archivedDataWithRootObject:arrCitys1];
    
    [[NSUserDefaults standardUserDefaults]setObject:datal forKey:@"Citys"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:datal forKey:@"Cit2"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *datalist = [defaults objectForKey:@"Citys"];
    arrCitys=[NSKeyedUnarchiver unarchiveObjectWithData:datalist];
    // [tabl reloadData];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    //        [self homeview];
    //    });
    
    [self homeview];
}



-(void)homeview
{
    if ([UIScreen mainScreen].bounds.size.width < 700 )
    {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        scrollView.contentSize = CGSizeMake(0, 170);
        [categoryScrollView addSubview:scrollView];
    }
    else
    {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        scrollView.contentSize = CGSizeMake(0, 270);
        [categoryScrollView addSubview:scrollView];
    }
    
    
    //    NSArray *URLs = @[@"http://think360.co/boxbazaar/upload/slider/dummy.jpg",
    //                      @"http://think360.co/boxbazaar/upload/slider/dummy.jpg",
    //                      @"http://think360.co/boxbazaar/upload/slider/dummy.jpg",
    //                      @"http://think360.co/boxbazaar/upload/slider/dummy.jpg"];
    
    
    NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
    NSData *datalist2 = [defaults2 objectForKey:@"URL"];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"URL"];
    if(object != nil)
    {
        urls=[NSKeyedUnarchiver unarchiveObjectWithData:datalist2];
        NSMutableArray *list=[[NSMutableArray alloc] init];
        [list addObject:[urls objectAtIndex:0]];
        [list addObject:[urls objectAtIndex:1]];
        [list addObject:[urls objectAtIndex:2]];
        [list addObject:[urls objectAtIndex:3]];
        URLs=list;
        
        [scrollView addSubview:({
            
            if ([UIScreen mainScreen].bounds.size.width < 700 )
            {
                bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150.0f)
                                                      delegate:self
                                                     imageURLs:URLs
                                          placeholderImageName:nil
                                                  timeInterval:3.0f
                                 currentPageIndicatorTintColor:[UIColor redColor]
                                        pageIndicatorTintColor:[UIColor whiteColor]];
                self.bannerView1 = bannerView;
            }
            else
            {
                bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250.0f)
                                                      delegate:self
                                                     imageURLs:URLs
                                          placeholderImageName:nil
                                                  timeInterval:3.0f
                                 currentPageIndicatorTintColor:[UIColor redColor]
                                        pageIndicatorTintColor:[UIColor whiteColor]];
                self.bannerView1 = bannerView;
            }
            
            self.bannerView1 = bannerView;
        })];
        
    }
    else
    {
        
    }
    
    
    
    
    
    if ([UIScreen mainScreen].bounds.size.width < 700 )
    {
        headerview=[[UIView alloc] initWithFrame:CGRectMake(1, 160, self.view.frame.size.width-2, 197)];
        headerview.backgroundColor=[UIColor clearColor];
        headerview.layer.borderColor = [UIColor lightGrayColor].CGColor;
        // headerview.layer.borderWidth = 2.0f;
        [categoryScrollView addSubview:headerview];
    }
    else
    {
        headerview=[[UIView alloc] initWithFrame:CGRectMake(1, 260, self.view.frame.size.width-2, 197)];
        headerview.backgroundColor=[UIColor clearColor];
        headerview.layer.borderColor = [UIColor lightGrayColor].CGColor;
        // headerview.layer.borderWidth = 2.0f;
        [categoryScrollView addSubview:headerview];
    }
    

    
    
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3, headerview.frame.size.height/2)];
    view1.backgroundColor=[UIColor whiteColor];
    view1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view1.layer.borderWidth = 0.5f;
    [headerview addSubview:view1];
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(view1.frame.size.width/2-25, view1.frame.size.height/2-35, 50, 50)];
    image1.image=[UIImage imageNamed:@"jobs-120x120.png"];
    [view1 addSubview:image1];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(view1.frame.size.width/2-30, view1.frame.size.height-40, 60, 40)];
    label1.text=@"Jobs";
    label1.textAlignment=NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor=[UIColor blackColor];
    [view1 addSubview:label1];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3, headerview.frame.size.height/2)];
    butt1.backgroundColor=[UIColor clearColor];
    [butt1 addTarget:self action:@selector(JobsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:butt1];
    
    
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(view1.frame.size.width, 0, self.view.frame.size.width/3, headerview.frame.size.height/2)];
    view2.backgroundColor=[UIColor whiteColor];
    view2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view2.layer.borderWidth = 0.5f;
    [headerview addSubview:view2];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(view2.frame.size.width/2-25, view2.frame.size.height/2-35, 50, 50)];
    image2.image=[UIImage imageNamed:@"classifieds-120x120.jpg"];
    [view2 addSubview:image2];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(view2.frame.size.width/2-40, view2.frame.size.height-40, 80, 40)];
    label2.text=@"Classified";
    label2.textAlignment=NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor=[UIColor blackColor];
    [view2 addSubview:label2];
    
    UIButton *butt2=[[UIButton alloc]initWithFrame:CGRectMake(view1.frame.size.width, 0, self.view.frame.size.width/3, headerview.frame.size.height/2)];
    butt2.backgroundColor=[UIColor clearColor];
    [butt2 addTarget:self action:@selector(ClassifiedsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:butt2];
    
    
    
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(view1.frame.size.width+view2.frame.size.width, 0, self.view.frame.size.width/3, headerview.frame.size.height/2)];
    view3.backgroundColor=[UIColor whiteColor];
    view3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view3.layer.borderWidth = 0.5f;
    [headerview addSubview:view3];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(view3.frame.size.width/2-25, view3.frame.size.height/2-35, 50, 50)];
    image3.image=[UIImage imageNamed:@"motor-120x120.png"];
    [view3 addSubview:image3];
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(view3.frame.size.width/2-40, view3.frame.size.height-40, 80, 40)];
    label3.text=@"Motor";
    label3.textAlignment=NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:15];
    label3.textColor=[UIColor blackColor];
    [view3 addSubview:label3];
    
    UIButton *butt3=[[UIButton alloc]initWithFrame:CGRectMake(view1.frame.size.width+view2.frame.size.width, 0, self.view.frame.size.width/3, headerview.frame.size.height/2)];
    butt3.backgroundColor=[UIColor clearColor];
    [butt3 addTarget:self action:@selector(MotorButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:butt3];
    
    
    
    
    UIView *view4=[[UIView alloc]initWithFrame:CGRectMake(0,view1.frame.size.height+view1.frame.origin.y, self.view.frame.size.width/3, headerview.frame.size.height/2)];
    view4.backgroundColor=[UIColor whiteColor];
    view4.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view4.layer.borderWidth = 0.5f;
    [headerview addSubview:view4];
    
    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(view4.frame.size.width/2-25, view4.frame.size.height/2-40, 50, 50)];
    image4.image=[UIImage imageNamed:@"xxxhdpi.png"];
    [view4 addSubview:image4];
    
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(5, view4.frame.size.height-40, view4.frame.size.width-10, 40)];
    label4.text=@"Community";
    label4.textAlignment=NSTextAlignmentCenter;
    label4.numberOfLines=2;
    label4.font = [UIFont systemFontOfSize:15];
    label4.textColor=[UIColor blackColor];
    [view4 addSubview:label4];
    
    UIButton *butt4=[[UIButton alloc]initWithFrame:CGRectMake(0,view1.frame.size.height+view1.frame.origin.y, self.view.frame.size.width/3, headerview.frame.size.height/2)];
    butt4.backgroundColor=[UIColor clearColor];
    [butt4 addTarget:self action:@selector(FurnitureClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:butt4];
    
    
    
    UIView *view5=[[UIView alloc]initWithFrame:CGRectMake(view4.frame.size.width, view2.frame.size.height+view2.frame.origin.y, self.view.frame.size.width/3, headerview.frame.size.height/2)];
    view5.backgroundColor=[UIColor whiteColor];
    view5.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view5.layer.borderWidth = 0.5f;
    [headerview addSubview:view5];
    
    UIImageView *image5=[[UIImageView alloc]initWithFrame:CGRectMake(view5.frame.size.width/2-25, view5.frame.size.height/2-40, 50, 50)];
    image5.image=[UIImage imageNamed:@"propertyonsale-120x120.png"];
    [view5 addSubview:image5];
    
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(5, view5.frame.size.height-40, view5.frame.size.width-10, 40)];
    label5.text=@"Property on Sale";
    label5.textAlignment=NSTextAlignmentCenter;
    label5.numberOfLines=2;
    label5.font = [UIFont systemFontOfSize:15];
    label5.textColor=[UIColor blackColor];
    [view5 addSubview:label5];
    
    UIButton *butt5=[[UIButton alloc]initWithFrame:CGRectMake(view4.frame.size.width, view2.frame.size.height+view2.frame.origin.y, self.view.frame.size.width/3, headerview.frame.size.height/2)];
    butt5.backgroundColor=[UIColor clearColor];
    [butt5 addTarget:self action:@selector(PropertyonSaleClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:butt5];
    
    
    
    UIView *view6=[[UIView alloc]initWithFrame:CGRectMake(view4.frame.size.width+view5.frame.size.width, view3.frame.size.height+view3.frame.origin.y, self.view.frame.size.width/3, headerview.frame.size.height/2)];
    view6.backgroundColor=[UIColor whiteColor];
    view6.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view6.layer.borderWidth = 0.5f;
    [headerview addSubview:view6];
    
    UIImageView *image6=[[UIImageView alloc]initWithFrame:CGRectMake(view6.frame.size.width/2-25, view6.frame.size.height/2-40, 50, 50)];
    image6.image=[UIImage imageNamed:@"propertyonrent-120x120.png"];
    [view6 addSubview:image6];
    
    UILabel *label6=[[UILabel alloc]initWithFrame:CGRectMake(5, view6.frame.size.height-40, view6.frame.size.width-10, 40)];
    label6.text=@"Property On Rent";
    label6.textAlignment=NSTextAlignmentCenter;
    label6.numberOfLines=2;
    label6.font = [UIFont systemFontOfSize:15];
    label6.textColor=[UIColor blackColor];
    [view6 addSubview:label6];
    
    UIButton *butt6=[[UIButton alloc]initWithFrame:CGRectMake(view4.frame.size.width+view5.frame.size.width, view3.frame.size.height+view3.frame.origin.y, self.view.frame.size.width/3, headerview.frame.size.height/2)];
    butt6.backgroundColor=[UIColor clearColor];
    [butt6 addTarget:self action:@selector(PropertyonRentClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:butt6];
    
    
    
    view7=[[UIView alloc]initWithFrame:CGRectMake(0,view4.frame.size.height+view4.frame.origin.y-2, self.view.frame.size.width/3+1, headerview.frame.size.height/2+1)];
    view7.backgroundColor=[UIColor whiteColor];
    view7.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view7.layer.borderWidth = 2.0f;
    view7.hidden=YES;
    [headerview addSubview:view7];
    
    UIImageView *image7=[[UIImageView alloc]initWithFrame:CGRectMake(view7.frame.size.width/2-25, view7.frame.size.height/2-35, 50, 50)];
    image7.image=[UIImage imageNamed:@"home-6.png"];
    [view7 addSubview:image7];
    
    UILabel *label7=[[UILabel alloc]initWithFrame:CGRectMake(5, view7.frame.size.height-40, view7.frame.size.width-10, 40)];
    label7.text=@"Services";
    label7.textAlignment=NSTextAlignmentCenter;
    label7.numberOfLines=2;
    label7.font = [UIFont systemFontOfSize:15];
    label7.textColor=[UIColor blackColor];
    [view7 addSubview:label7];
    
    UIButton *butt7=[[UIButton alloc]initWithFrame:CGRectMake(0,view4.frame.size.height+view4.frame.origin.y-2, self.view.frame.size.width/3+1, headerview.frame.size.height/2+1)];
    butt7.backgroundColor=[UIColor clearColor];
     [butt7 addTarget:self action:@selector(ServicesClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:butt7];
    
    
    
    view8=[[UIView alloc]initWithFrame:CGRectMake(view7.frame.size.width-2, view5.frame.size.height+view5.frame.origin.y-2, self.view.frame.size.width/3+0.334, headerview.frame.size.height/2+1)];
    view8.backgroundColor=[UIColor whiteColor];
    view8.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view8.layer.borderWidth = 2.0f;
    view8.hidden=YES;
    [headerview addSubview:view8];
    
    UIImageView *image8=[[UIImageView alloc]initWithFrame:CGRectMake(view8.frame.size.width/2-25, view8.frame.size.height/2-35, 50, 50)];
    image8.image=[UIImage imageNamed:@"home-6.png"];
    [view8 addSubview:image8];
    
    UILabel *label8=[[UILabel alloc]initWithFrame:CGRectMake(5, view8.frame.size.height-40, view8.frame.size.width-10, 40)];
    label8.text=@"Fashion";
    label8.textAlignment=NSTextAlignmentCenter;
    label8.numberOfLines=2;
    label8.font = [UIFont systemFontOfSize:15];
    label8.textColor=[UIColor blackColor];
    [view8 addSubview:label8];
    
    UIButton *butt8=[[UIButton alloc]initWithFrame:CGRectMake(view7.frame.size.width-2, view5.frame.size.height+view5.frame.origin.y-2, self.view.frame.size.width/3+0.334, headerview.frame.size.height/2+1)];
    butt8.backgroundColor=[UIColor clearColor];
    [butt8 addTarget:self action:@selector(FashionClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:butt8];
    
    
    
    
    view9=[[UIView alloc]initWithFrame:CGRectMake(view7.frame.size.width+view8.frame.size.width-4, view6.frame.size.height+view6.frame.origin.y-2, self.view.frame.size.width/3+1, headerview.frame.size.height/2+1)];
    view9.backgroundColor=[UIColor whiteColor];
    view9.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view9.layer.borderWidth = 2.0f;
    view9.hidden=YES;
    [headerview addSubview:view9];
    
    UIImageView *image9=[[UIImageView alloc]initWithFrame:CGRectMake(view9.frame.size.width/2-25, view9.frame.size.height/2-35, 50, 50)];
    image9.image=[UIImage imageNamed:@"home-6.png"];
    [view9 addSubview:image9];
    
    UILabel *label9=[[UILabel alloc]initWithFrame:CGRectMake(5, view9.frame.size.height-40, view9.frame.size.width-10, 40)];
    label9.text=@"Electronics";
    label9.textAlignment=NSTextAlignmentCenter;
    label9.numberOfLines=2;
    label9.font = [UIFont systemFontOfSize:15];
    label9.textColor=[UIColor blackColor];
    [view9 addSubview:label9];
    
    UIButton *butt9=[[UIButton alloc]initWithFrame:CGRectMake(view7.frame.size.width+view8.frame.size.width-4, view6.frame.size.height+view6.frame.origin.y-2, self.view.frame.size.width/3+1, headerview.frame.size.height/2+1)];
    butt9.backgroundColor=[UIColor clearColor];
    [butt9 addTarget:self action:@selector(ElectronicsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:butt9];
    
    
    
    view10=[[UIView alloc]initWithFrame:CGRectMake(0,view7.frame.size.height+view7.frame.origin.y-2, self.view.frame.size.width/3+1, headerview.frame.size.height/2+3)];
    view10.backgroundColor=[UIColor whiteColor];
    view10.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view10.layer.borderWidth = 2.0f;
    view10.hidden=YES;
    [headerview addSubview:view10];
    
    UIImageView *image10=[[UIImageView alloc]initWithFrame:CGRectMake(view10.frame.size.width/2-25, view10.frame.size.height/2-35, 50, 50)];
    image10.image=[UIImage imageNamed:@"home-6.png"];
    [view10 addSubview:image10];
    
    UILabel *label10=[[UILabel alloc]initWithFrame:CGRectMake(5, view10.frame.size.height-40, view10.frame.size.width-10, 40)];
    label10.text=@"Less";
    label10.textAlignment=NSTextAlignmentCenter;
    label10.numberOfLines=2;
    label10.font = [UIFont systemFontOfSize:15];
    label10.textColor=[UIColor blackColor];
    [view10 addSubview:label10];
    
    UIButton *butt10=[[UIButton alloc]initWithFrame:CGRectMake(0,view7.frame.size.height+view7.frame.origin.y-2, self.view.frame.size.width/3+1, headerview.frame.size.height/2+3)];
    butt10.backgroundColor=[UIColor clearColor];
   [butt10 addTarget:self action:@selector(LessClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:butt10];
    
    
    view11=[[UIView alloc]initWithFrame:CGRectMake(view10.frame.size.width-2, view8.frame.size.height+view8.frame.origin.y-2, self.view.frame.size.width/3+0.334, headerview.frame.size.height/2+3)];
    view11.backgroundColor=[UIColor whiteColor];
    view11.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view11.layer.borderWidth = 2.0f;
    view11.hidden=YES;
    [headerview addSubview:view11];
    
    UIImageView *image11=[[UIImageView alloc]initWithFrame:CGRectMake(view11.frame.size.width/2-25, view11.frame.size.height/2-35, 50, 50)];
    image11.image=[UIImage imageNamed:@"home-6.png"];
    [view11 addSubview:image11];
    
    UILabel *label11=[[UILabel alloc]initWithFrame:CGRectMake(5, view11.frame.size.height-40, view11.frame.size.width-10, 40)];
    label11.text=@"pets";
    label11.textAlignment=NSTextAlignmentCenter;
    label11.numberOfLines=2;
    label11.font = [UIFont systemFontOfSize:15];
    label11.textColor=[UIColor blackColor];
    [view11 addSubview:label11];
    
    UIButton *butt11=[[UIButton alloc]initWithFrame:CGRectMake(view10.frame.size.width-2, view8.frame.size.height+view8.frame.origin.y-2, self.view.frame.size.width/3+0.334, headerview.frame.size.height/2+3)];
    butt11.backgroundColor=[UIColor clearColor];
    [butt11 addTarget:self action:@selector(PetsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:butt11];
    
    
    
    view12=[[UIView alloc]initWithFrame:CGRectMake(view10.frame.size.width+view11.frame.size.width-4, view9.frame.size.height+view9.frame.origin.y-2, self.view.frame.size.width/3+1, headerview.frame.size.height/2+3)];
    view12.backgroundColor=[UIColor whiteColor];
    view12.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view12.layer.borderWidth = 2.0f;
    view12.hidden=YES;
    [headerview addSubview:view12];
    
    UIImageView *image12=[[UIImageView alloc]initWithFrame:CGRectMake(view12.frame.size.width/2-25, view12.frame.size.height/2-35, 50, 50)];
    image12.image=[UIImage imageNamed:@"home-6.png"];
    [view12 addSubview:image12];
    
    UILabel *label12=[[UILabel alloc]initWithFrame:CGRectMake(5, view12.frame.size.height-40, view12.frame.size.width-10, 40)];
    label12.text=@"Book & Sports";
    label12.textAlignment=NSTextAlignmentCenter;
    label12.numberOfLines=2;
    label12.font = [UIFont systemFontOfSize:15];
    label12.textColor=[UIColor blackColor];
    [view12 addSubview:label12];
    
    UIButton *butt12=[[UIButton alloc]initWithFrame:CGRectMake(view10.frame.size.width+view11.frame.size.width-4, view9.frame.size.height+view9.frame.origin.y-2, self.view.frame.size.width/3+1, headerview.frame.size.height/2+3)];
    butt12.backgroundColor=[UIColor clearColor];
     [butt12 addTarget:self action:@selector(bookSportsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:butt12];
    
    
    butt=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30, headerview.frame.origin.y+headerview.frame.size.height-2, 60, 40)];
    [butt setTitle:@"More" forState:UIControlStateNormal];
    //  butt.backgroundColor=[UIColor lightGrayColor];
    butt.layer.borderColor = [UIColor lightGrayColor].CGColor;
    butt.layer.borderWidth = 2.0f;
    [butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    butt.titleLabel.font = [UIFont systemFontOfSize:15];
    butt.hidden=YES;
    [butt addTarget:self action:@selector(buttClicked:) forControlEvents:UIControlEventTouchUpInside];
    [categoryScrollView addSubview:butt];
    
    [categeory1 removeFromSuperview];
    [category2 removeFromSuperview];
    [categeory3 removeFromSuperview];
    
    //    [scrollCarAll removeFromSuperview];
    //    [scrollPropertyforSale removeFromSuperview];
    //    [scrollElectronics removeFromSuperview];
    //
    //    [carslabel removeFromSuperview];
    //    [imagecar removeFromSuperview];
    //    [SeeAlllabel removeFromSuperview];
    //    [CarsSellAllbutt removeFromSuperview];
    //
    //    [propertyforSalelab removeFromSuperview];
    //    [imageProperty removeFromSuperview];
    //    [seeallpropertylab removeFromSuperview];
    //    [Propertyforsalebutt removeFromSuperview];
    //
    //    [ElectronicsApplianceslab removeFromSuperview];
    //    [imageElectronic removeFromSuperview];
    //    [seeAllElectroniclab removeFromSuperview];
    //    [Electronicappliancesbutt removeFromSuperview];
    
    [self.navigationController.view hideActivityView];
    
    
    
    for(int x = 0; x<homelistarray.count; x++)
    {
        if (x==0)
        {
            categeory1=[[UIView alloc]initWithFrame:CGRectMake(0, butt.frame.size.height+butt.frame.origin.y+5, self.view.frame.size.width, (203-165+(self.view.frame.size.width/3-5+65)))];
            categeory1.backgroundColor=[UIColor clearColor];
            [categoryScrollView addSubview:categeory1];
            
            
            carslabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, categeory1.frame.size.width-10, 30)];
            carslabel.text=[[homelistarray valueForKey:@"name"] objectAtIndex:0];
            carslabel.textAlignment=NSTextAlignmentRight;
            carslabel.numberOfLines=2;
            carslabel.font = [UIFont boldSystemFontOfSize:15];
            carslabel.textColor=[UIColor blackColor];
            [categeory1 addSubview:carslabel];
            
            imagecar=[[UIImageView alloc]initWithFrame:CGRectMake(5,7, 16, 16)];
            imagecar.image=[UIImage imageNamed:@"left.png"];
            [categeory1 addSubview:imagecar];
            
            SeeAlllabel=[[UILabel alloc] initWithFrame:CGRectMake(24, 0, 55, 30)];
            SeeAlllabel.text=@"See All";
            SeeAlllabel.textAlignment=NSTextAlignmentLeft;
            SeeAlllabel.numberOfLines=2;
            SeeAlllabel.font = [UIFont systemFontOfSize:15];
            SeeAlllabel.textColor=[UIColor blackColor];
            [categeory1 addSubview:SeeAlllabel];
            
            CarsSellAllbutt=[[UIButton alloc]initWithFrame:CGRectMake(5, 0, 80, 30)];
            CarsSellAllbutt.backgroundColor=[UIColor clearColor];
            [CarsSellAllbutt addTarget:self action:@selector(CarsSellAllbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
            [categeory1 addSubview:CarsSellAllbutt];
            
            DataArray=[[homelistarray valueForKey:@"post"] objectAtIndex:0];
            
            [self footerView];
            
            if ([UIScreen mainScreen].bounds.size.width < 700 )
            {
                categoryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, (((self.view.frame.size.width/3-5)*3)+(65*3)+(-495)+730));
            }
            else
            {
                categoryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, (((self.view.frame.size.width/3-5)*3)+(65*3)+(-495)+830));
            }
            
        }
        else if (x==1)
        {
            category2=[[UIView alloc]initWithFrame:CGRectMake(0, categeory1.frame.size.height+categeory1.frame.origin.y+5, self.view.frame.size.width, (203-165+(self.view.frame.size.width/3-5+65)))];
            category2.backgroundColor=[UIColor clearColor];
            [categoryScrollView addSubview:category2];
            
            
            propertyforSalelab=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, category2.frame.size.width-10, 30)];
            propertyforSalelab.text=[[homelistarray valueForKey:@"name"] objectAtIndex:1];
            propertyforSalelab.textAlignment=NSTextAlignmentRight;
            propertyforSalelab.numberOfLines=2;
            propertyforSalelab.font = [UIFont boldSystemFontOfSize:15];
            propertyforSalelab.textColor=[UIColor blackColor];
            [category2 addSubview:propertyforSalelab];
            
            imageProperty=[[UIImageView alloc]initWithFrame:CGRectMake(5,7, 16, 16)];
            imageProperty.image=[UIImage imageNamed:@"left.png"];
            [category2 addSubview:imageProperty];
            
            seeallpropertylab=[[UILabel alloc] initWithFrame:CGRectMake(24, 0, 55, 30)];
            seeallpropertylab.text=@"See All";
            seeallpropertylab.textAlignment=NSTextAlignmentLeft;
            seeallpropertylab.numberOfLines=2;
            seeallpropertylab.font = [UIFont systemFontOfSize:15];
            seeallpropertylab.textColor=[UIColor blackColor];
            [category2 addSubview:seeallpropertylab];
            
            Propertyforsalebutt=[[UIButton alloc]initWithFrame:CGRectMake(5, 0, 80, 30)];
            Propertyforsalebutt.backgroundColor=[UIColor clearColor];
            [Propertyforsalebutt addTarget:self action:@selector(PropertyforSalebuttClicked:) forControlEvents:UIControlEventTouchUpInside];
            [category2 addSubview:Propertyforsalebutt];
            
            DataArray1=[[homelistarray valueForKey:@"post"]objectAtIndex:1];
            
            [self footerView3];
            
            if ([UIScreen mainScreen].bounds.size.width < 700 )
            {
                categoryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, (((self.view.frame.size.width/3-5)*3)+(65*3)+(-495)+930));
            }
            else
            {
                 categoryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, (((self.view.frame.size.width/3-5)*3)+(65*3)+(-495)+1030));
            }
            
        }
        else if (x==2)
        {
            categeory3=[[UIView alloc]initWithFrame:CGRectMake(0, category2.frame.size.height+category2.frame.origin.y+5, self.view.frame.size.width, (203-165+(self.view.frame.size.width/3-5+65)))];
            categeory3.backgroundColor=[UIColor clearColor];
            [categoryScrollView addSubview:categeory3];
            
            
            ElectronicsApplianceslab=[[UILabel alloc] initWithFrame:CGRectMake(5, 0,categeory3.frame.size.width-10, 30)];
            ElectronicsApplianceslab.text=[[homelistarray valueForKey:@"name"] objectAtIndex:2];
            ElectronicsApplianceslab.textAlignment=NSTextAlignmentRight;
            ElectronicsApplianceslab.numberOfLines=2;
            ElectronicsApplianceslab.font = [UIFont boldSystemFontOfSize:15];
            ElectronicsApplianceslab.textColor=[UIColor blackColor];
            [categeory3 addSubview:ElectronicsApplianceslab];
            
            imageElectronic=[[UIImageView alloc]initWithFrame:CGRectMake(5,7, 16, 16)];
            imageElectronic.image=[UIImage imageNamed:@"left.png"];
            [categeory3 addSubview:imageElectronic];
            
            seeAllElectroniclab=[[UILabel alloc] initWithFrame:CGRectMake(24, 0, 55, 30)];
            seeAllElectroniclab.text=@"See All";
            seeAllElectroniclab.textAlignment=NSTextAlignmentLeft;
            seeAllElectroniclab.numberOfLines=2;
            seeAllElectroniclab.font = [UIFont systemFontOfSize:15];
            seeAllElectroniclab.textColor=[UIColor blackColor];
            [categeory3 addSubview:seeAllElectroniclab];
            
            Electronicappliancesbutt=[[UIButton alloc]initWithFrame:CGRectMake(5, 0, 80, 30)];
            Electronicappliancesbutt.backgroundColor=[UIColor clearColor];
            [Electronicappliancesbutt addTarget:self action:@selector(ElectronicsbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
            [categeory3 addSubview:Electronicappliancesbutt];
            
            DataArray2=[[homelistarray valueForKey:@"post"]objectAtIndex:2];
            
            [self footerView5];
            
            if ([UIScreen mainScreen].bounds.size.width < 700 )
            {
                 categoryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, (((self.view.frame.size.width/3-5)*3)+(65*3)+(-495)+1130));
            }
            else
            {
                 categoryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, (((self.view.frame.size.width/3-5)*3)+(65*3)+(-495)+1230));
            }
            
        }
    }
}


-(void)footerView
{
        scrollCarAll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, carslabel.frame.size.height+carslabel.frame.origin.y+3, self.view.frame.size.width, self.view.frame.size.width/3-5+65)];
        scrollCarAll.contentSize=CGSizeMake((DataArray.count)*(self.view.frame.size.width/3), self.view.frame.size.width/3-5+65);
        scrollCarAll.backgroundColor=[UIColor clearColor];
        scrollCarAll.showsHorizontalScrollIndicator=NO;
        scrollCarAll.scrollEnabled=YES;
        scrollCarAll.userInteractionEnabled=YES;
        
        int x=0;
        for (int i=0; i<DataArray.count; i++)
        {
            viewdas=[[UIView alloc]initWithFrame:CGRectMake(x+3, 0, self.view.frame.size.width/3-5, self.view.frame.size.width/3-5+65)];
            viewdas.backgroundColor=[UIColor whiteColor];
            viewdas.layer.borderColor = [UIColor lightGrayColor].CGColor;
            viewdas.layer.borderWidth = 1.0f;
            
            UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewdas.frame.size.width, self.view.frame.size.width/3-5)];
            image.clipsToBounds = YES;
            image.layer.borderWidth = 1.0;
            image.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[DataArray valueForKey:@"pic"] objectAtIndex:i]]]
                     placeholderImage:[UIImage imageNamed:@"upload-empty.png"]];
            image.contentMode = UIViewContentModeScaleAspectFill;
            [viewdas addSubview:image];
            
            UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(5, image.frame.size.height+image.frame.origin.y+2, viewdas.frame.size.width-10, 40)];
            lbltitle.text=[[DataArray valueForKey:@"name"] objectAtIndex:i];
            lbltitle.textColor=[UIColor blackColor];
            lbltitle.textAlignment=NSTextAlignmentCenter;
            lbltitle.numberOfLines=3;
            lbltitle.font=[UIFont systemFontOfSize:12];
            [viewdas addSubview:lbltitle];
            
            UILabel *lblprice=[[UILabel alloc] initWithFrame:CGRectMake(5, lbltitle.frame.size.height+lbltitle.frame.origin.y, viewdas.frame.size.width-10, 20)];
            NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:0];
            if ([strmodule isEqualToString:@"jobs"])
            {
                lblprice.text=[NSString stringWithFormat:@"%@",[[DataArray valueForKey:@"price"] objectAtIndex:i]];
            }
            else if ([strmodule isEqualToString:@"community"])
            {
                lblprice.text=[NSString stringWithFormat:@"%@",[[DataArray valueForKey:@"price"] objectAtIndex:i]];
            }
            else
            {
                lblprice.text=[NSString stringWithFormat:@"%@ AED",[[DataArray valueForKey:@"price"] objectAtIndex:i]];
            }

            lblprice.textColor=[UIColor blackColor];
            lblprice.textAlignment=NSTextAlignmentCenter;
            lblprice.numberOfLines=2;
            lblprice.font=[UIFont boldSystemFontOfSize:12];
            [viewdas addSubview:lblprice];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            btn.selected = !i;
            btnSelected = btn.selected?btn:btnSelected;
            btn.frame = CGRectMake(0, 0, self.view.frame.size.width/3-4, self.view.frame.size.width/3-5+65);
            btn.backgroundColor=[UIColor clearColor];
            //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-white.png"] forState:UIControlStateNormal];
            //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-voilet.png"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(AlltypesCarsbutonclicked:) forControlEvents:UIControlEventTouchUpInside];
            [viewdas addSubview:btn];
            
            [scrollCarAll addSubview:viewdas];
            
            x+=self.view.frame.size.width/3;
        }
        [categeory1 addSubview:scrollCarAll];
 }


-(void)footerView3
{
        scrollPropertyforSale=[[UIScrollView alloc]initWithFrame:CGRectMake(0, propertyforSalelab.frame.size.height+propertyforSalelab.frame.origin.y+3, self.view.frame.size.width, self.view.frame.size.width/3-5+65)];
        scrollPropertyforSale.contentSize=CGSizeMake((DataArray1.count)*(self.view.frame.size.width/3), self.view.frame.size.width/3-5+65);
        scrollPropertyforSale.backgroundColor=[UIColor clearColor];
        scrollPropertyforSale.showsHorizontalScrollIndicator=NO;
        scrollPropertyforSale.scrollEnabled=YES;
        scrollPropertyforSale.userInteractionEnabled=YES;
        
        int x=0;
        for (int i=0; i<DataArray1.count; i++)
        {
            viewdas3=[[UIView alloc]initWithFrame:CGRectMake(x+3, 0, self.view.frame.size.width/3-5, self.view.frame.size.width/3-5+65)];
            viewdas3.backgroundColor=[UIColor whiteColor];
            viewdas3.layer.borderColor = [UIColor lightGrayColor].CGColor;
            viewdas3.layer.borderWidth = 1.0f;
            
            UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewdas.frame.size.width, self.view.frame.size.width/3-5)];
            image.clipsToBounds = YES;
            image.layer.borderWidth = 1.0;
            image.layer.borderColor = [UIColor lightGrayColor].CGColor;
            image.contentMode = UIViewContentModeScaleAspectFill;
            [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[DataArray1 valueForKey:@"pic"] objectAtIndex:i]]]
                     placeholderImage:[UIImage imageNamed:@"upload-empty.png"]];
            [viewdas3 addSubview:image];
            
            UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(5, image.frame.size.height+image.frame.origin.y+2, viewdas.frame.size.width-10, 40)];
            lbltitle.text=[[DataArray1 valueForKey:@"name"] objectAtIndex:i];
            lbltitle.textColor=[UIColor blackColor];
            lbltitle.textAlignment=NSTextAlignmentCenter;
            lbltitle.numberOfLines=3;
            lbltitle.font=[UIFont systemFontOfSize:12];
            [viewdas3 addSubview:lbltitle];
            
            UILabel *lblprice=[[UILabel alloc] initWithFrame:CGRectMake(5, lbltitle.frame.size.height+lbltitle.frame.origin.y, viewdas.frame.size.width-10, 20)];
            NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:1];
            if ([strmodule isEqualToString:@"jobs"])
            {
                lblprice.text=[NSString stringWithFormat:@"%@",[[DataArray1 valueForKey:@"price"] objectAtIndex:i]];
            }
            else if ([strmodule isEqualToString:@"community"])
            {
                lblprice.text=[NSString stringWithFormat:@"%@",[[DataArray1 valueForKey:@"price"] objectAtIndex:i]];
            }
            else
            {
                lblprice.text=[NSString stringWithFormat:@"%@ AED",[[DataArray1 valueForKey:@"price"] objectAtIndex:i]];
            }

            lblprice.textColor=[UIColor blackColor];
            lblprice.textAlignment=NSTextAlignmentCenter;
            lblprice.numberOfLines=2;
            lblprice.font=[UIFont boldSystemFontOfSize:12];
            [viewdas3 addSubview:lblprice];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            btn.selected = !i;
            btnSelected = btn.selected?btn:btnSelected;
            btn.frame = CGRectMake(0, 0, self.view.frame.size.width/3-4, self.view.frame.size.width/3-5+65);
            btn.backgroundColor=[UIColor clearColor];
            //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-white.png"] forState:UIControlStateNormal];
            //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-voilet.png"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(PropertyforSaleCategeoryclicked:) forControlEvents:UIControlEventTouchUpInside];
            [viewdas3 addSubview:btn];
            
            [scrollPropertyforSale addSubview:viewdas3];
            
            x+=self.view.frame.size.width/3;
        }
        [category2 addSubview:scrollPropertyforSale];
  }

-(void)footerView5
{
        scrollElectronics=[[UIScrollView alloc]initWithFrame:CGRectMake(0, ElectronicsApplianceslab.frame.size.height+ElectronicsApplianceslab.frame.origin.y+3, self.view.frame.size.width, self.view.frame.size.width/3-5+65)];
        scrollElectronics.contentSize=CGSizeMake((DataArray2.count)*(self.view.frame.size.width/3), self.view.frame.size.width/3-5+65);
        scrollElectronics.backgroundColor=[UIColor clearColor];
        scrollElectronics.showsHorizontalScrollIndicator=NO;
        scrollElectronics.scrollEnabled=YES;
        scrollElectronics.userInteractionEnabled=YES;
        
        int x=0;
        for (int i=0; i<DataArray2.count; i++)
        {
            viewdas5=[[UIView alloc]initWithFrame:CGRectMake(x+3, 0, self.view.frame.size.width/3-5, self.view.frame.size.width/3-5+65)];
            viewdas5.backgroundColor=[UIColor whiteColor];
            viewdas5.layer.borderColor = [UIColor lightGrayColor].CGColor;
            viewdas5.layer.borderWidth = 1.0f;
            
            UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewdas.frame.size.width, self.view.frame.size.width/3-5)];
            image.clipsToBounds = YES;
            image.layer.borderWidth = 1.0;
            image.layer.borderColor = [UIColor lightGrayColor].CGColor;
            image.contentMode = UIViewContentModeScaleAspectFill;
            [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[DataArray2 valueForKey:@"pic"] objectAtIndex:i]]]
                     placeholderImage:[UIImage imageNamed:@"upload-empty.png"]];
            [viewdas5 addSubview:image];
            
            UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(5, image.frame.size.height+image.frame.origin.y+2, viewdas.frame.size.width-10, 40)];
            lbltitle.text=[[DataArray2 valueForKey:@"name"] objectAtIndex:i];
            lbltitle.textColor=[UIColor blackColor];
            lbltitle.textAlignment=NSTextAlignmentCenter;
            lbltitle.numberOfLines=3;
            lbltitle.font=[UIFont systemFontOfSize:12];
            [viewdas5 addSubview:lbltitle];
            
            UILabel *lblprice=[[UILabel alloc] initWithFrame:CGRectMake(5, lbltitle.frame.size.height+lbltitle.frame.origin.y, viewdas.frame.size.width-10, 20)];
            NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:2];
            if ([strmodule isEqualToString:@"jobs"])
            {
                lblprice.text=[NSString stringWithFormat:@"%@",[[DataArray2 valueForKey:@"price"] objectAtIndex:i]];
            }
            else if ([strmodule isEqualToString:@"community"])
            {
                lblprice.text=[NSString stringWithFormat:@"%@",[[DataArray2 valueForKey:@"price"] objectAtIndex:i]];
            }
            else
            {
                lblprice.text=[NSString stringWithFormat:@"%@ AED",[[DataArray2 valueForKey:@"price"] objectAtIndex:i]];
            }
            lblprice.textColor=[UIColor blackColor];
            lblprice.textAlignment=NSTextAlignmentCenter;
            lblprice.numberOfLines=2;
            lblprice.font=[UIFont boldSystemFontOfSize:12];
            [viewdas5 addSubview:lblprice];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            btn.selected = !i;
            btnSelected = btn.selected?btn:btnSelected;
            btn.frame = CGRectMake(0, 0, self.view.frame.size.width/3-4, self.view.frame.size.width/3-5+65);
            btn.backgroundColor=[UIColor clearColor];
            //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-white.png"] forState:UIControlStateNormal];
            //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-voilet.png"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(ElectronicsCategeoryclicked:) forControlEvents:UIControlEventTouchUpInside];
            [viewdas5 addSubview:btn];
            
            [scrollElectronics addSubview:viewdas5];
            
            x+=self.view.frame.size.width/3;
        }
        
        
        [categeory3 addSubview:scrollElectronics];
 }






-(void)footerView1
{
    
    scrollCarAll1=[[UIScrollView alloc]initWithFrame:CGRectMake(0, carslabel1.frame.size.height+carslabel1.frame.origin.y+3, self.view.frame.size.width, 160)];
    scrollCarAll1.contentSize=CGSizeMake((DataArray.count)*(106), 160);
    scrollCarAll1.backgroundColor=[UIColor clearColor];
    scrollCarAll1.showsHorizontalScrollIndicator=NO;
    scrollCarAll1.scrollEnabled=YES;
    scrollCarAll1.userInteractionEnabled=YES;
    
    int x=0;
    for (int i=0; i<DataArray.count; i++)
    {
        viewdas1=[[UIView alloc]initWithFrame:CGRectMake(x+5, 0, 100, 160)];
        viewdas1.backgroundColor=[UIColor whiteColor];
        viewdas1.layer.borderColor = [UIColor lightGrayColor].CGColor;
        viewdas1.layer.borderWidth = 1.0f;
        
        UIImageView *imag=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [imag sd_setImageWithURL:[NSURL URLWithString:@""]
                placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
        [viewdas1 addSubview:imag];
        
        UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(10, imag.frame.size.height+imag.frame.origin.y+2, 80, 40)];
        lbltitle.text=[DataArray objectAtIndex:i];
        lbltitle.textColor=[UIColor blackColor];
        lbltitle.textAlignment=NSTextAlignmentCenter;
        lbltitle.numberOfLines=3;
        lbltitle.font=[UIFont systemFontOfSize:10];
        [viewdas1 addSubview:lbltitle];
        
        UILabel *lblprice=[[UILabel alloc] initWithFrame:CGRectMake(10, lbltitle.frame.size.height+lbltitle.frame.origin.y, 80, 20)];
        lblprice.text=[AmountArray objectAtIndex:i];
        lblprice.textColor=[UIColor blackColor];
        lblprice.textAlignment=NSTextAlignmentCenter;
        lblprice.numberOfLines=2;
        lblprice.font=[UIFont boldSystemFontOfSize:12];
        [viewdas1 addSubview:lblprice];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.selected = !i;
        btnSelected = btn.selected?btn:btnSelected;
        btn.frame = CGRectMake(5, 2, 100, 158);
        btn.backgroundColor=[UIColor clearColor];
        //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-white.png"] forState:UIControlStateNormal];
        //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-voilet.png"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(AlltypesCarsbutonclicked:) forControlEvents:UIControlEventTouchUpInside];
        [viewdas1 addSubview:btn];
        
        [scrollCarAll1 addSubview:viewdas1];
        
        x+=105;
    }
    [categoryScrollView addSubview:scrollCarAll1];
}

-(void)footerView4
{
    scrollPropertyforSale1=[[UIScrollView alloc]initWithFrame:CGRectMake(0, propertyforSalelab1.frame.size.height+propertyforSalelab1.frame.origin.y+3, self.view.frame.size.width, 160)];
    scrollPropertyforSale1.contentSize=CGSizeMake((DataArray.count)*(106), 160);
    scrollPropertyforSale1.backgroundColor=[UIColor clearColor];
    scrollPropertyforSale1.showsHorizontalScrollIndicator=NO;
    scrollPropertyforSale1.scrollEnabled=YES;
    scrollPropertyforSale1.userInteractionEnabled=YES;
    
    int x=0;
    for (int i=0; i<DataArray1.count; i++)
    {
        viewdas4=[[UIView alloc]initWithFrame:CGRectMake(x+5, 0, 100, 160)];
        viewdas4.backgroundColor=[UIColor whiteColor];
        viewdas4.layer.borderColor = [UIColor lightGrayColor].CGColor;
        viewdas4.layer.borderWidth = 1.0f;
        
        UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [image sd_setImageWithURL:[NSURL URLWithString:@""]
                 placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
        [viewdas4 addSubview:image];
        
        UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(10, image.frame.size.height+image.frame.origin.y+2, 80, 40)];
        lbltitle.text=[DataArray1 objectAtIndex:i];
        lbltitle.textColor=[UIColor blackColor];
        lbltitle.textAlignment=NSTextAlignmentCenter;
        lbltitle.numberOfLines=3;
        lbltitle.font=[UIFont systemFontOfSize:10];
        [viewdas4 addSubview:lbltitle];
        
        UILabel *lblprice=[[UILabel alloc] initWithFrame:CGRectMake(10, lbltitle.frame.size.height+lbltitle.frame.origin.y, 80, 20)];
        lblprice.text=[AmountArray1 objectAtIndex:i];
        lblprice.textColor=[UIColor blackColor];
        lblprice.textAlignment=NSTextAlignmentCenter;
        lblprice.numberOfLines=2;
        lblprice.font=[UIFont boldSystemFontOfSize:12];
        [viewdas4 addSubview:lblprice];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.selected = !i;
        btnSelected = btn.selected?btn:btnSelected;
        btn.frame = CGRectMake(5, 2, 100, 158);
        btn.backgroundColor=[UIColor clearColor];
        //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-white.png"] forState:UIControlStateNormal];
        //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-voilet.png"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(PropertyforSaleCategeoryclicked:) forControlEvents:UIControlEventTouchUpInside];
        [viewdas4 addSubview:btn];
        
        [scrollPropertyforSale1 addSubview:viewdas4];
        
        x+=105;
    }
    [categoryScrollView addSubview:scrollPropertyforSale1];
}


-(void)footerView6
{
    scrollElectronics1=[[UIScrollView alloc]initWithFrame:CGRectMake(0, ElectronicsApplianceslab1.frame.size.height+ElectronicsApplianceslab1.frame.origin.y+3, self.view.frame.size.width, 160)];
    scrollElectronics1.contentSize=CGSizeMake((DataArray.count)*(106), 160);
    scrollElectronics1.backgroundColor=[UIColor clearColor];
    scrollElectronics1.showsHorizontalScrollIndicator=NO;
    scrollElectronics1.scrollEnabled=YES;
    scrollElectronics1.userInteractionEnabled=YES;
    
    int x=0;
    for (int i=0; i<DataArray2.count; i++)
    {
        viewdas6=[[UIView alloc]initWithFrame:CGRectMake(x+5, 0, 100, 160)];
        viewdas6.backgroundColor=[UIColor whiteColor];
        viewdas6.layer.borderColor = [UIColor lightGrayColor].CGColor;
        viewdas6.layer.borderWidth = 1.0f;
        
        UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [image sd_setImageWithURL:[NSURL URLWithString:@""]
                 placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
        [viewdas6 addSubview:image];
        
        UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(10, image.frame.size.height+image.frame.origin.y+2, 80, 40)];
        lbltitle.text=[DataArray2 objectAtIndex:i];
        lbltitle.textColor=[UIColor blackColor];
        lbltitle.textAlignment=NSTextAlignmentCenter;
        lbltitle.numberOfLines=3;
        lbltitle.font=[UIFont systemFontOfSize:10];
        [viewdas6 addSubview:lbltitle];
        
        UILabel *lblprice=[[UILabel alloc] initWithFrame:CGRectMake(10, lbltitle.frame.size.height+lbltitle.frame.origin.y, 80, 20)];
        lblprice.text=[AmountArray2 objectAtIndex:i];
        lblprice.textColor=[UIColor blackColor];
        lblprice.textAlignment=NSTextAlignmentCenter;
        lblprice.numberOfLines=2;
        lblprice.font=[UIFont boldSystemFontOfSize:12];
        [viewdas6 addSubview:lblprice];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.selected = !i;
        btnSelected = btn.selected?btn:btnSelected;
        btn.frame = CGRectMake(5, 2, 100, 158);
        btn.backgroundColor=[UIColor clearColor];
        //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-white.png"] forState:UIControlStateNormal];
        //        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-voilet.png"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(ElectronicsCategeoryclicked:) forControlEvents:UIControlEventTouchUpInside];
        [viewdas6 addSubview:btn];
        
        [scrollElectronics1 addSubview:viewdas6];
        
        x+=105;
    }
    [categoryScrollView addSubview:scrollElectronics1];
}




#pragma mark - Categeory Clicked

-(IBAction)MotorButtClicked:(id)sender
{
    //   [requested showMessage:@"Link will update soon" withTitle:@"Motor Categeory"];
    
    //    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    //    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    //    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    //    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?category=%@",BaseUrl,strtoken,module,english,strCityId,@"1"];
    //    [requested motorsEngRequest:nil withUrl:strurl];
    
    [requested checkNetworkStatus];
    
    isInternetConnectionAvailable=[[NSUserDefaults standardUserDefaults]objectForKey:@"internet"];
    
    if ([isInternetConnectionAvailable isEqualToString:@"NO"])
    {
        [requested showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again" withTitle:@"Message"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setInteger:6 forKey:@"index"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        MotorListArabicViewController *mfb=[self.storyboard instantiateViewControllerWithIdentifier:@"MotorListArabicViewController"];
        mfb.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:mfb animated:YES];
    }
    
}


-(void)responsewithDataEng:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Motor English Response: %@",responseDictionary);
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        NSMutableArray *arrMotorList=[[NSMutableArray alloc]init];
        arrMotorList=[responseDictionary valueForKey:@"data"];
        
        NSData *datah = [NSKeyedArchiver archivedDataWithRootObject:arrMotorList];
        
        [[NSUserDefaults standardUserDefaults]setObject:datah forKey:@"MotorEng"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setInteger:6 forKey:@"index"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        MotorListArabicViewController *mfb=[self.storyboard instantiateViewControllerWithIdentifier:@"MotorListArabicViewController"];
        mfb.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:mfb animated:YES];
        
        //        MotorFindsPerfectViewController *mfb=[self.storyboard instantiateViewControllerWithIdentifier:@"MotorFindsPerfectViewController"];
        //        mfb.hidesBottomBarWhenPushed=YES;
        //        [self.navigationController pushViewController:mfb animated:YES];
    }
    else
    {
        [requested showMessage:[responseDictionary valueForKey:@"message"] withTitle:@"Message"];
    }
}






-(IBAction)ClassifiedsClicked:(id)sender
{
    [requested checkNetworkStatus];
    
    isInternetConnectionAvailable=[[NSUserDefaults standardUserDefaults]objectForKey:@"internet"];
    
    if ([isInternetConnectionAvailable isEqualToString:@"NO"])
    {
        [requested showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again" withTitle:@"Message"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setInteger:5 forKey:@"index"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        MotorListArabicViewController *mfb=[self.storyboard instantiateViewControllerWithIdentifier:@"MotorListArabicViewController"];
        mfb.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:mfb animated:YES];
    }
  
    
    //    [self.navigationController.view showActivityViewWithLabel:@"Please Wait..."];
    //    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    //    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    //    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?category=%@",BaseUrl,strtoken,module,english,strCityId,@"2"];
    //    [requested OptionRequest4:nil withUrl:strurl];
}

-(IBAction)JobsClicked:(id)sender
{
    //    JobTypeViewController *jobs=[self.storyboard instantiateViewControllerWithIdentifier:@"JobTypeViewController"];
    //    [self.navigationController pushViewController:jobs animated:YES];
    
    //    [self.navigationController.view showActivityViewWithLabel:@"Please Wait..."];
    //    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    //    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    //    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?category=%@",BaseUrl,strtoken,module,english,strCityId,@"5"];
    //    [requested motorsRequest:nil withUrl:strurl];
    
    [self JobSetview];
    
    //    JobsInitialViewController *jobs=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsInitialViewController"];
    //    jobs.hidesBottomBarWhenPushed=YES;
    //    [self.navigationController pushViewController:jobs animated:YES];
    
}


-(void)JobSetview
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height/2-123, popview.frame.size.width-40, 246)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-20, 60)];
    lab.text=@"What are you looking for?";
    lab.textColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont boldSystemFontOfSize:16];
    [footerview addSubview:lab];
    
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(1, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width-2, 1)];
    labeunder.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:labeunder];
    
    
    UIButton *butt11=[[UIButton alloc]initWithFrame:CGRectMake(0, labeunder.frame.size.height+labeunder.frame.origin.y, footerview.frame.size.width, 60)];
    [butt11 setTitle:@"I am looking for a job" forState:UIControlStateNormal];
    butt11.titleLabel.font = [UIFont systemFontOfSize:15];
    butt11.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [butt11 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt11 addTarget:self action:@selector(lookingforclick:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt11];
    
    UILabel *labeunder2=[[UILabel alloc]initWithFrame:CGRectMake(0, butt11.frame.origin.y+butt11.frame.size.height+1, footerview.frame.size.width, 1)];
    labeunder2.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:labeunder2];
    
    UIButton *buttla=[[UIButton alloc]initWithFrame:CGRectMake(0,labeunder2.frame.origin.y+labeunder2.frame.size.height,footerview.frame.size.width,60)];
    [buttla setTitle:@"I am hiring" forState:UIControlStateNormal];
    buttla.titleLabel.font = [UIFont systemFontOfSize:15];
    buttla.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [buttla setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttla addTarget:self action:@selector(hiringClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:buttla];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(1, buttla.frame.origin.y+buttla.frame.size.height, footerview.frame.size.width-2, 60)];
    [butt1 setTitle:@"<- Go back" forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    butt1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [butt1 addTarget:self action:@selector(gobackClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt1];
    
}

-(IBAction)lookingforclick:(id)sender
{
    [requested checkNetworkStatus];
    
    isInternetConnectionAvailable=[[NSUserDefaults standardUserDefaults]objectForKey:@"internet"];
    
    if ([isInternetConnectionAvailable isEqualToString:@"NO"])
    {
        [requested showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again" withTitle:@"Message"];
    }
    else
    {
        [footerview removeFromSuperview];
        popview.hidden = YES;
        
        [[NSUserDefaults standardUserDefaults]setInteger:4 forKey:@"index"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        MotorListArabicViewController *mfb=[self.storyboard instantiateViewControllerWithIdentifier:@"MotorListArabicViewController"];
        mfb.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:mfb animated:YES];
    }
 
}

-(IBAction)hiringClick:(id)sender
{
    [requested checkNetworkStatus];
    
    isInternetConnectionAvailable=[[NSUserDefaults standardUserDefaults]objectForKey:@"internet"];
    
    if ([isInternetConnectionAvailable isEqualToString:@"NO"])
    {
        [requested showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again" withTitle:@"Message"];
    }
    else
    {
        [footerview removeFromSuperview];
        popview.hidden = YES;
        
        [[NSUserDefaults standardUserDefaults]setInteger:3 forKey:@"index"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        MotorListArabicViewController *mfb=[self.storyboard instantiateViewControllerWithIdentifier:@"MotorListArabicViewController"];
        mfb.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:mfb animated:YES];

    }
}

-(IBAction)gobackClick:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}


-(IBAction)PropertyonRentClicked:(id)sender
{
    [requested checkNetworkStatus];
    
    isInternetConnectionAvailable=[[NSUserDefaults standardUserDefaults]objectForKey:@"internet"];
    
    if ([isInternetConnectionAvailable isEqualToString:@"NO"])
    {
        [requested showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again" withTitle:@"Message"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setInteger:2 forKey:@"index"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        MotorListArabicViewController *mfb=[self.storyboard instantiateViewControllerWithIdentifier:@"MotorListArabicViewController"];
        mfb.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:mfb animated:YES];
    }
    
    //    [self.navigationController.view showActivityViewWithLabel:@"Please Wait..."];
    //    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    //    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    //    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?category=%@",BaseUrl,strtoken,module,english,strCityId,@"4"];
    //    [requested OptionRequest4:nil withUrl:strurl];
}



-(IBAction)PropertyonSaleClicked:(id)sender
{
    [requested checkNetworkStatus];
    
    isInternetConnectionAvailable=[[NSUserDefaults standardUserDefaults]objectForKey:@"internet"];
    
    if ([isInternetConnectionAvailable isEqualToString:@"NO"])
    {
        [requested showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again" withTitle:@"Message"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"index"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        MotorListArabicViewController *mfb=[self.storyboard instantiateViewControllerWithIdentifier:@"MotorListArabicViewController"];
        mfb.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:mfb animated:YES];
 
    }
    
    //    [self.navigationController.view showActivityViewWithLabel:@"Please Wait..."];
    //    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    //    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    //    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?category=%@",BaseUrl,strtoken,module,english,strCityId,@"3"];
    //    [requested OptionRequest4:nil withUrl:strurl];
}

-(IBAction)FurnitureClicked:(id)sender
{
    [requested checkNetworkStatus];
    
    isInternetConnectionAvailable=[[NSUserDefaults standardUserDefaults]objectForKey:@"internet"];
    
    if ([isInternetConnectionAvailable isEqualToString:@"NO"])
    {
        [requested showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again" withTitle:@"Message"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"index"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        MotorListArabicViewController *mfb=[self.storyboard instantiateViewControllerWithIdentifier:@"MotorListArabicViewController"];
        mfb.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:mfb animated:YES];

    }
    
    //    [self.navigationController.view showActivityViewWithLabel:@"Please Wait..."];
    //    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    //    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    //    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?category=%@",BaseUrl,strtoken,module,english,strCityId,@"6"];
    //    [requested OptionRequest4:nil withUrl:strurl];
}


-(void)responseOption4:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Dict Response: %@",responseDictionary);
    
    strnameUrlparameter=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"url_parameter"];
    strNmaeOfModule=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"name"];
    
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,arabic,strCityId,strnameUrlparameter,@"category",@"0"];
    [requested OtpVerifyRequest:nil withUrl:strurl];
}

-(void)responseRegistrationotp:(NSMutableDictionary *)responseDict
{
    NSLog(@"Jobs list Response: %@",responseDict);
    
    data=[responseDict valueForKey:@"data"];
    
    [self.navigationController.view hideActivityView];
    
    JobslistArabicViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"JobslistArabicViewController"];
    post.arrChildCategory=data;
    post.strModule=strnameUrlparameter;
    post.strtitle=strNmaeOfModule;
    post.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:post animated:YES];
}


-(void)responsewithData:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Dict Response: %@",responseDictionary);
    
    
    strnameUrlparameter=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"url_parameter"];
    strNmaeOfModule=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"name"];
    
    // [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSString *strmodule=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"url_parameter"];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *post = [NSString stringWithFormat:@"module=%@",strmodule];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,arabic,strCityId];
    [requested sendRequest1:post withUrl:strurl];
}


-(void)responsewithToken1:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Dict Response: %@",responseDictionary);
    
    [self.navigationController.view hideActivityView];
    
    NSString *strmessage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"status"]];
    
    NSString *strpage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"nextPage"]];
    
    if ([strmessage isEqualToString:@"0"])
    {
        [requested showMessage:[NSString stringWithFormat:@"There is no More %@ lists",[[homelistarray valueForKey:@"name"] objectAtIndex:0]] withTitle:@"All list"];
    }
    else
    {
        CarNameViewController *car=[self.storyboard instantiateViewControllerWithIdentifier:@"CarNameViewController"];
        car.arrDataList=[responseDictionary valueForKey:@"data"];
        car.hidesBottomBarWhenPushed = YES;
        car.strmodule=strnameUrlparameter;
        car.strname=strNmaeOfModule;
        car.strpage=strpage;
        [self.navigationController pushViewController:car animated:YES];
    }
}






-(IBAction)ElectronicsClicked:(id)sender
{
    [requested showMessage:@"Electronics Clicked" withTitle:@"Electronics"];
}

-(IBAction)FashionClicked:(id)sender
{
    [requested showMessage:@"Fashion Clicked" withTitle:@"Fashion"];
}

-(IBAction)ServicesClicked:(id)sender
{
    [requested showMessage:@"Services Clicked" withTitle:@"Services"];
}

-(IBAction)bookSportsClicked:(id)sender
{
    [requested showMessage:@"book & Sports Clicked" withTitle:@"bookSports"];
}
-(IBAction)PetsClicked:(id)sender
{
    [requested showMessage:@"Pets Clicked" withTitle:@"Pets"];
}

-(IBAction)LessClicked:(id)sender
{
    categoryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1120);
    
    CGRect newFrame = headerview.frame;
    newFrame.size.width = self.view.frame.size.width-2;
    newFrame.size.height = 197;
    [headerview setFrame:newFrame];
    
    CGRect newFrame1 = butt.frame;
    newFrame1.origin.y=335;
    newFrame1.size.width = 60;
    newFrame1.size.height = 40;
    [butt setTitle:@"More" forState:UIControlStateNormal];
    [butt setFrame:newFrame1];
    
    carslabel=[[UILabel alloc] initWithFrame:CGRectMake(5, butt.frame.size.height+butt.frame.origin.y+5, self.view.frame.size.width-40, 30)];
    carslabel.text=@"Cars";
    carslabel.textAlignment=NSTextAlignmentLeft;
    carslabel.numberOfLines=2;
    carslabel.font = [UIFont boldSystemFontOfSize:15];
    carslabel.textColor=[UIColor blackColor];
    [categoryScrollView addSubview:carslabel];
    
    imagecar=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-22,butt.frame.size.height+butt.frame.origin.y+13, 16, 16)];
    imagecar.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [categoryScrollView addSubview:imagecar];
    
    SeeAlllabel=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-80, butt.frame.size.height+butt.frame.origin.y+5, 55, 30)];
    SeeAlllabel.text=@"See All";
    SeeAlllabel.textAlignment=NSTextAlignmentRight;
    SeeAlllabel.numberOfLines=2;
    SeeAlllabel.font = [UIFont systemFontOfSize:15];
    SeeAlllabel.textColor=[UIColor blackColor];
    [categoryScrollView addSubview:SeeAlllabel];
    
    CarsSellAllbutt=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, butt.frame.size.height+butt.frame.origin.y+5, 80, 30)];
    CarsSellAllbutt.backgroundColor=[UIColor clearColor];
    [CarsSellAllbutt addTarget:self action:@selector(CarsSellAllbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    [categoryScrollView addSubview:CarsSellAllbutt];
    
    
    
    [self footerView];
    
    
    
    propertyforSalelab=[[UILabel alloc] initWithFrame:CGRectMake(5, scrollCarAll.frame.size.height+scrollCarAll.frame.origin.y+5, self.view.frame.size.width-80, 30)];
    propertyforSalelab.text=@"Property for Sale";
    propertyforSalelab.textAlignment=NSTextAlignmentLeft;
    propertyforSalelab.numberOfLines=2;
    propertyforSalelab.font = [UIFont boldSystemFontOfSize:15];
    propertyforSalelab.textColor=[UIColor blackColor];
    [categoryScrollView addSubview:propertyforSalelab];
    
    
    imageProperty=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-22,scrollCarAll.frame.size.height+scrollCarAll.frame.origin.y+12, 16, 16)];
    imageProperty.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [categoryScrollView addSubview:imageProperty];
    
    seeallpropertylab=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-80, scrollCarAll.frame.size.height+scrollCarAll.frame.origin.y+5, 55, 30)];
    seeallpropertylab.text=@"See All";
    seeallpropertylab.textAlignment=NSTextAlignmentRight;
    seeallpropertylab.numberOfLines=2;
    seeallpropertylab.font = [UIFont systemFontOfSize:15];
    seeallpropertylab.textColor=[UIColor blackColor];
    [categoryScrollView addSubview:seeallpropertylab];
    
    Propertyforsalebutt=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, scrollCarAll.frame.size.height+scrollCarAll.frame.origin.y+5, 80, 30)];
    Propertyforsalebutt.backgroundColor=[UIColor clearColor];
    [Propertyforsalebutt addTarget:self action:@selector(PropertyforSalebuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    [categoryScrollView addSubview:Propertyforsalebutt];
    
    
    [self footerView3];
    
    ElectronicsApplianceslab=[[UILabel alloc] initWithFrame:CGRectMake(5, scrollPropertyforSale.frame.size.height+scrollPropertyforSale.frame.origin.y+5, self.view.frame.size.width-80, 30)];
    ElectronicsApplianceslab.text=@"Electronic Appliances";
    ElectronicsApplianceslab.textAlignment=NSTextAlignmentLeft;
    ElectronicsApplianceslab.numberOfLines=2;
    ElectronicsApplianceslab.font = [UIFont boldSystemFontOfSize:15];
    ElectronicsApplianceslab.textColor=[UIColor blackColor];
    [categoryScrollView addSubview:ElectronicsApplianceslab];
    
    imageElectronic=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-22,scrollPropertyforSale.frame.size.height+scrollPropertyforSale.frame.origin.y+12, 16, 16)];
    imageElectronic.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [categoryScrollView addSubview:imageElectronic];
    
    seeAllElectroniclab=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-80, scrollPropertyforSale.frame.size.height+scrollPropertyforSale.frame.origin.y+5, 55, 30)];
    seeAllElectroniclab.text=@"See All";
    seeAllElectroniclab.textAlignment=NSTextAlignmentRight;
    seeAllElectroniclab.numberOfLines=2;
    seeAllElectroniclab.font = [UIFont systemFontOfSize:15];
    seeAllElectroniclab.textColor=[UIColor blackColor];
    [categoryScrollView addSubview:seeAllElectroniclab];
    
    Electronicappliancesbutt=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, scrollPropertyforSale.frame.size.height+scrollPropertyforSale.frame.origin.y+5, 80, 30)];
    Electronicappliancesbutt.backgroundColor=[UIColor clearColor];
    [Electronicappliancesbutt addTarget:self action:@selector(ElectronicsbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    [categoryScrollView addSubview:Electronicappliancesbutt];
    
    [self footerView5];
    
    view7.hidden=YES;
    view8.hidden=YES;
    view9.hidden=YES;
    view10.hidden=YES;
    view11.hidden=YES;
    view12.hidden=YES;
    butt.hidden=NO;
    
    carslabel1.hidden=YES;
    imagecar1.hidden=YES;
    SeeAlllabel1.hidden=YES;
    CarsSellAllbutt1.hidden=YES;
    
    scrollCarAll1.hidden=YES;
    viewdas1.hidden=YES;
    
    propertyforSalelab1.hidden=YES;
    imageProperty1.hidden=YES;
    seeallpropertylab1.hidden=YES;
    Propertyforsalebutt1.hidden=YES;
    
    scrollPropertyforSale1.hidden=YES;
    viewdas4.hidden=YES;
    
    ElectronicsApplianceslab1.hidden=YES;
    imageElectronic1.hidden=YES;
    seeAllElectroniclab1.hidden=YES;
    Electronicappliancesbutt1.hidden=YES;
    
    scrollElectronics1.hidden=YES;
    viewdas6.hidden=YES;
    
    isClick=NO;
}


-(IBAction)buttClicked:(id)sender
{
    if (isClick==NO)
    {
        categoryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1280);
        
        CGRect newFrame = headerview.frame;
        newFrame.size.width = self.view.frame.size.width-2;
        newFrame.size.height = 394;
        [headerview setFrame:newFrame];
        
        CGRect newFrame1 = butt.frame;
        newFrame1.origin.y=494;
        newFrame1.size.width = 60;
        newFrame1.size.height = 40;
        [butt setTitle:@"Less" forState:UIControlStateNormal];
        [butt setFrame:newFrame1];
        
        carslabel1=[[UILabel alloc] initWithFrame:CGRectMake(5, butt.frame.size.height+butt.frame.origin.y+5, self.view.frame.size.width-40, 30)];
        carslabel1.text=@"Cars";
        carslabel1.textAlignment=NSTextAlignmentLeft;
        carslabel1.numberOfLines=2;
        carslabel1.font = [UIFont boldSystemFontOfSize:15];
        carslabel1.textColor=[UIColor blackColor];
        [categoryScrollView addSubview:carslabel1];
        
        imagecar1=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-22,butt.frame.size.height+butt.frame.origin.y+13, 16, 16)];
        imagecar1.image=[UIImage imageNamed:@"right-arrow-2.png"];
        [categoryScrollView addSubview:imagecar1];
        
        SeeAlllabel1=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-80, butt.frame.size.height+butt.frame.origin.y+5, 55, 30)];
        SeeAlllabel1.text=@"See All";
        SeeAlllabel1.textAlignment=NSTextAlignmentRight;
        SeeAlllabel1.numberOfLines=2;
        SeeAlllabel1.font = [UIFont systemFontOfSize:15];
        SeeAlllabel1.textColor=[UIColor blackColor];
        [categoryScrollView addSubview:SeeAlllabel1];
        
        CarsSellAllbutt1=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, butt.frame.size.height+butt.frame.origin.y+5, 80, 30)];
        CarsSellAllbutt1.backgroundColor=[UIColor clearColor];
        [CarsSellAllbutt1 addTarget:self action:@selector(CarsSellAllbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
        [categoryScrollView addSubview:CarsSellAllbutt1];
        
        [self footerView1];
        
        
        
        propertyforSalelab1=[[UILabel alloc] initWithFrame:CGRectMake(5, scrollCarAll1.frame.size.height+scrollCarAll1.frame.origin.y+5, self.view.frame.size.width-80, 30)];
        propertyforSalelab1.text=@"Property for Sale";
        propertyforSalelab1.textAlignment=NSTextAlignmentLeft;
        propertyforSalelab1.numberOfLines=2;
        propertyforSalelab1.font = [UIFont boldSystemFontOfSize:15];
        propertyforSalelab1.textColor=[UIColor blackColor];
        [categoryScrollView addSubview:propertyforSalelab1];
        
        imageProperty1=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-22,scrollCarAll1.frame.size.height+scrollCarAll1.frame.origin.y+12, 16, 16)];
        imageProperty1.image=[UIImage imageNamed:@"right-arrow-2.png"];
        [categoryScrollView addSubview:imageProperty1];
        
        seeallpropertylab1=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-80, scrollCarAll1.frame.size.height+scrollCarAll1.frame.origin.y+5, 55, 30)];
        seeallpropertylab1.text=@"See All";
        seeallpropertylab1.textAlignment=NSTextAlignmentRight;
        seeallpropertylab1.numberOfLines=2;
        seeallpropertylab1.font = [UIFont systemFontOfSize:15];
        seeallpropertylab1.textColor=[UIColor blackColor];
        [categoryScrollView addSubview:seeallpropertylab1];
        
        Propertyforsalebutt1=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, scrollCarAll1.frame.size.height+scrollCarAll1.frame.origin.y+5, 80, 30)];
        Propertyforsalebutt1.backgroundColor=[UIColor clearColor];
        [Propertyforsalebutt1 addTarget:self action:@selector(PropertyforSalebuttClicked:) forControlEvents:UIControlEventTouchUpInside];
        [categoryScrollView addSubview:Propertyforsalebutt1];
        
        [self footerView4];
        
        
        ElectronicsApplianceslab1=[[UILabel alloc] initWithFrame:CGRectMake(5, scrollPropertyforSale1.frame.size.height+scrollPropertyforSale1.frame.origin.y+5, self.view.frame.size.width-80, 30)];
        ElectronicsApplianceslab1.text=@"Electronic Appliances";
        ElectronicsApplianceslab1.textAlignment=NSTextAlignmentLeft;
        ElectronicsApplianceslab1.numberOfLines=2;
        ElectronicsApplianceslab1.font = [UIFont boldSystemFontOfSize:15];
        ElectronicsApplianceslab1.textColor=[UIColor blackColor];
        [categoryScrollView addSubview:ElectronicsApplianceslab1];
        
        imageElectronic1=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-22,scrollPropertyforSale1.frame.size.height+scrollPropertyforSale1.frame.origin.y+12, 16, 16)];
        imageElectronic1.image=[UIImage imageNamed:@"right-arrow-2.png"];
        [categoryScrollView addSubview:imageElectronic1];
        
        seeAllElectroniclab1=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-80, scrollPropertyforSale1.frame.size.height+scrollPropertyforSale1.frame.origin.y+5, 55, 30)];
        seeAllElectroniclab1.text=@"See All";
        seeAllElectroniclab1.textAlignment=NSTextAlignmentRight;
        seeAllElectroniclab1.numberOfLines=2;
        seeAllElectroniclab1.font = [UIFont systemFontOfSize:15];
        seeAllElectroniclab1.textColor=[UIColor blackColor];
        [categoryScrollView addSubview:seeAllElectroniclab1];
        
        Electronicappliancesbutt1=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, scrollPropertyforSale1.frame.size.height+scrollPropertyforSale1.frame.origin.y+5, 80, 30)];
        Electronicappliancesbutt1.backgroundColor=[UIColor clearColor];
        [Electronicappliancesbutt1 addTarget:self action:@selector(ElectronicsbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
        [categoryScrollView addSubview:Electronicappliancesbutt1];
        
        [self footerView6];
        
        view7.hidden=NO;
        view8.hidden=NO;
        view9.hidden=NO;
        view10.hidden=NO;
        view11.hidden=NO;
        view12.hidden=NO;
        butt.hidden=YES;
        
        carslabel.hidden=YES;
        imagecar.hidden=YES;
        SeeAlllabel.hidden=YES;
        CarsSellAllbutt.hidden=YES;
        
        scrollCarAll.hidden=YES;
        viewdas.hidden=YES;
        
        propertyforSalelab.hidden=YES;
        imageProperty.hidden=YES;
        seeallpropertylab.hidden=YES;
        Propertyforsalebutt.hidden=YES;
        
        scrollPropertyforSale.hidden=YES;
        viewdas3.hidden=YES;
        
        ElectronicsApplianceslab.hidden=YES;
        imageElectronic.hidden=YES;
        seeAllElectroniclab.hidden=YES;
        Electronicappliancesbutt.hidden=YES;
        
        scrollElectronics.hidden=YES;
        viewdas5.hidden=YES;
        
        isClick=YES;
    }
    
    else if (isClick==YES)
    {
        CGRect newFrame = headerview.frame;
        newFrame.size.width = self.view.frame.size.width-2;
        newFrame.size.height = 197;
        [headerview setFrame:newFrame];
        
        CGRect newFrame1 = butt.frame;
        newFrame1.origin.y=329;
        newFrame1.size.width = 60;
        newFrame1.size.height = 40;
        [butt setTitle:@"More" forState:UIControlStateNormal];
        [butt setFrame:newFrame1];
        
        view7.hidden=YES;
        view8.hidden=YES;
        view9.hidden=YES;
        view10.hidden=YES;
        view11.hidden=YES;
        view12.hidden=YES;
        butt.hidden=NO;
        
        isClick=NO;
    }
}



#pragma mark - Categeory Response


-(void)CategeoryRequest:(NSString*)categeoryId
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?category=%@",BaseUrl,strtoken,module,arabic,strCityId,categeoryId];
    [requested motorsRequest:nil withUrl:strurl];
}



#pragma mark - See All Clicked


-(IBAction)CarsSellAllbuttClicked:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:0];
    //    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    //    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    //    NSString *post = [NSString stringWithFormat:@"module=%@",strmodule];
    //    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
    //    [requested loginRequest:post withUrl:strurl];
    
    if ([strmodule isEqualToString:@"jobs"])
    {
//        JobsInitialViewController *jobs=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsInitialViewController"];
//        jobs.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:jobs animated:YES];
        
         [self JobSetview];
    }
    else
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,arabic,strCityId,strmodule,@"category",@"0"];
        [requested CategoryOptionRequest:nil withUrl:strurl];
    }
}

-(void)responseCategoryOption:(NSMutableDictionary *)responseDict
{
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        NSLog(@"Jobs list Response: %@",responseDict);
        
        NSString *strname=[[homelistarray valueForKey:@"name"] objectAtIndex:0];
        NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:0];
        
        
        
        
        data=[responseDict valueForKey:@"data"];
        
        NSString *strna=[NSString stringWithFormat:@"All %@",strname];
        NSString *result = [[data valueForKey:@"id"] componentsJoinedByString:@","];
        
        
        NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:@"2",@"haschild",result,@"id",strna,@"name", nil];
        
        NSMutableArray *arrdata=[[NSMutableArray alloc] initWithObjects:dict, nil];
        
        arrdata=[[arrdata arrayByAddingObjectsFromArray:data] mutableCopy];
        
        //    [self.navigationController.view hideActivityView];
        
        
        SubCategeorylistArabicViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"SubCategeorylistArabicViewController"];
        post.arrChildCategory=arrdata;
        post.strModule=strmodule;
        post.strtitle=strname;
        post.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:post animated:YES];
        
        
        
        
        
        //        JobsListViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsListViewController"];
        //        post.arrChildCategory=[responseDict valueForKey:@"data"];
        //        post.strModule=strmodule;
        //        post.strtitle=strname;
        //        post.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:post animated:YES];
        
    }
    else
    {
        [requested showMessage:[responseDict valueForKey:@"message"] withTitle:@""];
    }
    
//    NSLog(@"Jobs list Response: %@",responseDict);
//    
//    NSString *strname=[[homelistarray valueForKey:@"name"] objectAtIndex:0];
//    NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:0];
//    
//    JobsListsArabicViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsListsArabicViewController"];
//    post.arrChildCategory=[responseDict valueForKey:@"data"];
//    post.strModule=strmodule;
//    post.strtitle=strname;
//    post.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:post animated:YES];
}

-(void)responseLogin:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Dict Response: %@",responseDictionary);
    
    
    
    NSString *strmessage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"status"]];
    
    NSString *strpage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"nextPage"]];
    
    if ([strmessage isEqualToString:@"0"])
    {
        [requested showMessage:[NSString stringWithFormat:@"There is no More %@ lists",[[homelistarray valueForKey:@"name"] objectAtIndex:0]] withTitle:@"All list"];
    }
    else
    {
        NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:0];
        
        if ([strmodule isEqualToString:@"jobs"])
        {
            JobsInitialViewController *jobs=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsInitialViewController"];
            jobs.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:jobs animated:YES];
        }
        else
        {
            NSString *strname=[[homelistarray valueForKey:@"name"] objectAtIndex:0];
            CarNameViewController *car=[self.storyboard instantiateViewControllerWithIdentifier:@"CarNameViewController"];
            car.arrDataList=[responseDictionary valueForKey:@"data"];
            car.strPrice=[responseDictionary valueForKey:@"price"];
            car.hidesBottomBarWhenPushed = YES;
            car.strmodule=strmodule;
            car.strname=strname;
            car.strpage=strpage;
            [self.navigationController pushViewController:car animated:YES];
        }
        
    }
}


-(IBAction)PropertyforSalebuttClicked:(UIButton *)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:1];
    //    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    //    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    //    NSString *post = [NSString stringWithFormat:@"module=%@",strmodule];
    //    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
    //    [requested DeleteFileRequest:post withUrl:strurl];
    
    if ([strmodule isEqualToString:@"jobs"])
    {
//        JobsInitialViewController *jobs=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsInitialViewController"];
//        jobs.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:jobs animated:YES];
        
         [self JobSetview];
    }
    else
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,arabic,strCityId,strmodule,@"category",@"0"];
        [requested CategoryOptionRequest2:nil withUrl:strurl];
    }
}

-(void)responseCategoryOption2:(NSMutableDictionary *)responseDict
{
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        NSLog(@"Jobs list Response: %@",responseDict);
        
        NSString *strname=[[homelistarray valueForKey:@"name"] objectAtIndex:1];
        NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:1];
        
        
        data=[responseDict valueForKey:@"data"];
        
        NSString *strna=[NSString stringWithFormat:@"All %@",strname];
        NSString *result = [[data valueForKey:@"id"] componentsJoinedByString:@","];
        
        
        NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:@"2",@"haschild",result,@"id",strna,@"name", nil];
        
        NSMutableArray *arrdata=[[NSMutableArray alloc] initWithObjects:dict, nil];
        
        arrdata=[[arrdata arrayByAddingObjectsFromArray:data] mutableCopy];
        
        //    [self.navigationController.view hideActivityView];
        
        
        SubCategeorylistArabicViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"SubCategeorylistArabicViewController"];
        post.arrChildCategory=arrdata;
        post.strModule=strmodule;
        post.strtitle=strname;
        post.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:post animated:YES];
        
        //        JobsListViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsListViewController"];
        //        post.arrChildCategory=[responseDict valueForKey:@"data"];
        //        post.strModule=strmodule;
        //        post.strtitle=strname;
        //        post.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:post animated:YES];
    }
    else
    {
        [requested showMessage:[responseDict valueForKey:@"message"] withTitle:@""];
    }

    
//    NSLog(@"Jobs list Response: %@",responseDict);
//    
//    NSString *strname=[[homelistarray valueForKey:@"name"] objectAtIndex:1];
//    NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:1];
//    
//    JobsListsArabicViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsListsArabicViewController"];
//    post.arrChildCategory=[responseDict valueForKey:@"data"];
//    post.strModule=strmodule;
//    post.strtitle=strname;
//    post.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:post animated:YES];
}

-(void)responsewithDeleteFile:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Dict Response: %@",responseDictionary);
    
    
    
    NSString *strmessage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"status"]];
    
    NSString *strpage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"nextPage"]];
    
    if ([strmessage isEqualToString:@"0"])
    {
        [requested showMessage:[NSString stringWithFormat:@"There is no More %@ lists",[[homelistarray valueForKey:@"name"] objectAtIndex:1]] withTitle:@"All list"];
    }
    else
    {
        NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:1];
        
        if ([strmodule isEqualToString:@"jobs"])
        {
//            JobsInitialViewController *jobs=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsInitialViewController"];
//            jobs.hidesBottomBarWhenPushed=YES;
//            [self.navigationController pushViewController:jobs animated:YES];
            
             [self JobSetview];
        }
        else
        {
            NSString *strname=[[homelistarray valueForKey:@"name"] objectAtIndex:1];
            CarNameViewController *car=[self.storyboard instantiateViewControllerWithIdentifier:@"CarNameViewController"];
            car.arrDataList=[responseDictionary valueForKey:@"data"];
            car.strPrice=[responseDictionary valueForKey:@"price"];
            car.hidesBottomBarWhenPushed = YES;
            car.strmodule=strmodule;
            car.strname=strname;
            car.strpage=strpage;
            [self.navigationController pushViewController:car animated:YES];
        }
    }
}



-(IBAction)ElectronicsbuttClicked:(UIButton *)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:2];
    //    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    //    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    //    NSString *post = [NSString stringWithFormat:@"module=%@",strmodule];
    //    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
    //    [requested sendRequest2:post withUrl:strurl];
    
    if ([strmodule isEqualToString:@"jobs"])
    {
//        JobsInitialViewController *jobs=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsInitialViewController"];
//        jobs.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:jobs animated:YES];
        
         [self JobSetview];
    }
    else
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,arabic,strCityId,strmodule,@"category",@"0"];
        [requested CategoryOptionRequest3:nil withUrl:strurl];
    }
}

-(void)responseCategoryOption3:(NSMutableDictionary *)responseDict
{
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        NSLog(@"Jobs list Response: %@",responseDict);
        
        NSString *strname=[[homelistarray valueForKey:@"name"] objectAtIndex:2];
        NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:2];
        
        data=[responseDict valueForKey:@"data"];
        
        NSString *strna=[NSString stringWithFormat:@"All %@",strname];
        NSString *result = [[data valueForKey:@"id"] componentsJoinedByString:@","];
        
        
        NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:@"2",@"haschild",result,@"id",strna,@"name", nil];
        
        NSMutableArray *arrdata=[[NSMutableArray alloc] initWithObjects:dict, nil];
        
        arrdata=[[arrdata arrayByAddingObjectsFromArray:data] mutableCopy];
        
        //    [self.navigationController.view hideActivityView];
        
        
        SubCategeorylistArabicViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"SubCategeorylistArabicViewController"];
        post.arrChildCategory=arrdata;
        post.strModule=strmodule;
        post.strtitle=strname;
        post.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:post animated:YES];
        
        //        JobsListViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsListViewController"];
        //        post.arrChildCategory=[responseDict valueForKey:@"data"];
        //        post.strModule=strmodule;
        //        post.strtitle=strname;
        //        post.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:post animated:YES];
    }
    else
    {
        [requested showMessage:[responseDict valueForKey:@"message"] withTitle:@""];
    }

//    NSLog(@"Jobs list Response: %@",responseDict);
//    
//    NSString *strname=[[homelistarray valueForKey:@"name"] objectAtIndex:2];
//    NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:2];
//    
//    JobsListsArabicViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsListsArabicViewController"];
//    post.arrChildCategory=[responseDict valueForKey:@"data"];
//    post.strModule=strmodule;
//    post.strtitle=strname;
//    post.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:post animated:YES];
}

-(void)responsewithToken2:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Dict Response: %@",responseDictionary);
    
    
    
    NSString *strmessage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"status"]];
    
    NSString *strpage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"nextPage"]];
    
    if ([strmessage isEqualToString:@"0"])
    {
        [requested showMessage:[NSString stringWithFormat:@"There is no More %@ lists",[[homelistarray valueForKey:@"name"] objectAtIndex:2]] withTitle:@"All list"];
    }
    else
    {
        NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:2];
        
        if ([strmodule isEqualToString:@"jobs"])
        {
            JobsInitialViewController *jobs=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsInitialViewController"];
            jobs.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:jobs animated:YES];
        }
        else
        {
            NSString *strname=[[homelistarray valueForKey:@"name"] objectAtIndex:2];
            CarNameViewController *car=[self.storyboard instantiateViewControllerWithIdentifier:@"CarNameViewController"];
            car.arrDataList=[responseDictionary valueForKey:@"data"];
            car.strPrice=[responseDictionary valueForKey:@"price"];
            car.hidesBottomBarWhenPushed = YES;
            car.strmodule=strmodule;
            car.strname=strname;
            car.strpage=strpage;
            [self.navigationController pushViewController:car animated:YES];
        }
    }
}




#pragma mark - Categeory Wise list of Items Clicked

-(IBAction)AlltypesCarsbutonclicked:(UIButton *)sender
{
    [DataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if (sender.tag== buttontag1+idx)
         {
             //     NSString *strname =[DataArray objectAtIndex:idx];
             //      NSString *strprice=[[DataArray valueForKey:@"price"] objectAtIndex:idx];
             
             //     [requested showMessage:strprice withTitle:[[DataArray valueForKey:@"name"] objectAtIndex:idx]];
             
             for(UIButton *btn in Scrollview.subviews)
                 if([btn isKindOfClass:[UIButton class]])
                     btn.selected = NO;
             
             sender.selected = YES;
             
             btnSelected = sender;
             
             
             NSString *postid=[[DataArray valueForKey:@"id"]objectAtIndex:idx];
             NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:0];
             
             [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
             NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
             NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
             NSString *post = [NSString stringWithFormat:@"module=%@&post_id=%@",strmodule,postid];
             NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Post,arabic,strCityId];
             [requested RegistrationRequest:post withUrl:strurl];
         }
     }];
}

-(IBAction)PropertyforSaleCategeoryclicked:(UIButton *)sender
{
    [DataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if (sender.tag== buttontag1+idx)
         {
             //    NSString *strprice=[[DataArray1 valueForKey:@"price"] objectAtIndex:idx];
             
             //     [requested showMessage:strprice withTitle:[[DataArray1 valueForKey:@"name"] objectAtIndex:idx]];
             
             for(UIButton *btn in Scrollview.subviews)
                 if([btn isKindOfClass:[UIButton class]])
                     btn.selected = NO;
             
             sender.selected = YES;
             
             btnSelected = sender;
             
             NSString *postid=[[DataArray1 valueForKey:@"id"]objectAtIndex:idx];
             NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:1];
             
             [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
             NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
             NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
             NSString *post = [NSString stringWithFormat:@"module=%@&post_id=%@",strmodule,postid];
             NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Post,arabic,strCityId];
             [requested RegistrationRequest:post withUrl:strurl];
         }
     }];
}


-(void)responseRegistration:(NSMutableDictionary *)responseDict
{
    NSLog(@"Dict Response: %@",responseDict);
    
    NSArray *strname=[[responseDict valueForKey:@"data"] valueForKey:@"name"];
    NSString *strn=[strname componentsJoinedByString:@""];
    NSDictionary *strurls=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"pic"];
    NSArray *strls=[strurls valueForKey:@"url"];
    
    NSLog(@"%@",strurls);
    
    CarDescriptionArabicViewController *des=[self.storyboard instantiateViewControllerWithIdentifier:@"CarDescriptionArabicViewController"];
    des.strDataArray=[[responseDict valueForKey:@"data"] objectAtIndex:0];
    des.strtitle=strn;
    des.strUrls=strls;
    des.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:des animated:YES];
}


-(IBAction)ElectronicsCategeoryclicked:(UIButton *)sender
{
    [DataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if (sender.tag== buttontag1+idx)
         {
             //    NSString *strprice=[[DataArray1 valueForKey:@"price"] objectAtIndex:idx];
             
             //     [requested showMessage:strprice withTitle:[[DataArray1 valueForKey:@"name"] objectAtIndex:idx]];
             
             for(UIButton *btn in Scrollview.subviews)
                 if([btn isKindOfClass:[UIButton class]])
                     btn.selected = NO;
             
             sender.selected = YES;
             
             btnSelected = sender;
             
             NSString *postid=[[DataArray2 valueForKey:@"id"]objectAtIndex:idx];
             NSString *strmodule=[[homelistarray valueForKey:@"url_parameter"] objectAtIndex:2];
             
             [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
             NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
             NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
             NSString *post = [NSString stringWithFormat:@"module=%@&post_id=%@",strmodule,postid];
             NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Post,arabic,strCityId];
             [requested RegistrationRequest:post withUrl:strurl];
         }
     }];
}



#pragma mark - TopView Clicked


- (IBAction)SearchBarClicked:(id)sender
{
    _CustomSearchbar.hidden=NO;
    _CrossButt.hidden=NO;
    _leftview.hidden=YES;
    _TitleLabel.hidden=YES;
}

- (IBAction)CrossMarkClicked:(id)sender
{
    [self.view endEditing:YES];
    _CustomSearchbar.hidden=YES;
    _CrossButt.hidden=YES;
    _leftview.hidden=NO;
    _TitleLabel.hidden=NO;
}
- (IBAction)DohabuttClicked:(id)sender
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-150, 300, 300)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(footerview.frame.size.width-120, 0, 110, 40)];
    lab.text=@"Select City";
    lab.textColor=[UIColor blackColor];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentRight;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, 50, 40)];
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
    return arrCitys.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    static NSString *cellIdetifier = @"Cell";
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
    
    if (tableView.tag==2)
    {
        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width-50, 40)];
        namel.text=[[arrCitys valueForKey:@"name"]objectAtIndex:indexPath.row];
        namel.lineBreakMode = NSLineBreakByWordWrapping;
        namel.textAlignment=NSTextAlignmentRight;
        namel.textColor=[UIColor blackColor];
        namel.numberOfLines = 1;
        [namel setFont:[UIFont boldSystemFontOfSize:15]];
        [cell addSubview:namel];
    }
    else
    {
        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width-50, 40)];
        namel.text=[[arrCitys valueForKey:@"name"]objectAtIndex:indexPath.row];
        namel.lineBreakMode = NSLineBreakByWordWrapping;
        namel.textAlignment=NSTextAlignmentRight;
        namel.textColor=[UIColor blackColor];
        namel.numberOfLines = 1;
        [namel setFont:[UIFont boldSystemFontOfSize:15]];
        [cell addSubview:namel];
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==2)
    {
        NSString *strcity=[[arrCitys valueForKey:@"name"]objectAtIndex:indexPath.row];
        [_dohaButt setTitle:strcity forState:UIControlStateNormal];
        txtSelectCity.text=strcity;
        
        [[NSUserDefaults standardUserDefaults]setObject:strcity forKey:@"City"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [footerview2 removeFromSuperview];
        
        NSString *strcityId=[[arrCitys valueForKey:@"city_id"]objectAtIndex:indexPath.row];
        NSLog(@"%@",strcityId);
        
        [[NSUserDefaults standardUserDefaults]setObject:strcityId forKey:@"CityId"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        popview2.hidden = YES;
    }
    else
    {
        NSString *strcity=[[arrCitys valueForKey:@"name"]objectAtIndex:indexPath.row];
        [_dohaButt setTitle:strcity forState:UIControlStateNormal];
        txtSelectCity.text=strcity;
        
        [[NSUserDefaults standardUserDefaults]setObject:strcity forKey:@"City"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [footerview removeFromSuperview];
        
        NSString *strcityId=[[arrCitys valueForKey:@"city_id"]objectAtIndex:indexPath.row];
        NSLog(@"%@",strcityId);
        
        [[NSUserDefaults standardUserDefaults]setObject:strcityId forKey:@"CityId"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        popview.hidden = YES;
    }
}





#pragma mark - Page View Controller Delegate

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}




#pragma mark - View Controller life Cycle


-(void)viewWillAppear:(BOOL)animated
{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"set"];
    if(object != nil)
    {
        
        
        NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];
        NSObject *object2 = [prefs2 objectForKey:@"City"];
        if(object2!= nil)
        {
            // txtCity.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"City"];
            [_dohaButt setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"City"] forState:UIControlStateNormal];
        }
        else
        {
            [_dohaButt setTitle:@"SelectCity" forState:UIControlStateNormal];
        }
        
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSObject * object = [prefs objectForKey:@"first"];
        if(object != nil)
        {
            
            NSString *post = [NSString stringWithFormat:@"user=%@&password=%@",@"rajinder",@"123456"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,@"123456",user,arabic,strCityId];
            [requested sendRequest:post withUrl:strurl];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"f1" forKey:@"first"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
           [self.navigationController.view showActivityViewWithLabel:@"Please Wait..."];
            NSString *post = [NSString stringWithFormat:@"user=%@&password=%@",@"rajinder",@"123456"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,@"123456",user,arabic,strCityId];
            [requested sendRequest:post withUrl:strurl];
        }
    }
    else
    {
        [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:NO];
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:NO];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:NO];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:NO];
        [[[[self.tabBarController tabBar]items]objectAtIndex:4]setEnabled:NO];
        
        [self SetCountry];
        
        
        
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSObject * object = [prefs objectForKey:@"ccode"];
        if(object != nil)
        {
            txtCountryName.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"ccode"];
            
        }
        else
        {
            
            NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
            countryCo = [currentLocale objectForKey:NSLocaleCountryCode];
            
            NSLog(@"%@",countryCo);
            
            NSString *country = [[NSLocale systemLocale] displayNameForKey:NSLocaleCountryCode value:countryCo];
            NSLog(@"%@",country);
            
            txtCountryName.text=@"United Arab Emirates";
            
        }
    }
    
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0]];
    
}



-(void)SetCountry
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-126, 300, 252)];
    footerview.backgroundColor = [UIColor whiteColor];
    footerview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    footerview.layer.borderWidth = 2.0f;
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-20, 40)];
    lab.text=@"Select Country & Language";
    lab.textColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(1, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width-2, 1)];
    labeunder.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:labeunder];
    
    
    
    txtCountryName=[[UITextField alloc]initWithFrame:CGRectMake(10, labeunder.frame.origin.y+10, footerview.frame.size.width-20, 40)];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"Select Country" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtCountryName.attributedPlaceholder = str2;
    txtCountryName.textAlignment = NSTextAlignmentCenter;
    txtCountryName.textColor=[UIColor blackColor];
    txtCountryName.font = [UIFont systemFontOfSize:15];
    txtCountryName.backgroundColor=[UIColor clearColor];
    [txtCountryName setBorderStyle:UITextBorderStyleBezel];
    txtCountryName.returnKeyType = UIReturnKeyDone;
    [footerview addSubview:txtCountryName];
    
    
    UIButton *buttc=[[UIButton alloc]initWithFrame:CGRectMake(10,labeunder.frame.origin.y+10,footerview.frame.size.width-20,40)];
    buttc.backgroundColor=[UIColor clearColor];
    [buttc addTarget:self action:@selector(CountryClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:buttc];
    
    
    txtSelectCity=[[UITextField alloc]initWithFrame:CGRectMake(10, txtCountryName.frame.origin.y+txtCountryName.frame.size.height+10, footerview.frame.size.width-20, 40)];
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"Select City (Currently Available)" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtSelectCity.attributedPlaceholder = str3;
    txtSelectCity.textAlignment = NSTextAlignmentCenter;
    txtSelectCity.textColor=[UIColor blackColor];
    txtSelectCity.font = [UIFont systemFontOfSize:15];
    txtSelectCity.backgroundColor=[UIColor clearColor];
    [txtSelectCity setBorderStyle:UITextBorderStyleBezel];
    txtSelectCity.returnKeyType = UIReturnKeyDone;
    [footerview addSubview:txtSelectCity];
    
    
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(10, txtCountryName.frame.origin.y+txtCountryName.frame.size.height+10, footerview.frame.size.width-20, 40)];
    butt1.backgroundColor=[UIColor clearColor];
    [butt1 addTarget:self action:@selector(Cityclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt1];
    
    
    
    txtLanguage=[[UITextField alloc]initWithFrame:CGRectMake(10, txtSelectCity.frame.origin.y+txtSelectCity.frame.size.height+10, footerview.frame.size.width-20, 40)];
    NSAttributedString *str4 = [[NSAttributedString alloc] initWithString:@"Select Language (Currently Available)" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtLanguage.attributedPlaceholder = str4;
    txtLanguage.textAlignment = NSTextAlignmentCenter;
    txtLanguage.textColor=[UIColor blackColor];
    txtLanguage.font = [UIFont systemFontOfSize:15];
    txtLanguage.backgroundColor=[UIColor clearColor];
    [txtLanguage setBorderStyle:UITextBorderStyleBezel];
    txtLanguage.returnKeyType = UIReturnKeyDone;
    [footerview addSubview:txtLanguage];
    
    UIButton *butt2=[[UIButton alloc]initWithFrame:CGRectMake(10, txtSelectCity.frame.origin.y+txtSelectCity.frame.size.height+10, footerview.frame.size.width-20, 40)];
    butt2.backgroundColor=[UIColor clearColor];
    [butt2 addTarget:self action:@selector(Languageclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt2];
    
    
    
    UIButton *butt3=[[UIButton alloc]initWithFrame:CGRectMake(0, txtLanguage.frame.origin.y+txtLanguage.frame.size.height+20, footerview.frame.size.width/2-1, 40)];
    [butt3 setTitle:@"Cancel" forState:UIControlStateNormal];
    butt3.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    butt3.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [butt3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt3.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [butt3 addTarget:self action:@selector(Cancelbclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt3];
    
    
    UIButton *butt4=[[UIButton alloc]initWithFrame:CGRectMake(butt3.frame.size.width+butt3.frame.origin.x+2, txtLanguage.frame.origin.y+txtLanguage.frame.size.height+20, footerview.frame.size.width/2-1, 40)];
    [butt4 setTitle:@"Set" forState:UIControlStateNormal];
    butt4.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    butt4.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [butt4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt4.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [butt4 addTarget:self action:@selector(Setclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt4];
    
}


-(IBAction)CountryClicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
    SLCountryPickerViewController *vc = [[SLCountryPickerViewController alloc]init];
    vc.hidesBottomBarWhenPushed=YES;
    vc.completionBlock = ^(NSString *country, NSString *code){
        
        NSString *count = [[NSLocale systemLocale] displayNameForKey:NSLocaleCountryCode value:code];
        NSLog(@"%@",count);
        
        [[NSUserDefaults standardUserDefaults]setObject:count forKey:@"ccode"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        txtCountryName.text=count;
    };
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(IBAction)Cityclicked:(id)sender
{
    [self.navigationController.view showActivityViewWithLabel:@"Please Wait..."];
    NSString *post = [NSString stringWithFormat:@"user=%@&password=%@",@"rajinder",@"123456"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,@"123456",user,arabic,strCityId];
    [requested sendRequest4:post withUrl:strurl];
}


-(void)responsewithToken4:(NSMutableDictionary *)responseToken
{
    
    NSString *stringtoken=[[responseToken valueForKey:@"data"] valueForKey:@"token"];
    NSLog(@"Token: %@",stringtoken);
    
    [[NSUserDefaults standardUserDefaults]setObject:stringtoken forKey:@"Token"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSLog(@"Token Response :%@",responseToken);
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,citylist,arabic,strCityId];
        [requested SubCategoryRequest4:nil withUrl:strurl];
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,citylist,arabic,strCityId];
        [requested SubCategoryRequest4:nil withUrl:strurl];
    }
    else
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,citylist,arabic,strCityId];
        [requested SubCategoryRequest4:nil withUrl:strurl];
    }
}

-(void)responseSubCategory4:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"City list Response: %@",responseDictionary);
    NSMutableArray *arrCitys1=[[NSMutableArray alloc]init];
    arrCitys1=[responseDict valueForKey:@"data"];
    
    NSData *datal = [NSKeyedArchiver archivedDataWithRootObject:arrCitys1];
    
    [[NSUserDefaults standardUserDefaults]setObject:datal forKey:@"Citys"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *datalist = [defaults objectForKey:@"Citys"];
    arrCitys=[NSKeyedUnarchiver unarchiveObjectWithData:datalist];
    // [tabl reloadData];
    
    [self.navigationController.view hideActivityView];
    
    [self CityList];
}

-(void)CityList
{
    
    popview2 = [[UIView alloc]init];
    popview2.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview2.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [footerview addSubview:popview2];
    
    footerview2=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-150, 300, 300)];
    footerview2.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview2];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-50, 40)];
    lab.text=@"Select City";
    lab.textColor=[UIColor blackColor];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentLeft+10;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview2 addSubview:lab];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60, 0, 50, 40)];
    [butt1 setTitle:@"Cancel" forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont systemFontOfSize:15];
    butt1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [butt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt1 addTarget:self action:@selector(Cancelclicked23:) forControlEvents:UIControlEventTouchUpInside];
    [footerview2 addSubview:butt1];
    
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(1, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width-2, 1)];
    labeunder.backgroundColor=[UIColor darkGrayColor];
    [footerview2 addSubview:labeunder];
    
    
    tabl=[[UITableView alloc] init];
    tabl.frame = CGRectMake(0,labeunder.frame.origin.y+labeunder.frame.size.height+10, footerview.frame.size.width, 257);
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.tag=2;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [tabl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [footerview2 addSubview:tabl];
    
}

-(IBAction)Cancelclicked23:(id)sender
{
    [footerview2 removeFromSuperview];
    popview2.hidden = YES;
}





-(IBAction)Languageclicked:(id)sender
{
    popview2 = [[ UIView alloc]init];
    popview2.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview2.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [footerview addSubview:popview2];
    
    footerview2=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-62, 300, 134)];
    footerview2.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview2];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-50, 40)];
    lab.text=@"Change language";
    lab.textColor=[UIColor blackColor];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentLeft+10;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview2 addSubview:lab];
    
    UIButton *butt11=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60, 0, 50, 40)];
    [butt11 setTitle:@"Cancel" forState:UIControlStateNormal];
    butt11.titleLabel.font = [UIFont systemFontOfSize:15];
    butt11.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [butt11 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt11 addTarget:self action:@selector(Cancelclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview2 addSubview:butt11];
    
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(1, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width-2, 1)];
    labeunder.backgroundColor=[UIColor lightGrayColor];
    [footerview2 addSubview:labeunder];
    
    UIButton *buttla=[[UIButton alloc]initWithFrame:CGRectMake(15,labeunder.frame.origin.y+5,footerview.frame.size.width-30,40)];
    [buttla setTitle:@"English" forState:UIControlStateNormal];
    buttla.titleLabel.font = [UIFont systemFontOfSize:15];
    buttla.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [buttla setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttla addTarget:self action:@selector(Englishbutnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview2 addSubview:buttla];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(15, buttla.frame.origin.y+buttla.frame.size.height+2, footerview.frame.size.width-30, 40)];
    [butt1 setTitle:@"العربية" forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont systemFontOfSize:15];
    butt1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [butt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt1 addTarget:self action:@selector(Arabicbutnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview2 addSubview:butt1];
    
}

-(IBAction)Englishbutnclicked:(id)sender
{
    txtLanguage.text=@"English";
    [footerview2 removeFromSuperview];
    popview2.hidden = YES;
    
    [[NSUserDefaults standardUserDefaults]setObject:txtLanguage.text forKey:@"language"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"en" forKey:@"languageapi"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

-(IBAction)Arabicbutnclicked:(id)sender
{
    txtLanguage.text=@"English";
    [footerview2 removeFromSuperview];
    popview2.hidden = YES;
    
    txtLanguage.text=@"English";
    [requested showMessage:@"Arabic is in Developement.Currently Check with English language" withTitle:@""];
}




-(IBAction)Cancelbclicked:(id)sender
{
    
    [footerview removeFromSuperview];
    popview.hidden = YES;
    
    
    
    NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];
    NSObject *object2 = [prefs2 objectForKey:@"City"];
    if(object2!= nil)
    {
        // txtCity.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"City"];
        [_dohaButt setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"City"] forState:UIControlStateNormal];
    }
    else
    {
        [_dohaButt setTitle:@"SelectCity" forState:UIControlStateNormal];
    }
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"first"];
    if(object != nil)
    {
        NSString *post = [NSString stringWithFormat:@"user=%@&password=%@",@"rajinder",@"123456"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,@"123456",user,arabic,strCityId];
        [requested sendRequest:post withUrl:strurl];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"f1" forKey:@"first"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self.navigationController.view showActivityViewWithLabel:@"Please Wait..."];
        NSString *post = [NSString stringWithFormat:@"user=%@&password=%@",@"rajinder",@"123456"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,@"123456",user,arabic,strCityId];
        [requested sendRequest:post withUrl:strurl];
    }
    
    
    [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:YES];
    [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:YES];
    [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:YES];
    [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:YES];
    [[[[self.tabBarController tabBar]items]objectAtIndex:4]setEnabled:YES];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"seted" forKey:@"set"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(IBAction)Setclicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
    
    
    NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];
    NSObject *object2 = [prefs2 objectForKey:@"City"];
    if(object2!= nil)
    {
        // txtCity.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"City"];
        [_dohaButt setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"City"] forState:UIControlStateNormal];
    }
    else
    {
        [_dohaButt setTitle:@"SelectCity" forState:UIControlStateNormal];
    }
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"first"];
    if(object != nil)
    {
        NSString *post = [NSString stringWithFormat:@"user=%@&password=%@",@"rajinder",@"123456"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,@"123456",user,arabic,strCityId];
        [requested sendRequest:post withUrl:strurl];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"f1" forKey:@"first"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self.navigationController.view showActivityViewWithLabel:@"Please Wait..."];
        NSString *post = [NSString stringWithFormat:@"user=%@&password=%@",@"rajinder",@"123456"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,@"123456",user,arabic,strCityId];
        [requested sendRequest:post withUrl:strurl];
    }
    
    [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:YES];
    [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:YES];
    [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:YES];
    [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:YES];
    [[[[self.tabBarController tabBar]items]objectAtIndex:4]setEnabled:YES];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:@"seted" forKey:@"set"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}





#pragma mark - Searchbar Delegate Methods


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_CustomSearchbar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [_CustomSearchbar resignFirstResponder];
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
