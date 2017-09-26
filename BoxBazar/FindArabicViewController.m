//
//  FindArabicViewController.m
//  BoxBazar
//
//  Created by bharat on 01/09/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "FindArabicViewController.h"
#import "ApiRequest.h"
#import "MARKRangeSlider.h"
#import "UIColor+Demo.h"
#import "CarnameArabicViewController.h"
#import "BoxBazarUrl.pch"
#import "DejalActivityView.h"

@interface FindArabicViewController ()<ApiRequestdelegate,UITableViewDelegate,UITableViewDataSource>
{
    ApiRequest *requested;
    UIView *topview;
    UIView *budgetView;
    UIView *carslistView;
    UILabel *label;
    
    UIImageView *image;
    UIButton *FindPerfectCarbutt;
    
    UIView *popview;
    UIView *footerview;
    IBOutlet UITableView *tabl;
    UITableViewCell *cell;
}
@property (nonatomic, strong) MARKRangeSlider *rangeSlider;

@end

@implementation FindArabicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    
     DataArray=[[NSMutableArray alloc]init];
    
    [self customView];
}


#pragma mark - UI

- (void)setUpViewComponents
{
    // Text label
    label= [[UILabel alloc] initWithFrame:CGRectMake(budgetView.frame.size.width/2-120, 10, 240, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 1;
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    // Init slider
    self.rangeSlider = [[MARKRangeSlider alloc] initWithFrame:CGRectMake(20, 50, budgetView.frame.size.width-40, 40)];
    self.rangeSlider.backgroundColor = [UIColor clearColor];
    self.rangeSlider.tintColor=[UIColor blackColor];
    [self.rangeSlider addTarget:self
                         action:@selector(rangeSliderValueDidChange:)
               forControlEvents:UIControlEventValueChanged];
    
    [self.rangeSlider setMinValue:500 maxValue:250000];
    [self.rangeSlider setLeftValue:25000 rightValue:500];
    
    self.rangeSlider.minimumDistance = 1000;
    
    [self updateRangeText];
    
    [budgetView addSubview:label];
    [budgetView addSubview:self.rangeSlider];
}

- (void)updateRangeText
{
    //  NSLog(@"%0.2f - %0.2f", self.rangeSlider.leftValue, self.rangeSlider.rightValue);
    NSString *a=[NSString stringWithFormat:@"%f",self.rangeSlider.leftValue];
    NSString *b=[NSString stringWithFormat:@"%f",self.rangeSlider.rightValue];
    
    int avalue=(int)[a integerValue];
    int bvalue=(int)[b integerValue];
    
    strminRange=[NSString stringWithFormat:@"%d",avalue];
    strmaxrange=[NSString stringWithFormat:@"%d",bvalue];
    
    label.text = [NSString stringWithFormat:@"%d AED - %d AED",bvalue, avalue];
}


#pragma mark - Actions

- (void)rangeSliderValueDidChange:(MARKRangeSlider *)slider
{
    [self updateRangeText];
}


-(void)customView
{
    topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
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
    
    UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(topview.frame.size.width/2-120, topview.frame.size.height/2-5, 240, 25)];
    lbltitle.text=_strtitle;
    lbltitle.textColor=[UIColor whiteColor];
    lbltitle.textAlignment=NSTextAlignmentCenter;
    lbltitle.font=[UIFont boldSystemFontOfSize:17];
    [topview addSubview:lbltitle];
    
    UILabel *lookingforspecificlab=[[UILabel alloc] initWithFrame:CGRectMake(5, topview.frame.size.height+topview.frame.origin.y+10, self.view.frame.size.width-10 , 25)];
    lookingforspecificlab.text=@"هل تبحث عن نموذج محدد؟";
    lookingforspecificlab.textColor=[UIColor blackColor];
    lookingforspecificlab.textAlignment=NSTextAlignmentRight;
    lookingforspecificlab.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:lookingforspecificlab];
    
    
    
    
    
    carslistView=[[UIView alloc]initWithFrame:CGRectMake(0,lookingforspecificlab.frame.origin.y+lookingforspecificlab.frame.size.height+5, self.view.frame.size.width, 100)];
    carslistView.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:carslistView];
    
    image=[[UIImageView alloc] initWithFrame:CGRectMake(carslistView.frame.size.width-60, 20, 40, 40)];
    image.image=[UIImage imageNamed:_strimage];
    [carslistView addSubview:image];
    
    
    FindPerfectCarbutt=[[UIButton alloc]initWithFrame:CGRectMake(49, 20, carslistView.frame.size.width-114, 40)];
    [FindPerfectCarbutt setTitle:@"على سبيل المثال أودى A4..." forState:UIControlStateNormal];
    FindPerfectCarbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [FindPerfectCarbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    FindPerfectCarbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [FindPerfectCarbutt addTarget:self action:@selector(FindperfectcarButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    FindPerfectCarbutt.backgroundColor=[UIColor clearColor];
    [carslistView addSubview:FindPerfectCarbutt];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(20,28, 24, 24)];
    image3.image=[UIImage imageNamed:@"back.png"];
    [carslistView addSubview:image3];
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(20, FindPerfectCarbutt.frame.origin.y+FindPerfectCarbutt.frame.size.height+4, carslistView.frame.size.width-40, 3)];
    label1.backgroundColor=[UIColor whiteColor];
    [carslistView addSubview:label1];
    
    
    
    UILabel *whatyourbudgetlab=[[UILabel alloc] initWithFrame:CGRectMake(5, carslistView.frame.size.height+carslistView.frame.origin.y+10, self.view.frame.size.width-10 , 25)];
    whatyourbudgetlab.text=@"ما ميزانيتك؟";
    whatyourbudgetlab.textColor=[UIColor blackColor];
    whatyourbudgetlab.textAlignment=NSTextAlignmentRight;
    whatyourbudgetlab.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:whatyourbudgetlab];
    
    budgetView=[[UIView alloc]initWithFrame:CGRectMake(0,whatyourbudgetlab.frame.origin.y+whatyourbudgetlab.frame.size.height+5, self.view.frame.size.width, 100)];
    budgetView.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    [self.view addSubview:budgetView];
    
    
    
    UIButton *Findbutt=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, budgetView.frame.origin.y+budgetView.frame.size.height+30, 200, 50)];
    [Findbutt setTitle:@"البحث عن" forState:UIControlStateNormal];
    Findbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [Findbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Findbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    Findbutt.layer.cornerRadius = 19;
    Findbutt.clipsToBounds = YES;
    [Findbutt addTarget:self action:@selector(FindButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    Findbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    [self.view addSubview:Findbutt];
    
    [self setUpViewComponents];
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@",BaseUrl,strtoken,carSubModule,arabic,@"1",_strCarSubModule];
    [requested motorsEngRequest:nil withUrl:strurl];

}

-(void)responsewithDataEng:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Motor SubModule English Response: %@",responseDictionary);
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        NSMutableArray *arrMotorList=[[NSMutableArray alloc]init];
        arrMotorList=[responseDictionary valueForKey:@"data"];
        
        DataArray=[arrMotorList valueForKey:@"make"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrMotorList];
        
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"MotorEngSubModule"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    else
    {
        [requested showMessage:[responseDictionary valueForKey:@"message"] withTitle:@"Message"];
    }
}



#pragma mark - Find Perfect Car Clicked

-(IBAction)FindperfectcarButtClicked:(id)sender
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-150, 300, 300)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(footerview.frame.size.width-150, 0, 140, 40)];
    lab.text=@"حدد نموذج";
    lab.textColor=[UIColor blackColor];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentRight;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, 50, 40)];
    [butt1 setTitle:@"إلغاء الأمر" forState:UIControlStateNormal];
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
    return DataArray.count;
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
    
    UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width-50, 40)];
    namel.text=[[DataArray valueForKey:@"name"]objectAtIndex:indexPath.row];
    namel.lineBreakMode = NSLineBreakByWordWrapping;
    namel.textColor=[UIColor blackColor];
    namel.numberOfLines = 1;
    namel.textAlignment=NSTextAlignmentRight;
    [namel setFont:[UIFont boldSystemFontOfSize:15]];
    [cell addSubview:namel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strSubModule=[[DataArray valueForKey:@"name"]objectAtIndex:indexPath.row];
    [FindPerfectCarbutt setTitle:strSubModule forState:UIControlStateNormal];
    
    strSubModuleId=[[DataArray valueForKey:@"id"]objectAtIndex:indexPath.row];
    NSLog(@"%@",strSubModuleId);
    
    [footerview removeFromSuperview];
    popview.hidden = YES;
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?make=%@",BaseUrl,strtoken,carModel,arabic,@"1",strSubModuleId];
    [requested motorsMakeRequest:nil withUrl:strurl];
    
    //    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    //    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    //    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,caroption,english,@"1"];
    //    [requested motorsMakeRequest:nil withUrl:strurl];
}

-(void)responsewithDataMakeMotor:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Motor Model English Response: %@",responseDictionary);
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        NSMutableArray *arrMotorList=[[NSMutableArray alloc]init];
        arrMotorList=[responseDictionary valueForKey:@"data"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrMotorList];
        
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"MotorEngCarModel"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else
    {
        [requested showMessage:[responseDictionary valueForKey:@"message"] withTitle:@"Message"];
    }
}


#pragma mark - Find  Clicked

-(IBAction)FindButtClicked:(id)sender
{
    CarnameArabicViewController *carfind=[self.storyboard instantiateViewControllerWithIdentifier:@"CarnameArabicViewController"];
    carfind.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:carfind animated:YES];
}



#pragma mark - Back Clicked

-(IBAction)BackbuttClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
