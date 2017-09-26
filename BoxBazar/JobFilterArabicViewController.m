//
//  JobFilterArabicViewController.m
//  BoxBazar
//
//  Created by bharat on 01/09/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "JobFilterArabicViewController.h"
#import "ApiRequest.h"
#import "MARKRangeSlider.h"
#import "BoxBazarUrl.pch"
#import "DejalActivityView.h"
#import "JobCategeoryArabicTableViewCell.h"

@interface JobFilterArabicViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,ApiRequestdelegate,UITextFieldDelegate>
{
    ApiRequest *requested;
    UILabel *label;
    UILabel *label1;
    UIView *popview;
    UIView *footerview;
    UIView *filterview;
    
    UIView *localitiesView,*RoleView,*ExpinYearView,*SalaryrangeView,*EducationView;
    
    UIButton *sortbyDatebutt,*sortrecentitemsbutt,*sortrecentitems2butt;
    
    JobCategeoryArabicTableViewCell *cell;
    JobCategeoryArabicTableViewCell *cell1;
    
    UITextField *searchEducation;
}
@property (nonatomic, strong) MARKRangeSlider *rangeSlider,*rangeSlider1;
@end

@implementation JobFilterArabicViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    
        
    
}

-(void)responsewithData:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSArray *arrlocalitynames=[responseDictionary valueForKey:@"data"];
    NSLog(@"%@",arrlocalitynames);
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrlocalitynames];
    
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"localities2"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _CustomSearchbar.barTintColor=[UIColor clearColor];
    _CustomSearchbar.searchBarStyle = UISearchBarStyleMinimal;
    
    _crossbutt.hidden=YES;
    _CustomSearchbar.hidden=YES;
    
    _titlelab.text=_strtitle;
    
    [table reloadData];
    [tabl2 reloadData];
    
    self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    arrlistofjobs=[[NSMutableArray alloc]init];
    
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    
    listjobs=[[NSMutableArray alloc]init];
    
    arrcategeoryfilterby=[[NSMutableArray alloc]initWithObjects:@"Localities",@"Role",@"Exp in Year",@"Salary in lakh",@"Education", nil];
    arrroles=[[NSMutableArray alloc]initWithObjects:@"Accountant",@"Architect",@"Beautician",@"BPO/Telecaller"@"cook",@"Data Entry",@"Doctor",nil];
    arreducation=[[NSMutableArray alloc]initWithObjects:@"Below class 12th",@"Class 12th pass",@"Diploma",@"Graduate",@"other",@"Post Graduate & Above", nil];
    
    [self Expendview];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"localities2"];
    
    arrlocalities = [NSKeyedUnarchiver unarchiveObjectWithData:data];
}


-(void)Expendview
{
    UIButton *SortButt=[[UIButton alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width/2-1, 40)];
    [SortButt setTitle:@"Sort" forState:UIControlStateNormal];
    SortButt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [SortButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    SortButt.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [SortButt addTarget:self action:@selector(SortbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    SortButt.backgroundColor=[UIColor grayColor];
    [self.view addSubview:SortButt];
    
    UIButton *FilterButt=[[UIButton alloc] initWithFrame:CGRectMake(SortButt.frame.size.width+SortButt.frame.origin.x+2, 65, self.view.frame.size.width/2-1, 40)];
    [FilterButt setTitle:@"Filter" forState:UIControlStateNormal];
    FilterButt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [FilterButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    FilterButt.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [FilterButt addTarget:self action:@selector(FilterbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    FilterButt.backgroundColor=[UIColor grayColor];
    [self.view addSubview:FilterButt];
    
    table=[[UITableView alloc] init];
    table.frame = CGRectMake(0,FilterButt.frame.origin.y+FilterButt.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-110);
    table.delegate=self;
    table.dataSource=self;
    [table setAllowsSelection:YES];
    table.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:table];
    
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,localitylist,arabic,@"1"];
    [requested motorsRequest:nil withUrl:strurl];

    
}



#pragma mark - Sort butt Clicked

-(IBAction)SortbuttClicked:(id)sender
{
    // [requested showMessage:@"Sort Clicked" withTitle:@"Sort butt"];
    [self sortClicked];
}

#pragma mark - Filter butt Clicked

-(IBAction)FilterbuttClicked:(id)sender
{
    [self FilterClicked];
}




- (IBAction)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SearchbuttClicked:(id)sender
{
    _crossbutt.hidden=NO;
    _CustomSearchbar.hidden=NO;
    _backbutt.hidden=YES;
    _titlelab.hidden=YES;
}

- (IBAction)crossButtClicked:(id)sender
{
    _crossbutt.hidden=YES;
    _CustomSearchbar.hidden=YES;
    _backbutt.hidden=NO;
    _titlelab.hidden=NO;
}



#pragma mark - TableView Delegate Methods


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==2)
    {
        return 50;
    }
    else if (tableView.tag==3)
    {
        return 50;
    }
    else if (tableView.tag==4)
    {
        return 50;
    }
    else if (tableView.tag==5)
    {
        return 50;
    }
    else
    {
        return 141;
    }
    return 141;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==2)
    {
        return arrcategeoryfilterby.count;
    }
    else if (tableView.tag==3)
    {
        return arrlocalities.count;
    }
    else if (tableView.tag==4)
    {
        return arrroles.count;
    }
    else if (tableView.tag==5)
    {
        return arreducation.count;
    }
    else
    {
        return 6;
    }
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"Cell1";
  //  static NSString *CellIdentifier2 = @"Cell2";
    
    UITableViewCell *cell5;
    
    if (tableView.tag==2)
    {
        
        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        cell5 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        
        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, table.frame.size.width-20, 40)];
        namel.text=[arrcategeoryfilterby objectAtIndex:indexPath.row];
        namel.lineBreakMode = NSLineBreakByWordWrapping;
        namel.numberOfLines = 1;
        namel.textAlignment=NSTextAlignmentRight;
        [namel setFont:[UIFont systemFontOfSize:15]];
        [cell5 addSubview:namel];
        
        return cell5;

        
    }
    else if (tableView.tag==3)
    {
        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        cell5 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        
        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, filterview.frame.size.width-20, 40)];
        namel.text=[[arrlocalities valueForKey:@"name"] objectAtIndex:indexPath.row];
        namel.lineBreakMode = NSLineBreakByWordWrapping;
        namel.numberOfLines = 1;
        namel.textAlignment=NSTextAlignmentRight;
        [namel setFont:[UIFont systemFontOfSize:15]];
        [cell5 addSubview:namel];
       
        return cell5;

    }
    else if (tableView.tag==4)
    {
        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        cell5 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        
        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, filterview.frame.size.width-20, 40)];
        namel.text=[arrroles objectAtIndex:indexPath.row];
        namel.lineBreakMode = NSLineBreakByWordWrapping;
        namel.numberOfLines = 1;
        namel.textAlignment=NSTextAlignmentRight;
        [namel setFont:[UIFont systemFontOfSize:15]];
        [cell5 addSubview:namel];
        
        return cell5;
    }
    else if (tableView.tag==5)
    {
        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        cell5 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        
        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, filterview.frame.size.width-20, 40)];
        namel.text=[arreducation objectAtIndex:indexPath.row];
        namel.lineBreakMode = NSLineBreakByWordWrapping;
        namel.numberOfLines = 2;
        namel.textAlignment=NSTextAlignmentRight;
        [namel setFont:[UIFont systemFontOfSize:15]];
        [cell5 addSubview:namel];
        
        return cell5;
    }
    else
    {
        static NSString *CellClassName = @"JobCategeoryArabicTableViewCell";
        
        cell = (JobCategeoryArabicTableViewCell *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
        
        if (cell == nil)
        {
            cell = [[JobCategeoryArabicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"JobCategeoryArabicTableViewCell"
                                                         owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.backgroundColor=[UIColor blackColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        //            UIImageView *Jobimage=(UIImageView*)[cell viewWithTag:1];
        //            UILabel *JobName=(UILabel *)[cell viewWithTag:3];
        //            UILabel *JobDes=(UILabel *)[cell viewWithTag:4];
        //            UILabel *Placelab=(UILabel *)[cell viewWithTag:5];
        //            UILabel *Timelab=(UILabel *)[cell viewWithTag:6];
        //
        //            NSString *imageName=[listjobs objectAtIndex:indexPath.row];
        //            Jobimage.image=[UIImage imageNamed:imageName];
        //
        //            JobName.text=[listjobs objectAtIndex:indexPath.row];
        //
        //            JobDes.text=[listjobs objectAtIndex:indexPath.row];
        //
        //            Placelab.text=[listjobs objectAtIndex:indexPath.row];
        //
        //            Timelab.text=[listjobs objectAtIndex:indexPath.row];
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==2)
    {
        NSString *strname=[arrcategeoryfilterby objectAtIndex:indexPath.row];
        NSLog(@"Selected Row: %@",strname);
        
        if (indexPath.row==0)
        {
            localitiesView.hidden=NO;
            RoleView.hidden=YES;
            ExpinYearView.hidden=YES;
            SalaryrangeView.hidden=YES;
            EducationView.hidden=YES;
        }
        else if(indexPath.row==1)
        {
            localitiesView.hidden=YES;
            RoleView.hidden=NO;
            ExpinYearView.hidden=YES;
            SalaryrangeView.hidden=YES;
            EducationView.hidden=YES;
        }
        else if(indexPath.row==2)
        {
            localitiesView.hidden=YES;
            RoleView.hidden=YES;
            ExpinYearView.hidden=NO;
            SalaryrangeView.hidden=YES;
            EducationView.hidden=YES;
        }
        else if(indexPath.row==3)
        {
            localitiesView.hidden=YES;
            RoleView.hidden=YES;
            ExpinYearView.hidden=YES;
            SalaryrangeView.hidden=NO;
            EducationView.hidden=YES;
        }
        else if(indexPath.row==4)
        {
            localitiesView.hidden=YES;
            RoleView.hidden=YES;
            ExpinYearView.hidden=YES;
            SalaryrangeView.hidden=YES;
            EducationView.hidden=NO;
        }
    }
    else if (tableView.tag==3)
    {
        NSString *strLocalityname=[[arrlocalities valueForKey:@"name"] objectAtIndex:indexPath.row];
        NSString *strLocalityid=[[arrlocalities valueForKey:@"locality_id"] objectAtIndex:indexPath.row];
        NSLog(@"Selected Row: %@",strLocalityname);
        NSLog(@"Selected Row: %@",strLocalityid);
    }
    else if (tableView.tag==4)
    {
        NSString *strLocalityname=[arrroles objectAtIndex:indexPath.row];
        NSLog(@"Selected Row: %@",strLocalityname);
    }
    else if (tableView.tag==5)
    {
        NSString *strLocalityname=[arreducation objectAtIndex:indexPath.row];
        NSLog(@"Selected Row: %@",strLocalityname);
    }
}




#pragma mark - Sort Clicked


-(void)sortClicked
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height)];
    footerview.backgroundColor = [UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    [popview addSubview:footerview];
    
    
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 10)];
    lab1.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:lab1];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, footerview.frame.size.width, 50)];
    lab.text=@"Sort";
    lab.textColor=[UIColor whiteColor];
    lab.backgroundColor=[UIColor darkGrayColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont boldSystemFontOfSize:19];
    [footerview addSubview:lab];
    
    UIButton *butt11=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    [butt11 setTitle:@"Cancel" forState:UIControlStateNormal];
    butt11.titleLabel.font = [UIFont systemFontOfSize:15];
    butt11.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [butt11 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butt11 addTarget:self action:@selector(Cancelclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt11];
    
    
    
    sortbyDatebutt=[[UIButton alloc]initWithFrame:CGRectMake(0, lab.frame.size.height+lab.frame.origin.y+50, self.view.frame.size.width, 50)];
    [sortbyDatebutt setTitle:@"Sort By Date" forState:UIControlStateNormal];
    sortbyDatebutt.titleLabel.font = [UIFont systemFontOfSize:20];
    sortbyDatebutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [sortbyDatebutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sortbyDatebutt.backgroundColor=[UIColor lightGrayColor];
    [sortbyDatebutt addTarget:self action:@selector(SortbyDateClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:sortbyDatebutt];
    
    sortrecentitemsbutt=[[UIButton alloc]initWithFrame:CGRectMake(0, sortbyDatebutt.frame.size.height+sortbyDatebutt.frame.origin.y+10, self.view.frame.size.width, 50)];
    [sortrecentitemsbutt setTitle:@"Sort Recent Items" forState:UIControlStateNormal];
    sortrecentitemsbutt.titleLabel.font = [UIFont systemFontOfSize:20];
    sortrecentitemsbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [sortrecentitemsbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sortrecentitemsbutt.backgroundColor=[UIColor lightGrayColor];
    [sortrecentitemsbutt addTarget:self action:@selector(SortbyrecentItemsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:sortrecentitemsbutt];
    
    sortrecentitems2butt=[[UIButton alloc]initWithFrame:CGRectMake(0, sortrecentitemsbutt.frame.size.height+sortrecentitemsbutt.frame.origin.y+10, self.view.frame.size.width, 50)];
    [sortrecentitems2butt setTitle:@"Sort Recent Items" forState:UIControlStateNormal];
    sortrecentitems2butt.titleLabel.font = [UIFont systemFontOfSize:20];
    sortrecentitems2butt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [sortrecentitems2butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sortrecentitems2butt.backgroundColor=[UIColor lightGrayColor];
    [sortrecentitems2butt addTarget:self action:@selector(Sortbyrecentitems2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:sortrecentitems2butt];
}



#pragma mark - Sort By Date Clicked

-(IBAction)SortbyDateClicked:(id)sender
{
    sortbyDatebutt.backgroundColor=[UIColor redColor];
    sortrecentitemsbutt.backgroundColor=[UIColor lightGrayColor];
    sortrecentitems2butt.backgroundColor=[UIColor lightGrayColor];
}


-(IBAction)SortbyrecentItemsClicked:(id)sender
{
    sortbyDatebutt.backgroundColor=[UIColor lightGrayColor];
    sortrecentitemsbutt.backgroundColor=[UIColor redColor];
    sortrecentitems2butt.backgroundColor=[UIColor lightGrayColor];
}


-(IBAction)Sortbyrecentitems2Clicked:(id)sender
{
    sortbyDatebutt.backgroundColor=[UIColor lightGrayColor];
    sortrecentitemsbutt.backgroundColor=[UIColor lightGrayColor];
    sortrecentitems2butt.backgroundColor=[UIColor redColor];
    
    [footerview removeFromSuperview];
    popview.hidden = YES;
}



#pragma mark - Filter By Clicked

-(void)FilterClicked
{
    self.hidesBottomBarWhenPushed = YES;
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height)];
    footerview.backgroundColor = [UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    [popview addSubview:footerview];
    
    
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 10)];
    lab1.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:lab1];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, footerview.frame.size.width, 50)];
    lab.text=@"Filter By";
    lab.textColor=[UIColor whiteColor];
    lab.backgroundColor=[UIColor darkGrayColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont boldSystemFontOfSize:19];
    [footerview addSubview:lab];
    
    UIButton *butt11=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60, 10, 50, 50)];
    [butt11 setTitle:@"Cancel" forState:UIControlStateNormal];
    butt11.titleLabel.font = [UIFont systemFontOfSize:15];
    butt11.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [butt11 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butt11 addTarget:self action:@selector(Cancelclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt11];
    
    
    //    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(1, lab.frame.origin.y+lab.frame.size.height, footerview.frame.size.width-2, 1)];
    //    labeunder.backgroundColor=[UIColor lightGrayColor];
    //    [footerview addSubview:labeunder];
    
    
    table=[[UITableView alloc] init];
    table.frame = CGRectMake(footerview.frame.size.width-160,lab.frame.origin.y+lab.frame.size.height, 160, self.view.frame.size.height-110);
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    table.backgroundColor=[UIColor lightGrayColor];
    table.delegate=self;
    table.dataSource=self;
    [table setAllowsSelection:YES];
    table.tag=2;
    table.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [footerview addSubview:table];
    
    
    filterview=[[UIView alloc]initWithFrame:CGRectMake(0, lab.frame.origin.y+lab.frame.size.height, footerview.frame.size.width-160, self.view.frame.size.height-110)];
    filterview.backgroundColor=[UIColor clearColor];
    [footerview addSubview:filterview];
    
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(0,footerview.frame.size.height-50 ,filterview.frame.size.width,50)];
    [butt setTitle:@"Apply" forState:UIControlStateNormal];
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    butt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt.backgroundColor=[UIColor grayColor];
    //   [butt addTarget:self action:@selector(Englishbutnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width, footerview.frame.size.height-50, table.frame.size.width, 50)];
    [butt1 setTitle:@"Reset" forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    butt1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.backgroundColor=[UIColor darkGrayColor];
    //   [butt1 addTarget:self action:@selector(Arabicbutnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt1];
    

    
    localitiesView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, filterview.frame.size.width, self.view.frame.size.height-110)];
    localitiesView.backgroundColor=[UIColor clearColor];
    [filterview addSubview:localitiesView];
    [self localityview];
    
    
    RoleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, filterview.frame.size.width, self.view.frame.size.height-110)];
    RoleView.backgroundColor=[UIColor clearColor];
    RoleView.hidden=YES;
    [self roleView];
    [filterview addSubview:RoleView];
    
    
    
    ExpinYearView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, filterview.frame.size.width, 100)];
    [self setUpViewComponents];
    ExpinYearView.hidden=YES;
    [filterview addSubview:ExpinYearView];
    
    
    
    SalaryrangeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, filterview.frame.size.width, 100)];
    [self setUpViewComponents1];
    SalaryrangeView.hidden=YES;
    [filterview addSubview:SalaryrangeView];
    
    
    EducationView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, filterview.frame.size.width, self.view.frame.size.height-110)];
    EducationView.hidden=YES;
    [self educationview];
    [filterview addSubview:EducationView];
}


-(IBAction)Cancelclicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}


-(void)localityview
{
    searchEducation=[[UITextField alloc]initWithFrame:CGRectMake(26, 5, localitiesView.frame.size.width-31, 40)];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Search locality" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    searchEducation.attributedPlaceholder = str1;
    searchEducation.textAlignment=NSTextAlignmentRight;
    searchEducation.textColor=[UIColor blackColor];
    searchEducation.font = [UIFont systemFontOfSize:15];
    searchEducation.backgroundColor=[UIColor clearColor];
    searchEducation.delegate=self;
    [searchEducation setKeyboardType:UIKeyboardTypeEmailAddress];
    searchEducation.returnKeyType = UIReturnKeyNext;
    [localitiesView addSubview:searchEducation];
    
    
    UIButton *SearchEdubutt=[[UIButton alloc] initWithFrame:CGRectMake(5, 13, 24, 24)];
    [SearchEdubutt setImage:[UIImage imageNamed:@"magnifying-glass-icon.png"] forState:UIControlStateNormal];
    SearchEdubutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [SearchEdubutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    SearchEdubutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [SearchEdubutt addTarget:self action:@selector(SearchedubuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    SearchEdubutt.backgroundColor=[UIColor clearColor];
    [localitiesView addSubview:SearchEdubutt];
    
    
    UILabel *searchEducationUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(5, searchEducation.frame.size.height+searchEducation.frame.origin.y+1, localitiesView.frame.size.width-10, 2)];
    searchEducationUnderlabel.backgroundColor=[UIColor lightGrayColor];
    [localitiesView addSubview:searchEducationUnderlabel];
    
    
    tabl2=[[UITableView alloc] init];
    tabl2.frame = CGRectMake(0,searchEducationUnderlabel.frame.origin.y+searchEducationUnderlabel.frame.size.height, localitiesView.frame.size.width, self.view.frame.size.height-160);
    tabl2.delegate=self;
    tabl2.dataSource=self;
    [tabl2 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tabl2.backgroundColor=[UIColor lightGrayColor];
    tabl2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tabl2.tag=3;
    [tabl2 setAllowsSelection:YES];
    [tabl2 reloadData];
    [localitiesView addSubview:tabl2];
    
}

-(void)roleView
{
    searchEducation=[[UITextField alloc]initWithFrame:CGRectMake(26, 5, RoleView.frame.size.width-31, 40)];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Search Role" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    searchEducation.attributedPlaceholder = str1;
    searchEducation.textAlignment=NSTextAlignmentRight;
    searchEducation.textColor=[UIColor blackColor];
    searchEducation.font = [UIFont systemFontOfSize:15];
    searchEducation.backgroundColor=[UIColor clearColor];
    searchEducation.delegate=self;
    [searchEducation setKeyboardType:UIKeyboardTypeEmailAddress];
    searchEducation.returnKeyType = UIReturnKeyNext;
    [RoleView addSubview:searchEducation];
    
    
    UIButton *SearchEdubutt=[[UIButton alloc] initWithFrame:CGRectMake(5, 13, 24, 24)];
    [SearchEdubutt setImage:[UIImage imageNamed:@"magnifying-glass-icon.png"] forState:UIControlStateNormal];
    SearchEdubutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [SearchEdubutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    SearchEdubutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [SearchEdubutt addTarget:self action:@selector(SearchedubuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    SearchEdubutt.backgroundColor=[UIColor clearColor];
    [RoleView addSubview:SearchEdubutt];
    
    
    UILabel *searchEducationUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(5, searchEducation.frame.size.height+searchEducation.frame.origin.y+1, RoleView.frame.size.width-10, 2)];
    searchEducationUnderlabel.backgroundColor=[UIColor lightGrayColor];
    [RoleView addSubview:searchEducationUnderlabel];
    
    
    tabl2=[[UITableView alloc] init];
    tabl2.frame = CGRectMake(0,searchEducationUnderlabel.frame.origin.y+searchEducationUnderlabel.frame.size.height, RoleView.frame.size.width, self.view.frame.size.height-160);
    tabl2.delegate=self;
    tabl2.dataSource=self;
    [tabl2 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tabl2.backgroundColor=[UIColor lightGrayColor];
    tabl2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tabl2.tag=4;
    [tabl2 setAllowsSelection:YES];
    [RoleView addSubview:tabl2];
}

-(void)educationview
{
    searchEducation=[[UITextField alloc]initWithFrame:CGRectMake(26, 5, EducationView.frame.size.width-31, 40)];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Search Education" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    searchEducation.attributedPlaceholder = str1;
    searchEducation.textAlignment=NSTextAlignmentRight;
    searchEducation.textColor=[UIColor blackColor];
    searchEducation.font = [UIFont systemFontOfSize:15];
    searchEducation.backgroundColor=[UIColor clearColor];
    searchEducation.delegate=self;
    [searchEducation setKeyboardType:UIKeyboardTypeEmailAddress];
    searchEducation.returnKeyType = UIReturnKeyNext;
    [EducationView addSubview:searchEducation];
    
    
    UIButton *SearchEdubutt=[[UIButton alloc] initWithFrame:CGRectMake(5, 13, 24, 24)];
    [SearchEdubutt setImage:[UIImage imageNamed:@"magnifying-glass-icon.png"] forState:UIControlStateNormal];
    SearchEdubutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [SearchEdubutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    SearchEdubutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [SearchEdubutt addTarget:self action:@selector(SearchedubuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    SearchEdubutt.backgroundColor=[UIColor clearColor];
    [EducationView addSubview:SearchEdubutt];
    
    
    UILabel *searchEducationUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(5, searchEducation.frame.size.height+searchEducation.frame.origin.y+1, EducationView.frame.size.width-10, 2)];
    searchEducationUnderlabel.backgroundColor=[UIColor lightGrayColor];
    [EducationView addSubview:searchEducationUnderlabel];
    
    
    tabl2=[[UITableView alloc] init];
    tabl2.frame = CGRectMake(0,searchEducationUnderlabel.frame.origin.y+searchEducationUnderlabel.frame.size.height, EducationView.frame.size.width, self.view.frame.size.height-160);
    tabl2.delegate=self;
    tabl2.dataSource=self;
    [tabl2 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tabl2.backgroundColor=[UIColor lightGrayColor];
    tabl2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tabl2.tag=5;
    [tabl2 setAllowsSelection:YES];
    [EducationView addSubview:tabl2];
}



-(IBAction)SearchedubuttClicked:(id)sender
{
    [requested showMessage:@"Search Clicked" withTitle:@"Search"];
}

- (void)setUpViewComponents
{
    // Text label
    label= [[UILabel alloc] initWithFrame:CGRectMake(5, 10, ExpinYearView.frame.size.width-10, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 1;
    label.font=[UIFont systemFontOfSize:12];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    
    // Init slider
    self.rangeSlider = [[MARKRangeSlider alloc] initWithFrame:CGRectMake(5, 50, ExpinYearView.frame.size.width-10, 40)];
    self.rangeSlider.backgroundColor = [UIColor clearColor];
    self.rangeSlider.tintColor=[UIColor blackColor];
    [self.rangeSlider addTarget:self
                         action:@selector(rangeSliderValueDidChange2:)
               forControlEvents:UIControlEventValueChanged];
    
    [self.rangeSlider setMinValue:0.0 maxValue:+15.0];
    [self.rangeSlider setLeftValue:0.0 rightValue:+15.0];
    
    self.rangeSlider.minimumDistance = 0.6;
    
    [self updateRangeText];
    
    [ExpinYearView addSubview:label];
    [ExpinYearView addSubview:self.rangeSlider];
}

- (void)updateRangeText
{
    //  NSLog(@"%0.2f - %0.2f", self.rangeSlider.leftValue, self.rangeSlider.rightValue);
    NSString *a=[NSString stringWithFormat:@"%f",self.rangeSlider.leftValue];
    NSString *b=[NSString stringWithFormat:@"%f",self.rangeSlider.rightValue];
    
    //    int avalue=(int)[a integerValue];
    //    int bvalue=(int)[b integerValue];
    
    strminRange=[NSString stringWithFormat:@"%@",a];
    strmaxrange=[NSString stringWithFormat:@"%@",b];
    
    //   label.text = [NSString stringWithFormat:@"%@ Yr - %@ Yr",a, b];
    
    label.text = [NSString stringWithFormat:@"%0.1f Yr - %0.1f Yr",
                  self.rangeSlider.leftValue, self.rangeSlider.rightValue];
}


#pragma mark - Actions

- (void)rangeSliderValueDidChange2:(MARKRangeSlider *)slider
{
    [self updateRangeText];
}


- (void)setUpViewComponents1
{
    // Text label
    label1= [[UILabel alloc] initWithFrame:CGRectMake(5, 10, SalaryrangeView.frame.size.width-10, 30)];
    label1.backgroundColor = [UIColor clearColor];
    label1.numberOfLines = 1;
    label1.font=[UIFont systemFontOfSize:12];
    label1.textAlignment=NSTextAlignmentCenter;
    label1.textColor = [UIColor blackColor];
    
    // Init slider
    self.rangeSlider1 = [[MARKRangeSlider alloc] initWithFrame:CGRectMake(5, 50, SalaryrangeView.frame.size.width-10, 40)];
    self.rangeSlider1.backgroundColor = [UIColor clearColor];
    self.rangeSlider1.tintColor=[UIColor blackColor];
    [self.rangeSlider1 addTarget:self
                          action:@selector(rangeSliderValueDidChange1:)
                forControlEvents:UIControlEventValueChanged];
    
    [self.rangeSlider1 setMinValue:00 maxValue:25];
    [self.rangeSlider1 setLeftValue:00 rightValue:25];
    
    self.rangeSlider1.minimumDistance = 0.6;
    
    [self updateRangeText1];
    
    [SalaryrangeView addSubview:label1];
    [SalaryrangeView addSubview:self.rangeSlider1];
}

- (void)updateRangeText1
{
    //  NSLog(@"%0.2f - %0.2f", self.rangeSlider.leftValue, self.rangeSlider.rightValue);
    NSString *a=[NSString stringWithFormat:@"%f",self.rangeSlider1.leftValue];
    NSString *b=[NSString stringWithFormat:@"%f",self.rangeSlider1.rightValue];
    
    int avalue=(int)[a integerValue];
    int bvalue=(int)[b integerValue];
    
    strminsalaryRange=[NSString stringWithFormat:@"%d",avalue];
    strmaxsalaryrange=[NSString stringWithFormat:@"%d",bvalue];
    
    //   label.text = [NSString stringWithFormat:@"%d lakh - %d lakh",avalue, bvalue];
    
    label1.text = [NSString stringWithFormat:@"%0.1f lakh - %0.1f lakh",
                   self.rangeSlider1.leftValue, self.rangeSlider1.rightValue];
}


#pragma mark - Actions

- (void)rangeSliderValueDidChange1:(MARKRangeSlider *)slider
{
    [self updateRangeText1];
}





#pragma mark - Searchbar Delegate Methods


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - TextField Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
    
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
