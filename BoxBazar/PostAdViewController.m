//
//  PostAdViewController.m
//  BoxBazar
//
//  Created by bharat on 27/07/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "PostAdViewController.h"
#import "ApiRequest.h"
#import "ExpandableTableView.h"
#import "PostingArabicViewController.h"
#import "LoginandRegisterViewController.h"
#import "PostadsarabicViewController.h"
#import "ArabicloginRegisterViewController.h"

#import "FTFoldingTableView.h"
#import "PostingViewController.h"

#import "BoxBazarUrl.pch"
#import "DejalActivityView.h"

static NSString *SectionHeaderViewIdentifier    = @"SectionHeaderViewIdentifier";
static NSString *DemoTableViewIdentifier        = @"DemoTableViewIdentifier";

@interface PostAdViewController ()<ApiRequestdelegate,UITableViewDelegate,UITableViewDataSource>
{
    ApiRequest *requested;
    UIScrollView *PostAdScrollView;
    UIView *view1;
    
    
    UIButton *Motorbutt,*Jobsbutt,*PropertyOnRentbutt,*PropertyOnSalebutt,*Classifiedbutt,*Furniturebutt;
    NSMutableArray *arraylist;
    NSMutableArray *arrcategeorys;
    
    
    NSString *strCategeory,*strcategeoryType,*strCategeoryid,*strCategeoryUrlparameter,*strcategeoryTypeid,*strcategeoryTypeisCatgory,*strcategeoryTypeurl_parameter;
}
@property (weak, nonatomic) IBOutlet ExpandableTableView *tableView;

@property (nonatomic, strong) NSArray *cells;
@property (nonatomic, strong) NSArray *headers;

@property (nonatomic, strong) NSArray <NSDictionary *> *productsList1;



@end

@implementation PostAdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
         NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,modulelist,english,strCityId];
        [requested motorsRequest:nil withUrl:strurl];
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
         NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,modulelist,arabic,strCityId];
        [requested motorsRequest:nil withUrl:strurl];
    }
    else
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,modulelist,english,strCityId];
        [requested motorsRequest:nil withUrl:strurl];
    }
  
    self.tableView.allHeadersInitiallyCollapsed = YES;
  
   // self.tableView.initiallyExpandedSection = 0;
    
    [self moreaction];
}

-(void)moreaction
{
    UIView *topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    topview.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [self.view addSubview:topview];
    
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(10, topview.frame.size.height/2-8, topview.frame.size.width-20, 30)];
    titlelabel.text=@"Select Category";
    titlelabel.textAlignment=NSTextAlignmentCenter;
    [titlelabel setFont:[UIFont boldSystemFontOfSize:15]];
    titlelabel.textColor=[UIColor whiteColor];
    [topview addSubview:titlelabel];
    
}

#pragma mark - TableView Delegate Methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return arrcategeorys.count;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    for (int i=0; i<arrcategeorys.count; i++)
    {
        if (section==i)
        {
            NSString *str=[NSString stringWithFormat:@"%lu",(unsigned long)[[[arraylist objectAtIndex:i] valueForKey:@"child"]count]];
            int i=(int)[str integerValue];
           
            
             return [self.tableView totalNumberOfRows:i inSection:section];
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSArray *arlist=[[[_productsList1 objectAtIndex:indexPath.section]valueForKey:@"child"] objectAtIndex:indexPath.row];
    cell.textLabel.text = [arlist valueForKey:@"name"];
    
    
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

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    for (int i=0; i<arrcategeorys.count; i++)
    {
        if (section==i)
        {
            NSString *strname=[NSString stringWithFormat:@"%@",[arrcategeorys objectAtIndex:i]];
            NSString *strcount=[NSString stringWithFormat:@"%lu",(unsigned long)[[[arraylist objectAtIndex:i] valueForKey:@"child"]count]];
            int i=(int)[strcount integerValue];
            return [self.tableView headerWithTitle:strname totalRows:i inSection:section];
        }
    }
    return 0;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"userid"];
    if(object != nil)
    {
        strCategeory = [[_productsList1 objectAtIndex:indexPath.section] objectForKey:@"name"];
        NSLog(@"%@",strCategeory);
        strcategeoryType=[[[[_productsList1 objectAtIndex:indexPath.section]objectForKey:@"child"]valueForKey:@"name"] objectAtIndex:indexPath.row];
        NSLog(@"%@",strcategeoryType);
        
        
        strCategeoryid = [[_productsList1 objectAtIndex:indexPath.section] objectForKey:@"id"];
        NSLog(@"%@",strCategeoryid);
        strCategeoryUrlparameter = [[_productsList1 objectAtIndex:indexPath.section] objectForKey:@"url_parameter"];
        NSLog(@"%@",strCategeoryUrlparameter);
        
        strcategeoryTypeid=[[[[_productsList1 objectAtIndex:indexPath.section]objectForKey:@"child"]valueForKey:@"id"] objectAtIndex:indexPath.row];
        NSLog(@"%@",strcategeoryTypeid);
        strcategeoryTypeisCatgory=[[[[_productsList1 objectAtIndex:indexPath.section]objectForKey:@"child"]valueForKey:@"isCatgory"] objectAtIndex:indexPath.row];
        NSLog(@"%@",strcategeoryTypeisCatgory);
        strcategeoryTypeurl_parameter=[[[[_productsList1 objectAtIndex:indexPath.section]objectForKey:@"child"]valueForKey:@"url_parameter"] objectAtIndex:indexPath.row];
        NSLog(@"%@",strcategeoryTypeurl_parameter);
        
        
        if ([strcategeoryTypeurl_parameter isEqualToString:@"car"])
        {
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
            {
                PostingViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"PostingViewController"];
                post.strCategeory=strCategeory;
                post.strcategeoryType=strcategeoryType;
                post.strCategeoryid=strCategeoryid;
                post.strCategeoryUrlparameter=strCategeoryUrlparameter;
                post.strcategeoryTypeid=strcategeoryTypeid;
                post.strcategeoryTypeisCatgory=strcategeoryTypeisCatgory;
                post.strcategeoryTypeurl_parameter=strcategeoryTypeurl_parameter;
                post.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:post animated:YES];
            }
            else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
            {
                PostadsarabicViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"PostadsarabicViewController"];
                post.strCategeory=strCategeory;
                post.strcategeoryType=strcategeoryType;
                post.strCategeoryid=strCategeoryid;
                post.strCategeoryUrlparameter=strCategeoryUrlparameter;
                post.strcategeoryTypeid=strcategeoryTypeid;
                post.strcategeoryTypeisCatgory=strcategeoryTypeisCatgory;
                post.strcategeoryTypeurl_parameter=strcategeoryTypeurl_parameter;
                post.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:post animated:YES];
                
            }
            else
            {
                PostingViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"PostingViewController"];
                post.strCategeory=strCategeory;
                post.strcategeoryType=strcategeoryType;
                post.strCategeoryid=strCategeoryid;
                post.strCategeoryUrlparameter=strCategeoryUrlparameter;
                post.strcategeoryTypeid=strcategeoryTypeid;
                post.strcategeoryTypeisCatgory=strcategeoryTypeisCatgory;
                post.strcategeoryTypeurl_parameter=strcategeoryTypeurl_parameter;
                post.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:post animated:YES];
            }
        }
        else
        {
            
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
            {
                if ([strcategeoryTypeisCatgory isEqualToString:[NSString stringWithFormat:@"%@",@"1"]])
                {
                    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,english,strCityId,strcategeoryTypeurl_parameter,@"category",strcategeoryTypeid];
                    [requested OtpVerifyRequest:nil withUrl:strurl];
                }
                else
                {
                    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,english,strCityId,strcategeoryTypeurl_parameter,@"category",@"0"];
                    [requested OtpVerifyRequest:nil withUrl:strurl];
                }

                
            }
            else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
            {
                
                if ([strcategeoryTypeisCatgory isEqualToString:[NSString stringWithFormat:@"%@",@"1"]])
                {
                    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,arabic,strCityId,strcategeoryTypeurl_parameter,@"category",strcategeoryTypeid];
                    [requested OtpVerifyRequest:nil withUrl:strurl];
                }
                else
                {
                    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,arabic,strCityId,strcategeoryTypeurl_parameter,@"category",@"0"];
                    [requested OtpVerifyRequest:nil withUrl:strurl];
                }

            }
            else
            {
                
                if ([strcategeoryTypeisCatgory isEqualToString:[NSString stringWithFormat:@"%@",@"1"]])
                {
                    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,english,strCityId,strcategeoryTypeurl_parameter,@"category",strcategeoryTypeid];
                    [requested OtpVerifyRequest:nil withUrl:strurl];
                }
                else
                {
                    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,english,strCityId,strcategeoryTypeurl_parameter,@"category",@"0"];
                    [requested OtpVerifyRequest:nil withUrl:strurl];
                }

            }
        }
    }
    else
    {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
        {
            LoginandRegisterViewController *lr=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginandRegisterViewController"];
            [self.navigationController pushViewController:lr animated:YES];
        }
        else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
        {
            ArabicloginRegisterViewController *lr=[self.storyboard instantiateViewControllerWithIdentifier:@"ArabicloginRegisterViewController"];
            [self.navigationController pushViewController:lr animated:YES];
        }
        else
        {
            LoginandRegisterViewController *lr=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginandRegisterViewController"];
            [self.navigationController pushViewController:lr animated:YES];
        }
    }
}

-(void)responseRegistrationotp:(NSMutableDictionary *)responseDict
{
    NSLog(@"category list Response: %@",responseDict);
    
    NSArray *data=[responseDict valueForKey:@"data"];
    NSString *strmessage=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
    {
        PostingViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"PostingViewController"];
        post.strCategeory=strCategeory;
        post.strcategeoryType=strcategeoryType;
        post.strCategeoryid=strCategeoryid;
        post.strCategeoryUrlparameter=strCategeoryUrlparameter;
        post.strcategeoryTypeid=strcategeoryTypeid;
        post.strcategeoryTypeisCatgory=strcategeoryTypeisCatgory;
        post.strcategeoryTypeurl_parameter=strcategeoryTypeurl_parameter;
        post.arrChildCategory=data;
        post.strmessage=strmessage;
        post.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:post animated:YES];
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
    {
        PostadsarabicViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"PostadsarabicViewController"];
        post.strCategeory=strCategeory;
        post.strcategeoryType=strcategeoryType;
        post.strCategeoryid=strCategeoryid;
        post.strCategeoryUrlparameter=strCategeoryUrlparameter;
        post.strcategeoryTypeid=strcategeoryTypeid;
        post.strcategeoryTypeisCatgory=strcategeoryTypeisCatgory;
        post.strcategeoryTypeurl_parameter=strcategeoryTypeurl_parameter;
        post.arrChildCategory=data;
        post.strmessage=strmessage;
        post.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:post animated:YES];
    }
    else
    {
        PostingViewController *post=[self.storyboard instantiateViewControllerWithIdentifier:@"PostingViewController"];
        post.strCategeory=strCategeory;
        post.strcategeoryType=strcategeoryType;
        post.strCategeoryid=strCategeoryid;
        post.strCategeoryUrlparameter=strCategeoryUrlparameter;
        post.strcategeoryTypeid=strcategeoryTypeid;
        post.strcategeoryTypeisCatgory=strcategeoryTypeisCatgory;
        post.strcategeoryTypeurl_parameter=strcategeoryTypeurl_parameter;
        post.arrChildCategory=data;
        post.strmessage=strmessage;
        post.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:post animated:YES];
    }
}

-(void)responseResendotp:(NSMutableDictionary *)responseDict
{
    NSLog(@"category option list Response: %@",responseDict);
}

#pragma mark - View life Cycles

-(void)viewWillAppear:(BOOL)animated
{
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pathid"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
//    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pathid1"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"userid"];
    if(object != nil)
    {
        
    }
    else
    {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
        {
            LoginandRegisterViewController *lr=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginandRegisterViewController"];
            [self.navigationController pushViewController:lr animated:YES];
        }
        else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
        {
            ArabicloginRegisterViewController *lr=[self.storyboard instantiateViewControllerWithIdentifier:@"ArabicloginRegisterViewController"];
            [self.navigationController pushViewController:lr animated:YES];
        }
        else
        {
            LoginandRegisterViewController *lr=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginandRegisterViewController"];
            [self.navigationController pushViewController:lr animated:YES];
        }

    }
}

-(void)viewWillDisappear:(BOOL)animated
{
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pathid"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
//    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pathid1"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)responsewithData:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
 //   NSLog(@"Module list Response: %@",responseDictionary);
    
    arraylist=[[NSMutableArray alloc]init];
    arraylist=[responseDictionary valueForKey:@"data"];
    
    _productsList1=arraylist;
    NSArray *arr=[[NSArray alloc]init];
    
    NSArray *arr2=[[NSArray alloc]init];
    arrcategeorys=[[NSMutableArray alloc]init];
    NSMutableArray *arrcategeorysurlparameter=[[NSMutableArray alloc]init];
    
    for (int i=0; i<arraylist.count; i++)
    {
        arr=[[[responseDictionary valueForKey:@"data"] objectAtIndex:i] valueForKey:@"name"];
    
        [arrcategeorys addObject:arr];
        
        arr2=[[[responseDictionary valueForKey:@"data"] objectAtIndex:i] valueForKey:@"url_parameter"];
         [arrcategeorysurlparameter addObject:arr2];
      
    }
      NSLog(@"list: %@",arrcategeorys);
     NSLog(@"Url_Parameters list: %@",arrcategeorysurlparameter);
    NSLog(@"%@",arraylist);
    
    [self.tableView reloadData];
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
