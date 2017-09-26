//
//  CarModelViewController.m
//  BoxBazar
//
//  Created by bharat on 21/10/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "CarModelViewController.h"
#import "ApiRequest.h"
#import "DejalActivityView.h"
#import "BoxBazarUrl.pch"
#import "UIView+RNActivityView.h"
#import "CarNameViewController.h"

@interface CarModelViewController ()<ApiRequestdelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating>
{
    ApiRequest *requested;
    UIView *topview;
    
    IBOutlet UITableView *tabl;
    UITableViewCell *cell;
    
    NSString *strModuleId,*strModuleName,*strModuleUrlParameter,*strHasChild;
    
    NSMutableArray *searchResults,*data;
}
@property (strong, nonatomic) UISearchController *searchController;
@end

@implementation CarModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    searchResults=[[NSMutableArray alloc]init];
    [self customView];
    
    data=[[NSMutableArray alloc]init];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.searchController.navigationController.navigationBarHidden=YES;
    [[self.searchController navigationController] setNavigationBarHidden:YES animated:YES];
    
    tabl.tableHeaderView = self.searchController.searchBar;

}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    NSString *searchString = searchController.searchBar.text;
    NSLog(@"%@",searchString);
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
            NSLog(@"string contains bla!");
            
            tabl.tag=2;
            [searchResults addObject:[_arrChildCategory objectAtIndex:i]];
        }
        else
        {
            NSLog(@"string does not contain bla");
        }
    }
    NSLog(@"fiilterArray : %@",searchResults);
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
    
    
    tabl=[[UITableView alloc] init];
    tabl.frame = CGRectMake(0,topview.frame.origin.y+topview.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-65);
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
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    static NSString *cellIdetifier = @"Cell";
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
    
    
    if (tabl.tag==2) {
        cell.textLabel.text =[[searchResults valueForKey:@"name"] objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [[_arrChildCategory valueForKey:@"name"] objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tabl.tag==2) {
        strModuleId=[[searchResults valueForKey:@"id"]objectAtIndex:indexPath.row];
        strModuleName=[[searchResults valueForKey:@"name"]objectAtIndex:indexPath.row];
    } else {
        strModuleId=[[_arrChildCategory valueForKey:@"id"]objectAtIndex:indexPath.row];
        strModuleName=[[_arrChildCategory valueForKey:@"name"]objectAtIndex:indexPath.row];
    }
    //    strModuleId=[[_arrChildCategory valueForKey:@"id"]objectAtIndex:indexPath.row];
    //    strModuleName=[[_arrChildCategory valueForKey:@"name"]objectAtIndex:indexPath.row];
    strModuleUrlParameter=_strModule;
    
    NSLog(@"%@",strModuleId);
    NSLog(@"%@",strModuleName);
    NSLog(@"%@",strModuleUrlParameter);
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    //    NSString *strmodule=[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"url_parameter"];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *post = [NSString stringWithFormat:@"module=%@&category=%@",strModuleUrlParameter,strModuleId];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Posts,english,strCityId];
    [requested sendRequest1:post withUrl:strurl];
}



-(void)responsewithToken1:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Dict Response: %@",responseDictionary);
    
    NSString *strmessage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"status"]];
    
    NSString *strpage=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"nextPage"]];
    
    if ([strmessage isEqualToString:@"0"])
    {
        [requested showMessage:[NSString stringWithFormat:@"There is no More Data found for this category"] withTitle:@""];
    }
    else
    {
        [self.searchController dismissViewControllerAnimated:YES completion:nil];
        [self.view endEditing:YES];
        CarNameViewController *car=[self.storyboard instantiateViewControllerWithIdentifier:@"CarNameViewController"];
        car.arrDataList=[responseDictionary valueForKey:@"data"];
        car.hidesBottomBarWhenPushed = YES;
        car.strmodule=strModuleUrlParameter;
        car.strname=strModuleName;
        car.strpage=strpage;
        [self.navigationController pushViewController:car animated:YES];
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
