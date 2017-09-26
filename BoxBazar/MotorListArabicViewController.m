//
//  MotorListArabicViewController.m
//  BoxBazar
//
//  Created by bharat on 15/12/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "MotorListArabicViewController.h"
#import "YSLContainerViewController.h"
#import "ApiRequest.h"
#import "UIImageView+WebCache.h"
#import "DejalActivityView.h"
#import "BoxBazarUrl.pch"

#import "MotorFindsArabicViewController.h"
#import "ClassifiedListArabicViewController.h"
#import "JobslistArabicViewController.h"
#import "JobsWantedArabicViewController.h"
#import "PropertyRentListArabicViewController.h"
#import "PropertySaleListArabicViewController.h"
#import "CommunityListArabicViewController.h"


@interface MotorListArabicViewController ()<YSLContainerViewControllerDelegate,UISearchBarDelegate,UISearchControllerDelegate>
{
    YSLContainerViewController *containerVC;
    UISearchBar *searchbar;
    UILabel *titlelabel;
    
    MotorFindsArabicViewController *playListVC;
    ClassifiedListArabicViewController *artistVC;
    JobslistArabicViewController *sampleVC1;
    JobsWantedArabicViewController *sampleVC11;
    PropertyRentListArabicViewController *sampleVC2;
    PropertySaleListArabicViewController *sampleVC3;
    CommunityListArabicViewController *sampleVC4;
}

@end

@implementation MotorListArabicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    playListVC=[self.storyboard instantiateViewControllerWithIdentifier:@"MotorFindsArabicViewController"];
    playListVC.title = @"Motors";
    
    artistVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ClassifiedListArabicViewController"];
    artistVC.title = @"Classifieds";
    
    sampleVC1=[self.storyboard instantiateViewControllerWithIdentifier:@"JobslistArabicViewController"];
    sampleVC1.title = @"Jobs";
    
    sampleVC11=[self.storyboard instantiateViewControllerWithIdentifier:@"JobsWantedArabicViewController"];
    sampleVC11.title = @"Jobs Wanted";
    
    sampleVC2=[self.storyboard instantiateViewControllerWithIdentifier:@"PropertyRentListArabicViewController"];
    sampleVC2.title = @"Property on Rent";
    
    sampleVC3=[self.storyboard instantiateViewControllerWithIdentifier:@"PropertySaleListArabicViewController"];
    sampleVC3.title = @"Property on Sale";
    
    sampleVC4=[self.storyboard instantiateViewControllerWithIdentifier:@"CommunityListArabicViewController"];
    sampleVC4.title = @"Community";
    
    
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    NSString *strv=[[NSUserDefaults standardUserDefaults]objectForKey:@"index"];
    int a=(int)[strv integerValue];
    
    containerVC = [[YSLContainerViewController alloc]initWithControllers:@[sampleVC4,sampleVC3,sampleVC2,sampleVC11,sampleVC1,artistVC,playListVC]
                                                            topBarHeight:statusHeight + navigationHeight
                                                    parentViewController:self];
    
    //    if (a==0)
    //    {
    //        containerVC = [[YSLContainerViewController alloc]initWithControllers:@[playListVC,artistVC,sampleVC1,sampleVC11,sampleVC2,sampleVC3,sampleVC4]
    //                                                                topBarHeight:statusHeight + navigationHeight
    //                                                        parentViewController:self];
    //    }
    //    else if (a==1)
    //    {
    //        containerVC = [[YSLContainerViewController alloc]initWithControllers:@[artistVC,playListVC,sampleVC1,sampleVC11,sampleVC2,sampleVC3,sampleVC4]
    //                                                                topBarHeight:statusHeight + navigationHeight
    //                                                        parentViewController:self];
    //    }
    //    else if (a==2)
    //    {
    //        containerVC = [[YSLContainerViewController alloc]initWithControllers:@[sampleVC1,playListVC,artistVC,sampleVC11,sampleVC2,sampleVC3,sampleVC4]
    //                                                                topBarHeight:statusHeight + navigationHeight
    //                                                        parentViewController:self];
    //    }
    //    else if (a==3)
    //    {
    //        containerVC = [[YSLContainerViewController alloc]initWithControllers:@[sampleVC11,playListVC,artistVC,sampleVC1,sampleVC2,sampleVC3,sampleVC4]
    //                                                                topBarHeight:statusHeight + navigationHeight
    //                                                        parentViewController:self];
    //    }
    //    else if (a==4)
    //    {
    //        containerVC = [[YSLContainerViewController alloc]initWithControllers:@[sampleVC2,playListVC,artistVC,sampleVC1,sampleVC11,sampleVC3,sampleVC4]
    //                                                                topBarHeight:statusHeight + navigationHeight
    //                                                        parentViewController:self];
    //    }
    //    else if (a==5)
    //    {
    //        containerVC = [[YSLContainerViewController alloc]initWithControllers:@[sampleVC3,playListVC,artistVC,sampleVC1,sampleVC11,sampleVC2,sampleVC4]
    //                                                                topBarHeight:statusHeight + navigationHeight
    //                                                        parentViewController:self];
    //    }
    //    else if (a==6)
    //    {
    //        containerVC = [[YSLContainerViewController alloc]initWithControllers:@[sampleVC4,playListVC,artistVC,sampleVC1,sampleVC11,sampleVC2,sampleVC3]
    //                                                                topBarHeight:statusHeight + navigationHeight
    //                                                        parentViewController:self];
    //    }
    
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont systemFontOfSize:16];
    [self.view addSubview:containerVC.view];
    
    
    
    
    UIView *topview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    topview.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [self.view addSubview:topview];
    
    
    UIButton *Backbutt=[[UIButton alloc] initWithFrame:CGRectMake(topview.frame.size.width-35, topview.frame.size.height/2-3, 25, 25)];
    [Backbutt setImage:[UIImage imageNamed:@"rightar.png"] forState:UIControlStateNormal];
    Backbutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [Backbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Backbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Backbutt addTarget:self action:@selector(BackbuttClickedjf2:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt];
    
    UIButton *Backbutt2=[[UIButton alloc] initWithFrame:CGRectMake(topview.frame.size.width-70, 5, 60, 60)];
    [Backbutt2 addTarget:self action:@selector(BackbuttClickedjf2:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt2.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt2];
    
    titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(topview.frame.size.width/2-100, 20, 200, 40)];
    titlelabel.font=[UIFont boldSystemFontOfSize:18];
    titlelabel.textColor=[UIColor whiteColor];
    if (a==6)
    {
        titlelabel.text=@"Motors";
    }
    else if (a==5)
    {
        titlelabel.text=@"Classifieds";
    }
    else if (a==4)
    {
        titlelabel.text=@"Jobs";
    }
    else if (a==3)
    {
        titlelabel.text=@"Jobs Wanted";
    }
    else if (a==2)
    {
        titlelabel.text=@"Property On Rent";
    }
    else if (a==1)
    {
        titlelabel.text=@"Property On Sale";
    }
    else if (a==0)
    {
        titlelabel.text=@"Community";
    }
    titlelabel.textAlignment=NSTextAlignmentCenter;
    [topview addSubview:titlelabel];
    
    searchbar=[[UISearchBar alloc] initWithFrame:CGRectMake(40, 20, self.view.frame.size.width-50, 40)];
    searchbar.placeholder=@"Search Motors";
    searchbar.backgroundColor=[UIColor whiteColor];
    searchbar.searchBarStyle = UISearchBarStyleMinimal;
    searchbar.hidden=YES;
    [topview addSubview:searchbar];
}

#pragma mark -- YSLContainerViewControllerDelegate

- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    NSLog(@"%ld",(long)index);
    NSLog(@"%@", NSStringFromClass([controller class]));
    NSString *strname=NSStringFromClass([controller class]);
    
    if ([strname isEqualToString:@"MotorFindsArabicViewController"])
    {
        searchbar.placeholder=@"Search Motors";
        // searchbar.delegate=controller;
        titlelabel.text=@"Motors";
    }
    else if ([strname isEqualToString:@"ClassifiedListArabicViewController"])
    {
        searchbar.placeholder=@"Search Classifieds";
        titlelabel.text=@"Classifieds";
    }
    else if ([strname isEqualToString:@"JobslistArabicViewController"])
    {
        searchbar.placeholder=@"Search Jobs";
        titlelabel.text=@"Jobs";
    }
    else if ([strname isEqualToString:@"JobsWantedArabicViewController"])
    {
        searchbar.placeholder=@"Search Jobs";
        titlelabel.text=@"Jobs Wanted";
    }
    else if ([strname isEqualToString:@"PropertyRentListArabicViewController"])
    {
        searchbar.placeholder=@"Search Property On Rent";
        titlelabel.text=@"Property On Rent";
    }
    else if ([strname isEqualToString:@"PropertySaleListArabicViewController"])
    {
        searchbar.placeholder=@"Search Property On Sale";
        titlelabel.text=@"Property On Sale";
    }
    else if ([strname isEqualToString:@"CommunityListArabicViewController"])
    {
        searchbar.placeholder=@"Search Community";
        titlelabel.text=@"Community";
    }
    [controller viewWillAppear:YES];
}


#pragma mark - Back Clicked

-(IBAction)BackbuttClickedjf2:(id)sender
{
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    //   self.searchController.active=false;
}


#pragma mark - Searchbar Delegate Methods

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}


-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar becomeFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchbar resignFirstResponder];
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
