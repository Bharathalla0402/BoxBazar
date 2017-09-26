//
//  ChatViewController.m
//  BoxBazar
//
//  Created by bharat on 27/07/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "ChatViewController.h"
#import "ApiRequest.h"
#import "ChatTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "LoginandRegisterViewController.h"
#import "BoxBazarUrl.pch"
#import "UIImageView+WebCache.h"
#import "ChatingDetailsViewController.h"


@interface ChatViewController ()<ApiRequestdelegate,UITableViewDelegate,UITableViewDataSource>
{
    ApiRequest *requested;
    
    IBOutlet UITableView *tabl;
     NSInteger selectedIndex;
    
    UIButton *Allbutt;
    UIButton *Buyingbutt;
    UIButton *Sellingbutt;
    
    UISegmentedControl *segmentedControl;
    ChatTableViewCell *cell;
    
    NSMutableArray *arrChatAll,*arrChatBying,*arrChatCelling;
    UILabel *lab;
}
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    
    arrChatAll=[[NSMutableArray alloc]init];
    arrChatBying=[[NSMutableArray alloc]init];
    arrChatCelling=[[NSMutableArray alloc]init];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"userid"];
    if(object != nil)
    {
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&type=%@",BaseUrl,strtoken,getConversionList,english,strCityId,struseridnum,@"0"];
        [requested OptionRequest5:nil withUrl:strurl];
    }
    else
    {
    
    }
    
    [self moreaction];
        
    
    
}

-(void)moreaction
{
    UIView *topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 55)];
    topview.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [self.view addSubview:topview];
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(10, topview.frame.size.height/2-8, topview.frame.size.width-20, 30)];
    titlelabel.text=@"Chat";
    titlelabel.textAlignment=NSTextAlignmentCenter;
    [titlelabel setFont:[UIFont boldSystemFontOfSize:17]];
    titlelabel.textColor=[UIColor whiteColor];
    [topview addSubview:titlelabel];

    
    lab=[[UILabel alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height/2-30, self.view.frame.size.width-20, 60)];
    lab.backgroundColor=[UIColor clearColor];
    lab.textColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    lab.numberOfLines=2;
    lab.textAlignment=NSTextAlignmentCenter;
    lab.text=@"Please Login into Your account to Communicating with Chat";
    [self.view addSubview:lab];

    
    
    
    tabl=[[UITableView alloc] init];
    tabl.frame = CGRectMake(0,95, self.view.frame.size.width, self.view.frame.size.height-145);
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:tabl];
    
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"All", @"Buying",@"Selling", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(20, 65, topview.frame.size.width-40, 30);
    [segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    
    
    UIColor *selectedColor = [UIColor colorWithRed: 90.0f/255.0 green:143.0f/255.0 blue:63.0f/255.0 alpha:1.0];
    UIColor *deselectedColor = [UIColor colorWithRed: 90.0f/255.0 green:143.0f/255.0 blue:63.0f/255.0 alpha:1.0];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:17], NSFontAttributeName,
                                [UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0], NSForegroundColorAttributeName, nil];
    
    
    
    NSDictionary *attributes1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [UIFont boldSystemFontOfSize:17], NSFontAttributeName,
                                 [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [segmentedControl setTitleTextAttributes:attributes1 forState:UIControlStateSelected];
    
    for (id subview in [segmentedControl subviews]) {
        if ([subview isSelected])
            [subview setTintColor:selectedColor];
        else
            [subview setTintColor:deselectedColor];

    }
    
    selectedIndex = -1;
    tabl.tag=1;
    [tabl reloadData];
    [self.view addSubview:segmentedControl];
    
}


-(IBAction)AllbuttClicked:(id)sender
{
    [requested showMessage:@"All Clicked" withTitle:@"All"];
    
    [Allbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     Allbutt.backgroundColor=[UIColor whiteColor];
    
    [Buyingbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Buyingbutt.backgroundColor=[UIColor clearColor];
    
    [Sellingbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Sellingbutt.backgroundColor=[UIColor clearColor];
}


-(IBAction)BuyingbuttClicked:(id)sender
{
    [requested showMessage:@"buying Clicked" withTitle:@"Buying"];
    
    [Allbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Allbutt.backgroundColor=[UIColor clearColor];
    
    [Buyingbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Buyingbutt.backgroundColor=[UIColor whiteColor];
    
    [Sellingbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Sellingbutt.backgroundColor=[UIColor clearColor];
}


-(IBAction)SellingbuttClicked:(id)sender
{
    [requested showMessage:@"Selling Clicked" withTitle:@"Selling"];
    
    [Allbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Allbutt.backgroundColor=[UIColor clearColor];
    
    [Buyingbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Buyingbutt.backgroundColor=[UIColor clearColor];
    
    [Sellingbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Sellingbutt.backgroundColor=[UIColor whiteColor];
    
}



#pragma mark - Segment Changed

- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    UIColor *selectedColor = [UIColor colorWithRed: 90.0f/255.0 green:143.0f/255.0 blue:63.0f/255.0 alpha:1.0];
    UIColor *deselectedColor = [UIColor colorWithRed: 90.0f/255.0 green:143.0f/255.0 blue:63.0f/255.0 alpha:1.0];
    
    for (id subview in [segmentedControl subviews]) {
        if ([subview isSelected])
            [subview setTintColor:selectedColor];
        else
            [subview setTintColor:deselectedColor];
        
    }
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:17], NSFontAttributeName,
                                [UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0], NSForegroundColorAttributeName, nil];
    
    
    
    NSDictionary *attributes1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [UIFont boldSystemFontOfSize:17], NSFontAttributeName,
                                 [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [segmentedControl setTitleTextAttributes:attributes1 forState:UIControlStateSelected];
    
    
    if(segment.selectedSegmentIndex == 0)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSObject * object = [prefs objectForKey:@"userid"];
        if(object != nil)
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&type=%@",BaseUrl,strtoken,getConversionList,english,strCityId,struseridnum,@"0"];
            [requested OptionRequest5:nil withUrl:strurl];
        }
        else
        {
            
        }
        
        [self.view endEditing:YES];
        selectedIndex = -1;
        tabl.tag=1;
        [tabl reloadData];
    }
    else if(segment.selectedSegmentIndex == 1)
    {
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSObject * object = [prefs objectForKey:@"userid"];
        if(object != nil)
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&type=%@",BaseUrl,strtoken,getConversionList,english,strCityId,struseridnum,@"1"];
            [requested OptionRequest6:nil withUrl:strurl];
        }
        else
        {
            
        }
        
        
        [self.view endEditing:YES];
        selectedIndex = -1;
        tabl.tag=2;
        [tabl reloadData];
       
    }
    else if(segment.selectedSegmentIndex == 2)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSObject * object = [prefs objectForKey:@"userid"];
        if(object != nil)
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&type=%@",BaseUrl,strtoken,getConversionList,english,strCityId,struseridnum,@"2"];
            [requested OptionRequest7:nil withUrl:strurl];
        }
        else
        {
            
        }
        
        [self.view endEditing:YES];
        selectedIndex = -1;
        tabl.tag=3;
        [tabl reloadData];
    }
}




#pragma mark - Table view Delegate Methods


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1)
    {
        return 141;
    }
    else if (tableView.tag==2)
    {
        return 141;
    }
    else if (tableView.tag==3)
    {
        return 141;
    }
    return 141;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1)
    {
        return arrChatAll.count;
    }
    else if (tableView.tag==2)
    {
        return arrChatBying.count;
    }
    else if (tableView.tag==3)
    {
        return arrChatCelling.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1)
    {
        static NSString *CellClassName = @"ChatTableViewCell";
        
        cell = (ChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
        
        if (cell == nil)
        {
            cell = [[ChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatTableViewCell"
                                                         owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.backgroundColor=[UIColor blackColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
          UIImageView *Profileimage=(UIImageView*)[cell viewWithTag:1];
          UILabel *labName=(UILabel *)[cell viewWithTag:2];
          UILabel *labDate=(UILabel *)[cell viewWithTag:3];
          UILabel *labDescribtion=(UILabel *)[cell viewWithTag:4];
        
        Profileimage.contentMode = UIViewContentModeScaleAspectFill;
        Profileimage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
        NSString *imageName=[[[arrChatAll valueForKey:@"user"] valueForKey:@"profile_pic"] objectAtIndex:indexPath.row];
        if (imageName == (id)[NSNull null] || imageName.length == 0 )
        {
            [Profileimage sd_setImageWithURL:[NSURL URLWithString:@""]
                            placeholderImage:[UIImage imageNamed:@"upload-empty.png"]];
        }
        else
        {
            [Profileimage sd_setImageWithURL:[NSURL URLWithString:imageName]
                            placeholderImage:[UIImage imageNamed:@"upload-empty.png"]];
        }
        
        Profileimage.layer.cornerRadius = Profileimage.frame.size.height /2;
        Profileimage.layer.masksToBounds = YES;
        Profileimage.layer.borderWidth = 0;
        
        NSString *strname=[[[arrChatAll valueForKey:@"user"] valueForKey:@"name"] objectAtIndex:indexPath.row];
        if (strname == (id)[NSNull null] || strname.length == 0 )
        {
            labName.text=@"";
        }
        else
        {
           labName.text=[NSString stringWithFormat:@"%@",strname];
        }

        NSString *strdate=[[arrChatAll valueForKey:@"dateTime"] objectAtIndex:indexPath.row];
        if (strdate == (id)[NSNull null] || strdate.length == 0 )
        {
            labDate.text=@"";
        }
        else
        {
            labDate.text=[NSString stringWithFormat:@"%@",strdate];
        }
        
        NSString *strdesc=[[arrChatAll valueForKey:@"post_name"] objectAtIndex:indexPath.row];
        if (strdesc == (id)[NSNull null] || strdesc.length == 0 )
        {
            labDescribtion.text=@"";
        }
        else
        {
            labDescribtion.text=[NSString stringWithFormat:@"%@",strdesc];
        }
        
        
        
     //   labDate.text=[[arrChatAll valueForKey:@"dateTime"] objectAtIndex:indexPath.row];
        
    //    labDescribtion.text=[[arrChatAll valueForKey:@"post_name"] objectAtIndex:indexPath.row];
        
        return cell;
       
    }
    
    else if(tableView.tag==2)
    {
        static NSString *CellClassName = @"ChatTableViewCell";
        
        cell = (ChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
        
        if (cell == nil)
        {
            cell = [[ChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatTableViewCell"
                                                         owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.backgroundColor=[UIColor blackColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        UIImageView *Profileimage=(UIImageView*)[cell viewWithTag:1];
        UILabel *labName=(UILabel *)[cell viewWithTag:2];
        UILabel *labDate=(UILabel *)[cell viewWithTag:3];
        UILabel *labDescribtion=(UILabel *)[cell viewWithTag:4];
        
        Profileimage.contentMode = UIViewContentModeScaleAspectFill;
        Profileimage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
        NSString *imageName=[[[arrChatBying valueForKey:@"user"] valueForKey:@"profile_pic"] objectAtIndex:indexPath.row];
        if (imageName == (id)[NSNull null] || imageName.length == 0 )
        {
            [Profileimage sd_setImageWithURL:[NSURL URLWithString:@""]
                            placeholderImage:[UIImage imageNamed:@"upload-empty.png"]];
        }
        else
        {
            [Profileimage sd_setImageWithURL:[NSURL URLWithString:imageName]
                            placeholderImage:[UIImage imageNamed:@"upload-empty.png"]];
        }
        Profileimage.layer.cornerRadius = Profileimage.frame.size.height /2;
        Profileimage.layer.masksToBounds = YES;
        Profileimage.layer.borderWidth = 0;
        
        NSString *strname=[[[arrChatBying valueForKey:@"user"] valueForKey:@"name"] objectAtIndex:indexPath.row];
        if (strname == (id)[NSNull null] || strname.length == 0 )
        {
            labName.text=@"";
        }
        else
        {
            labName.text=[NSString stringWithFormat:@"%@",strname];
        }
        
        NSString *strdate=[[arrChatBying valueForKey:@"dateTime"] objectAtIndex:indexPath.row];
        if (strdate == (id)[NSNull null] || strdate.length == 0 )
        {
            labDate.text=@"";
        }
        else
        {
            labDate.text=[NSString stringWithFormat:@"%@",strdate];
        }
        
        NSString *strdesc=[[arrChatBying valueForKey:@"post_name"] objectAtIndex:indexPath.row];
        if (strdesc == (id)[NSNull null] || strdesc.length == 0 )
        {
            labDescribtion.text=@"";
        }
        else
        {
            labDescribtion.text=[NSString stringWithFormat:@"%@",strdesc];
        }
        

        
     //   labDate.text=[[arrChatBying valueForKey:@"dateTime"] objectAtIndex:indexPath.row];
        
     //   labDescribtion.text=[[arrChatBying valueForKey:@"post_name"] objectAtIndex:indexPath.row];

        return cell;

    }
    
    else if(tableView.tag==3)
    {
        static NSString *CellClassName = @"ChatTableViewCell";
        
        cell = (ChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
        
        if (cell == nil)
        {
            cell = [[ChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatTableViewCell"
                                                         owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.backgroundColor=[UIColor blackColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        UIImageView *Profileimage=(UIImageView*)[cell viewWithTag:1];
        UILabel *labName=(UILabel *)[cell viewWithTag:2];
        UILabel *labDate=(UILabel *)[cell viewWithTag:3];
        UILabel *labDescribtion=(UILabel *)[cell viewWithTag:4];
        
        Profileimage.contentMode = UIViewContentModeScaleAspectFill;
        Profileimage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
        NSString *imageName=[[[arrChatCelling valueForKey:@"user"] valueForKey:@"profile_pic"] objectAtIndex:indexPath.row];
        if (imageName == (id)[NSNull null] || imageName.length == 0 )
        {
            [Profileimage sd_setImageWithURL:[NSURL URLWithString:@""]
                            placeholderImage:[UIImage imageNamed:@"upload-empty.png"]];
        }
        else
        {
            [Profileimage sd_setImageWithURL:[NSURL URLWithString:imageName]
                            placeholderImage:[UIImage imageNamed:@"upload-empty.png"]];
        }
        Profileimage.layer.cornerRadius = Profileimage.frame.size.height /2;
        Profileimage.layer.masksToBounds = YES;
        Profileimage.layer.borderWidth = 0;
        
        NSString *strname=[[[arrChatCelling valueForKey:@"user"] valueForKey:@"name"] objectAtIndex:indexPath.row];
        if (strname == (id)[NSNull null] || strname.length == 0 )
        {
            labName.text=@"";
        }
        else
        {
            labName.text=[NSString stringWithFormat:@"%@",strname];
        }
        
        
        NSString *strdate=[[arrChatCelling valueForKey:@"dateTime"] objectAtIndex:indexPath.row];
        if (strdate == (id)[NSNull null] || strdate.length == 0 )
        {
            labDate.text=@"";
        }
        else
        {
            labDate.text=[NSString stringWithFormat:@"%@",strdate];
        }
        
        NSString *strdesc=[[arrChatCelling valueForKey:@"post_name"] objectAtIndex:indexPath.row];
        if (strdesc == (id)[NSNull null] || strdesc.length == 0 )
        {
            labDescribtion.text=@"";
        }
        else
        {
            labDescribtion.text=[NSString stringWithFormat:@"%@",strdesc];
        }

    //    labDate.text=[[arrChatCelling valueForKey:@"dateTime"] objectAtIndex:indexPath.row];
        
   //     labDescribtion.text=[[arrChatCelling valueForKey:@"post_name"] objectAtIndex:indexPath.row];

        
        return cell;
    }
    
    return nil;
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
    if (tableView.tag==1)
    {
        NSString *strconversionid=[NSString stringWithFormat:@"%@",[[arrChatAll valueForKey:@"conversation_id"] objectAtIndex:indexPath.row]];
        ChatingDetailsViewController *chat=[self.storyboard instantiateViewControllerWithIdentifier:@"ChatingDetailsViewController"];
        chat.strConversionId=strconversionid;
        chat.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:chat animated:YES];
    }
    else if (tableView.tag==2)
    {
        NSString *strconversionid=[NSString stringWithFormat:@"%@",[[arrChatBying valueForKey:@"conversation_id"] objectAtIndex:indexPath.row]];
        ChatingDetailsViewController *chat=[self.storyboard instantiateViewControllerWithIdentifier:@"ChatingDetailsViewController"];
        chat.strConversionId=strconversionid;
        chat.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:chat animated:YES];
    }
    else if (tableView.tag==3)
    {
        NSString *strconversionid=[NSString stringWithFormat:@"%@",[[arrChatCelling valueForKey:@"conversation_id"] objectAtIndex:indexPath.row]];
        ChatingDetailsViewController *chat=[self.storyboard instantiateViewControllerWithIdentifier:@"ChatingDetailsViewController"];
        chat.strConversionId=strconversionid;
        chat.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:chat animated:YES];
    }
}



#pragma mark - View life Cycles

-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"userid"];
    if(object != nil)
    {
        lab.hidden=YES;
        tabl.hidden=NO;
        
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&type=%@",BaseUrl,strtoken,getConversionList,english,strCityId,struseridnum,@"0"];
        [requested OptionRequest5:nil withUrl:strurl];

    }
    else
    {
        tabl.hidden=YES;
        lab.hidden=NO;
    }
}

-(void)responseOption5:(NSMutableDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    NSString *strsttus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strsttus isEqualToString:@"1"])
    {
        [arrChatAll removeAllObjects];
        NSArray *ardata=[responseDict valueForKey:@"data"];
        
        for (int i=0; i<ardata.count; i++)
        {
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            
            NSString *strpostname=[[ardata objectAtIndex:i]valueForKey:@"post_name"];
            NSString *strname=[[[ardata objectAtIndex:i]valueForKey:@"user"] valueForKey:@"name"];
            
            if (strname == (id)[NSNull null] || strname.length == 0)
            {
            
            }
            else if (strpostname == (id)[NSNull null] || strpostname.length == 0)
            {
            
            }
            else
            {
              [arr addObject:[ardata objectAtIndex:i]];
                arrChatAll=[[arrChatAll arrayByAddingObjectsFromArray:arr] mutableCopy];
            }
            
        }
        
      //  arrChatAll=[responseDict valueForKey:@"data"];
        
        [tabl reloadData];
    }
    else
    {
        [requested showMessage:[responseDict valueForKey:@"message"] withTitle:@""];
    }
}

-(void)responseOption6:(NSMutableDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    NSString *strsttus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strsttus isEqualToString:@"1"])
    {
        
        [arrChatBying removeAllObjects];
        NSArray *ardata=[responseDict valueForKey:@"data"];
        
        for (int i=0; i<ardata.count; i++)
        {
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            
            NSString *strpostname=[[ardata objectAtIndex:i]valueForKey:@"post_name"];
            NSString *strname=[[[ardata objectAtIndex:i]valueForKey:@"user"] valueForKey:@"name"];
            
            if (strname == (id)[NSNull null] || strname.length == 0)
            {
                
            }
            else if (strpostname == (id)[NSNull null] || strpostname.length == 0)
            {
                
            }
            else
            {
                [arr addObject:[ardata objectAtIndex:i]];
                arrChatBying=[[arrChatBying arrayByAddingObjectsFromArray:arr] mutableCopy];
            }
            
        }

      //  arrChatBying=[responseDict valueForKey:@"data"];
         [tabl reloadData];
    }
    else
    {
        [requested showMessage:[responseDict valueForKey:@"message"] withTitle:@""];
    }
}

-(void)responseOption7:(NSMutableDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    NSString *strsttus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strsttus isEqualToString:@"1"])
    {
        [arrChatCelling removeAllObjects];
        NSArray *ardata=[responseDict valueForKey:@"data"];
        
        for (int i=0; i<ardata.count; i++)
        {
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            
            NSString *strpostname=[[ardata objectAtIndex:i]valueForKey:@"post_name"];
            NSString *strname=[[[ardata objectAtIndex:i]valueForKey:@"user"] valueForKey:@"name"];
            
            if (strname == (id)[NSNull null] || strname.length == 0)
            {
                
            }
            else if (strpostname == (id)[NSNull null] || strpostname.length == 0)
            {
                
            }
            else
            {
                [arr addObject:[ardata objectAtIndex:i]];
                arrChatCelling=[[arrChatCelling arrayByAddingObjectsFromArray:arr] mutableCopy];
            }
            
        }

      //  arrChatCelling=[responseDict valueForKey:@"data"];
         [tabl reloadData];
    }
    else
    {
        [requested showMessage:[responseDict valueForKey:@"message"] withTitle:@""];
    }
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
