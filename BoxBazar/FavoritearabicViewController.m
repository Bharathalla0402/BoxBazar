//
//  FavoritearabicViewController.m
//  BoxBazar
//
//  Created by bharat on 14/12/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "FavoritearabicViewController.h"
#import "ApiRequest.h"
#import "CarDescriptionArabicViewController.h"
#import "UIImageView+WebCache.h"
#import "DejalActivityView.h"
#import "BoxBazarUrl.pch"
#import "FavoritearabicTableViewCell.h"
#import "CarDescriptionArabicViewController.h"

@interface FavoritearabicViewController ()<ApiRequestdelegate,UITableViewDelegate,UITableViewDataSource>
{
    ApiRequest *requested;
    UIView *topview;
    IBOutlet UITableView *tabl;
    
    FavoritearabicTableViewCell *cell2;
    
     UILabel *labeldata;
}
@end

@implementation FavoritearabicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    labeldata.hidden=YES;
    tabl.hidden=NO;
    self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    [self customView];
    
    tabl.allowsMultipleSelectionDuringEditing = NO;
    
    arrCarslist=[[NSMutableArray alloc]init];
    [arrCarslist addObjectsFromArray:_arrChildCategory];
    
    NSLog(@"%@",_arrChildCategory);
}

-(void)customView
{
    topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    topview.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [self.view addSubview:topview];
    
    
    UIButton *Backbutt=[[UIButton alloc] initWithFrame:CGRectMake(topview.frame.size.width-35, topview.frame.size.height/2-3, 25, 25)];
    [Backbutt setImage:[UIImage imageNamed:@"rightar.png"] forState:UIControlStateNormal];
    Backbutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [Backbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Backbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Backbutt addTarget:self action:@selector(BackbuttClickedjfc:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt];
    
    UIButton *Backbutt2=[[UIButton alloc] initWithFrame:CGRectMake(topview.frame.size.width-70, 5, 60, 60)];
    [Backbutt2 addTarget:self action:@selector(BackbuttClickedjfc:) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - Table view Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 141;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrCarslist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellClassName = @"FavoritearabicTableViewCell";
    cell2 = (FavoritearabicTableViewCell *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
    if (cell2 == nil)
    {
        cell2 = [[FavoritearabicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FavoritearabicTableViewCell"
                                                     owner:self options:nil];
        cell2 = [nib objectAtIndex:0];
        cell2.backgroundColor=[UIColor blackColor];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UIImageView *adimage=(UIImageView*)[cell2 viewWithTag:1];
    UILabel *Categeorytype=(UILabel *)[cell2 viewWithTag:3];
    UILabel *namelab=(UILabel *)[cell2 viewWithTag:9];
    UILabel *pricelab=(UILabel *)[cell2 viewWithTag:7];
    
    adimage.contentMode = UIViewContentModeScaleAspectFill;
    adimage.clipsToBounds = YES;
    adimage.layer.borderWidth = 1.0;
    adimage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imagena=[[arrCarslist objectAtIndex:indexPath.row]valueForKey:@"pic"];
    [adimage sd_setImageWithURL:[NSURL URLWithString:imagena]
               placeholderImage:[UIImage imageNamed:@"upload-empty.png"]];
    
    
    NSString *strname=[[arrCarslist valueForKey:@"url_parameter"]objectAtIndex:indexPath.row];
    if (strname == (id)[NSNull null] || strname.length == 0 )
    {
        Categeorytype.text=@"";
    }
    else
    {
        Categeorytype.text=[NSString stringWithFormat:@"Categeory : %@",strname];
    }
    
    NSString *strname2=[[arrCarslist valueForKey:@"name"]objectAtIndex:indexPath.row];
    if (strname2 == (id)[NSNull null] || strname2.length == 0 )
    {
        namelab.text=@"";
    }
    else
    {
        namelab.text=[NSString stringWithFormat:@"Name : %@",strname2];
    }
    
    NSString *strlist=[[arrCarslist valueForKey:@"price"]objectAtIndex:indexPath.row];
    if (strlist == (id)[NSNull null] || strlist.length == 0 )
    {
        pricelab.text=@"";
    }
    else
    {
        pricelab.text=[NSString stringWithFormat:@"%@ AED",strlist];
    }
    
    return cell2;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strname=[[arrCarslist valueForKey:@"url_parameter"]objectAtIndex:indexPath.row];
    
    if ([strname isEqualToString:@"car"])
    {
        NSString *postid=[[arrCarslist valueForKey:@"id"]objectAtIndex:indexPath.row];
        NSString *strname=[[arrCarslist valueForKey:@"url_parameter"]objectAtIndex:indexPath.row];
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *post = [NSString stringWithFormat:@"module=%@&post_id=%@&user_id=%@",strname,postid,struseridnum];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarPost,arabic,strCityId];
        [requested RegistrationRequest:post withUrl:strurl];
    }
    else
    {
        NSString *postid=[[arrCarslist valueForKey:@"id"]objectAtIndex:indexPath.row];
        NSString *strname=[[arrCarslist valueForKey:@"url_parameter"]objectAtIndex:indexPath.row];
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *post = [NSString stringWithFormat:@"module=%@&post_id=%@&user_id=%@",strname,postid,struseridnum];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,Post,arabic,strCityId];
        [requested RegistrationRequest:post withUrl:strurl];
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
    
    CarDescriptionArabicViewController *des=[self.storyboard instantiateViewControllerWithIdentifier:@"CarDescriptionArabicViewController"];
    des.strDataArray=[[responseDict valueForKey:@"data"] objectAtIndex:0];
    des.strtitle=strn;
    des.strUrls=strls;
    [self.navigationController pushViewController:des animated:YES];
}




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *postid=[[arrCarslist valueForKey:@"id"]objectAtIndex:indexPath.row];
        NSString *strname=[[arrCarslist valueForKey:@"url_parameter"]objectAtIndex:indexPath.row];
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *post = [NSString stringWithFormat:@"post_id=%@&post_type=%@&user_id=%@",postid,strname,struseridnum];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,removeFavorites,arabic,strCityId];
        [requested sendRequest3:post withUrl:strurl];
    }
}

-(void)responsewithToken3:(NSMutableDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
    NSString *post = [NSString stringWithFormat:@"user_id=%@",struseridnum];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,userFavorites,arabic,strCityId];
    [requested sendRequest4:post withUrl:strurl];
    
}

-(void)responsewithToken4:(NSMutableDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        tabl.hidden=NO;
        labeldata.hidden=YES;
        [arrCarslist removeAllObjects];
        
        NSArray *arrlist=[responseDict valueForKey:@"data"];
        
        [arrCarslist addObjectsFromArray:arrlist];
        
        [tabl reloadData];
    }
    else
    {
        tabl.hidden=YES;
        labeldata.hidden=NO;
        labeldata=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-20, 100, 40)];
        labeldata.font=[UIFont systemFontOfSize:15];
        labeldata.textColor=[UIColor lightGrayColor];
        labeldata.text=@"No More List";
        [self.view addSubview:labeldata];
    }
}




#pragma mark - Back Clicked

-(IBAction)BackbuttClickedjfc:(id)sender
{
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
