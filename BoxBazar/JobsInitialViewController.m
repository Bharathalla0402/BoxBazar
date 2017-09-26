//
//  JobsInitialViewController.m
//  BoxBazar
//
//  Created by bharat on 19/10/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "JobsInitialViewController.h"
#import "ApiRequest.h"
#import "DejalActivityView.h"
#import "BoxBazarUrl.pch"
#import "UIView+RNActivityView.h"
#import "JobsListViewController.h"

@interface JobsInitialViewController ()<ApiRequestdelegate,UISearchBarDelegate>
{
    ApiRequest *requested;
    UIView *topview;
    
    NSString *strnameUrlparameter,*strNmaeOfModule,*strtitle;
    NSMutableArray *data;
}

@end

@implementation JobsInitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    data=[[NSMutableArray alloc] init];
    self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    
    
     [self customView];
}

-(void)customView
{
    topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    topview.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [self.view addSubview:topview];
    
    
    UIButton *Backbutt=[[UIButton alloc] initWithFrame:CGRectMake(10, topview.frame.size.height/2-3, 20, 20)];
    [Backbutt setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    Backbutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [Backbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Backbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Backbutt addTarget:self action:@selector(BackbuttClickedj:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt];
    
    UIButton *Backbutt2=[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 55, 55)];
    [Backbutt2 addTarget:self action:@selector(BackbuttClickedj:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt2.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt2];
    
    UILabel *labtitle=[[UILabel alloc]initWithFrame:CGRectMake(topview.frame.size.width/2-120, topview.frame.size.height/2-10, 240, 30)];
    labtitle.text=@"Jobs";
    labtitle.font=[UIFont boldSystemFontOfSize:17];
    labtitle.textColor=[UIColor whiteColor];
    labtitle.textAlignment=NSTextAlignmentCenter;
    [topview addSubview:labtitle];
    
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 75, self.view.frame.size.width-20, 30)];
    label.text=@"Looking For";
    [self.view addSubview:label];
    
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(5, label.frame.size.height+label.frame.origin.y+5, self.view.frame.size.width-10, 100)];
    view2.backgroundColor=[UIColor whiteColor];
    view2.layer.cornerRadius = 5;
    view2.clipsToBounds = YES;
    view2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view2.layer.borderWidth = 1.0f;
    [self.view addSubview:view2];
    
    UIButton *AdsPostbutt=[[UIButton alloc]initWithFrame:CGRectMake(6, 1, view2.frame.size.width-60, 50)];
    [AdsPostbutt setTitle:@"Seeking For Job" forState:UIControlStateNormal];
    AdsPostbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [AdsPostbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    AdsPostbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [AdsPostbutt addTarget:self action:@selector(SeekingforjobsClicked:) forControlEvents:UIControlEventTouchUpInside];
    AdsPostbutt.backgroundColor=[UIColor clearColor];
    [view2 addSubview:AdsPostbutt];

    UILabel *label6=[[UILabel alloc] initWithFrame:CGRectMake(6, AdsPostbutt.frame.origin.y+AdsPostbutt.frame.size.height+1, view2.frame.size.width-12, 1)];
    label6.backgroundColor=[UIColor lightGrayColor];
    [view2 addSubview:label6];
    
    
    UIButton *MyShortlistbutt=[[UIButton alloc]initWithFrame:CGRectMake(6, label6.frame.origin.y+label6.frame.size.height+1, view2.frame.size.width-60, 50)];
    [MyShortlistbutt setTitle:@"Jobs Posted" forState:UIControlStateNormal];
    MyShortlistbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [MyShortlistbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    MyShortlistbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [MyShortlistbutt addTarget:self action:@selector(JobsPostedbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    MyShortlistbutt.backgroundColor=[UIColor clearColor];
    [view2 addSubview:MyShortlistbutt];
    
    UILabel *label8=[[UILabel alloc] initWithFrame:CGRectMake(6, MyShortlistbutt.frame.origin.y+MyShortlistbutt.frame.size.height+1, view2.frame.size.width-12, 1)];
    label8.backgroundColor=[UIColor lightGrayColor];
    [view2 addSubview:label8];
}


-(IBAction)SeekingforjobsClicked:(id)sender
{
    strtitle=@"Seeking For Job";
    [self.navigationController.view showActivityViewWithLabel:@"Please Wait..."];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,english,strCityId,@"jobs",@"category",@"1"];
    [requested OtpVerifyRequest:nil withUrl:strurl];
}


-(IBAction)JobsPostedbuttClicked:(id)sender
{
     strtitle=@"Jobs Posted";
    [self.navigationController.view showActivityViewWithLabel:@"Please Wait..."];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,english,strCityId,@"jobs",@"category",@"0"];
    [requested OtpVerifyRequest:nil withUrl:strurl];
}


-(void)responseRegistrationotp:(NSMutableDictionary *)responseDict
{
    NSLog(@"Jobs list Response: %@",responseDict);
   
    if ([strtitle isEqualToString:@"Jobs Posted"])
    {
        NSArray *da=[responseDict valueForKey:@"data"];
    
        NSMutableArray *arrayThatYouCanRemoveObjects = [NSMutableArray arrayWithArray:da];
        
        [arrayThatYouCanRemoveObjects removeObjectAtIndex:0];
    
        
        data = [NSMutableArray arrayWithArray: arrayThatYouCanRemoveObjects];
        
        NSLog(@"%@",data);
    }
    else
    {
        data=[responseDict valueForKey:@"data"];
    }
    
    [self.navigationController.view hideActivityView];
    
    JobsListViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsListViewController"];
    post.arrChildCategory=data;
    post.strModule=@"jobs";
    post.strtitle=strtitle;
    post.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:post animated:YES];
}



#pragma mark - Back Clicked

-(IBAction)BackbuttClickedj:(id)sender
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
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
