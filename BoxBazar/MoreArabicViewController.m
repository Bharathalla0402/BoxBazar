//
//  MoreArabicViewController.m
//  BoxBazar
//
//  Created by bharat on 17/08/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "MoreArabicViewController.h"
#import "ApiRequest.h"
#import "SettingArabicViewController.h"

@interface MoreArabicViewController ()<ApiRequestdelegate>
{
    ApiRequest *request;
    BOOL isClick;
    
    UIButton *languagebutt;
    UILabel *labellanguage;
    
    UIView *popview;
    UIView *footerview;
}

@end

@implementation MoreArabicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    request=[[ApiRequest alloc]init];
    request.delegate=self;
    isClick=NO;
    [self moreaction];
}


-(void)moreaction
{
    UIView *topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 52)];
    topview.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [self.view addSubview:topview];
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(topview.frame.size.width/2-20, topview.frame.size.height/2-8, 40, 30)];
    titlelabel.text=@"أكثر";
    titlelabel.textAlignment=NSTextAlignmentCenter;
    [titlelabel setFont:[UIFont boldSystemFontOfSize:15]];
    titlelabel.textColor=[UIColor whiteColor];
    [topview addSubview:titlelabel];
    
    
    
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(5, topview.frame.size.height+5, self.view.frame.size.width-10, 199)];
    view1.backgroundColor=[UIColor whiteColor];
    view1.layer.cornerRadius = 5;
    view1.clipsToBounds = YES;
    view1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view1.layer.borderWidth = 1.0f;
    [self.view addSubview:view1];
    
    
    labellanguage=[[UILabel alloc]initWithFrame:CGRectMake(25, 0, 50, 30)];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
    {
        labellanguage.text=@"العربية";
    }
    else
    {
        labellanguage.text=@"English";
    }
    labellanguage.textAlignment=NSTextAlignmentCenter;
    [labellanguage setFont:[UIFont systemFontOfSize:15]];
    labellanguage.textColor=[UIColor blackColor];
    [view1 addSubview:labellanguage];
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(6, 8, 16, 16)];
    image1.image=[UIImage imageNamed:@"left.png"];
    [view1 addSubview:image1];
    
    languagebutt=[[UIButton alloc] initWithFrame:CGRectMake(6, 0, view1.frame.size.width-12, 30)];
    [languagebutt setTitle:@"أعطيت الأولوية للغة" forState:UIControlStateNormal];
    languagebutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [languagebutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    languagebutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [languagebutt addTarget:self action:@selector(languagebuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    languagebutt.backgroundColor=[UIColor clearColor];
    [view1 addSubview:languagebutt];
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(6, languagebutt.frame.origin.y+languagebutt.frame.size.height+1, view1.frame.size.width-12, 1)];
    label1.backgroundColor=[UIColor lightGrayColor];
    [view1 addSubview:label1];
    
    
    
    UIButton *addsnearbybutt=[[UIButton alloc]initWithFrame:CGRectMake(30, label1.frame.origin.y+label1.frame.size.height+1, view1.frame.size.width-40, 30)];
    [addsnearbybutt setTitle:@"الإعلانات قريبة" forState:UIControlStateNormal];
    addsnearbybutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [addsnearbybutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addsnearbybutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [addsnearbybutt addTarget:self action:@selector(addsnearbyClicked:) forControlEvents:UIControlEventTouchUpInside];
    addsnearbybutt.backgroundColor=[UIColor clearColor];
    [view1 addSubview:addsnearbybutt];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(6,label1.frame.origin.y+label1.frame.size.height+9, 16, 16)];
    image2.image=[UIImage imageNamed:@"left.png"];
    [view1 addSubview:image2];
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(6, addsnearbybutt.frame.origin.y+addsnearbybutt.frame.size.height+1, view1.frame.size.width-12, 1)];
    label2.backgroundColor=[UIColor lightGrayColor];
    [view1 addSubview:label2];
    
    
    
    
    UIButton *RecentlyViewAdsbutt=[[UIButton alloc]initWithFrame:CGRectMake(30, label2.frame.origin.y+label2.frame.size.height+1, view1.frame.size.width-40, 30)];
    [RecentlyViewAdsbutt setTitle:@"مؤخرا عرض الإعلانات" forState:UIControlStateNormal];
    RecentlyViewAdsbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [RecentlyViewAdsbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    RecentlyViewAdsbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [RecentlyViewAdsbutt addTarget:self action:@selector(RecentlyViewAdsClicked:) forControlEvents:UIControlEventTouchUpInside];
    RecentlyViewAdsbutt.backgroundColor=[UIColor clearColor];
    [view1 addSubview:RecentlyViewAdsbutt];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(6,label2.frame.origin.y+label2.frame.size.height+9, 16, 16)];
    image3.image=[UIImage imageNamed:@"left.png"];
    [view1 addSubview:image3];
    
    UILabel *label3=[[UILabel alloc] initWithFrame:CGRectMake(6, RecentlyViewAdsbutt.frame.origin.y+RecentlyViewAdsbutt.frame.size.height+1, view1.frame.size.width-12, 1)];
    label3.backgroundColor=[UIColor lightGrayColor];
    [view1 addSubview:label3];
    
    
    
    UIButton *PopularInYourAreabutt=[[UIButton alloc]initWithFrame:CGRectMake(30, label3.frame.origin.y+label3.frame.size.height+1, view1.frame.size.width-40, 30)];
    [PopularInYourAreabutt setTitle:@"شعبية في منطقتك" forState:UIControlStateNormal];
    PopularInYourAreabutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [PopularInYourAreabutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    PopularInYourAreabutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [PopularInYourAreabutt addTarget:self action:@selector(PopularinyourAreaClicked:) forControlEvents:UIControlEventTouchUpInside];
    PopularInYourAreabutt.backgroundColor=[UIColor clearColor];
    [view1 addSubview:PopularInYourAreabutt];
    
    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(6,label3.frame.origin.y+label3.frame.size.height+9, 16, 16)];
    image4.image=[UIImage imageNamed:@"left.png"];
    [view1 addSubview:image4];
    
    UILabel *label4=[[UILabel alloc] initWithFrame:CGRectMake(6, PopularInYourAreabutt.frame.origin.y+PopularInYourAreabutt.frame.size.height+1, view1.frame.size.width-12, 1)];
    label4.backgroundColor=[UIColor lightGrayColor];
    [view1 addSubview:label4];
    
    
    
    UIButton *ClearsearchHistorybutt=[[UIButton alloc]initWithFrame:CGRectMake(30, label4.frame.origin.y+label4.frame.size.height+1, view1.frame.size.width-40, 30)];
    [ClearsearchHistorybutt setTitle:@"امسح البحث السابق" forState:UIControlStateNormal];
    ClearsearchHistorybutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [ClearsearchHistorybutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ClearsearchHistorybutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [ClearsearchHistorybutt addTarget:self action:@selector(ClearSearchHistoryClicked:) forControlEvents:UIControlEventTouchUpInside];
    ClearsearchHistorybutt.backgroundColor=[UIColor clearColor];
    [view1 addSubview:ClearsearchHistorybutt];
    
    UIImageView *image5=[[UIImageView alloc]initWithFrame:CGRectMake(6,label4.frame.origin.y+label4.frame.size.height+9, 16, 16)];
    image5.image=[UIImage imageNamed:@"left.png"];
    [view1 addSubview:image5];
    
    UILabel *label5=[[UILabel alloc] initWithFrame:CGRectMake(6, ClearsearchHistorybutt.frame.origin.y+ClearsearchHistorybutt.frame.size.height+1, view1.frame.size.width-12, 1)];
    label5.backgroundColor=[UIColor lightGrayColor];
    [view1 addSubview:label5];
    
    
    
    UIButton *Notificationsbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, label5.frame.origin.y+label5.frame.size.height+2, view1.frame.size.width-50, 30)];
    [Notificationsbutt setTitle:@"إعلام" forState:UIControlStateNormal];
    Notificationsbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [Notificationsbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Notificationsbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Notificationsbutt addTarget:self action:@selector(NotificationClicked:) forControlEvents:UIControlEventTouchUpInside];
    Notificationsbutt.backgroundColor=[UIColor clearColor];
    [view1 addSubview:Notificationsbutt];
    
    UISwitch *switchcheck=[[UISwitch alloc]initWithFrame:CGRectMake(6,label5.frame.origin.y+label5.frame.size.height+2, 30, 30)];
    [switchcheck setOn:YES];
    [switchcheck addTarget:self action:@selector(switchIsChanged:)forControlEvents:UIControlEventValueChanged];
    [view1 addSubview:switchcheck];
    
    
    
    
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(5, view1.frame.size.height+view1.frame.origin.y+5, self.view.frame.size.width-10, 165)];
    view2.backgroundColor=[UIColor whiteColor];
    view2.layer.cornerRadius = 5;
    view2.clipsToBounds = YES;
    view2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view2.layer.borderWidth = 1.0f;
    [self.view addSubview:view2];
    
    UIButton *settingsbutt=[[UIButton alloc]initWithFrame:CGRectMake(30, 1, view2.frame.size.width-40, 30)];
    [settingsbutt setTitle:@"إعدادات" forState:UIControlStateNormal];
    settingsbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [settingsbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    settingsbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [settingsbutt addTarget:self action:@selector(SettingsClicked:) forControlEvents:UIControlEventTouchUpInside];
    settingsbutt.backgroundColor=[UIColor clearColor];
    [view2 addSubview:settingsbutt];
    
    UIImageView *image6=[[UIImageView alloc]initWithFrame:CGRectMake(6, 8, 16, 16)];
    image6.image=[UIImage imageNamed:@"left.png"];
    [view2 addSubview:image6];
    
    UILabel *label6=[[UILabel alloc] initWithFrame:CGRectMake(6, settingsbutt.frame.origin.y+settingsbutt.frame.size.height+1, view2.frame.size.width-12, 1)];
    label6.backgroundColor=[UIColor lightGrayColor];
    [view2 addSubview:label6];
    
    
    
    UIButton *feedbackbutt=[[UIButton alloc]initWithFrame:CGRectMake(30, label6.frame.origin.y+label6.frame.size.height+1, view2.frame.size.width-40, 30)];
    [feedbackbutt setTitle:@"ردود الفعل" forState:UIControlStateNormal];
    feedbackbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [feedbackbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    feedbackbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [feedbackbutt addTarget:self action:@selector(feedbackClicked:) forControlEvents:UIControlEventTouchUpInside];
    feedbackbutt.backgroundColor=[UIColor clearColor];
    [view2 addSubview:feedbackbutt];
    
    UIImageView *image7=[[UIImageView alloc]initWithFrame:CGRectMake(6,label6.frame.origin.y+label6.frame.size.height+9, 16, 16)];
    image7.image=[UIImage imageNamed:@"left.png"];
    [view2 addSubview:image7];
    
    UILabel *label7=[[UILabel alloc] initWithFrame:CGRectMake(6, feedbackbutt.frame.origin.y+feedbackbutt.frame.size.height+1, view2.frame.size.width-12, 1)];
    label7.backgroundColor=[UIColor lightGrayColor];
    [view2 addSubview:label7];
    
    
    
    UIButton *ContactUsbutt=[[UIButton alloc]initWithFrame:CGRectMake(30, label7.frame.origin.y+label7.frame.size.height+1, view2.frame.size.width-40, 30)];
    [ContactUsbutt setTitle:@"اتصل بنا" forState:UIControlStateNormal];
    ContactUsbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [ContactUsbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ContactUsbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [ContactUsbutt addTarget:self action:@selector(ContactUsClicked:) forControlEvents:UIControlEventTouchUpInside];
    ContactUsbutt.backgroundColor=[UIColor clearColor];
    [view2 addSubview:ContactUsbutt];
    
    UIImageView *image8=[[UIImageView alloc]initWithFrame:CGRectMake(6,label7.frame.origin.y+label7.frame.size.height+9, 16, 16)];
    image8.image=[UIImage imageNamed:@"left.png"];
    [view2 addSubview:image8];
    
    UILabel *label8=[[UILabel alloc] initWithFrame:CGRectMake(6, ContactUsbutt.frame.origin.y+ContactUsbutt.frame.size.height+1, view2.frame.size.width-12, 1)];
    label8.backgroundColor=[UIColor lightGrayColor];
    [view2 addSubview:label8];
    
    
    
    UIButton *RateUsbutt=[[UIButton alloc]initWithFrame:CGRectMake(30, label8.frame.origin.y+label8.frame.size.height+1, view2.frame.size.width-40, 30)];
    [RateUsbutt setTitle:@"قيمنا" forState:UIControlStateNormal];
    RateUsbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [RateUsbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    RateUsbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [RateUsbutt addTarget:self action:@selector(RateUsClicked:) forControlEvents:UIControlEventTouchUpInside];
    RateUsbutt.backgroundColor=[UIColor clearColor];
    [view2 addSubview:RateUsbutt];
    
    UIImageView *image9=[[UIImageView alloc]initWithFrame:CGRectMake(6,label8.frame.origin.y+label8.frame.size.height+9, 16, 16)];
    image9.image=[UIImage imageNamed:@"left.png"];
    [view2 addSubview:image9];
    
    UILabel *label9=[[UILabel alloc] initWithFrame:CGRectMake(6, RateUsbutt.frame.origin.y+RateUsbutt.frame.size.height+1, view2.frame.size.width-12, 1)];
    label9.backgroundColor=[UIColor lightGrayColor];
    [view2 addSubview:label9];
    
    
    
    UIButton *Sharebutt=[[UIButton alloc]initWithFrame:CGRectMake(30, label9.frame.origin.y+label9.frame.size.height+1, view2.frame.size.width-40, 30)];
    [Sharebutt setTitle:@"شارك" forState:UIControlStateNormal];
    Sharebutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [Sharebutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Sharebutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Sharebutt addTarget:self action:@selector(ShareClicked:) forControlEvents:UIControlEventTouchUpInside];
    Sharebutt.backgroundColor=[UIColor clearColor];
    [view2 addSubview:Sharebutt];
    
    UIImageView *image10=[[UIImageView alloc]initWithFrame:CGRectMake(6,label9.frame.origin.y+label9.frame.size.height+9, 16, 16)];
    image10.image=[UIImage imageNamed:@"left.png"];
    [view2 addSubview:image10];
    
    UILabel *label10=[[UILabel alloc] initWithFrame:CGRectMake(6, Sharebutt.frame.origin.y+Sharebutt.frame.size.height+1, view2.frame.size.width-12, 1)];
    label10.backgroundColor=[UIColor lightGrayColor];
    [view2 addSubview:label10];
}

-(IBAction)languagebuttClicked:(id)sender
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-62, 300, 134)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(footerview.frame.size.width-150, 0, 140, 40)];
    lab.text=@"Change language";
    lab.textColor=[UIColor blackColor];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentRight;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UIButton *butt11=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, 50, 40)];
    [butt11 setTitle:@"Cancel" forState:UIControlStateNormal];
    butt11.titleLabel.font = [UIFont systemFontOfSize:15];
    butt11.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [butt11 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt11 addTarget:self action:@selector(Cancelclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt11];
    
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(1, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width-2, 1)];
    labeunder.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:labeunder];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(15,labeunder.frame.origin.y+5,footerview.frame.size.width-30,40)];
    [butt setTitle:@"English" forState:UIControlStateNormal];
    butt.titleLabel.font = [UIFont systemFontOfSize:15];
    butt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(Englishbutnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(15, butt.frame.origin.y+butt.frame.size.height+2, footerview.frame.size.width-30, 40)];
    [butt1 setTitle:@"العربية" forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont systemFontOfSize:15];
    butt1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [butt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt1 addTarget:self action:@selector(Arabicbutnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt1];
    
}

-(IBAction)Englishbutnclicked:(id)sender
{
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"City"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"CityId"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pathid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"first"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pathid1"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    
    labellanguage.text=@"English";
    [footerview removeFromSuperview];
    popview.hidden = YES;
    
    [[NSUserDefaults standardUserDefaults]setObject:labellanguage.text forKey:@"language"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"en" forKey:@"languageapi"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"english"];
    [self.window makeKeyAndVisible];
}

-(IBAction)Arabicbutnclicked:(id)sender
{
    labellanguage.text=@"العربية";
    [footerview removeFromSuperview];
    popview.hidden = YES;
    
    [[NSUserDefaults standardUserDefaults]setObject:@"Arabic" forKey:@"language"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"ar" forKey:@"languageapi"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
//    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainArabic" bundle:nil];
//    UITabBarController *tbc = [storyboard instantiateViewControllerWithIdentifier:@"arabic"];
//    self.window.rootViewController = tbc;
//    tbc.selectedIndex=4;
//    [self.window makeKeyAndVisible];
}


-(IBAction)addsnearbyClicked:(id)sender
{
    
    
    
}


-(IBAction)RecentlyViewAdsClicked:(id)sender
{
    
    
    
}


-(IBAction)PopularinyourAreaClicked:(id)sender
{
    
    
    
}


-(IBAction)ClearSearchHistoryClicked:(id)sender
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-62, 300, 134)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-50, 40)];
    lab.text=@"Clear Search History";
    lab.textColor=[UIColor blackColor];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentLeft+10;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UIButton *butt11=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60, 0, 50, 40)];
    [butt11 setTitle:@"Cancel" forState:UIControlStateNormal];
    butt11.titleLabel.font = [UIFont systemFontOfSize:15];
    butt11.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [butt11 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt11 addTarget:self action:@selector(Cancelclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt11];
    
    
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(1, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width-2, 1)];
    labeunder.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:labeunder];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(14,labeunder.frame.origin.y+5,footerview.frame.size.width-30,40)];
    [butt setTitle:@"Yes" forState:UIControlStateNormal];
    butt.titleLabel.font = [UIFont systemFontOfSize:15];
    butt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(Yesclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(15, butt.frame.origin.y+butt.frame.size.height+2, footerview.frame.size.width-30, 40)];
    [butt1 setTitle:@"No" forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont systemFontOfSize:15];
    butt1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [butt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt1 addTarget:self action:@selector(Noclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt1];
}

-(IBAction)Cancelclicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}



-(IBAction)Yesclicked:(id)sender
{
    [request showMessage:@"Yes Clicked" withTitle:@"Message"];
    [footerview removeFromSuperview];
    popview.hidden = YES;
    
}

-(IBAction)Noclicked:(id)sender
{
    [request showMessage:@"No Clicked" withTitle:@"Message"];
    [footerview removeFromSuperview];
    popview.hidden = YES;
}




-(IBAction)NotificationClicked:(id)sender
{
    
    
    
}



- (void) switchIsChanged:(UISwitch *)paramSender
{
    if ([paramSender isOn])
    {
        NSLog(@"The switch is turned on.");
    }
    else {
        NSLog(@"The switch is turned off.");
    }
}


-(IBAction)SettingsClicked:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"userid"];
    
    if(object != nil)
    {
        SettingArabicViewController *svc=[self.storyboard instantiateViewControllerWithIdentifier:@"SettingArabicViewController"];
        svc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    else
    {
        [request showMessage:@"You are not login into the BoxBazar account" withTitle:@"Ooops.."];
    }
}


-(IBAction)feedbackClicked:(id)sender
{
    
    
    
}

-(IBAction)ContactUsClicked:(id)sender
{
    
    
    
}


-(IBAction)RateUsClicked:(id)sender
{
    
    
    
}

-(IBAction)ShareClicked:(id)sender
{
    
    
    
}




-(void)viewDidDisappear:(BOOL)animated
{
    self.title = @"";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
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
