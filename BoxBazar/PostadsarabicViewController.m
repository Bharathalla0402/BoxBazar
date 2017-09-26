//
//  PostadsarabicViewController.m
//  BoxBazar
//
//  Created by bharat on 16/12/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "PostadsarabicViewController.h"
#import "ApiRequest.h"
#import "DejalActivityView.h"
#import "BoxBazarUrl.pch"
#import "ACFloatingTextField.h"
#import "ORGArticleCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "PickArabicViewController.h"

@interface PostadsarabicViewController ()<ApiRequestdelegate,UITextFieldDelegate,UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
    
    UIAlertView *exitalert;
    ApiRequest *requested;
    UIScrollView *scrollMainView;
    UIScrollView *Scrollview;
    
    
    
    int m;
    UIImage *currentSelectedImage;
    UIImageView *Profileimage;
    
    
    UIView *view1,*motorView,*PropertyonRentView,*coverphotoview,*view2,*view3,*view4,*view5;
    UIButton *button1,*button2,*button3,*button4,*button5,*button6,*button7;
    NSString *straccount,*strowners,*strsellingoptions;
    
    BOOL showPlaceHolder;
    UITextView *txtadDesc;
    UITextField *txtadtitle,*color;
    UILabel *brandname,*FuelType,*YearofReg,*kmsDriven,*price,*insuranceValid;
    
    UIView *popview;
    UIView *footerview;
    UIView *popview1;
    UIView *footerview1;
    UIDatePicker *datePicker;
    
    UIView *CommonView3;
    UILabel *city,*locality,*name,*email,*mobile,*pluslabel;
    // UITextField *txtcity,*txtlocality,*txtName,*txtemail,*txtccode,*txtmobile;
    ACFloatingTextField *txtlocality,*txtName,*txtemail,*txtmobile;
    
    UIButton *buttonj1,*buttonj2,*ChoosefileAdbutt;
    NSString *strjobOption;
    UITextField *CompanyName;
    UILabel *Role,*education,*experience,*compensation,*nofilelab;
    UIImageView *imagej;
    UIButton *rolebutt1,*rolebutt,*educationbutt,*educationbutt1,*experiencebutt,*experiencebutt1,*compensationbutt,*compensationbutt1,*willingtolocate;
    
    
    UIButton *buttonpr1,*buttonpr2,*buttonpr3,*buttonpr4,*buttonpr5;
    NSString *strwanttogive,*strindiviself;
    UILabel *labP1,*labP2;
    UITextField *txtprice,*txtareasquare;
    UILabel *noofroomslab,*furnishedlab;
    NSString *strsellerbuyer;
    
    NSArray *arrfueltype;
    NSArray *arrfueltype1;
    
    NSMutableArray *DataMotorOptions,*DataOtherOptions;
    UIView *viewdas5;
    BOOL condition;
    //  UILabel *lbltitle;
    
    ACFloatingTextField *lbltitle;
    ACFloatingTextField *txtmake,*txtModel,*txtyear,*txtCarprice,*txtKilometer;
    NSString *strid;
    NSMutableArray *DataCarMakeArray,*DataCarModelArray;
    
    IBOutlet UITableView *tabl;
    UITableViewCell *cells,*cells2;
    int b;
    NSString *stridforpost;
    NSString *strSubModule,*strmakeid,*strmodelid,*strlocalityid,*strsubCategoryid,*strsubCategoryid2,*strsubCategoryid3,*strsubCategoryid4,*strsubCategoryname,*strsubCategoryname2,*strsubCategoryname3,*strsubCategoryname4;
    
    UILabel *Categorytypeunderlinelab8;
    UICollectionView *_collectionView;
    
    NSMutableArray *arrimages;
    NSMutableArray *arrlocations;
    NSMutableArray *arrurls;
    NSMutableArray *arrlocalitylist;
    NSString *strUploadPic,*jsonStringValues,*jsonStringOptions,*strCoverPhoto;
    ORGArticleCollectionViewCell *cell,*cell1;
    UIImageView *CoverPhotoImage;
    UILabel *chooselab;
    
    NSMutableDictionary *carpostdict;
    NSMutableDictionary *carpostvalue;
    
    
    
    ACFloatingTextField *txtSubCate,*txtsubCate2,*txtsubCate3,*txtsubCate4;
    NSMutableArray *arrsubcatlist,*arrsubcatlist2,*arrsubcatlist3;
    UIButton *MotorPostAdbutt,*MotorPostAdbutt2;
    //  NSString *strCategoryIdForPost;
    
    NSString *strusername,*strusemobile,*struseremail;}


@end


typedef enum{
    
    buttontag1= 0,
    imageTAg = 100
    
}buttontag;

@implementation PostadsarabicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"latlong"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    CoverPhotoImage.contentMode = UIViewContentModeScaleAspectFill;
    [CoverPhotoImage setClipsToBounds:YES];
    
    self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0]];
    DataMotorOptions=[[NSMutableArray alloc]init];
    
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user=%@",BaseUrl,strtoken,userProfile,arabic,strCityId,struseridnum];
    [requested CitysRequest:nil withUrl:strurl];
    
    arrimages=[[NSMutableArray alloc]init];
    arrlocations=[[NSMutableArray alloc]init];
    arrurls=[[NSMutableArray alloc]init];
    carpostdict=[[NSMutableDictionary alloc]init];
    DataCarMakeArray=[[NSMutableArray alloc]init];
    DataCarModelArray=[[NSMutableArray alloc]init];
    arrlocalitylist=[[NSMutableArray alloc]init];
    
    arrsubcatlist=[[NSMutableArray alloc]init];
    arrsubcatlist2=[[NSMutableArray alloc]init];
    arrsubcatlist3=[[NSMutableArray alloc]init];
    DataOtherOptions=[[NSMutableArray alloc]init];
    
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
    //
    //                                   initWithTarget:self
    //
    //                                   action:@selector(dismissKeyboard)];
    //
    //    [self.view addGestureRecognizer:tap];
    
    
    [self setupAlertCtrl];
    [self moreaction];

}

-(void)responsewithCitylist:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=[responseDict objectForKey:@"data"];
    NSLog(@"Profile Response: %@",responseDictionary);
    NSString *strname=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"firstname"]];
    strusername=strname;
    strusemobile=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"mobile"]];
    struseremail=[responseDictionary valueForKey:@"email"];
    
    NSLog(@"Name: %@",strusername);
    NSLog(@"Mobile: %@",strusemobile);
    NSLog(@"Email: %@",struseremail);
}

-(void)moreaction
{
    UIView *topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    topview.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [self.view addSubview:topview];
    
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(10, topview.frame.size.height/2-8, topview.frame.size.width-20, 30)];
    titlelabel.text=@"Post Ad";
    titlelabel.textAlignment=NSTextAlignmentCenter;
    [titlelabel setFont:[UIFont boldSystemFontOfSize:15]];
    titlelabel.textColor=[UIColor whiteColor];
    [topview addSubview:titlelabel];
    
    
    UIButton *Backbutt=[[UIButton alloc] initWithFrame:CGRectMake(topview.frame.size.width-35, topview.frame.size.height/2-5, 25, 25)];
    [Backbutt setImage:[UIImage imageNamed:@"rightar.png"] forState:UIControlStateNormal];
    Backbutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [Backbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Backbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Backbutt addTarget:self action:@selector(BackbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt];
    
    UIButton *Backbutt2=[[UIButton alloc] initWithFrame:CGRectMake(topview.frame.size.width-70, 5, 60, 60)];
    [Backbutt2 addTarget:self action:@selector(BackbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt2.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt2];
    
    scrollMainView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:scrollMainView];
    
    UILabel *CategeoryDetaillab=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.view.frame.size.width-20, 30)];
    CategeoryDetaillab.text=@"Category Detail";
    CategeoryDetaillab.textAlignment=NSTextAlignmentRight;
    [CategeoryDetaillab setFont:[UIFont systemFontOfSize:15]];
    CategeoryDetaillab.textColor=[UIColor blackColor];
    [scrollMainView addSubview:CategeoryDetaillab];

    
    view1=[[UIView alloc]initWithFrame:CGRectMake(0, CategeoryDetaillab.frame.origin.y+CategeoryDetaillab.frame.size.height+5, self.view.frame.size.width, 100)];
    view1.backgroundColor=[UIColor whiteColor];
    [scrollMainView addSubview:view1];
    
    UILabel *Categorytypelab=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, view1.frame.size.width-20, 15)];
    Categorytypelab.text=@"Category";
    Categorytypelab.textAlignment=NSTextAlignmentRight;
    [Categorytypelab setFont:[UIFont systemFontOfSize:13]];
    Categorytypelab.textColor=[UIColor lightGrayColor];
    [view1 addSubview:Categorytypelab];
    
    UILabel *Categorytypelabtext=[[UILabel alloc]initWithFrame:CGRectMake(10, 25, view1.frame.size.width-20, 15)];
    Categorytypelabtext.text=_strCategeory;
    Categorytypelabtext.textAlignment=NSTextAlignmentRight;
    [Categorytypelabtext setFont:[UIFont systemFontOfSize:15]];
    Categorytypelabtext.textColor=[UIColor blackColor];
    [view1 addSubview:Categorytypelabtext];
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 24,16, 16)];
    image1.image=[UIImage imageNamed:@"left.png"];
    [view1 addSubview:image1];
    
    UILabel *Categorytypeunderlinelab=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, view1.frame.size.width-20, 1)];
    Categorytypeunderlinelab.backgroundColor=[UIColor lightGrayColor];
    [view1 addSubview:Categorytypeunderlinelab];
    
    
    UILabel *Categorysubtypelab=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab.frame.origin.y+Categorytypeunderlinelab.frame.size.height+5, view1.frame.size.width-20, 15)];
    Categorysubtypelab.text=@"Sub Category";
    Categorysubtypelab.textAlignment=NSTextAlignmentRight;
    [Categorysubtypelab setFont:[UIFont systemFontOfSize:13]];
    Categorysubtypelab.textColor=[UIColor lightGrayColor];
    [view1 addSubview:Categorysubtypelab];
    
    UILabel *CategorySubtypelabtext=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab.frame.origin.y+Categorytypeunderlinelab.frame.size.height+25, view1.frame.size.width-20, 15)];
    CategorySubtypelabtext.text=_strcategeoryType;
    CategorySubtypelabtext.textAlignment=NSTextAlignmentRight;
    [CategorySubtypelabtext setFont:[UIFont systemFontOfSize:15]];
    CategorySubtypelabtext.textColor=[UIColor blackColor];
    [view1 addSubview:CategorySubtypelabtext];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab.frame.origin.y+Categorytypeunderlinelab.frame.size.height+24,16, 16)];
    image2.image=[UIImage imageNamed:@"left.png"];
    [view1 addSubview:image2];
    
    
    
    [self categeorylistwiseviews];
}

#pragma mark - Categeory list

-(void)categeorylistwiseviews
{
    if ([_strCategeory isEqualToString:@"المحركات"])
    {
        if ([_strcategeoryTypeurl_parameter isEqualToString:@"car"])
        {
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,caroption,arabic,strCityId];
            [requested motorsMakeRequest:nil withUrl:strurl];
        }
        else
        {
            if ([_strmessage isEqualToString:@"0"])
            {
                [self subcategoryOptionlist];
            }
            else
            {
                [self subcategorylist];
            }
        }
    }
    else
    {
        if ([_strmessage isEqualToString:@"0"])
        {
            [self subcategoryOptionlist];
        }
        else
        {
            [self subcategorylist];
        }
    }
}


#pragma mark - Data Not Found list

-(void)subcategoryOptionlist
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&category=%@",BaseUrl,strtoken,CategoryOption,arabic,strCityId,_strcategeoryTypeurl_parameter,strsubCategoryid];
    [requested emptyCategoryOptionRequest:nil withUrl:strurl];
    
//    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
//    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
//    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
//    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@",BaseUrl,strtoken,Option,arabic,strCityId,_strcategeoryTypeurl_parameter];
//    [requested emptyOptionRequest:nil withUrl:strurl];
}

-(void)emptyresponseCategoryOption:(NSMutableDictionary *)responseDict
{
    NSLog(@"Response Empty Category Option:%@",responseDict);
    
    NSString *message=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([message isEqualToString:@"0"])
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@",BaseUrl,strtoken,Option,arabic,strCityId,_strcategeoryTypeurl_parameter];
        [requested emptyOptionRequest:nil withUrl:strurl];
    }
    else
    {
        NSArray *arrdata=[responseDict valueForKey:@"data"];
        NSString *strdata=[arrdata componentsJoinedByString:@","];
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&optionId=%@",BaseUrl,strtoken,Option,arabic,strCityId,_strcategeoryTypeurl_parameter,strdata];
        [requested emptyOptionRequest:nil withUrl:strurl];
    }
}


-(void)emptyresponseOption:(NSMutableDictionary *)responseDict
{
    
    NSLog(@"Option list Response: %@",responseDict);
    
    DataMotorOptions=[responseDict valueForKey:@"data"];
    
    if ([_strCategeoryUrlparameter isEqualToString:@"community"])
    {
        motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view1.frame.origin.y+view1.frame.size.height+15, self.view.frame.size.width, 400+(DataMotorOptions.count*50))];
        motorView.backgroundColor=[UIColor whiteColor];
        [scrollMainView addSubview:motorView];
        
        [self commonview2community];
        [self commonView3];
        
        MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
        [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
        MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        MotorPostAdbutt.layer.cornerRadius = 19;
        MotorPostAdbutt.clipsToBounds = YES;
        [MotorPostAdbutt addTarget:self action:@selector(CommunityPostButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
        MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
        [scrollMainView addSubview:MotorPostAdbutt];
        
        scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 832+(DataMotorOptions.count*50));
    }
    else if ([_strCategeoryUrlparameter isEqualToString:@"jobs"])
    {
        
        if ([_strcategeoryTypeid isEqualToString:[NSString stringWithFormat:@"%@",@"1"]])
        {
            motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view1.frame.origin.y+view1.frame.size.height+15, self.view.frame.size.width, 400+(DataMotorOptions.count*50))];
            motorView.backgroundColor=[UIColor whiteColor];
            [scrollMainView addSubview:motorView];
            
            [self commonview2community];
            [self commonView3];
            
            MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
            [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
            MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            MotorPostAdbutt.layer.cornerRadius = 19;
            MotorPostAdbutt.clipsToBounds = YES;
            [MotorPostAdbutt addTarget:self action:@selector(CommunityPostButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
            MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
            [scrollMainView addSubview:MotorPostAdbutt];
            
            scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 832+(DataMotorOptions.count*50));
            
        }
        else
        {
            motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view1.frame.origin.y+view1.frame.size.height+15, self.view.frame.size.width, 500+(DataMotorOptions.count*50))];
            motorView.backgroundColor=[UIColor whiteColor];
            [scrollMainView addSubview:motorView];
            
            [self commonview2Job];
            [self commonView3];
            
            MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
            [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
            MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            MotorPostAdbutt.layer.cornerRadius = 19;
            MotorPostAdbutt.clipsToBounds = YES;
            [MotorPostAdbutt addTarget:self action:@selector(JobPostButtClicked:) forControlEvents:UIControlEventTouchUpInside];
            MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
            [scrollMainView addSubview:MotorPostAdbutt];
            
            scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 932+(DataMotorOptions.count*50));
            
        }
    }
    else
    {
        motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view1.frame.origin.y+view1.frame.size.height+15, self.view.frame.size.width, 450+(DataMotorOptions.count*50))];
        motorView.backgroundColor=[UIColor whiteColor];
        [scrollMainView addSubview:motorView];
        
        [self commonview2];
        [self commonView3];
        
        MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
        [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
        MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        MotorPostAdbutt.layer.cornerRadius = 19;
        MotorPostAdbutt.clipsToBounds = YES;
        [MotorPostAdbutt addTarget:self action:@selector(MotorPostButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
        MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
        [scrollMainView addSubview:MotorPostAdbutt];
        
        scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 882+(DataMotorOptions.count*50));
    }
}



#pragma mark - Sub Categeory list

-(void)subcategorylist
{
    view2=[[UIView alloc]initWithFrame:CGRectMake(0, view1.frame.size.height+view1.frame.origin.y, self.view.frame.size.width, 55)];
    view2.backgroundColor=[UIColor whiteColor];
    [scrollMainView addSubview:view2];
    
    UILabel *Categorytypeunderlinelab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, view2.frame.size.width-20, 1)];
    Categorytypeunderlinelab.backgroundColor=[UIColor lightGrayColor];
    [view2 addSubview:Categorytypeunderlinelab];
    
    txtSubCate=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, 8, view2.frame.size.width-20, 45)];
    [txtSubCate setTextFieldPlaceholderText:[NSString stringWithFormat:@"Select SubCategory of %@",_strcategeoryType]];
    txtSubCate.textColor=[UIColor blackColor];
    txtSubCate.delegate=self;
    txtSubCate.btmLineColor = [UIColor lightGrayColor];
    txtSubCate.textAlignment=NSTextAlignmentRight;
    [txtSubCate setFont:[UIFont systemFontOfSize:15]];
    txtSubCate.textColor=[UIColor blackColor];
    [view2 addSubview:txtSubCate];
    
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 27,16, 16)];
    image2.image=[UIImage imageNamed:@"left.png"];
    [view2 addSubview:image2];
    
    UIButton *subcatButt=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, view2.frame.size.width-20, 45)];
    [subcatButt addTarget:self action:@selector(SubCatClicked:) forControlEvents:UIControlEventTouchUpInside];
    subcatButt.backgroundColor=[UIColor clearColor];
    [view2 addSubview:subcatButt];
}

-(IBAction)SubCatClicked:(id)sender
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-200, 300, 400)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-50, 40)];
    lab.text=@"Select Categeory";
    lab.textColor=[UIColor blackColor];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentLeft+10;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60, 0, 50, 40)];
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
    tabl.frame = CGRectMake(0,labeunder.frame.origin.y+labeunder.frame.size.height+10, footerview.frame.size.width, 357);
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.tag=4;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    // [tabl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [footerview addSubview:tabl];
}




-(void)responseCategoryOption:(NSMutableDictionary *)responseDict
{
    NSLog(@" Category Option Response : %@",responseDict);
    
    NSString *message=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([message isEqualToString:@"0"])
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@",BaseUrl,strtoken,Option,arabic,strCityId,_strcategeoryTypeurl_parameter];
        [requested OptionRequest:nil withUrl:strurl];
    }
    else
    {
        NSArray *arrdata=[responseDict valueForKey:@"data"];
        NSString *strdata=[arrdata componentsJoinedByString:@","];
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&optionId=%@",BaseUrl,strtoken,Option,arabic,strCityId,_strcategeoryTypeurl_parameter,strdata];
        [requested OptionRequest:nil withUrl:strurl];
    }
}

-(void)responseOption:(NSMutableDictionary *)responseDict
{
    
    NSLog(@"Option list Response: %@",responseDict);
    
    DataMotorOptions=[responseDict valueForKey:@"data"];
    
    if ([_strCategeoryUrlparameter isEqualToString:@"community"])
    {
        motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view2.frame.origin.y+view2.frame.size.height+15, self.view.frame.size.width, 400+(DataMotorOptions.count*50))];
        motorView.backgroundColor=[UIColor whiteColor];
        [scrollMainView addSubview:motorView];
        
        [self commonview2community];
        [self commonView3];
        
        MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
        [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
        MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        MotorPostAdbutt.layer.cornerRadius = 19;
        MotorPostAdbutt.clipsToBounds = YES;
        [MotorPostAdbutt addTarget:self action:@selector(CommunityPostButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
        MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
        [scrollMainView addSubview:MotorPostAdbutt];
        
        scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 882+(DataMotorOptions.count*50));
    }
    else if ([_strCategeoryUrlparameter isEqualToString:@"jobs"])
    {
        
        if ([_strcategeoryTypeid isEqualToString:[NSString stringWithFormat:@"%@",@"1"]])
        {
            motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view2.frame.origin.y+view2.frame.size.height+15, self.view.frame.size.width, 400+(DataMotorOptions.count*50))];
            motorView.backgroundColor=[UIColor whiteColor];
            [scrollMainView addSubview:motorView];
            
            [self commonview2community];
            [self commonView3];
            
            MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
            [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
            MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            MotorPostAdbutt.layer.cornerRadius = 19;
            MotorPostAdbutt.clipsToBounds = YES;
            [MotorPostAdbutt addTarget:self action:@selector(CommunityPostButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
            MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
            [scrollMainView addSubview:MotorPostAdbutt];
            
            scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 882+(DataMotorOptions.count*50));
        }
        else
        {
            motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view2.frame.origin.y+view2.frame.size.height+15, self.view.frame.size.width, 500+(DataMotorOptions.count*50))];
            motorView.backgroundColor=[UIColor whiteColor];
            [scrollMainView addSubview:motorView];
            
            [self commonview2Job];
            [self commonView3];
            
            MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
            [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
            MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            MotorPostAdbutt.layer.cornerRadius = 19;
            MotorPostAdbutt.clipsToBounds = YES;
            [MotorPostAdbutt addTarget:self action:@selector(JobPostButtClicked:) forControlEvents:UIControlEventTouchUpInside];
            MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
            [scrollMainView addSubview:MotorPostAdbutt];
            
            scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 982+(DataMotorOptions.count*50));
        }
        
    }
    else
    {
        motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view2.frame.origin.y+view2.frame.size.height+15, self.view.frame.size.width, 450+(DataMotorOptions.count*50))];
        motorView.backgroundColor=[UIColor whiteColor];
        [scrollMainView addSubview:motorView];
        
        [self commonview2];
        [self commonView3];
        
        MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
        [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
        MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        MotorPostAdbutt.layer.cornerRadius = 19;
        MotorPostAdbutt.clipsToBounds = YES;
        [MotorPostAdbutt addTarget:self action:@selector(MotorPostButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
        MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
        [scrollMainView addSubview:MotorPostAdbutt];
        
        scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 932+(DataMotorOptions.count*50));
    }
}

-(void)responseSubCategory:(NSMutableDictionary *)responseDict
{
    
    NSLog(@"Sub Categeory list Response: %@",responseDict);
    
    arrsubcatlist=[responseDict valueForKey:@"data"];
    
    view3=[[UIView alloc]initWithFrame:CGRectMake(0, view2.frame.size.height+view2.frame.origin.y, self.view.frame.size.width, 55)];
    view3.backgroundColor=[UIColor whiteColor];
    [scrollMainView addSubview:view3];
    
    txtsubCate2=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, 8, view3.frame.size.width-20, 45)];
    [txtsubCate2 setTextFieldPlaceholderText:[NSString stringWithFormat:@"Select SubCategory of %@",strsubCategoryname]];
    txtsubCate2.textColor=[UIColor blackColor];
    txtsubCate2.delegate=self;
    txtsubCate2.textAlignment=NSTextAlignmentRight;
    txtsubCate2.btmLineColor = [UIColor lightGrayColor];
    [txtsubCate2 setFont:[UIFont systemFontOfSize:15]];
    txtsubCate2.textColor=[UIColor blackColor];
    [view3 addSubview:txtsubCate2];
    
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 27,16, 16)];
    image2.image=[UIImage imageNamed:@"left.png"];
    [view3 addSubview:image2];
    
    UIButton *subcatButt=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, view3.frame.size.width-20, 45)];
    [subcatButt addTarget:self action:@selector(SubCatClicked2:) forControlEvents:UIControlEventTouchUpInside];
    subcatButt.backgroundColor=[UIColor clearColor];
    [view3 addSubview:subcatButt];
}




#pragma mark -Subcategory2 Clicked

-(IBAction)SubCatClicked2:(id)sender
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-200, 300, 400)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-50, 40)];
    lab.text=@"Select Categeory";
    lab.textColor=[UIColor blackColor];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentLeft+10;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60, 0, 50, 40)];
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
    tabl.frame = CGRectMake(0,labeunder.frame.origin.y+labeunder.frame.size.height+10, footerview.frame.size.width, 357);
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.tag=5;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //  [tabl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [footerview addSubview:tabl];
}





-(void)responseCategoryOption2:(NSMutableDictionary *)responseDict
{
    NSLog(@" Category Option Response : %@",responseDict);
    
    NSString *message=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([message isEqualToString:@"0"])
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@",BaseUrl,strtoken,Option,arabic,strCityId,_strcategeoryTypeurl_parameter];
        [requested OptionRequest2:nil withUrl:strurl];
    }
    else
    {
        NSArray *arrdata=[responseDict valueForKey:@"data"];
        NSString *strdata=[arrdata componentsJoinedByString:@","];
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&optionId=%@",BaseUrl,strtoken,Option,arabic,strCityId,_strcategeoryTypeurl_parameter,strdata];
        [requested OptionRequest2:nil withUrl:strurl];
    }
}

-(void)responseOption2:(NSMutableDictionary *)responseDict
{
    
    NSLog(@"Option list Response: %@",responseDict);
    
    DataMotorOptions=[responseDict valueForKey:@"data"];
    
    if ([_strCategeoryUrlparameter isEqualToString:@"community"])
    {
        motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view3.frame.origin.y+view3.frame.size.height+15, self.view.frame.size.width, 400+(DataMotorOptions.count*50))];
        motorView.backgroundColor=[UIColor whiteColor];
        [scrollMainView addSubview:motorView];
        
        [self commonview2community];
        [self commonView3];
        
        MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
        [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
        MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        MotorPostAdbutt.layer.cornerRadius = 19;
        MotorPostAdbutt.clipsToBounds = YES;
        [MotorPostAdbutt addTarget:self action:@selector(CommunityPostButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
        MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
        [scrollMainView addSubview:MotorPostAdbutt];
        
        scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 932+(DataMotorOptions.count*50));
    }
    else if ([_strCategeoryUrlparameter isEqualToString:@"jobs"])
    {
        
        if ([_strcategeoryTypeid isEqualToString:[NSString stringWithFormat:@"%@",@"1"]])
        {
            motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view3.frame.origin.y+view3.frame.size.height+15, self.view.frame.size.width, 400+(DataMotorOptions.count*50))];
            motorView.backgroundColor=[UIColor whiteColor];
            [scrollMainView addSubview:motorView];
            
            [self commonview2community];
            [self commonView3];
            
            MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
            [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
            MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            MotorPostAdbutt.layer.cornerRadius = 19;
            MotorPostAdbutt.clipsToBounds = YES;
            [MotorPostAdbutt addTarget:self action:@selector(CommunityPostButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
            MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
            [scrollMainView addSubview:MotorPostAdbutt];
            
            scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 932+(DataMotorOptions.count*50));
        }
        else
        {
            motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view3.frame.origin.y+view3.frame.size.height+15, self.view.frame.size.width, 500+(DataMotorOptions.count*50))];
            motorView.backgroundColor=[UIColor whiteColor];
            [scrollMainView addSubview:motorView];
            
            [self commonview2Job];
            [self commonView3];
            
            MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
            [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
            MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            MotorPostAdbutt.layer.cornerRadius = 19;
            MotorPostAdbutt.clipsToBounds = YES;
            [MotorPostAdbutt addTarget:self action:@selector(JobPostButtClicked:) forControlEvents:UIControlEventTouchUpInside];
            MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
            [scrollMainView addSubview:MotorPostAdbutt];
            
            scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 1032+(DataMotorOptions.count*50));
        }
    }
    
    else
    {
        motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view3.frame.origin.y+view3.frame.size.height+15, self.view.frame.size.width, 450+(DataMotorOptions.count*50))];
        motorView.backgroundColor=[UIColor whiteColor];
        [scrollMainView addSubview:motorView];
        
        [self commonview2];
        [self commonView3];
        
        MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
        [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
        MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        MotorPostAdbutt.layer.cornerRadius = 19;
        MotorPostAdbutt.clipsToBounds = YES;
        [MotorPostAdbutt addTarget:self action:@selector(MotorPostButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
        MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
        [scrollMainView addSubview:MotorPostAdbutt];
        
        scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 982+(DataMotorOptions.count*50));
    }
}

-(void)responseSubCategory2:(NSMutableDictionary *)responseDict
{
    
    NSLog(@"Sub Categeory list Response: %@",responseDict);
    
    arrsubcatlist2=[responseDict valueForKey:@"data"];
    
    view4=[[UIView alloc]initWithFrame:CGRectMake(0, view3.frame.size.height+view3.frame.origin.y, self.view.frame.size.width, 55)];
    view4.backgroundColor=[UIColor whiteColor];
    [scrollMainView addSubview:view4];
    
    txtsubCate3=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, 8, view4.frame.size.width-20, 45)];
    [txtsubCate3 setTextFieldPlaceholderText:[NSString stringWithFormat:@"Select SubCategory of %@",strsubCategoryname2]];
    txtsubCate3.textColor=[UIColor blackColor];
    txtsubCate3.delegate=self;
    txtsubCate3.btmLineColor = [UIColor lightGrayColor];
    txtsubCate3.textAlignment=NSTextAlignmentRight;
    [txtsubCate3 setFont:[UIFont systemFontOfSize:15]];
    txtsubCate3.textColor=[UIColor blackColor];
    [view4 addSubview:txtsubCate3];
    
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 27,16, 16)];
    image2.image=[UIImage imageNamed:@"left.png"];
    [view4 addSubview:image2];
    
    UIButton *subcatButt=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, view4.frame.size.width-20, 50)];
    [subcatButt addTarget:self action:@selector(SubCatClicked3:) forControlEvents:UIControlEventTouchUpInside];
    subcatButt.backgroundColor=[UIColor clearColor];
    [view4 addSubview:subcatButt];
}

#pragma mark -Subcategory3 Clicked

-(IBAction)SubCatClicked3:(id)sender
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-200, 300, 400)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-50, 40)];
    lab.text=@"Select Categeory";
    lab.textColor=[UIColor blackColor];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentLeft+10;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60, 0, 50, 40)];
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
    tabl.frame = CGRectMake(0,labeunder.frame.origin.y+labeunder.frame.size.height+10, footerview.frame.size.width, 357);
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.tag=6;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //  [tabl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [footerview addSubview:tabl];
}

-(void)responseCategoryOption3:(NSMutableDictionary *)responseDict
{
    NSLog(@" Category Option Response : %@",responseDict);
    
    NSString *message=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([message isEqualToString:@"0"])
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@",BaseUrl,strtoken,Option,arabic,strCityId,_strcategeoryTypeurl_parameter];
        [requested OptionRequest3:nil withUrl:strurl];
    }
    else
    {
        NSArray *arrdata=[responseDict valueForKey:@"data"];
        NSString *strdata=[arrdata componentsJoinedByString:@","];
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&optionId=%@",BaseUrl,strtoken,Option,arabic,strCityId,_strcategeoryTypeurl_parameter,strdata];
        [requested OptionRequest3:nil withUrl:strurl];
    }
}

-(void)responseOption3:(NSMutableDictionary *)responseDict
{
    
    NSLog(@"Option list Response: %@",responseDict);
    
    DataMotorOptions=[responseDict valueForKey:@"data"];
    
    
    if ([_strCategeoryUrlparameter isEqualToString:@"community"])
    {
        motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view4.frame.origin.y+view4.frame.size.height+15, self.view.frame.size.width, 400+(DataMotorOptions.count*50))];
        motorView.backgroundColor=[UIColor whiteColor];
        [scrollMainView addSubview:motorView];
        
        [self commonview2community];
        [self commonView3];
        
        MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
        [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
        MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        MotorPostAdbutt.layer.cornerRadius = 19;
        MotorPostAdbutt.clipsToBounds = YES;
        [MotorPostAdbutt addTarget:self action:@selector(CommunityPostButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
        MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
        [scrollMainView addSubview:MotorPostAdbutt];
        
        scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 1042+(DataMotorOptions.count*50));
    }
    else if ([_strCategeoryUrlparameter isEqualToString:@"jobs"])
    {
        
        if ([_strcategeoryTypeid isEqualToString:[NSString stringWithFormat:@"%@",@"1"]])
        {
            motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view4.frame.origin.y+view4.frame.size.height+15, self.view.frame.size.width, 400+(DataMotorOptions.count*50))];
            motorView.backgroundColor=[UIColor whiteColor];
            [scrollMainView addSubview:motorView];
            
            [self commonview2community];
            [self commonView3];
            
            MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
            [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
            MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            MotorPostAdbutt.layer.cornerRadius = 19;
            MotorPostAdbutt.clipsToBounds = YES;
            [MotorPostAdbutt addTarget:self action:@selector(CommunityPostButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
            MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
            [scrollMainView addSubview:MotorPostAdbutt];
            
            scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 1042+(DataMotorOptions.count*50));
        }
        else
        {
            motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view4.frame.origin.y+view4.frame.size.height+15, self.view.frame.size.width, 500+(DataMotorOptions.count*50))];
            motorView.backgroundColor=[UIColor whiteColor];
            [scrollMainView addSubview:motorView];
            
            [self commonview2Job];
            [self commonView3];
            
            MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
            [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
            MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            MotorPostAdbutt.layer.cornerRadius = 19;
            MotorPostAdbutt.clipsToBounds = YES;
            [MotorPostAdbutt addTarget:self action:@selector(JobPostButtClicked:) forControlEvents:UIControlEventTouchUpInside];
            MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
            [scrollMainView addSubview:MotorPostAdbutt];
            
            scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 1142+(DataMotorOptions.count*50));
        }
        
    }
    else
    {
        
        motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view4.frame.origin.y+view4.frame.size.height+15, self.view.frame.size.width, 505+(DataMotorOptions.count*50))];
        motorView.backgroundColor=[UIColor whiteColor];
        [scrollMainView addSubview:motorView];
        
        [self commonview2];
        [self commonView3];
        
        MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
        [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
        MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        MotorPostAdbutt.layer.cornerRadius = 19;
        MotorPostAdbutt.clipsToBounds = YES;
        [MotorPostAdbutt addTarget:self action:@selector(MotorPostButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
        MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
        [scrollMainView addSubview:MotorPostAdbutt];
        
        scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 1092+(DataMotorOptions.count*50));
    }
}

-(void)responseSubCategory3:(NSMutableDictionary *)responseDict
{
    
    NSLog(@"Sub Categeory list Response: %@",responseDict);
    
    arrsubcatlist3=[responseDict valueForKey:@"data"];
    
    view5=[[UIView alloc]initWithFrame:CGRectMake(0, view4.frame.size.height+view4.frame.origin.y, self.view.frame.size.width, 55)];
    view5.backgroundColor=[UIColor whiteColor];
    [scrollMainView addSubview:view5];
    
    txtsubCate4=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, 8, view5.frame.size.width-20, 45)];
    [txtsubCate4 setTextFieldPlaceholderText:[NSString stringWithFormat:@"Select SubCategory of %@",strsubCategoryname3]];
    txtsubCate4.textColor=[UIColor blackColor];
    txtsubCate4.delegate=self;
    txtsubCate4.btmLineColor = [UIColor lightGrayColor];
    txtsubCate4.textAlignment=NSTextAlignmentRight;
    [txtsubCate4 setFont:[UIFont systemFontOfSize:15]];
    txtsubCate4.textColor=[UIColor blackColor];
    [view5 addSubview:txtsubCate4];
    
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 27,16, 16)];
    image2.image=[UIImage imageNamed:@"left.png"];
    [view5 addSubview:image2];
    
    UIButton *subcatButt=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, view5.frame.size.width-20, 50)];
    [subcatButt addTarget:self action:@selector(SubCatClicked4:) forControlEvents:UIControlEventTouchUpInside];
    subcatButt.backgroundColor=[UIColor clearColor];
    [view5 addSubview:subcatButt];
}


#pragma mark -Subcategory4 Clicked

-(IBAction)SubCatClicked4:(id)sender
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-200, 300, 400)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-50, 40)];
    lab.text=@"Select Categeory";
    lab.textColor=[UIColor blackColor];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentLeft+10;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60, 0, 50, 40)];
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
    tabl.frame = CGRectMake(0,labeunder.frame.origin.y+labeunder.frame.size.height+10, footerview.frame.size.width, 357);
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.tag=7;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //  [tabl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [footerview addSubview:tabl];
}

-(void)responseCategoryOption4:(NSMutableDictionary *)responseDict
{
    NSLog(@" Category Option Response : %@",responseDict);
    
    NSString *message=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([message isEqualToString:@"0"])
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@",BaseUrl,strtoken,Option,arabic,strCityId,_strcategeoryTypeurl_parameter];
        [requested OptionRequest4:nil withUrl:strurl];
    }
    else
    {
        NSArray *arrdata=[responseDict valueForKey:@"data"];
        NSString *strdata=[arrdata componentsJoinedByString:@","];
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&optionId=%@",BaseUrl,strtoken,Option,arabic,strCityId,_strcategeoryTypeurl_parameter,strdata];
        [requested OptionRequest4:nil withUrl:strurl];
    }
}

-(void)responseOption4:(NSMutableDictionary *)responseDict
{
    
    NSLog(@"Option list Response: %@",responseDict);
    
    DataMotorOptions=[responseDict valueForKey:@"data"];
    
    if ([_strCategeoryUrlparameter isEqualToString:@"community"])
    {
        motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view5.frame.origin.y+view5.frame.size.height+15, self.view.frame.size.width, 400+(DataMotorOptions.count*50))];
        motorView.backgroundColor=[UIColor whiteColor];
        [scrollMainView addSubview:motorView];
        
        [self commonview2community];
        [self commonView3];
        
        MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
        [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
        MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        MotorPostAdbutt.layer.cornerRadius = 19;
        MotorPostAdbutt.clipsToBounds = YES;
        [MotorPostAdbutt addTarget:self action:@selector(CommunityPostButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
        MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
        [scrollMainView addSubview:MotorPostAdbutt];
        
        scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 1092+(DataMotorOptions.count*50));
    }
    
    else if ([_strCategeoryUrlparameter isEqualToString:@"jobs"])
    {
        if ([_strcategeoryTypeid isEqualToString:[NSString stringWithFormat:@"%@",@"1"]])
        {
            motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view5.frame.origin.y+view5.frame.size.height+15, self.view.frame.size.width, 400+(DataMotorOptions.count*50))];
            motorView.backgroundColor=[UIColor whiteColor];
            [scrollMainView addSubview:motorView];
            
            [self commonview2community];
            [self commonView3];
            
            MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
            [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
            MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            MotorPostAdbutt.layer.cornerRadius = 19;
            MotorPostAdbutt.clipsToBounds = YES;
            [MotorPostAdbutt addTarget:self action:@selector(CommunityPostButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
            MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
            [scrollMainView addSubview:MotorPostAdbutt];
            
            scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 1092+(DataMotorOptions.count*50));
        }
        else
        {
            motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view5.frame.origin.y+view5.frame.size.height+15, self.view.frame.size.width, 500+(DataMotorOptions.count*50))];
            motorView.backgroundColor=[UIColor whiteColor];
            [scrollMainView addSubview:motorView];
            
            [self commonview2Job];
            [self commonView3];
            
            MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
            [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
            MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            MotorPostAdbutt.layer.cornerRadius = 19;
            MotorPostAdbutt.clipsToBounds = YES;
            [MotorPostAdbutt addTarget:self action:@selector(JobPostButtClicked:) forControlEvents:UIControlEventTouchUpInside];
            MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
            [scrollMainView addSubview:MotorPostAdbutt];
            
            scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 1192+(DataMotorOptions.count*50));
        }
    }
    
    else
    {
        motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view5.frame.origin.y+view5.frame.size.height+15, self.view.frame.size.width, 560+(DataMotorOptions.count*50))];
        motorView.backgroundColor=[UIColor whiteColor];
        [scrollMainView addSubview:motorView];
        
        [self commonview2];
        [self commonView3];
        
        MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
        [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
        MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        MotorPostAdbutt.layer.cornerRadius = 19;
        MotorPostAdbutt.clipsToBounds = YES;
        [MotorPostAdbutt addTarget:self action:@selector(MotorPostButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
        MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
        [scrollMainView addSubview:MotorPostAdbutt];
        
        scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 1142+(DataMotorOptions.count*50));
    }
}



#pragma mark - Motor Delegate Response for Car Category


-(void)responsewithDataMakeMotor:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Motor Model English Response: %@",responseDictionary);
    DataMotorOptions=[responseDictionary valueForKey:@"data"];
    
    motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view1.frame.origin.y+view1.frame.size.height+15, self.view.frame.size.width, 710+(DataMotorOptions.count*50))];
    motorView.backgroundColor=[UIColor whiteColor];
    [scrollMainView addSubview:motorView];
    
    [self motorview2];
    [self commonView3];
    
    MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
    [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
    MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    MotorPostAdbutt.layer.cornerRadius = 19;
    MotorPostAdbutt.clipsToBounds = YES;
    [MotorPostAdbutt addTarget:self action:@selector(MotorPostButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    [scrollMainView addSubview:MotorPostAdbutt];
    
    scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 1280+(DataMotorOptions.count*50));
    
}

#pragma mark - Other Category Total View

-(void)commonview2
{
    
    txtadtitle=[[UITextField alloc]initWithFrame:CGRectMake(10, 5, motorView.frame.size.width-20, 40)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Enter Ad title (Min 10 Characters)" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtadtitle.attributedPlaceholder = str;
    txtadtitle.textAlignment=NSTextAlignmentRight;
    txtadtitle.textColor=[UIColor blackColor];
    txtadtitle.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtadtitle.layer.borderWidth=1.0;
    txtadtitle.font = [UIFont systemFontOfSize:15];
    txtadtitle.backgroundColor=[UIColor clearColor];
    txtadtitle.delegate=self;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5,40)];
    txtadtitle.rightView = paddingView;
    txtadtitle.rightViewMode = UITextFieldViewModeAlways;
    [motorView addSubview:txtadtitle];
    
    txtadDesc=[[UITextView alloc]initWithFrame:CGRectMake(10, txtadtitle.frame.size.height+txtadtitle.frame.origin.y+10, motorView.frame.size.width-20, 80)];
    txtadDesc.textAlignment=NSTextAlignmentRight;
    [self setPlaceholder];
    txtadDesc.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtadDesc.layer.borderWidth=1.0;
    txtadDesc.font = [UIFont systemFontOfSize:15];
    txtadDesc.backgroundColor=[UIColor clearColor];
    txtadDesc.delegate=self;
    [motorView addSubview:txtadDesc];
    
    txtCarprice=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,txtadDesc.frame.size.height+txtadDesc.frame.origin.y+10, motorView.frame.size.width-20, 40)];
    [txtCarprice setTextFieldPlaceholderText:@"Price"];
    txtCarprice.textColor=[UIColor blackColor];
    txtCarprice.textAlignment=NSTextAlignmentRight;
    [txtCarprice setKeyboardType:UIKeyboardTypeNumberPad];
    [txtCarprice setFont:[UIFont systemFontOfSize:15]];
    txtCarprice.delegate=self;
    txtCarprice.textColor=[UIColor blackColor];
    [motorView addSubview:txtCarprice];
    
    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(10, txtadDesc.frame.size.height+txtadDesc.frame.origin.y+17,16, 16)];
    image4.image=[UIImage imageNamed:@"left.png"];
    [motorView addSubview:image4];
    
    int x=190;
    for (int i=0; i<DataMotorOptions.count; i++)
    {
        viewdas5=[[UIView alloc]initWithFrame:CGRectMake(0, x, motorView.frame.size.width, 50)];
        viewdas5.backgroundColor=[UIColor clearColor];
        
        
        lbltitle=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10, 5, motorView.frame.size.width-20, 40)];
        [lbltitle setTextFieldPlaceholderText:[[DataMotorOptions objectAtIndex:i] valueForKey:@"name"]];
        lbltitle.textColor=[UIColor blackColor];
        lbltitle.textAlignment=NSTextAlignmentRight;
        lbltitle.tag=i+1;
        lbltitle.font=[UIFont systemFontOfSize:15];
        [viewdas5 addSubview:lbltitle];
        
        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 12,16, 16)];
        image2.image=[UIImage imageNamed:@"left.png"];
        [viewdas5 addSubview:image2];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.selected = !i;
        btnSelected = btn.selected?btn:btnSelected;
        btn.frame = CGRectMake(10, 5, motorView.frame.size.width-10, 40);
        btn.backgroundColor=[UIColor clearColor];
        [btn addTarget:self action:@selector(PropertyforSaleCategeoryclicked:) forControlEvents:UIControlEventTouchUpInside];
        [viewdas5 addSubview:btn];
        
        
        [motorView addSubview:viewdas5];
        
        x+=50;
    }
    
    if (DataMotorOptions.count==0)
    {
        Categorytypeunderlinelab8=[[UILabel alloc]initWithFrame:CGRectMake(10,190, motorView.frame.size.width-20, 1)];
        Categorytypeunderlinelab8.backgroundColor=[UIColor lightGrayColor];
        Categorytypeunderlinelab8.hidden=YES;
        [motorView addSubview:Categorytypeunderlinelab8];
    }
    else
    {
        Categorytypeunderlinelab8=[[UILabel alloc]initWithFrame:CGRectMake(10, viewdas5.frame.size.height+viewdas5.frame.origin.y+6, motorView.frame.size.width-20, 1)];
        Categorytypeunderlinelab8.backgroundColor=[UIColor lightGrayColor];
        Categorytypeunderlinelab8.hidden=YES;
        [motorView addSubview:Categorytypeunderlinelab8];
    }
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(10, Categorytypeunderlinelab8.frame.size.height+Categorytypeunderlinelab8.frame.origin.y+5, motorView.frame.size.width-20, 70) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    _collectionView.pagingEnabled = YES;
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [_collectionView registerNib:[UINib nibWithNibName:@"ORGArticleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ORGArticleCollectionViewCell"];
    
    [motorView addSubview:_collectionView];
    
    
    
    UIImageView *image8=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-16, Categorytypeunderlinelab8.frame.origin.y+Categorytypeunderlinelab8.frame.size.height+80, 32, 32)];
    image8.image=[UIImage imageNamed:@"photo-camera-2.png"];
    [motorView addSubview:image8];
    
    UIButton *CamereButt=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-26, Categorytypeunderlinelab8.frame.origin.y+Categorytypeunderlinelab8.frame.size.height+80, 52, 52)];
    [CamereButt addTarget:self action:@selector(Camerabuttclicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:CamereButt];
    
    UILabel *lab8=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-50, image8.frame.origin.y+image8.frame.size.height+5, 100, 15)];
    lab8.text=@"Add Photos";
    lab8.textColor=[UIColor blackColor];
    lab8.textAlignment=NSTextAlignmentCenter;
    lab8.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab8];
    
    
    
    chooselab=[[UILabel alloc]initWithFrame:CGRectMake(10, lab8.frame.origin.y+lab8.frame.size.height+35, motorView.frame.size.width-20, 40)];
    chooselab.text=@"please Choose atleast one Image to Display Your Add More Frequent";
    chooselab.textColor=[UIColor blackColor];
    chooselab.textAlignment=NSTextAlignmentRight;
    chooselab.numberOfLines=2;
    chooselab.font=[UIFont systemFontOfSize:14];
    [motorView addSubview:chooselab];
    
    
    
    coverphotoview=[[UIView alloc]initWithFrame:CGRectMake(0, lab8.frame.origin.y+lab8.frame.size.height, motorView.frame.size.width, 130)];
    coverphotoview.backgroundColor=[UIColor whiteColor];
    coverphotoview.hidden=YES;
    [motorView addSubview:coverphotoview];
    
    
    
    UILabel *lab9=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width-188, 10, 178, 70)];
    lab9.text=@": Cover Photo of the Ad";
    lab9.textColor=[UIColor blackColor];
    lab9.textAlignment=NSTextAlignmentRight;
    lab9.font=[UIFont systemFontOfSize:17];
    [coverphotoview addSubview:lab9];
    
    CoverPhotoImage=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-258, 10, 70, 70)];
    CoverPhotoImage.image=[UIImage imageNamed:@"profilepic.png"];
    CoverPhotoImage.contentMode = UIViewContentModeScaleAspectFit;
    [coverphotoview addSubview:CoverPhotoImage];
    
    
    UILabel *lab10=[[UILabel alloc]initWithFrame:CGRectMake(10, lab9.frame.origin.y+lab9.frame.size.height+10, motorView.frame.size.width-20, 40)];
    lab10.text=@"You Can Select Cover Photo From above Selected Images";
    lab10.textColor=[UIColor blackColor];
    lab10.textAlignment=NSTextAlignmentRight;
    lab10.numberOfLines=2;
    lab10.font=[UIFont systemFontOfSize:12];
    [coverphotoview addSubview:lab10];
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPads)],
                           nil];
    [numberToolbar sizeToFit];
    
    
    txtCarprice.inputAccessoryView=numberToolbar;
    
}


#pragma mark - Other Category Total View for Community

-(void)commonview2community
{
    txtadtitle=[[UITextField alloc]initWithFrame:CGRectMake(10, 5, motorView.frame.size.width-20, 40)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Enter Ad title (Min 10 Characters)" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtadtitle.attributedPlaceholder = str;
    txtadtitle.textAlignment=NSTextAlignmentRight;
    txtadtitle.textColor=[UIColor blackColor];
    txtadtitle.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtadtitle.layer.borderWidth=1.0;
    txtadtitle.font = [UIFont systemFontOfSize:15];
    txtadtitle.backgroundColor=[UIColor clearColor];
    txtadtitle.delegate=self;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5,40)];
    txtadtitle.rightView = paddingView;
    txtadtitle.rightViewMode = UITextFieldViewModeAlways;
    [motorView addSubview:txtadtitle];
    
    txtadDesc=[[UITextView alloc]initWithFrame:CGRectMake(10, txtadtitle.frame.size.height+txtadtitle.frame.origin.y+10, motorView.frame.size.width-20, 80)];
    txtadDesc.textAlignment=NSTextAlignmentRight;
    [self setPlaceholder];
    txtadDesc.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtadDesc.layer.borderWidth=1.0;
    txtadDesc.font = [UIFont systemFontOfSize:15];
    txtadDesc.backgroundColor=[UIColor clearColor];
    txtadDesc.delegate=self;
    [motorView addSubview:txtadDesc];
    
    int x=140;
    for (int i=0; i<DataMotorOptions.count; i++)
    {
        viewdas5=[[UIView alloc]initWithFrame:CGRectMake(0, x, motorView.frame.size.width, 50)];
        viewdas5.backgroundColor=[UIColor clearColor];
        
        
        lbltitle=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10, 5, motorView.frame.size.width-20, 40)];
        [lbltitle setTextFieldPlaceholderText:[[DataMotorOptions objectAtIndex:i] valueForKey:@"name"]];
        lbltitle.textColor=[UIColor blackColor];
        lbltitle.textAlignment=NSTextAlignmentRight;
        lbltitle.tag=i+1;
        lbltitle.font=[UIFont systemFontOfSize:15];
        [viewdas5 addSubview:lbltitle];
        
        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 12,16, 16)];
        image2.image=[UIImage imageNamed:@"left.png"];
        [viewdas5 addSubview:image2];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.selected = !i;
        btnSelected = btn.selected?btn:btnSelected;
        btn.frame = CGRectMake(10, 5, motorView.frame.size.width-10, 40);
        btn.backgroundColor=[UIColor clearColor];
        [btn addTarget:self action:@selector(PropertyforSaleCategeoryclicked:) forControlEvents:UIControlEventTouchUpInside];
        [viewdas5 addSubview:btn];
        
        
        [motorView addSubview:viewdas5];
        
        x+=50;
    }
    
    if (DataMotorOptions.count==0)
    {
        Categorytypeunderlinelab8=[[UILabel alloc]initWithFrame:CGRectMake(10,140, motorView.frame.size.width-20, 1)];
        Categorytypeunderlinelab8.backgroundColor=[UIColor lightGrayColor];
        Categorytypeunderlinelab8.hidden=YES;
        [motorView addSubview:Categorytypeunderlinelab8];
    }
    else
    {
        Categorytypeunderlinelab8=[[UILabel alloc]initWithFrame:CGRectMake(10, viewdas5.frame.size.height+viewdas5.frame.origin.y+6, motorView.frame.size.width-20, 1)];
        Categorytypeunderlinelab8.backgroundColor=[UIColor lightGrayColor];
        Categorytypeunderlinelab8.hidden=YES;
        [motorView addSubview:Categorytypeunderlinelab8];
    }
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(10, Categorytypeunderlinelab8.frame.size.height+Categorytypeunderlinelab8.frame.origin.y+5, motorView.frame.size.width-20, 70) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    _collectionView.pagingEnabled = YES;
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [_collectionView registerNib:[UINib nibWithNibName:@"ORGArticleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ORGArticleCollectionViewCell"];
    
    [motorView addSubview:_collectionView];
    
    
    
    UIImageView *image8=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-16, Categorytypeunderlinelab8.frame.origin.y+Categorytypeunderlinelab8.frame.size.height+80, 32, 32)];
    image8.image=[UIImage imageNamed:@"photo-camera-2.png"];
    [motorView addSubview:image8];
    
    UIButton *CamereButt=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-26, Categorytypeunderlinelab8.frame.origin.y+Categorytypeunderlinelab8.frame.size.height+80, 52, 52)];
    [CamereButt addTarget:self action:@selector(Camerabuttclicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:CamereButt];
    
    UILabel *lab8=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-50, image8.frame.origin.y+image8.frame.size.height+5, 100, 15)];
    lab8.text=@"Add Photos";
    lab8.textColor=[UIColor blackColor];
    lab8.textAlignment=NSTextAlignmentCenter;
    lab8.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab8];
    
    
    
    chooselab=[[UILabel alloc]initWithFrame:CGRectMake(10, lab8.frame.origin.y+lab8.frame.size.height+35, motorView.frame.size.width-20, 40)];
    chooselab.text=@"please Choose atleast one Image to Display Your Add More Frequent";
    chooselab.textColor=[UIColor blackColor];
    chooselab.textAlignment=NSTextAlignmentRight;
    chooselab.numberOfLines=2;
    chooselab.font=[UIFont systemFontOfSize:14];
    [motorView addSubview:chooselab];
    
    
    
    coverphotoview=[[UIView alloc]initWithFrame:CGRectMake(0, lab8.frame.origin.y+lab8.frame.size.height, motorView.frame.size.width, 130)];
    coverphotoview.backgroundColor=[UIColor whiteColor];
    coverphotoview.hidden=YES;
    [motorView addSubview:coverphotoview];
    
    
    
    UILabel *lab9=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width-188, 10, 178, 70)];
    lab9.text=@": Cover Photo of the Ad";
    lab9.textColor=[UIColor blackColor];
    lab9.textAlignment=NSTextAlignmentRight;
    lab9.font=[UIFont systemFontOfSize:17];
    [coverphotoview addSubview:lab9];
    
    CoverPhotoImage=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-258, 10, 70, 70)];
    CoverPhotoImage.image=[UIImage imageNamed:@"profilepic.png"];
    CoverPhotoImage.contentMode = UIViewContentModeScaleAspectFit;
    [coverphotoview addSubview:CoverPhotoImage];
    
    
    UILabel *lab10=[[UILabel alloc]initWithFrame:CGRectMake(10, lab9.frame.origin.y+lab9.frame.size.height+10, motorView.frame.size.width-20, 40)];
    lab10.text=@"You Can Select Cover Photo From above Selected Images";
    lab10.textColor=[UIColor blackColor];
    lab10.textAlignment=NSTextAlignmentRight;
    lab10.numberOfLines=2;
    lab10.font=[UIFont systemFontOfSize:12];
    [coverphotoview addSubview:lab10];
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPads)],
                           nil];
    [numberToolbar sizeToFit];
    
    
    txtCarprice.inputAccessoryView=numberToolbar;
    
}


#pragma mark - Other Category Total View for Jobs

-(void)commonview2Job
{
    
    txtadtitle=[[UITextField alloc]initWithFrame:CGRectMake(10, 5, motorView.frame.size.width-20, 40)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Enter Ad title (Min 10 Characters)" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtadtitle.attributedPlaceholder = str;
    txtadtitle.textAlignment=NSTextAlignmentRight;
    txtadtitle.textColor=[UIColor blackColor];
    txtadtitle.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtadtitle.layer.borderWidth=1.0;
    txtadtitle.font = [UIFont systemFontOfSize:15];
    txtadtitle.backgroundColor=[UIColor clearColor];
    txtadtitle.delegate=self;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5,40)];
    txtadtitle.rightView = paddingView;
    txtadtitle.rightViewMode = UITextFieldViewModeAlways;
    [motorView addSubview:txtadtitle];
    
    txtadDesc=[[UITextView alloc]initWithFrame:CGRectMake(10, txtadtitle.frame.size.height+txtadtitle.frame.origin.y+10, motorView.frame.size.width-20, 80)];
    txtadDesc.textAlignment=NSTextAlignmentRight;
    [self setPlaceholder];
    txtadDesc.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtadDesc.layer.borderWidth=1.0;
    txtadDesc.font = [UIFont systemFontOfSize:15];
    txtadDesc.backgroundColor=[UIColor clearColor];
    txtadDesc.delegate=self;
    [motorView addSubview:txtadDesc];
    
    
    txtmake=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,txtadDesc.frame.size.height+txtadDesc.frame.origin.y+10, motorView.frame.size.width-20, 40)];
    [txtmake setTextFieldPlaceholderText:@"Job Role"];
    txtmake.textColor=[UIColor blackColor];
    txtmake.textAlignment=NSTextAlignmentRight;
    [txtmake setFont:[UIFont systemFontOfSize:15]];
    txtmake.delegate=self;
    txtmake.textColor=[UIColor blackColor];
    [motorView addSubview:txtmake];
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(10, txtadDesc.frame.size.height+txtadDesc.frame.origin.y+17,16, 16)];
    image1.image=[UIImage imageNamed:@"left.png"];
    [motorView addSubview:image1];
    
    
    txtModel=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,txtmake.frame.size.height+txtmake.frame.origin.y+10, motorView.frame.size.width-20, 40)];
    [txtModel setTextFieldPlaceholderText:@"Company Name"];
    txtModel.textColor=[UIColor blackColor];
    txtModel.delegate=self;
    txtModel.textAlignment=NSTextAlignmentRight;
    [txtModel setFont:[UIFont systemFontOfSize:15]];
    txtModel.textColor=[UIColor blackColor];
    [motorView addSubview:txtModel];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10, txtmake.frame.size.height+txtmake.frame.origin.y+17,16, 16)];
    image2.image=[UIImage imageNamed:@"left.png"];
    [motorView addSubview:image2];
    
    
    int x=240;
    for (int i=0; i<DataMotorOptions.count; i++)
    {
        viewdas5=[[UIView alloc]initWithFrame:CGRectMake(0, x, motorView.frame.size.width, 50)];
        viewdas5.backgroundColor=[UIColor clearColor];
        
        
        lbltitle=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10, 5, motorView.frame.size.width-20, 40)];
        [lbltitle setTextFieldPlaceholderText:[[DataMotorOptions objectAtIndex:i] valueForKey:@"name"]];
        lbltitle.textColor=[UIColor blackColor];
        lbltitle.textAlignment=NSTextAlignmentRight;
        lbltitle.tag=i+1;
        lbltitle.font=[UIFont systemFontOfSize:15];
        [viewdas5 addSubview:lbltitle];
        
        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 12,16, 16)];
        image2.image=[UIImage imageNamed:@"left.png"];
        [viewdas5 addSubview:image2];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.selected = !i;
        btnSelected = btn.selected?btn:btnSelected;
        btn.frame = CGRectMake(10, 5, motorView.frame.size.width-10, 40);
        btn.backgroundColor=[UIColor clearColor];
        [btn addTarget:self action:@selector(PropertyforSaleCategeoryclicked:) forControlEvents:UIControlEventTouchUpInside];
        [viewdas5 addSubview:btn];
        
        
        [motorView addSubview:viewdas5];
        
        x+=50;
    }
    
    if (DataMotorOptions.count==0)
    {
        Categorytypeunderlinelab8=[[UILabel alloc]initWithFrame:CGRectMake(10,240, motorView.frame.size.width-20, 1)];
        Categorytypeunderlinelab8.backgroundColor=[UIColor lightGrayColor];
        Categorytypeunderlinelab8.hidden=YES;
        [motorView addSubview:Categorytypeunderlinelab8];
    }
    else
    {
        Categorytypeunderlinelab8=[[UILabel alloc]initWithFrame:CGRectMake(10, viewdas5.frame.size.height+viewdas5.frame.origin.y+6, motorView.frame.size.width-20, 1)];
        Categorytypeunderlinelab8.backgroundColor=[UIColor lightGrayColor];
        Categorytypeunderlinelab8.hidden=YES;
        [motorView addSubview:Categorytypeunderlinelab8];
    }
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(10, Categorytypeunderlinelab8.frame.size.height+Categorytypeunderlinelab8.frame.origin.y+5, motorView.frame.size.width-20, 70) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    _collectionView.pagingEnabled = YES;
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [_collectionView registerNib:[UINib nibWithNibName:@"ORGArticleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ORGArticleCollectionViewCell"];
    
    [motorView addSubview:_collectionView];
    
    
    
    UIImageView *image8=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-16, Categorytypeunderlinelab8.frame.origin.y+Categorytypeunderlinelab8.frame.size.height+80, 32, 32)];
    image8.image=[UIImage imageNamed:@"photo-camera-2.png"];
    [motorView addSubview:image8];
    
    UIButton *CamereButt=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-26, Categorytypeunderlinelab8.frame.origin.y+Categorytypeunderlinelab8.frame.size.height+80, 52, 52)];
    [CamereButt addTarget:self action:@selector(Camerabuttclicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:CamereButt];
    
    UILabel *lab8=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-50, image8.frame.origin.y+image8.frame.size.height+5, 100, 15)];
    lab8.text=@"Add Photos";
    lab8.textColor=[UIColor blackColor];
    lab8.textAlignment=NSTextAlignmentCenter;
    lab8.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab8];
    
    
    
    chooselab=[[UILabel alloc]initWithFrame:CGRectMake(10, lab8.frame.origin.y+lab8.frame.size.height+35, motorView.frame.size.width-20, 40)];
    chooselab.text=@"please Choose atleast one Image to Display Your Add More Frequent";
    chooselab.textColor=[UIColor blackColor];
    chooselab.textAlignment=NSTextAlignmentRight;
    chooselab.numberOfLines=2;
    chooselab.font=[UIFont systemFontOfSize:14];
    [motorView addSubview:chooselab];
    
    
    
    coverphotoview=[[UIView alloc]initWithFrame:CGRectMake(0, lab8.frame.origin.y+lab8.frame.size.height, motorView.frame.size.width, 130)];
    coverphotoview.backgroundColor=[UIColor whiteColor];
    coverphotoview.hidden=YES;
    [motorView addSubview:coverphotoview];
    
    
    
    UILabel *lab9=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width-188, 10, 178, 70)];
    lab9.text=@": Cover Photo of the Ad";
    lab9.textColor=[UIColor blackColor];
    lab9.textAlignment=NSTextAlignmentRight;
    lab9.font=[UIFont systemFontOfSize:17];
    [coverphotoview addSubview:lab9];
    
    CoverPhotoImage=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-258, 10, 70, 70)];
    CoverPhotoImage.image=[UIImage imageNamed:@"profilepic.png"];
    CoverPhotoImage.contentMode = UIViewContentModeScaleAspectFit;
    [coverphotoview addSubview:CoverPhotoImage];
    
    
    UILabel *lab10=[[UILabel alloc]initWithFrame:CGRectMake(10, lab9.frame.origin.y+lab9.frame.size.height+10, motorView.frame.size.width-20, 40)];
    lab10.text=@"You Can Select Cover Photo From above Selected Images";
    lab10.textColor=[UIColor blackColor];
    lab10.textAlignment=NSTextAlignmentRight;
    lab10.numberOfLines=2;
    lab10.font=[UIFont systemFontOfSize:12];
    [coverphotoview addSubview:lab10];
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPads)],
                           nil];
    [numberToolbar sizeToFit];
    
    
    txtCarprice.inputAccessoryView=numberToolbar;
    
}




#pragma mark - Motor-Categeory view for Car

-(void)motorview2
{
    
    txtadtitle=[[UITextField alloc]initWithFrame:CGRectMake(10, 5, motorView.frame.size.width-20, 40)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Enter Ad title (Min 10 Characters)" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtadtitle.attributedPlaceholder = str;
    txtadtitle.textAlignment=NSTextAlignmentRight;
    txtadtitle.textColor=[UIColor blackColor];
    txtadtitle.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtadtitle.layer.borderWidth=1.0;
    txtadtitle.font = [UIFont systemFontOfSize:15];
    txtadtitle.backgroundColor=[UIColor clearColor];
    txtadtitle.delegate=self;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5,40)];
    txtadtitle.rightView = paddingView;
    txtadtitle.rightViewMode = UITextFieldViewModeAlways;
    [motorView addSubview:txtadtitle];
    
    txtadDesc=[[UITextView alloc]initWithFrame:CGRectMake(10, txtadtitle.frame.size.height+txtadtitle.frame.origin.y+10, motorView.frame.size.width-20, 80)];
    txtadDesc.textAlignment=NSTextAlignmentRight;
    [self setPlaceholder];
    txtadDesc.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtadDesc.layer.borderWidth=1.0;
    txtadDesc.font = [UIFont systemFontOfSize:15];
    txtadDesc.backgroundColor=[UIColor clearColor];
    txtadDesc.delegate=self;
    [motorView addSubview:txtadDesc];
    
    
    txtmake=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,txtadDesc.frame.size.height+txtadDesc.frame.origin.y+10, motorView.frame.size.width-20, 40)];
    [txtmake setTextFieldPlaceholderText:@"Car Make"];
    txtmake.textColor=[UIColor blackColor];
    txtmake.textAlignment=NSTextAlignmentRight;
    [txtmake setFont:[UIFont systemFontOfSize:15]];
    txtmake.delegate=self;
    txtmake.textColor=[UIColor blackColor];
    [motorView addSubview:txtmake];
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(10, txtadDesc.frame.size.height+txtadDesc.frame.origin.y+17,16, 16)];
    image1.image=[UIImage imageNamed:@"left.png"];
    [motorView addSubview:image1];
    
    UIButton *brandnamebutt=[[UIButton alloc]initWithFrame:CGRectMake(10, txtadDesc.frame.size.height+txtadDesc.frame.origin.y+5, motorView.frame.size.width-20, 45)];
    [brandnamebutt addTarget:self action:@selector(MakeClicked:) forControlEvents:UIControlEventTouchUpInside];
    brandnamebutt.backgroundColor=[UIColor clearColor];
    [motorView addSubview:brandnamebutt];
    
    
    
    txtModel=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,txtmake.frame.size.height+txtmake.frame.origin.y+10, motorView.frame.size.width-20, 40)];
    [txtModel setTextFieldPlaceholderText:@"Car Model"];
    txtModel.textColor=[UIColor blackColor];
    txtModel.delegate=self;
    txtModel.textAlignment=NSTextAlignmentRight;
    [txtModel setFont:[UIFont systemFontOfSize:15]];
    txtModel.textColor=[UIColor blackColor];
    [motorView addSubview:txtModel];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10, txtmake.frame.size.height+txtmake.frame.origin.y+17,16, 16)];
    image2.image=[UIImage imageNamed:@"left.png"];
    [motorView addSubview:image2];
    
    UIButton *brandnamebutt2=[[UIButton alloc]initWithFrame:CGRectMake(10, txtmake.frame.size.height+txtmake.frame.origin.y+5, motorView.frame.size.width-20, 45)];
    [brandnamebutt2 addTarget:self action:@selector(ModelClicked:) forControlEvents:UIControlEventTouchUpInside];
    brandnamebutt2.backgroundColor=[UIColor clearColor];
    [motorView addSubview:brandnamebutt2];
    
    
    txtyear=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,txtModel.frame.size.height+txtModel.frame.origin.y+10, motorView.frame.size.width-20, 40)];
    [txtyear setTextFieldPlaceholderText:@"Year"];
    txtyear.textColor=[UIColor blackColor];
    txtyear.textAlignment=NSTextAlignmentRight;
    [txtyear setKeyboardType:UIKeyboardTypeNumberPad];
    [txtyear setFont:[UIFont systemFontOfSize:15]];
    txtyear.delegate=self;
    txtyear.textColor=[UIColor blackColor];
    [motorView addSubview:txtyear];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(10, txtModel.frame.size.height+txtModel.frame.origin.y+17,16, 16)];
    image3.image=[UIImage imageNamed:@"left.png"];
    [motorView addSubview:image3];
    
    //    UIButton *brandnamebutt3=[[UIButton alloc]initWithFrame:CGRectMake(10, txtModel.frame.size.height+txtModel.frame.origin.y+5, motorView.frame.size.width-20, 40)];
    //    [brandnamebutt3 addTarget:self action:@selector(YearClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    brandnamebutt3.backgroundColor=[UIColor clearColor];
    //    [motorView addSubview:brandnamebutt3];
    
    
    
    txtCarprice=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,txtyear.frame.size.height+txtyear.frame.origin.y+10, motorView.frame.size.width-20, 40)];
    [txtCarprice setTextFieldPlaceholderText:@"Price"];
    txtCarprice.textColor=[UIColor blackColor];
    txtCarprice.textAlignment=NSTextAlignmentRight;
    [txtCarprice setKeyboardType:UIKeyboardTypeNumberPad];
    [txtCarprice setFont:[UIFont systemFontOfSize:15]];
    txtCarprice.delegate=self;
    txtCarprice.textColor=[UIColor blackColor];
    [motorView addSubview:txtCarprice];
    
    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(10, txtyear.frame.size.height+txtyear.frame.origin.y+17,16, 16)];
    image4.image=[UIImage imageNamed:@"left.png"];
    [motorView addSubview:image4];
    
    //    UIButton *brandnamebutt4=[[UIButton alloc]initWithFrame:CGRectMake(10, txtyear.frame.size.height+txtyear.frame.origin.y+5, motorView.frame.size.width-20, 40)];
    //    [brandnamebutt4 addTarget:self action:@selector(PriceClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    brandnamebutt4.backgroundColor=[UIColor clearColor];
    //    [motorView addSubview:brandnamebutt4];
    
    
    txtKilometer=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,txtCarprice.frame.size.height+txtCarprice.frame.origin.y+10, motorView.frame.size.width-20, 40)];
    [txtKilometer setTextFieldPlaceholderText:@"Kilometers Driven"];
    txtKilometer.textColor=[UIColor blackColor];
    txtKilometer.textAlignment=NSTextAlignmentRight;
    [txtKilometer setFont:[UIFont systemFontOfSize:15]];
    [txtKilometer setKeyboardType:UIKeyboardTypeNumberPad];
    txtKilometer.delegate=self;
    txtKilometer.textColor=[UIColor blackColor];
    [motorView addSubview:txtKilometer];
    
    UIImageView *image5=[[UIImageView alloc]initWithFrame:CGRectMake(10, txtCarprice.frame.size.height+txtCarprice.frame.origin.y+17,16, 16)];
    image5.image=[UIImage imageNamed:@"left.png"];
    [motorView addSubview:image5];
    
    //    UIButton *brandnamebutt5=[[UIButton alloc]initWithFrame:CGRectMake(10, txtCarprice.frame.size.height+txtCarprice.frame.origin.y+5, motorView.frame.size.width-20, 40)];
    //    [brandnamebutt5 addTarget:self action:@selector(KilometerClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    brandnamebutt5.backgroundColor=[UIColor clearColor];
    //    [motorView addSubview:brandnamebutt5];
    
    
    
    int x=390;
    for (int i=0; i<DataMotorOptions.count; i++)
    {
        viewdas5=[[UIView alloc]initWithFrame:CGRectMake(0, x, motorView.frame.size.width, 50)];
        viewdas5.backgroundColor=[UIColor clearColor];
        
        
        lbltitle=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10, 5, motorView.frame.size.width-20, 40)];
        [lbltitle setTextFieldPlaceholderText:[[DataMotorOptions objectAtIndex:i] valueForKey:@"name"]];
        lbltitle.textColor=[UIColor blackColor];
        lbltitle.textAlignment=NSTextAlignmentRight;
        lbltitle.tag=i+1;
        lbltitle.font=[UIFont systemFontOfSize:15];
        [viewdas5 addSubview:lbltitle];
        
        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 12,16, 16)];
        image2.image=[UIImage imageNamed:@"left.png"];
        [viewdas5 addSubview:image2];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.selected = !i;
        btnSelected = btn.selected?btn:btnSelected;
        btn.frame = CGRectMake(10, 5, motorView.frame.size.width-10, 40);
        btn.backgroundColor=[UIColor clearColor];
        [btn addTarget:self action:@selector(PropertyforSaleCategeoryclicked:) forControlEvents:UIControlEventTouchUpInside];
        [viewdas5 addSubview:btn];
        
        
        [motorView addSubview:viewdas5];
        
        x+=50;
    }
    
    Categorytypeunderlinelab8=[[UILabel alloc]initWithFrame:CGRectMake(10, viewdas5.frame.size.height+viewdas5.frame.origin.y+6, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab8.backgroundColor=[UIColor lightGrayColor];
    Categorytypeunderlinelab8.hidden=YES;
    [motorView addSubview:Categorytypeunderlinelab8];
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(10, Categorytypeunderlinelab8.frame.size.height+Categorytypeunderlinelab8.frame.origin.y+5, motorView.frame.size.width-20, 70) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    _collectionView.pagingEnabled = YES;
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [_collectionView registerNib:[UINib nibWithNibName:@"ORGArticleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ORGArticleCollectionViewCell"];
    
    [motorView addSubview:_collectionView];
    
    
    
    UIImageView *image8=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-16, Categorytypeunderlinelab8.frame.origin.y+Categorytypeunderlinelab8.frame.size.height+80, 32, 32)];
    image8.image=[UIImage imageNamed:@"photo-camera-2.png"];
    [motorView addSubview:image8];
    
    UIButton *CamereButt=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-26, Categorytypeunderlinelab8.frame.origin.y+Categorytypeunderlinelab8.frame.size.height+80, 52, 52)];
    [CamereButt addTarget:self action:@selector(Camerabuttclicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:CamereButt];
    
    UILabel *lab8=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-50, image8.frame.origin.y+image8.frame.size.height+5, 100, 15)];
    lab8.text=@"Add Photos";
    lab8.textColor=[UIColor blackColor];
    lab8.textAlignment=NSTextAlignmentCenter;
    lab8.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab8];
    
    
    
    chooselab=[[UILabel alloc]initWithFrame:CGRectMake(10, lab8.frame.origin.y+lab8.frame.size.height+35, motorView.frame.size.width-20, 40)];
    chooselab.text=@"please Choose atleast one Image to Display Your Add More Frequent";
    chooselab.textColor=[UIColor blackColor];
    chooselab.textAlignment=NSTextAlignmentRight;
    chooselab.numberOfLines=2;
    chooselab.font=[UIFont systemFontOfSize:14];
    [motorView addSubview:chooselab];
    
    
    
    coverphotoview=[[UIView alloc]initWithFrame:CGRectMake(0, lab8.frame.origin.y+lab8.frame.size.height, motorView.frame.size.width, 130)];
    coverphotoview.backgroundColor=[UIColor whiteColor];
    coverphotoview.hidden=YES;
    [motorView addSubview:coverphotoview];
    
    
    
    UILabel *lab9=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width-188, 10, 178, 70)];
    lab9.text=@": Cover Photo of the Ad";
    lab9.textColor=[UIColor blackColor];
    lab9.textAlignment=NSTextAlignmentLeft;
    lab9.font=[UIFont systemFontOfSize:17];
    [coverphotoview addSubview:lab9];
    
    CoverPhotoImage=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-258, 10, 70, 70)];
    CoverPhotoImage.image=[UIImage imageNamed:@"profilepic.png"];
    CoverPhotoImage.contentMode = UIViewContentModeScaleAspectFit;
    [coverphotoview addSubview:CoverPhotoImage];
    
    
    UILabel *lab10=[[UILabel alloc]initWithFrame:CGRectMake(10, lab9.frame.origin.y+lab9.frame.size.height+10, motorView.frame.size.width-20, 40)];
    lab10.text=@"You Can Select Cover Photo From above Selected Images";
    lab10.textColor=[UIColor blackColor];
    lab10.textAlignment=NSTextAlignmentRight;
    lab10.numberOfLines=2;
    lab10.font=[UIFont systemFontOfSize:12];
    [coverphotoview addSubview:lab10];
    
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPads)],
                           nil];
    [numberToolbar sizeToFit];
    
    txtyear.inputAccessoryView = numberToolbar;
    txtCarprice.inputAccessoryView=numberToolbar;
    txtKilometer.inputAccessoryView=numberToolbar;
}

-(void)doneWithNumberPads
{
    [txtyear resignFirstResponder];
    [txtCarprice resignFirstResponder];
    [txtKilometer resignFirstResponder];
}



-(IBAction)PropertyforSaleCategeoryclicked:(UIButton *)sender
{
    [DataMotorOptions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if (sender.tag== buttontag1+idx)
         {
             [self.view endEditing:YES];
             arrfueltype=[[[DataMotorOptions objectAtIndex:idx] valueForKey:@"values"] valueForKey:@"name"];
             //   arrfueltype=[[[DataMotorOptions objectAtIndex:idx] valueForKey:@"values"] valueForKey:@"id"];
             
             strid=[NSString stringWithFormat:@"%lu",(unsigned long)idx];
             stridforpost=[[DataMotorOptions objectAtIndex:idx] valueForKey:@"id"];
             b=(int)idx+1;
             
             NSString *strname =[[DataMotorOptions objectAtIndex:idx] valueForKey:@"name"];
             NSString *strtype=[[DataMotorOptions objectAtIndex:idx] valueForKey:@"type"];
             
             if ([strtype isEqualToString:@"1"])
             {
                 condition=NO;
             }
             else
             {
                 condition=YES;
             }
             
             
             for(UIButton *btn in Scrollview.subviews)
                 if([btn isKindOfClass:[UIButton class]])
                     btn.selected = NO;
             
             sender.selected = YES;
             
             btnSelected = sender;
             
             
             [Dropobj fadeOut];
             
             
             if ([UIScreen mainScreen].bounds.size.width < 350 )
             {
                 [self showPopUpWithTitle:strname withOption:arrfueltype xy:CGPointMake(self.view.frame.size.width/2-150, 70) size:CGSizeMake(300, 400) isMultiple:condition];
             }
             else
             {
                 [self showPopUpWithTitle:strname withOption:arrfueltype xy:CGPointMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-200) size:CGSizeMake(300, 400) isMultiple:condition];
             }
         }
     }];
}



#pragma mark -Car Post Ad Clicked

-(IBAction)MakeClicked:(id)sender
{
    txtModel.text=nil;
    [txtModel textFieldDidEndEditing];
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@",BaseUrl,strtoken,carSubModule,arabic,strCityId,_strcategeoryTypeid];
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
        
        DataCarMakeArray=[arrMotorList valueForKey:@"make"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrMotorList];
        
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"MotorEngSubModule"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self model];
    }
    else
    {
        [requested showMessage:[responseDictionary valueForKey:@"message"] withTitle:@"Message"];
    }
}


-(IBAction)ModelClicked:(id)sender
{
    if (txtmake.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please Select the Car Make" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?make=%@",BaseUrl,strtoken,carModel,arabic,strCityId,strSubModule];
        [requested motorsRequest:nil withUrl:strurl];
        
    }
}

-(void)responsewithData:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Motor Model English Response: %@",responseDictionary);
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        NSMutableArray *arrMotorList=[[NSMutableArray alloc]init];
        arrMotorList=[responseDictionary valueForKey:@"data"];
        
        DataCarModelArray=[responseDictionary valueForKey:@"data"];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrMotorList];
        
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"MotorEngCarModel"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [self model2];
    }
    else
    {
        [requested showMessage:[responseDictionary valueForKey:@"message"] withTitle:@"Message"];
    }
}



-(IBAction)YearClicked:(id)sender
{
    //    NSDate *currentYear=[[NSDate alloc]init];
    //    currentYear=[NSDate date];
    //    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    //    [formatter1 setDateFormat:@"yyyy"];
    //    NSString *currentYearString = [formatter1 stringFromDate:currentYear];
    //
    //    for (int k=0; k<20; k++)
    //    {
    //        NSMutableArray *arr=[[NSMutableArray alloc] init];
    //        [arr addObject:[NSString stringWithFormat:@"%d",[currentYearString integerValue]-k]];
    //        [[arryearslist arrayByAddingObjectsFromArray:arr] mutableCopy];
    //    }
    //    NSLog(@"%@",arryearslist);
}

-(IBAction)PriceClicked:(id)sender
{
    [requested showMessage:@"Price Clicked" withTitle:@"Price"];
}

-(IBAction)KilometerClicked:(id)sender
{
    [requested showMessage:@"Kilometer Clicked" withTitle:@"Kilometer"];
}


#pragma mark -Car Make and Model


-(void)model
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-100, 300, 200)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-50, 40)];
    lab.text=@"Select Model";
    lab.textColor=[UIColor blackColor];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentLeft+10;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60, 0, 50, 40)];
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
    tabl.frame = CGRectMake(0,labeunder.frame.origin.y+labeunder.frame.size.height+10, footerview.frame.size.width, 157);
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.tag=1;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //  [tabl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [footerview addSubview:tabl];
}

-(void)model2
{
    popview1 = [[UIView alloc]init];
    popview1.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview1.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview1];
    
    footerview1=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-100, 300, 200)];
    footerview1.backgroundColor = [UIColor whiteColor];
    [popview1 addSubview:footerview1];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-50, 40)];
    lab.text=@"Select SubModel";
    lab.textColor=[UIColor blackColor];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentLeft+10;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview1 addSubview:lab];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60, 0, 50, 40)];
    [butt1 setTitle:@"Cancel" forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont systemFontOfSize:15];
    butt1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [butt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt1 addTarget:self action:@selector(Cancelclicked2:) forControlEvents:UIControlEventTouchUpInside];
    [footerview1 addSubview:butt1];
    
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(1, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width-2, 1)];
    labeunder.backgroundColor=[UIColor darkGrayColor];
    [footerview1 addSubview:labeunder];
    
    
    tabl=[[UITableView alloc] init];
    tabl.frame = CGRectMake(0,labeunder.frame.origin.y+labeunder.frame.size.height+10, footerview.frame.size.width, 157);
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.tag=2;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //   [tabl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [footerview1 addSubview:tabl];
}



-(IBAction)Cancelclicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}
-(IBAction)Cancelclicked2:(id)sender
{
    [footerview1 removeFromSuperview];
    popview1.hidden = YES;
}



#pragma mark -Motor old method


-(void)motorView
{
    brandname=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, motorView.frame.size.width-20, 30)];
    brandname.text=@"Brand Name";
    brandname.textAlignment=NSTextAlignmentLeft;
    [brandname setFont:[UIFont systemFontOfSize:15]];
    brandname.textColor=[UIColor blackColor];
    [motorView addSubview:brandname];
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-26, 12,16, 16)];
    image1.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [motorView addSubview:image1];
    
    UILabel *Categorytypeunderlinelab=[[UILabel alloc]initWithFrame:CGRectMake(10, brandname.frame.size.height+brandname.frame.origin.y+2, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab];
    
    UIButton *brandnamebutt=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, motorView.frame.size.width-10, 30)];
    [brandnamebutt addTarget:self action:@selector(brandNamebuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    brandnamebutt.backgroundColor=[UIColor clearColor];
    [motorView addSubview:brandnamebutt];
    
    
    
    FuelType=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab.frame.size.height+Categorytypeunderlinelab.frame.origin.y+5, motorView.frame.size.width-20, 30)];
    FuelType.text=@"Fuel Type";
    FuelType.textAlignment=NSTextAlignmentLeft;
    [FuelType setFont:[UIFont systemFontOfSize:15]];
    FuelType.textColor=[UIColor blackColor];
    [motorView addSubview:FuelType];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-26, Categorytypeunderlinelab.frame.size.height+Categorytypeunderlinelab.frame.origin.y+12,16, 16)];
    image2.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [motorView addSubview:image2];
    
    UILabel *Categorytypeunderlinelab1=[[UILabel alloc]initWithFrame:CGRectMake(10, FuelType.frame.size.height+FuelType.frame.origin.y+2, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab1.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab1];
    
    UIButton *fuelTypebutt=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab.frame.size.height+Categorytypeunderlinelab.frame.origin.y+5, motorView.frame.size.width-10, 30)];
    [fuelTypebutt addTarget:self action:@selector(fuelTypebuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    fuelTypebutt.backgroundColor=[UIColor clearColor];
    [motorView addSubview:fuelTypebutt];
    
    
    YearofReg=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab1.frame.size.height+Categorytypeunderlinelab1.frame.origin.y+5, motorView.frame.size.width-20, 30)];
    YearofReg.text=@"Year of Registration";
    YearofReg.textAlignment=NSTextAlignmentLeft;
    [YearofReg setFont:[UIFont systemFontOfSize:15]];
    YearofReg.textColor=[UIColor blackColor];
    [motorView addSubview:YearofReg];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-26, Categorytypeunderlinelab1.frame.size.height+Categorytypeunderlinelab1.frame.origin.y+12,16, 16)];
    image3.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [motorView addSubview:image3];
    
    UILabel *Categorytypeunderlinelab2=[[UILabel alloc]initWithFrame:CGRectMake(10, YearofReg.frame.size.height+YearofReg.frame.origin.y+2, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab2.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab2];
    
    UIButton *YearofRegbutt=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab1.frame.size.height+Categorytypeunderlinelab1.frame.origin.y+5, motorView.frame.size.width-10, 30)];
    [YearofRegbutt addTarget:self action:@selector(YearofRegbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    YearofRegbutt.backgroundColor=[UIColor clearColor];
    [motorView addSubview:YearofRegbutt];
    
    
    
    kmsDriven=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+5, motorView.frame.size.width-20, 30)];
    kmsDriven.text=@"Kms Driven";
    kmsDriven.textAlignment=NSTextAlignmentLeft;
    [kmsDriven setFont:[UIFont systemFontOfSize:15]];
    kmsDriven.textColor=[UIColor blackColor];
    [motorView addSubview:kmsDriven];
    
    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-26, Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+12,16, 16)];
    image4.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [motorView addSubview:image4];
    
    UILabel *Categorytypeunderlinelab3=[[UILabel alloc]initWithFrame:CGRectMake(10, kmsDriven.frame.size.height+kmsDriven.frame.origin.y+2, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab3.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab3];
    
    UIButton *kmsDrivenbutt=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+5, motorView.frame.size.width-10, 30)];
    [kmsDrivenbutt addTarget:self action:@selector(kmsDrivenbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    kmsDrivenbutt.backgroundColor=[UIColor clearColor];
    [motorView addSubview:kmsDrivenbutt];
    
    
    price=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+5, motorView.frame.size.width-20, 30)];
    price.text=@"Price";
    price.textAlignment=NSTextAlignmentLeft;
    [price setFont:[UIFont systemFontOfSize:15]];
    price.textColor=[UIColor blackColor];
    [motorView addSubview:price];
    
    UIImageView *image5=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-26, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+12,16, 16)];
    image5.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [motorView addSubview:image5];
    
    UILabel *Categorytypeunderlinelab4=[[UILabel alloc]initWithFrame:CGRectMake(10, price.frame.size.height+price.frame.origin.y+2, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab4.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab4];
    
    UIButton *Pricebutt=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+5, motorView.frame.size.width-10, 30)];
    [Pricebutt addTarget:self action:@selector(PricebuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    Pricebutt.backgroundColor=[UIColor clearColor];
    [motorView addSubview:Pricebutt];
    
    
    
    UILabel *YouAre=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab4.frame.size.height+Categorytypeunderlinelab4.frame.origin.y+5, motorView.frame.size.width-20, 30)];
    YouAre.text=@"You are";
    YouAre.textAlignment=NSTextAlignmentLeft;
    [YouAre setFont:[UIFont systemFontOfSize:15]];
    YouAre.textColor=[UIColor blackColor];
    [motorView addSubview:YouAre];
    
    
    button1=[[UIButton alloc]initWithFrame:CGRectMake(10, YouAre.frame.size.height+YouAre.frame.origin.y+5, 24, 24)];
    [button1 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button1.backgroundColor=[UIColor clearColor];
    [button1 addTarget:self action:@selector(Button11Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:button1];
    
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(button1.frame.size.width+button1.frame.origin.x+5, YouAre.frame.size.height+YouAre.frame.origin.y+5, 80, 24)];
    lab1.text=@"Individual";
    lab1.textColor=[UIColor blackColor];
    lab1.textAlignment=NSTextAlignmentLeft;
    lab1.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab1];
    
    button2=[[UIButton alloc]initWithFrame:CGRectMake(lab1.frame.size.width+lab1.frame.origin.x+30, YouAre.frame.size.height+YouAre.frame.origin.y+5, 24, 24)];
    [button2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button2.backgroundColor=[UIColor clearColor];
    [button2 addTarget:self action:@selector(Button22Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:button2];
    
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(button2.frame.size.width+button2.frame.origin.x+5, YouAre.frame.size.height+YouAre.frame.origin.y+5, 80, 24)];
    lab2.text=@"Dealer";
    lab2.textColor=[UIColor blackColor];
    lab2.textAlignment=NSTextAlignmentLeft;
    lab2.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab2];
    
    
    
    txtadtitle=[[UITextField alloc]initWithFrame:CGRectMake(10, lab1.frame.size.height+lab1.frame.origin.y+10, motorView.frame.size.width-20, 40)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Enter Ad title (Min 10 Characters)" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtadtitle.attributedPlaceholder = str;
    txtadtitle.textAlignment=NSTextAlignmentLeft+5;
    txtadtitle.textColor=[UIColor blackColor];
    txtadtitle.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtadtitle.layer.borderWidth=1.0;
    txtadtitle.font = [UIFont systemFontOfSize:15];
    txtadtitle.backgroundColor=[UIColor clearColor];
    txtadtitle.delegate=self;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5,40)];
    txtadtitle.leftView = paddingView;
    txtadtitle.leftViewMode = UITextFieldViewModeAlways;
    [motorView addSubview:txtadtitle];
    
    
    txtadDesc=[[UITextView alloc]initWithFrame:CGRectMake(10, txtadtitle.frame.size.height+txtadtitle.frame.origin.y+10, motorView.frame.size.width-20, 80)];
    txtadDesc.textAlignment=NSTextAlignmentNatural;
    [self setPlaceholder];
    txtadDesc.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtadDesc.layer.borderWidth=1.0;
    txtadDesc.font = [UIFont systemFontOfSize:15];
    txtadDesc.backgroundColor=[UIColor clearColor];
    txtadDesc.delegate=self;
    [motorView addSubview:txtadDesc];
    
    
    UILabel *numberofowners=[[UILabel alloc]initWithFrame:CGRectMake(10, txtadDesc.frame.size.height+txtadDesc.frame.origin.y+5, motorView.frame.size.width-20, 30)];
    numberofowners.text=@"Number of owners";
    numberofowners.textAlignment=NSTextAlignmentLeft;
    [numberofowners setFont:[UIFont systemFontOfSize:15]];
    numberofowners.textColor=[UIColor blackColor];
    [motorView addSubview:numberofowners];
    
    
    button3=[[UIButton alloc]initWithFrame:CGRectMake(10, numberofowners.frame.size.height+numberofowners.frame.origin.y+5, 24, 24)];
    [button3 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button3.backgroundColor=[UIColor clearColor];
    [button3 addTarget:self action:@selector(Button33Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:button3];
    
    UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(button3.frame.size.width+button3.frame.origin.x+5, numberofowners.frame.size.height+numberofowners.frame.origin.y+5, 60, 24)];
    lab3.text=@"One";
    lab3.textColor=[UIColor blackColor];
    lab3.textAlignment=NSTextAlignmentLeft;
    lab3.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab3];
    
    button4=[[UIButton alloc]initWithFrame:CGRectMake(lab3.frame.size.width+lab3.frame.origin.x+20, numberofowners.frame.size.height+numberofowners.frame.origin.y+5, 24, 24)];
    [button4 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button4.backgroundColor=[UIColor clearColor];
    [button4 addTarget:self action:@selector(Button44Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:button4];
    
    UILabel *lab4=[[UILabel alloc]initWithFrame:CGRectMake(button4.frame.size.width+button4.frame.origin.x+5, numberofowners.frame.size.height+numberofowners.frame.origin.y+5, 60, 24)];
    lab4.text=@"Two";
    lab4.textColor=[UIColor blackColor];
    lab4.textAlignment=NSTextAlignmentLeft;
    lab4.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab4];
    
    button5=[[UIButton alloc]initWithFrame:CGRectMake(lab4.frame.size.width+lab4.frame.origin.x+20, numberofowners.frame.size.height+numberofowners.frame.origin.y+5, 24, 24)];
    [button5 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button5.backgroundColor=[UIColor clearColor];
    [button5 addTarget:self action:@selector(Button55Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:button5];
    
    UILabel *lab5=[[UILabel alloc]initWithFrame:CGRectMake(button5.frame.size.width+button5.frame.origin.x+5, numberofowners.frame.size.height+numberofowners.frame.origin.y+5, 60, 24)];
    lab5.text=@"Three";
    lab5.textColor=[UIColor blackColor];
    lab5.textAlignment=NSTextAlignmentLeft;
    lab5.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab5];
    
    
    
    UILabel *Categorytypeunderlinelab5=[[UILabel alloc]initWithFrame:CGRectMake(10, lab3.frame.size.height+lab3.frame.origin.y+15, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab5.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab5];
    
    
    
    insuranceValid=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab5.frame.size.height+Categorytypeunderlinelab5.frame.origin.y+5, motorView.frame.size.width-20, 30)];
    insuranceValid.text=@"Insurance Valid Till";
    insuranceValid.textAlignment=NSTextAlignmentLeft;
    [insuranceValid setFont:[UIFont systemFontOfSize:15]];
    insuranceValid.textColor=[UIColor blackColor];
    [motorView addSubview:insuranceValid];
    
    UIImageView *image6=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-26, Categorytypeunderlinelab5.frame.size.height+Categorytypeunderlinelab5.frame.origin.y+12,16, 16)];
    image6.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [motorView addSubview:image6];
    
    UILabel *Categorytypeunderlinelab6=[[UILabel alloc]initWithFrame:CGRectMake(10, insuranceValid.frame.size.height+insuranceValid.frame.origin.y+2, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab6.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab6];
    
    UIButton *InsuranceValidbutt=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab5.frame.size.height+Categorytypeunderlinelab5.frame.origin.y+5, motorView.frame.size.width-10, 30)];
    [InsuranceValidbutt addTarget:self action:@selector(InsurancebuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    InsuranceValidbutt.backgroundColor=[UIColor clearColor];
    [motorView addSubview:InsuranceValidbutt];
    
    
    
    color=[[UITextField alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab6.frame.size.height+Categorytypeunderlinelab6.frame.origin.y+5, motorView.frame.size.width-20, 30)];
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"Color" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    color.attributedPlaceholder = str3;
    color.textAlignment=NSTextAlignmentLeft;
    color.textColor=[UIColor blackColor];
    color.font = [UIFont systemFontOfSize:15];
    color.backgroundColor=[UIColor clearColor];
    color.delegate=self;
    [motorView addSubview:color];
    
    UIImageView *image7=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-26, Categorytypeunderlinelab6.frame.size.height+Categorytypeunderlinelab6.frame.origin.y+12,16, 16)];
    image7.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [motorView addSubview:image7];
    
    UILabel *Categorytypeunderlinelab7=[[UILabel alloc]initWithFrame:CGRectMake(10, color.frame.size.height+color.frame.origin.y+2, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab7.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab7];
    
    //    UIButton *Colorbutt=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab6.frame.size.height+Categorytypeunderlinelab6.frame.origin.y+5, motorView.frame.size.width-10, 30)];
    //    [Colorbutt addTarget:self action:@selector(ColourbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    Colorbutt.backgroundColor=[UIColor clearColor];
    //    [motorView addSubview:Colorbutt];
    
    
    
    button6=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab7.frame.size.height+Categorytypeunderlinelab7.frame.origin.y+15, 24, 24)];
    [button6 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button6.backgroundColor=[UIColor clearColor];
    [button6 addTarget:self action:@selector(Button66Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:button6];
    
    UILabel *lab6=[[UILabel alloc]initWithFrame:CGRectMake(button6.frame.size.width+button6.frame.origin.x+5, Categorytypeunderlinelab7.frame.size.height+Categorytypeunderlinelab7.frame.origin.y+15, 100, 24)];
    lab6.text=@"I Want to sell";
    lab6.textColor=[UIColor blackColor];
    lab6.textAlignment=NSTextAlignmentLeft;
    lab6.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab6];
    
    button7=[[UIButton alloc]initWithFrame:CGRectMake(10, lab6.frame.size.height+lab6.frame.origin.y+5, 24, 24)];
    [button7 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button7.backgroundColor=[UIColor clearColor];
    [button7 addTarget:self action:@selector(Button77Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:button7];
    
    UILabel *lab7=[[UILabel alloc]initWithFrame:CGRectMake(button7.frame.size.width+button7.frame.origin.x+5, lab6.frame.size.height+lab6.frame.origin.y+5, 100, 24)];
    lab7.text=@"I Want to buy";
    lab7.textColor=[UIColor blackColor];
    lab7.textAlignment=NSTextAlignmentLeft;
    lab7.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab7];
    
    Categorytypeunderlinelab8=[[UILabel alloc]initWithFrame:CGRectMake(10, lab7.frame.size.height+lab7.frame.origin.y+6, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab8.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab8];
    
    
    
    
    UIImageView *image8=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-16, Categorytypeunderlinelab8.frame.origin.y+Categorytypeunderlinelab8.frame.size.height+40, 32, 32)];
    image8.image=[UIImage imageNamed:@"photo-camera-2.png"];
    [motorView addSubview:image8];
    
    UIButton *CamereButt=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-26, Categorytypeunderlinelab8.frame.origin.y+Categorytypeunderlinelab8.frame.size.height+40, 52, 52)];
    [CamereButt addTarget:self action:@selector(Camerabuttclicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:CamereButt];
    
    UILabel *lab8=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-50, image8.frame.origin.y+image8.frame.size.height+5, 100, 15)];
    lab8.text=@"Add Photos";
    lab8.textColor=[UIColor blackColor];
    lab8.textAlignment=NSTextAlignmentCenter;
    lab8.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab8];
}

- (void)setPlaceholder
{
    txtadDesc.text = NSLocalizedString(@"Ad Description (Min 30 Characters)", @"placeholder");
    txtadDesc.textColor = [UIColor lightGrayColor];
    showPlaceHolder = YES;
}






#pragma mark -Motor -Categeory buttons Clicked

-(IBAction)brandNamebuttClicked:(id)sender
{
    [requested showMessage:@"Brand Name Clicked" withTitle:@"Brand Name"];
}

-(IBAction)fuelTypebuttClicked:(id)sender
{
    [Dropobj fadeOut];
    //    [self showPopUpWithTitle:@"Select Fuel Type" withOption:arrfueltype xy:CGPointMake(10, 300) size:CGSizeMake(FuelType.frame.size.width, 200) isMultiple:YES];
    [self showPopUpWithTitle:@"Select Fuel Type" withOption:arrfueltype xy:CGPointMake(16, 260) size:CGSizeMake(287, 200) isMultiple:YES];
}

-(IBAction)YearofRegbuttClicked:(id)sender
{
    [requested showMessage:@"Year of Registration Clicked" withTitle:@"Year of Registration"];
}

-(IBAction)kmsDrivenbuttClicked:(id)sender
{
    [requested showMessage:@"kms Driven Clicked" withTitle:@"Kms Driven"];
}

-(IBAction)PricebuttClicked:(id)sender
{
    [requested showMessage:@"price Clicked" withTitle:@"price"];
}

-(IBAction)InsurancebuttClicked:(id)sender
{
    [self.view endEditing:YES];
    
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-110, 300, 240)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 40)];
    lab1.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:lab1];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-10, 40)];
    lab.text=@"Select Date";
    lab.textColor=[UIColor whiteColor];
    lab.backgroundColor=[UIColor darkGrayColor];
    lab.textAlignment=NSTextAlignmentLeft+10;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60, 0, 50, 40)];
    [butt1 setTitle:@"Done" forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont systemFontOfSize:15];
    butt1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butt1 addTarget:self action:@selector(Doneclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt1];
    
    datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, footerview.frame.size.width, 200)];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.hidden=NO;
    datePicker.date=[NSDate date];
    [datePicker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
    [footerview addSubview:datePicker];
    
}

-(void)LabelTitle:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePicker.date]];
    //assign text to label
    insuranceValid.text=str;
}

-(IBAction)Doneclicked:(id)sender
{
    [datePicker removeFromSuperview];
    [footerview removeFromSuperview];
    popview.hidden = YES;
}



-(IBAction)ColourbuttClicked:(id)sender
{
    [requested showMessage:@"Color Clicked" withTitle:@"Color"];
}


-(IBAction)Camerabuttclicked:(id)sender
{
    self.alertCtrl.popoverPresentationController.sourceView = self.view;
    [self presentViewController:self.alertCtrl animated:YES completion:^{}];
}



#pragma mark -Motor-Individual/Dealer Checked

-(IBAction)Button11Clicked:(id)sender
{
    straccount=@"Individual";
    [button1 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
}

-(IBAction)Button22Clicked:(id)sender
{
    straccount=@"Dealer";
    [button1 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
}
-(IBAction)Button33Clicked:(id)sender
{
    strowners=@"one";
    [button3 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
    [button4 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button5 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
}
-(IBAction)Button44Clicked:(id)sender
{
    strowners=@"Two";
    [button3 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button4 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
    [button5 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
}
-(IBAction)Button55Clicked:(id)sender
{
    strowners=@"Three";
    [button3 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button4 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button5 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
}
-(IBAction)Button66Clicked:(id)sender
{
    strsellingoptions=@"I Want to sell";
    [button6 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
    [button7 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
}
-(IBAction)Button77Clicked:(id)sender
{
    strsellingoptions=@"I Want to buy";
    [button6 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button7 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
}



#pragma mark - Jobs-Categeory view

-(void)JobsView
{
    buttonj1=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
    [buttonj1 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    buttonj1.backgroundColor=[UIColor clearColor];
    [buttonj1 addTarget:self action:@selector(Buttonj1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:buttonj1];
    
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(39, 10, 150, 24)];
    lab1.text=@"I am an employer";
    lab1.textColor=[UIColor blackColor];
    lab1.textAlignment=NSTextAlignmentLeft;
    lab1.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab1];
    
    buttonj2=[[UIButton alloc]initWithFrame:CGRectMake(10, lab1.frame.size.height+lab1.frame.origin.y+5, 24, 24)];
    [buttonj2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    buttonj2.backgroundColor=[UIColor clearColor];
    [buttonj2 addTarget:self action:@selector(Buttonj2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:buttonj2];
    
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(buttonj2.frame.size.width+buttonj2.frame.origin.x+5, lab1.frame.size.height+lab1.frame.origin.y+5, 150, 24)];
    lab2.text=@"I need a Job";
    lab2.textColor=[UIColor blackColor];
    lab2.textAlignment=NSTextAlignmentLeft;
    lab2.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab2];
    
    
    
    CompanyName=[[UITextField alloc]initWithFrame:CGRectMake(10, lab2.frame.size.height+lab2.frame.origin.y+15, motorView.frame.size.width-20, 30)];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Company Name" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    CompanyName.attributedPlaceholder = str1;
    CompanyName.textAlignment=NSTextAlignmentLeft;
    CompanyName.textColor=[UIColor blackColor];
    CompanyName.font = [UIFont systemFontOfSize:15];
    CompanyName.backgroundColor=[UIColor clearColor];
    CompanyName.delegate=self;
    [motorView addSubview:CompanyName];
    
    imagej=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-26, lab2.frame.size.height+lab2.frame.origin.y+22,16, 16)];
    imagej.image=[UIImage imageNamed:@"right-arrow-2.png"];
    imagej.hidden=YES;
    [motorView addSubview:imagej];
    
    UILabel *Categorytypeunderlinelab=[[UILabel alloc]initWithFrame:CGRectMake(10, CompanyName.frame.size.height+CompanyName.frame.origin.y+2, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab];
    
    rolebutt1=[[UIButton alloc]initWithFrame:CGRectMake(10, lab2.frame.size.height+lab2.frame.origin.y+15, motorView.frame.size.width-10, 30)];
    [rolebutt1 addTarget:self action:@selector(Rolebutt1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    rolebutt1.backgroundColor=[UIColor clearColor];
    rolebutt1.hidden=YES;
    [motorView addSubview:rolebutt1];
    
    
    Role=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab.frame.size.height+Categorytypeunderlinelab.frame.origin.y+5, motorView.frame.size.width-20, 30)];
    Role.text=@"Role";
    Role.textAlignment=NSTextAlignmentLeft;
    [Role setFont:[UIFont systemFontOfSize:15]];
    Role.textColor=[UIColor blackColor];
    [motorView addSubview:Role];
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-26, Categorytypeunderlinelab.frame.size.height+Categorytypeunderlinelab.frame.origin.y+12,16, 16)];
    image1.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [motorView addSubview:image1];
    
    UILabel *Categorytypeunderlinelab1=[[UILabel alloc]initWithFrame:CGRectMake(10, Role.frame.size.height+Role.frame.origin.y+2, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab1.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab1];
    
    rolebutt=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab.frame.size.height+Categorytypeunderlinelab.frame.origin.y+5, motorView.frame.size.width-10, 30)];
    [rolebutt addTarget:self action:@selector(RolebuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    rolebutt.backgroundColor=[UIColor clearColor];
    [motorView addSubview:rolebutt];
    
    educationbutt1=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab.frame.size.height+Categorytypeunderlinelab.frame.origin.y+5, motorView.frame.size.width-10, 30)];
    [educationbutt1 addTarget:self action:@selector(educationbutt1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    educationbutt1.backgroundColor=[UIColor clearColor];
    educationbutt1.hidden=YES;
    [motorView addSubview:educationbutt1];
    
    
    education=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab1.frame.size.height+Categorytypeunderlinelab1.frame.origin.y+5, motorView.frame.size.width-20, 30)];
    education.text=@"Education";
    education.textAlignment=NSTextAlignmentLeft;
    [education setFont:[UIFont systemFontOfSize:15]];
    education.textColor=[UIColor blackColor];
    [motorView addSubview:education];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-26, Categorytypeunderlinelab1.frame.size.height+Categorytypeunderlinelab1.frame.origin.y+12,16, 16)];
    image2.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [motorView addSubview:image2];
    
    UILabel *Categorytypeunderlinelab2=[[UILabel alloc]initWithFrame:CGRectMake(10, education.frame.size.height+education.frame.origin.y+2, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab2.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab2];
    
    educationbutt=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab1.frame.size.height+Categorytypeunderlinelab1.frame.origin.y+5, motorView.frame.size.width-10, 30)];
    [educationbutt addTarget:self action:@selector(educationbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    educationbutt.backgroundColor=[UIColor clearColor];
    [motorView addSubview:educationbutt];
    
    experiencebutt1=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab1.frame.size.height+Categorytypeunderlinelab1.frame.origin.y+5, motorView.frame.size.width-10, 30)];
    [experiencebutt1 addTarget:self action:@selector(experiencebutt1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    experiencebutt1.backgroundColor=[UIColor clearColor];
    experiencebutt1.hidden=YES;
    [motorView addSubview:experiencebutt1];
    
    
    experience=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+5, motorView.frame.size.width-20, 30)];
    experience.text=@"Experience";
    experience.textAlignment=NSTextAlignmentLeft;
    [experience setFont:[UIFont systemFontOfSize:15]];
    experience.textColor=[UIColor blackColor];
    [motorView addSubview:experience];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-26, Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+12,16, 16)];
    image3.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [motorView addSubview:image3];
    
    UILabel *Categorytypeunderlinelab3=[[UILabel alloc]initWithFrame:CGRectMake(10, experience.frame.size.height+experience.frame.origin.y+2, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab3.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab3];
    
    experiencebutt=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+5, motorView.frame.size.width-10, 30)];
    [experiencebutt addTarget:self action:@selector(experiencebuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    experiencebutt.backgroundColor=[UIColor clearColor];
    [motorView addSubview:experiencebutt];
    
    compensationbutt1=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+5, motorView.frame.size.width-10, 30)];
    [compensationbutt1 addTarget:self action:@selector(compensationbutt1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    compensationbutt1.backgroundColor=[UIColor clearColor];
    compensationbutt1.hidden=YES;
    [motorView addSubview:compensationbutt1];
    
    
    
    compensation=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+5, motorView.frame.size.width-20, 30)];
    compensation.text=@"Compensation";
    compensation.textAlignment=NSTextAlignmentLeft;
    [compensation setFont:[UIFont systemFontOfSize:15]];
    compensation.textColor=[UIColor blackColor];
    [motorView addSubview:compensation];
    
    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-26, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+12,16, 16)];
    image4.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [motorView addSubview:image4];
    
    UILabel *Categorytypeunderlinelab4=[[UILabel alloc]initWithFrame:CGRectMake(10, compensation.frame.size.height+compensation.frame.origin.y+2, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab4.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab4];
    
    compensationbutt=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+5, motorView.frame.size.width-10, 30)];
    [compensationbutt addTarget:self action:@selector(compensationbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    compensationbutt.backgroundColor=[UIColor clearColor];
    [motorView addSubview:compensationbutt];
    
    willingtolocate=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+5, motorView.frame.size.width-10, 30)];
    [willingtolocate addTarget:self action:@selector(WillingtobuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    willingtolocate.backgroundColor=[UIColor clearColor];
    willingtolocate.hidden=YES;
    [motorView addSubview:willingtolocate];
    
    
    txtadtitle=[[UITextField alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab4.frame.size.height+Categorytypeunderlinelab4.frame.origin.y+15, motorView.frame.size.width-20, 40)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Enter Ad title (Min 10 Characters)" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtadtitle.attributedPlaceholder = str;
    txtadtitle.textAlignment=NSTextAlignmentLeft+5;
    txtadtitle.textColor=[UIColor blackColor];
    txtadtitle.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtadtitle.layer.borderWidth=1.0;
    txtadtitle.font = [UIFont systemFontOfSize:15];
    txtadtitle.backgroundColor=[UIColor clearColor];
    txtadtitle.delegate=self;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5,40)];
    txtadtitle.leftView = paddingView;
    txtadtitle.leftViewMode = UITextFieldViewModeAlways;
    [motorView addSubview:txtadtitle];
    
    
    txtadDesc=[[UITextView alloc]initWithFrame:CGRectMake(10, txtadtitle.frame.size.height+txtadtitle.frame.origin.y+10, motorView.frame.size.width-20, 80)];
    txtadDesc.textAlignment=NSTextAlignmentNatural;
    [self setPlaceholder];
    txtadDesc.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtadDesc.layer.borderWidth=1.0;
    txtadDesc.font = [UIFont systemFontOfSize:15];
    txtadDesc.backgroundColor=[UIColor clearColor];
    txtadDesc.delegate=self;
    [motorView addSubview:txtadDesc];
    
    
    ChoosefileAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(10, txtadDesc.frame.origin.y+txtadDesc.frame.size.height+15, 100, 20)];
    [ChoosefileAdbutt setTitle:@"Choose File" forState:UIControlStateNormal];
    ChoosefileAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [ChoosefileAdbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ChoosefileAdbutt.titleLabel.font = [UIFont systemFontOfSize:14];
    [[ChoosefileAdbutt layer] setBorderWidth:1.0f];
    [[ChoosefileAdbutt layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [[ChoosefileAdbutt layer] setCornerRadius:8.0f];
    [[ChoosefileAdbutt layer] setMasksToBounds:YES];
    [ChoosefileAdbutt addTarget:self action:@selector(ChoosefileButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    ChoosefileAdbutt.backgroundColor= [UIColor whiteColor];
    ChoosefileAdbutt.hidden=YES;
    [motorView addSubview:ChoosefileAdbutt];
    
    nofilelab=[[UILabel alloc]initWithFrame:CGRectMake(ChoosefileAdbutt.frame.size.width+ChoosefileAdbutt.frame.origin.x+5, txtadDesc.frame.size.height+txtadDesc.frame.origin.y+15,180, 20)];
    nofilelab.text=@"no file selected";
    nofilelab.textAlignment=NSTextAlignmentLeft;
    [nofilelab setFont:[UIFont systemFontOfSize:14]];
    nofilelab.textColor=[UIColor blackColor];
    nofilelab.hidden=YES;
    [motorView addSubview:nofilelab];
    
    
    
    UIImageView *image8=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-16, nofilelab.frame.origin.y+nofilelab.frame.size.height+40, 32, 32)];
    image8.image=[UIImage imageNamed:@"photo-camera-2.png"];
    [motorView addSubview:image8];
    
    UIButton *CamereButt=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-26, nofilelab.frame.origin.y+nofilelab.frame.size.height+40, 52, 52)];
    [CamereButt addTarget:self action:@selector(Camerabuttclicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:CamereButt];
    
    UILabel *lab8=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width/2-50, image8.frame.origin.y+image8.frame.size.height+5, 100, 15)];
    lab8.text=@"Add Photos";
    lab8.textColor=[UIColor blackColor];
    lab8.textAlignment=NSTextAlignmentCenter;
    lab8.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab8];
}





#pragma mark -Jobs -Categeory buttons Clicked

-(IBAction)RolebuttClicked:(id)sender
{
    [requested showMessage:@"Role Clicked" withTitle:@"Role"];
}


-(IBAction)educationbuttClicked:(id)sender
{
    [requested showMessage:@"Education Clicked" withTitle:@"Education"];
}

-(IBAction)experiencebuttClicked:(id)sender
{
    [requested showMessage:@"Experience Clicked" withTitle:@"Experience"];
}

-(IBAction)compensationbuttClicked:(id)sender
{
    [requested showMessage:@"Compensation Clicked" withTitle:@"Compensation"];
}




-(IBAction)Rolebutt1Clicked:(id)sender
{
    [requested showMessage:@"Role1 Clicked" withTitle:@"Role1"];
}

-(IBAction)educationbutt1Clicked:(id)sender
{
    [requested showMessage:@"Education1 Clicked" withTitle:@"Education1"];
}

-(IBAction)experiencebutt1Clicked:(id)sender
{
    [requested showMessage:@"Experience1 Clicked" withTitle:@"Experience1"];
}

-(IBAction)compensationbutt1Clicked:(id)sender
{
    [requested showMessage:@"Compensation1 Clicked" withTitle:@"Compensation1"];
}

-(IBAction)WillingtobuttClicked:(id)sender
{
    [requested showMessage:@"Willing to Relocate Clicked" withTitle:@"Relocate"];
}

-(IBAction)ChoosefileButtClicked:(id)sender
{
    self.alertCtrl.popoverPresentationController.sourceView = self.view;
    [self presentViewController:self.alertCtrl animated:YES completion:^{}];
}


#pragma mark -Jobs-employer/job Checked

-(IBAction)Buttonj1Clicked:(id)sender
{
    strjobOption=@"I am an employer";
    [buttonj1 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
    [buttonj2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    
    ChoosefileAdbutt.hidden=YES;
    nofilelab.hidden=YES;
    imagej.hidden=YES;
    
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Company Name" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    CompanyName.attributedPlaceholder = str1;
    Role.text=@"Role";
    education.text=@"Education";
    experience.text=@"Experience";
    compensation.text=@"Compensation";
    
    rolebutt1.hidden=YES;
    educationbutt1.hidden=YES;
    experiencebutt1.hidden=YES;
    compensationbutt1.hidden=YES;
    willingtolocate.hidden=YES;
    
    
    rolebutt.hidden=NO;
    educationbutt.hidden=NO;
    experiencebutt.hidden=NO;
    compensationbutt.hidden=NO;
}

-(IBAction)Buttonj2Clicked:(id)sender
{
    strjobOption=@"I need a Job";
    [buttonj1 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [buttonj2 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
    
    ChoosefileAdbutt.hidden=NO;
    nofilelab.hidden=NO;
    imagej.hidden=NO;
    
    rolebutt1.hidden=NO;
    educationbutt1.hidden=NO;
    experiencebutt1.hidden=NO;
    compensationbutt1.hidden=NO;
    willingtolocate.hidden=NO;
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Role" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    CompanyName.attributedPlaceholder = str1;
    
    
    Role.text=@"Education";
    education.text=@"Experience";
    experience.text=@"Current sallry";
    compensation.text=@"Willing to Relocate";
    
    rolebutt.hidden=YES;
    educationbutt.hidden=YES;
    experiencebutt.hidden=YES;
    compensationbutt.hidden=YES;
}



#pragma mark - Property On Rent / sale-Categeory view

-(void)PropertyOnRentandsellView
{
    buttonpr1=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
    [buttonpr1 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    buttonpr1.backgroundColor=[UIColor clearColor];
    [buttonpr1 addTarget:self action:@selector(Buttonpr1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [PropertyonRentView addSubview:buttonpr1];
    
    labP1=[[UILabel alloc]initWithFrame:CGRectMake(39, 10, 280, 24)];
    if ([_strCategeory isEqualToString:@"Property for Rent"])
    {
        labP1.text=@"I want to give on rent i am a landlord";
    }
    else if ([_strCategeory isEqualToString:@"Property for Sale"])
    {
        labP1.text=@"I am a seller";
    }
    labP1.textColor=[UIColor blackColor];
    labP1.textAlignment=NSTextAlignmentLeft;
    labP1.font=[UIFont systemFontOfSize:15];
    [PropertyonRentView addSubview:labP1];
    
    buttonpr2=[[UIButton alloc]initWithFrame:CGRectMake(10, labP1.frame.size.height+labP1.frame.origin.y+5, 24, 24)];
    [buttonpr2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    buttonpr2.backgroundColor=[UIColor clearColor];
    [buttonpr2 addTarget:self action:@selector(Buttonpr2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [PropertyonRentView addSubview:buttonpr2];
    
    labP2=[[UILabel alloc]initWithFrame:CGRectMake(buttonpr2.frame.size.width+buttonpr2.frame.origin.x+5, labP1.frame.size.height+labP1.frame.origin.y+5, 280, 24)];
    if ([_strCategeory isEqualToString:@"Property for Rent"])
    {
        labP2.text=@"I want to take on rent i am a tenant";
    }
    else if ([_strCategeory isEqualToString:@"Property for Sale"])
    {
        labP2.text=@"I am a buyer";
    }
    labP2.textColor=[UIColor blackColor];
    labP2.textAlignment=NSTextAlignmentLeft;
    labP2.font=[UIFont systemFontOfSize:15];
    [PropertyonRentView addSubview:labP2];
    
    UILabel *Categorytypeunderlinelab=[[UILabel alloc]initWithFrame:CGRectMake(10, labP2.frame.size.height+labP2.frame.origin.y+10, PropertyonRentView.frame.size.width-20, 1)];
    Categorytypeunderlinelab.backgroundColor=[UIColor lightGrayColor];
    [PropertyonRentView addSubview:Categorytypeunderlinelab];
    
    UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab.frame.size.height+Categorytypeunderlinelab.frame.origin.y+5, 180, 24)];
    lab3.text=@"You are:";
    lab3.textColor=[UIColor blackColor];
    lab3.textAlignment=NSTextAlignmentLeft;
    lab3.font=[UIFont systemFontOfSize:15];
    [PropertyonRentView addSubview:lab3];
    
    
    
    buttonpr3=[[UIButton alloc]initWithFrame:CGRectMake(10, lab3.frame.size.height+lab3.frame.origin.y+6, 24, 24)];
    [buttonpr3 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    buttonpr3.backgroundColor=[UIColor clearColor];
    [buttonpr3 addTarget:self action:@selector(Buttonpr3Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [PropertyonRentView addSubview:buttonpr3];
    
    UILabel *lab4=[[UILabel alloc]initWithFrame:CGRectMake(39, lab3.frame.size.height+lab3.frame.origin.y+6, 240, 24)];
    lab4.text=@"Individual";
    lab4.textColor=[UIColor blackColor];
    lab4.textAlignment=NSTextAlignmentLeft;
    lab4.font=[UIFont systemFontOfSize:15];
    [PropertyonRentView addSubview:lab4];
    
    buttonpr4=[[UIButton alloc]initWithFrame:CGRectMake(10, lab4.frame.size.height+lab4.frame.origin.y+5, 24, 24)];
    [buttonpr4 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    buttonpr4.backgroundColor=[UIColor clearColor];
    [buttonpr4 addTarget:self action:@selector(Buttonpr4Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [PropertyonRentView addSubview:buttonpr4];
    
    UILabel *lab5=[[UILabel alloc]initWithFrame:CGRectMake(buttonpr4.frame.size.width+buttonpr4.frame.origin.x+5, lab4.frame.size.height+lab4.frame.origin.y+5, 280, 24)];
    lab5.text=@"Broker";
    lab5.textColor=[UIColor blackColor];
    lab5.textAlignment=NSTextAlignmentLeft;
    lab5.font=[UIFont systemFontOfSize:15];
    [PropertyonRentView addSubview:lab5];
    
    
    buttonpr5=[[UIButton alloc]initWithFrame:CGRectMake(10, lab5.frame.size.height+lab5.frame.origin.y+5, 24, 24)];
    [buttonpr5 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    buttonpr5.backgroundColor=[UIColor clearColor];
    [buttonpr5 addTarget:self action:@selector(Buttonpr5Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [PropertyonRentView addSubview:buttonpr5];
    
    UILabel *lab6=[[UILabel alloc]initWithFrame:CGRectMake(buttonpr5.frame.size.width+buttonpr5.frame.origin.x+5, lab5.frame.size.height+lab5.frame.origin.y+5, 280, 24)];
    lab6.text=@"Builder";
    lab6.textColor=[UIColor blackColor];
    lab6.textAlignment=NSTextAlignmentLeft;
    lab6.font=[UIFont systemFontOfSize:15];
    [PropertyonRentView addSubview:lab6];
    
    UILabel *Categorytypeunderlinelab1=[[UILabel alloc]initWithFrame:CGRectMake(10, lab6.frame.size.height+lab6.frame.origin.y+10, PropertyonRentView.frame.size.width-20, 1)];
    Categorytypeunderlinelab1.backgroundColor=[UIColor lightGrayColor];
    [PropertyonRentView addSubview:Categorytypeunderlinelab1];
    
    
    
    txtprice=[[UITextField alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab1.frame.size.height+Categorytypeunderlinelab1.frame.origin.y+5, PropertyonRentView.frame.size.width-20, 30)];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Price" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtprice.attributedPlaceholder = str1;
    txtprice.textAlignment=NSTextAlignmentLeft;
    txtprice.textColor=[UIColor blackColor];
    txtprice.font = [UIFont systemFontOfSize:15];
    txtprice.backgroundColor=[UIColor clearColor];
    txtprice.delegate=self;
    [PropertyonRentView addSubview:txtprice];
    
    UILabel *Categorytypeunderlinelab2=[[UILabel alloc]initWithFrame:CGRectMake(10, txtprice.frame.size.height+txtprice.frame.origin.y+2, PropertyonRentView.frame.size.width-20, 1)];
    Categorytypeunderlinelab2.backgroundColor=[UIColor lightGrayColor];
    [PropertyonRentView addSubview:Categorytypeunderlinelab2];
    
    
    
    noofroomslab=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+5, PropertyonRentView.frame.size.width-20, 30)];
    noofroomslab.text=@"No. of Rooms";
    noofroomslab.textAlignment=NSTextAlignmentLeft;
    [noofroomslab setFont:[UIFont systemFontOfSize:15]];
    noofroomslab.textColor=[UIColor blackColor];
    [PropertyonRentView addSubview:noofroomslab];
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-26, Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+12,16, 16)];
    image.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [PropertyonRentView addSubview:image];
    
    UILabel *Categorytypeunderlinelab4=[[UILabel alloc]initWithFrame:CGRectMake(10, noofroomslab.frame.size.height+noofroomslab.frame.origin.y+2, PropertyonRentView.frame.size.width-20, 1)];
    Categorytypeunderlinelab4.backgroundColor=[UIColor lightGrayColor];
    [PropertyonRentView addSubview:Categorytypeunderlinelab4];
    
    UIButton *noofroomsbutt=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+5, PropertyonRentView.frame.size.width-10, 30)];
    [noofroomsbutt addTarget:self action:@selector(noofroomsbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    noofroomsbutt.backgroundColor=[UIColor clearColor];
    [PropertyonRentView addSubview:noofroomsbutt];
    
    
    
    txtareasquare=[[UITextField alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab4.frame.size.height+Categorytypeunderlinelab4.frame.origin.y+5, PropertyonRentView.frame.size.width-20, 30)];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"Area Sq. Ft." attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtareasquare.attributedPlaceholder = str2;
    txtareasquare.textAlignment=NSTextAlignmentLeft;
    txtareasquare.textColor=[UIColor blackColor];
    txtareasquare.font = [UIFont systemFontOfSize:15];
    txtareasquare.backgroundColor=[UIColor clearColor];
    txtareasquare.delegate=self;
    [PropertyonRentView addSubview:txtareasquare];
    
    UILabel *Categorytypeunderlinelab3=[[UILabel alloc]initWithFrame:CGRectMake(10, txtareasquare.frame.size.height+txtareasquare.frame.origin.y+2, PropertyonRentView.frame.size.width-20, 1)];
    Categorytypeunderlinelab3.backgroundColor=[UIColor lightGrayColor];
    [PropertyonRentView addSubview:Categorytypeunderlinelab3];
    
    
    
    
    furnishedlab=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+5, PropertyonRentView.frame.size.width-20, 30)];
    furnishedlab.text=@"Furnished";
    furnishedlab.textAlignment=NSTextAlignmentLeft;
    [furnishedlab setFont:[UIFont systemFontOfSize:15]];
    furnishedlab.textColor=[UIColor blackColor];
    [PropertyonRentView addSubview:furnishedlab];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-26, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+12,16, 16)];
    image2.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [PropertyonRentView addSubview:image2];
    
    UILabel *Categorytypeunderlinelab5=[[UILabel alloc]initWithFrame:CGRectMake(10, furnishedlab.frame.size.height+furnishedlab.frame.origin.y+2, PropertyonRentView.frame.size.width-20, 1)];
    Categorytypeunderlinelab5.backgroundColor=[UIColor lightGrayColor];
    [PropertyonRentView addSubview:Categorytypeunderlinelab5];
    
    UIButton *furnishrebutt=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+5, PropertyonRentView.frame.size.width-10, 30)];
    [furnishrebutt addTarget:self action:@selector(furnishedbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    furnishrebutt.backgroundColor=[UIColor clearColor];
    [PropertyonRentView addSubview:furnishrebutt];
    
    
    
    txtadtitle=[[UITextField alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab5.frame.size.height+Categorytypeunderlinelab5.frame.origin.y+15, motorView.frame.size.width-20, 40)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Enter Ad title (Min 10 Characters)" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtadtitle.attributedPlaceholder = str;
    txtadtitle.textAlignment=NSTextAlignmentLeft+5;
    txtadtitle.textColor=[UIColor blackColor];
    txtadtitle.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtadtitle.layer.borderWidth=1.0;
    txtadtitle.font = [UIFont systemFontOfSize:15];
    txtadtitle.backgroundColor=[UIColor clearColor];
    txtadtitle.delegate=self;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5,40)];
    txtadtitle.leftView = paddingView;
    txtadtitle.leftViewMode = UITextFieldViewModeAlways;
    [PropertyonRentView addSubview:txtadtitle];
    
    
    txtadDesc=[[UITextView alloc]initWithFrame:CGRectMake(10, txtadtitle.frame.size.height+txtadtitle.frame.origin.y+10, motorView.frame.size.width-20, 80)];
    txtadDesc.textAlignment=NSTextAlignmentNatural;
    [self setPlaceholder];
    txtadDesc.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtadDesc.layer.borderWidth=1.0;
    txtadDesc.font = [UIFont systemFontOfSize:15];
    txtadDesc.backgroundColor=[UIColor clearColor];
    txtadDesc.delegate=self;
    [PropertyonRentView addSubview:txtadDesc];
    
    
    
    UIImageView *image8=[[UIImageView alloc]initWithFrame:CGRectMake(PropertyonRentView.frame.size.width/2-16, txtadDesc.frame.origin.y+txtadDesc.frame.size.height+40, 32, 32)];
    image8.image=[UIImage imageNamed:@"photo-camera-2.png"];
    [PropertyonRentView addSubview:image8];
    
    UIButton *CamereButt=[[UIButton alloc]initWithFrame:CGRectMake(PropertyonRentView.frame.size.width/2-26, txtadDesc.frame.origin.y+txtadDesc.frame.size.height+40, 52, 52)];
    [CamereButt addTarget:self action:@selector(Camerabuttclicked:) forControlEvents:UIControlEventTouchUpInside];
    [PropertyonRentView addSubview:CamereButt];
    
    UILabel *lab8=[[UILabel alloc]initWithFrame:CGRectMake(PropertyonRentView.frame.size.width/2-50, image8.frame.origin.y+image8.frame.size.height+5, 100, 15)];
    lab8.text=@"Add Photos";
    lab8.textColor=[UIColor blackColor];
    lab8.textAlignment=NSTextAlignmentCenter;
    lab8.font=[UIFont systemFontOfSize:15];
    [PropertyonRentView addSubview:lab8];
}



#pragma mark -Propertyonrent/sale- button options

-(IBAction)noofroomsbuttClicked:(id)sender
{
    [requested showMessage:@"No of rooms Clicked" withTitle:@"No of rooms"];
}

-(IBAction)furnishedbuttClicked:(id)sender
{
    [requested showMessage:@"furnished Clicked" withTitle:@"furnished"];
}


#pragma mark -Propertyonrent/sale- Checked

-(IBAction)Buttonpr1Clicked:(id)sender
{
    if ([_strCategeory isEqualToString:@"Property for Rent"])
    {
        strwanttogive=@"I want to give on rent i am a landlord";
    }
    else if ([_strCategeory isEqualToString:@"Property for Sale"])
    {
        strsellerbuyer=@"I am a seller";
    }
    
    [buttonpr1 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
    [buttonpr2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
}


-(IBAction)Buttonpr2Clicked:(id)sender
{
    if ([_strCategeory isEqualToString:@"Property for Rent"])
    {
        strwanttogive=@"I want to take on rent i am a tenant";
    }
    else if ([_strCategeory isEqualToString:@"Property for Sale"])
    {
        strsellerbuyer=@"I am a buyer";
    }
    
    [buttonpr1 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [buttonpr2 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
}

-(IBAction)Buttonpr3Clicked:(id)sender
{
    strindiviself=@"Individual";
    [buttonpr3 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
    [buttonpr4 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [buttonpr5 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
}

-(IBAction)Buttonpr4Clicked:(id)sender
{
    strindiviself=@"Broker";
    [buttonpr3 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [buttonpr4 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
    [buttonpr5 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
}

-(IBAction)Buttonpr5Clicked:(id)sender
{
    strindiviself=@"Builder";
    [buttonpr3 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [buttonpr4 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [buttonpr5 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
}











#pragma mark - Post Ads Different Categeory


-(IBAction)MotorPostButtClicked:(id)sender
{
    [self.view endEditing:YES];
    
    if (txtadtitle.text.length==0)
    {
        [requested showMessage:@"Please Enter Add Title" withTitle:@"Warning"];
    }
    else if (txtadtitle.text.length<10)
    {
        [requested showMessage:@"Please Enter Minimum 10 Characters for Ad Title" withTitle:@"Warning"];
    }
    else if (txtadDesc.text.length==0)
    {
        [requested showMessage:@"Please Enter Add Description" withTitle:@"Warning"];
    }
    else if (txtadDesc.text.length<36)
    {
        [requested showMessage:@"Please Enter Minimum 30 Characters for Ad Description" withTitle:@"Warning"];
    }
    else if (txtmake.text.length==0)
    {
        [requested showMessage:@"Please select Car Make" withTitle:@"Warning"];
    }
    else if (txtModel.text.length==0)
    {
        [requested showMessage:@"Please Select Car Model" withTitle:@"Warning"];
    }
    else if (txtyear.text.length==0)
    {
        [requested showMessage:@"Please Enter Car Model Year" withTitle:@"Warning"];
    }
    else if (txtCarprice.text.length==0)
    {
        [requested showMessage:@"Please Enter Your Car Price" withTitle:@"Warning"];
    }
    else if (txtKilometer.text.length==0)
    {
        [requested showMessage:@"Please Enter Kilometers Driven by Car" withTitle:@"Warning"];
    }
    else if (txtlocality.text.length==0)
    {
        [requested showMessage:@"Please Select Your locality" withTitle:@"Warning"];
    }
    else if (arrlocations.count==0)
    {
        [requested showMessage:@"Please Select Atleast One Image to Display Ad" withTitle:@"Warning"];
    }
    else
    {
        NSString *string = txtemail.text;
        string = [string stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceCharacterSet]];
        txtemail.text=string;
        
        NSString *strtit=[NSString stringWithFormat:@"%@",txtadtitle.text];
        NSString *strdes=[NSString stringWithFormat:@"%@",txtadDesc.text];
        
        NSString *encodetitle=[strtit stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        NSString *encodeDescription=[strdes stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        
        encodetitle=[strtit stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        encodeDescription=[strdes stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        
        NSString *struserlat=[NSString stringWithFormat:@"%f",latitude];
        NSString *struserlong=[NSString stringWithFormat:@"%f",longitude];
        
        
        carpostvalue=[[NSMutableDictionary alloc]init];
        [carpostvalue setObject:encodetitle forKey:@"name"];
        [carpostvalue setObject:encodeDescription forKey:@"description"];
        [carpostvalue setObject:strmakeid forKey:@"make_id"];
        [carpostvalue setObject:strmodelid forKey:@"model_id"];
        [carpostvalue setObject:txtyear.text forKey:@"year"];
        [carpostvalue setObject:txtCarprice.text forKey:@"price"];
        [carpostvalue setObject:strusername forKey:@"contact_name"];
        [carpostvalue setObject:struseremail forKey:@"contact_email"];
        [carpostvalue setObject:strusemobile forKey:@"contact_no"];
        [carpostvalue setObject:txtKilometer.text forKey:@"kilometer"];
        //   [carpostvalue setObject:_strCategoryIdForPost forKey:@"category_id"];
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:carpostvalue
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            jsonStringValues = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"jsonString: %@",jsonStringValues);
        }
        
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *struserid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        NSString *post = [NSString stringWithFormat:@"user_id=%@&value=%@&option=%@&pic=%@&coverphoto=%@&latitude=%@&longitude=%@&device=%@",struserid,jsonStringValues,jsonStringOptions,strUploadPic,strCoverPhoto,struserlat,struserlong,@"ios"];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,CarAddPost,arabic,strCityId];
        [requested PostAddRequest:post withUrl:strurl];
    }
}


-(void)PostAddResponse:(NSMutableDictionary *)responseToken
{
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        [self.navigationController popViewControllerAnimated:YES];
        
        NSLog(@"Posting Add Response: %@",responseToken);
        
        [requested showMessage:@"Your Add has been Successfully Posted to the BoxBazar" withTitle:@"Post Ad"];
    }
    else if ([strstatus isEqualToString:@"0"])
    {
        NSLog(@"Posting Add Response: %@",responseToken);
        [requested showMessage:[responseToken valueForKey:@"message"] withTitle:@"Post Ad"];
    }
    else
    {
        NSLog(@"Posting Add Response: %@",responseToken);
        [requested showMessage:@"There is some Server Error.Please Try after some Time" withTitle:@"Post Ad"];
    }
}


-(IBAction)MotorPostButtClicked2:(id)sender
{
    [self.view endEditing:YES];
    
    if (txtadtitle.text.length==0)
    {
        [requested showMessage:@"Please Enter Add Title" withTitle:@"Warning"];
    }
    else if (txtadtitle.text.length<10)
    {
        [requested showMessage:@"Please Enter Minimum 10 Characters for Ad Title" withTitle:@"Warning"];
    }
    else if (txtadDesc.text.length==0)
    {
        [requested showMessage:@"Please Enter Add Description" withTitle:@"Warning"];
    }
    else if (txtadDesc.text.length<36)
    {
        [requested showMessage:@"Please Enter Minimum 30 Characters for Ad Description" withTitle:@"Warning"];
    }
    else if (txtCarprice.text.length==0)
    {
        [requested showMessage:@"Please Enter Your Price" withTitle:@"Warning"];
    }
    else if (txtlocality.text.length==0)
    {
        [requested showMessage:@"Please Select Your locality" withTitle:@"Warning"];
    }
    else if (arrlocations.count==0)
    {
        [requested showMessage:@"Please Select Atleast One Image to Display Ad" withTitle:@"Warning"];
    }
    else
    {
        NSString *string = txtemail.text;
        string = [string stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceCharacterSet]];
        txtemail.text=string;
        
        
        //        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789!@#$%^&*(){}[]|;"];
        //
        //        NSString *encodetitle = [txtadtitle.text stringByAddingPercentEncodingWithAllowedCharacters:set];
        //        NSString *encodeDescription = [txtadDesc.text stringByAddingPercentEncodingWithAllowedCharacters:set];
        
        
        //        NSString *encodetitle = [txtadtitle.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //        NSString *encodeDescription = [txtadDesc.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *strtit=[NSString stringWithFormat:@"%@",txtadtitle.text];
        NSString *strdes=[NSString stringWithFormat:@"%@",txtadDesc.text];
        
        NSString *encodetitle=[strtit stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        NSString *encodeDescription=[strdes stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        
        encodetitle=[strtit stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        encodeDescription=[strdes stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        
        NSString *struserlat=[NSString stringWithFormat:@"%f",latitude];
        NSString *struserlong=[NSString stringWithFormat:@"%f",longitude];
        
        carpostvalue=[[NSMutableDictionary alloc]init];
        [carpostvalue setObject:encodetitle forKey:@"name"];
        [carpostvalue setObject:encodeDescription forKey:@"description"];
        [carpostvalue setObject:txtCarprice.text forKey:@"price"];
        [carpostvalue setObject:strusername forKey:@"contact_name"];
        [carpostvalue setObject:struseremail forKey:@"contact_email"];
        [carpostvalue setObject:strusemobile forKey:@"contact"];
        
        if (_strCategoryIdForPost == (id)[NSNull null] || _strCategoryIdForPost.length == 0 )
        {
            [carpostvalue setObject:_strcategeoryTypeid forKey:@"category_id"];
        }
        else
        {
            [carpostvalue setObject:_strCategoryIdForPost forKey:@"category_id"];
        }
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:carpostvalue
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            jsonStringValues = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            jsonStringValues = [jsonStringValues stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
            NSLog(@"jsonString: %@",jsonStringValues);
        }
        
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *struserid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        NSString *post = [NSString stringWithFormat:@"module=%@&user_id=%@&value=%@&option=%@&pic=%@&coverphoto=%@&latitude=%@&longitude=%@&device=%@",_strcategeoryTypeurl_parameter,struserid,jsonStringValues,jsonStringOptions,strUploadPic,strCoverPhoto,struserlat,struserlong,@"ios"];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,AddPost,arabic,strCityId];
        [requested PostAddRequest:post withUrl:strurl];
    }
}





-(IBAction)CommunityPostButtClicked2:(id)sender
{
    [self.view endEditing:YES];
    
    if (txtadtitle.text.length==0)
    {
        [requested showMessage:@"Please Enter Add Title" withTitle:@"Warning"];
    }
    else if (txtadtitle.text.length<10)
    {
        [requested showMessage:@"Please Enter Minimum 10 Characters for Ad Title" withTitle:@"Warning"];
    }
    else if (txtadDesc.text.length==0)
    {
        [requested showMessage:@"Please Enter Add Description" withTitle:@"Warning"];
    }
    else if (txtadDesc.text.length<36)
    {
        [requested showMessage:@"Please Enter Minimum 30 Characters for Ad Description" withTitle:@"Warning"];
    }
    else if (txtlocality.text.length==0)
    {
        [requested showMessage:@"Please Select Your locality" withTitle:@"Warning"];
    }
    else if (arrlocations.count==0)
    {
        [requested showMessage:@"Please Select Atleast One Image to Display Ad" withTitle:@"Warning"];
    }
    else
    {
        NSString *string = txtemail.text;
        string = [string stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceCharacterSet]];
        txtemail.text=string;
        
        NSString *strtit=[NSString stringWithFormat:@"%@",txtadtitle.text];
        NSString *strdes=[NSString stringWithFormat:@"%@",txtadDesc.text];
        
        NSString *encodetitle=[strtit stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        NSString *encodeDescription=[strdes stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        
        encodetitle=[strtit stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        encodeDescription=[strdes stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        
        NSString *struserlat=[NSString stringWithFormat:@"%f",latitude];
        NSString *struserlong=[NSString stringWithFormat:@"%f",longitude];
        
        carpostvalue=[[NSMutableDictionary alloc]init];
        [carpostvalue setObject:encodetitle forKey:@"name"];
        [carpostvalue setObject:encodeDescription forKey:@"description"];
        [carpostvalue setObject:strusername forKey:@"contact_name"];
        [carpostvalue setObject:struseremail forKey:@"contact_email"];
        [carpostvalue setObject:strusemobile forKey:@"contact"];
        
        if (_strCategoryIdForPost == (id)[NSNull null] || _strCategoryIdForPost.length == 0 )
        {
            [carpostvalue setObject:_strcategeoryTypeid forKey:@"category_id"];
        }
        else
        {
            [carpostvalue setObject:_strCategoryIdForPost forKey:@"category_id"];
        }
        
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:carpostvalue
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            jsonStringValues = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"jsonString: %@",jsonStringValues);
        }
        
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *struserid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        NSString *post = [NSString stringWithFormat:@"module=%@&user_id=%@&value=%@&option=%@&pic=%@&coverphoto=%@&latitude=%@&longitude=%@&device=%@",_strcategeoryTypeurl_parameter,struserid,jsonStringValues,jsonStringOptions,strUploadPic,strCoverPhoto,struserlat,struserlong,@"ios"];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,AddPost,arabic,strCityId];
        [requested PostAddRequest:post withUrl:strurl];
    }
}

-(IBAction)JobPostButtClicked:(id)sender
{
    [self.view endEditing:YES];
    
    if (txtadtitle.text.length==0)
    {
        [requested showMessage:@"Please Enter Add Title" withTitle:@"Warning"];
    }
    else if (txtadtitle.text.length<10)
    {
        [requested showMessage:@"Please Enter Minimum 10 Characters for Ad Title" withTitle:@"Warning"];
    }
    else if (txtadDesc.text.length==0)
    {
        [requested showMessage:@"Please Enter Add Description" withTitle:@"Warning"];
    }
    else if (txtadDesc.text.length<36)
    {
        [requested showMessage:@"Please Enter Minimum 30 Characters for Ad Description" withTitle:@"Warning"];
    }
    else if (txtmake.text.length==0)
    {
        [requested showMessage:@"Please Provide Your Job Role" withTitle:@"Warning"];
    }
    else if (txtModel.text.length==0)
    {
        [requested showMessage:@"Please Provide Your Company Name" withTitle:@"Warning"];
    }
    else if (txtlocality.text.length==0)
    {
        [requested showMessage:@"Please Select Your locality" withTitle:@"Warning"];
    }
    else if (arrlocations.count==0)
    {
        [requested showMessage:@"Please Select Atleast One Image to Display Ad" withTitle:@"Warning"];
    }
    else
    {
        NSString *string = txtemail.text;
        string = [string stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceCharacterSet]];
        txtemail.text=string;
        
        NSString *strtit=[NSString stringWithFormat:@"%@",txtadtitle.text];
        NSString *strdes=[NSString stringWithFormat:@"%@",txtadDesc.text];
        
        NSString *encodetitle=[strtit stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        NSString *encodeDescription=[strdes stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        
        encodetitle=[strtit stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        encodeDescription=[strdes stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        
        NSString *struserlat=[NSString stringWithFormat:@"%f",latitude];
        NSString *struserlong=[NSString stringWithFormat:@"%f",longitude];
        
        carpostvalue=[[NSMutableDictionary alloc]init];
        [carpostvalue setObject:encodetitle forKey:@"name"];
        [carpostvalue setObject:encodeDescription forKey:@"description"];
        [carpostvalue setObject:txtmake.text forKey:@"job_role"];
        [carpostvalue setObject:txtModel.text forKey:@"company_name"];
        [carpostvalue setObject:strusername forKey:@"contact_name"];
        [carpostvalue setObject:struseremail forKey:@"contact_email"];
        [carpostvalue setObject:strusemobile forKey:@"contact"];
        
        if (_strCategoryIdForPost == (id)[NSNull null] || _strCategoryIdForPost.length == 0 )
        {
            [carpostvalue setObject:_strcategeoryTypeid forKey:@"category_id"];
        }
        else
        {
            [carpostvalue setObject:_strCategoryIdForPost forKey:@"category_id"];
        }
        
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:carpostvalue
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            jsonStringValues = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"jsonString: %@",jsonStringValues);
        }
        
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *struserid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        NSString *post = [NSString stringWithFormat:@"module=%@&user_id=%@&value=%@&option=%@&pic=%@&coverphoto=%@&latitude=%@&longitude=%@&device=%@",_strcategeoryTypeurl_parameter,struserid,jsonStringValues,jsonStringOptions,strUploadPic,strCoverPhoto,struserlat,struserlong,@"ios"];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,AddPost,arabic,strCityId];
        [requested PostAddRequest:post withUrl:strurl];
    }
}


-(IBAction)PropertyonrentButtClicked:(id)sender
{
    [requested showMessage:@"Property on Rent Clicked" withTitle:@"Property on rent"];
}
-(IBAction)PropertyonsaleButtClicked:(id)sender
{
    [requested showMessage:@"Property on sale Clicked" withTitle:@"Property on sale"];
}




#pragma mark - Common view3 for Contact Information

-(void)commonView3
{
    CommonView3=[[UIView alloc]initWithFrame:CGRectMake(0, motorView.frame.origin.y+motorView.frame.size.height+5, self.view.frame.size.width, 100)];
    CommonView3.backgroundColor=[UIColor clearColor];
    [scrollMainView addSubview:CommonView3];
    
    
    UILabel *contactlab=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, CommonView3.frame.size.width-20, 30)];
    contactlab.text=@"Select Location";
    contactlab.textAlignment=NSTextAlignmentLeft;
    [contactlab setFont:[UIFont boldSystemFontOfSize:15]];
    contactlab.textColor=[UIColor blackColor];
    [CommonView3 addSubview:contactlab];
    
    
    UIView *ContactView=[[UIView alloc]initWithFrame:CGRectMake(0, contactlab.frame.origin.y+contactlab.frame.size.height+5, CommonView3.frame.size.width, 60)];
    ContactView.backgroundColor=[UIColor whiteColor];
    [CommonView3 addSubview:ContactView];
    
    
    txtlocality=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,10, ContactView.frame.size.width-20, 40)];
    [txtlocality setTextFieldPlaceholderText:@"Locality"];
    txtlocality.textColor=[UIColor blackColor];
    txtlocality.textAlignment=NSTextAlignmentRight;
    [txtlocality setFont:[UIFont systemFontOfSize:15]];
    txtlocality.delegate=self;
    txtlocality.textColor=[UIColor blackColor];
    [ContactView addSubview:txtlocality];
    
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 17,16, 16)];
    image1.image=[UIImage imageNamed:@"left.png"];
    [ContactView addSubview:image1];
    
    UIButton *brandnamebutt=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, ContactView.frame.size.width-20, 40)];
    [brandnamebutt addTarget:self action:@selector(localitypClicked:) forControlEvents:UIControlEventTouchUpInside];
    brandnamebutt.backgroundColor=[UIColor clearColor];
    [ContactView addSubview:brandnamebutt];
    
    
    
    
//    CommonView3=[[UIView alloc]initWithFrame:CGRectMake(0, motorView.frame.origin.y+motorView.frame.size.height+5, self.view.frame.size.width, 270)];
//    CommonView3.backgroundColor=[UIColor clearColor];
//    [scrollMainView addSubview:CommonView3];
//    
//    UILabel *contactlab=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, CommonView3.frame.size.width-20, 30)];
//    contactlab.text=@"Your Contact information";
//    contactlab.textAlignment=NSTextAlignmentRight;
//    [contactlab setFont:[UIFont boldSystemFontOfSize:15]];
//    contactlab.textColor=[UIColor blackColor];
//    [CommonView3 addSubview:contactlab];
//    
//    
//    UIView *ContactView=[[UIView alloc]initWithFrame:CGRectMake(0, contactlab.frame.origin.y+contactlab.frame.size.height+5, CommonView3.frame.size.width, 205)];
//    ContactView.backgroundColor=[UIColor whiteColor];
//    [CommonView3 addSubview:ContactView];
//    
//    
//    txtlocality=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,10, ContactView.frame.size.width-20, 40)];
//    [txtlocality setTextFieldPlaceholderText:@"Locality"];
//    txtlocality.textColor=[UIColor blackColor];
//    txtlocality.textAlignment=NSTextAlignmentRight;
//    [txtlocality setFont:[UIFont systemFontOfSize:15]];
//    txtlocality.delegate=self;
//    txtlocality.textColor=[UIColor blackColor];
//    [ContactView addSubview:txtlocality];
//    
//    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 17,16, 16)];
//    image1.image=[UIImage imageNamed:@"left.png"];
//    [ContactView addSubview:image1];
//    
//    UIButton *brandnamebutt=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, ContactView.frame.size.width-20, 40)];
//    [brandnamebutt addTarget:self action:@selector(localityClicked:) forControlEvents:UIControlEventTouchUpInside];
//    brandnamebutt.backgroundColor=[UIColor clearColor];
//    [ContactView addSubview:brandnamebutt];
//    
//    
//    
//    
//    txtName=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,txtlocality.frame.size.height+txtlocality.frame.origin.y+10, motorView.frame.size.width-20, 40)];
//    [txtName setTextFieldPlaceholderText:@"Name"];
//    txtName.textColor=[UIColor blackColor];
//    txtName.textAlignment=NSTextAlignmentRight;
//    [txtName setFont:[UIFont systemFontOfSize:15]];
//    txtName.delegate=self;
//    txtName.textColor=[UIColor blackColor];
//    [ContactView addSubview:txtName];
//    
//    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10, txtlocality.frame.size.height+txtlocality.frame.origin.y+17,16, 16)];
//    image2.image=[UIImage imageNamed:@"left.png"];
//    [ContactView addSubview:image2];
//    
//    
//    txtemail=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,txtName.frame.size.height+txtName.frame.origin.y+10, motorView.frame.size.width-20, 40)];
//    [txtemail setTextFieldPlaceholderText:@"Email Id"];
//    txtemail.textColor=[UIColor blackColor];
//    txtemail.textAlignment=NSTextAlignmentRight;
//    [txtemail setFont:[UIFont systemFontOfSize:15]];
//    txtemail.delegate=self;
//    txtemail.textColor=[UIColor blackColor];
//    [ContactView addSubview:txtemail];
//    
//    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(10, txtName.frame.size.height+txtName.frame.origin.y+17,16, 16)];
//    image3.image=[UIImage imageNamed:@"left.png"];
//    [ContactView addSubview:image3];
//    
//    
//    txtmobile=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10,txtemail.frame.size.height+txtemail.frame.origin.y+10, motorView.frame.size.width-20, 40)];
//    [txtmobile setTextFieldPlaceholderText:@"Mobile Number"];
//    txtmobile.textColor=[UIColor blackColor];
//    txtmobile.textAlignment=NSTextAlignmentRight;
//    [txtmobile setFont:[UIFont systemFontOfSize:15]];
//    txtmobile.delegate=self;
//    [txtmobile setKeyboardType:UIKeyboardTypeNumberPad];
//    txtmobile.textColor=[UIColor blackColor];
//    [ContactView addSubview:txtmobile];
//    
//    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(10, txtemail.frame.size.height+txtemail.frame.origin.y+17,16, 16)];
//    image4.image=[UIImage imageNamed:@"left.png"];
//    [ContactView addSubview:image4];
//    
//    
//    
//    
//    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
//    numberToolbar.tintColor=[UIColor whiteColor];
//    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
//    numberToolbar.items = [NSArray arrayWithObjects:
//                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
//                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
//                           nil];
//    [numberToolbar sizeToFit];
//    
//    txtmobile.inputAccessoryView=numberToolbar;
    
}



-(void)doneWithNumberPad
{
    [txtmobile resignFirstResponder];
}

-(IBAction)localitypClicked:(id)sender
{
    PickArabicViewController *pc=[self.storyboard instantiateViewControllerWithIdentifier:@"PickArabicViewController"];
    [self.navigationController pushViewController:pc animated:YES];
}



-(IBAction)localityClicked:(id)sender
{
    [self.view endEditing:YES];
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,localitylist,arabic,strCityId];
    [requested LocalityRequest:nil withUrl:strurl];
}

-(void)responsewithlocalitylist:(NSMutableDictionary *)responseDict
{
    NSLog(@"locality list Response: %@",responseDict);
    arrlocalitylist=[responseDict valueForKey:@"data"];
    [self model3];
}



-(void)model3
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-100, 300, 200)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-50, 40)];
    lab.text=@"Select locality";
    lab.textColor=[UIColor blackColor];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentLeft+10;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60, 0, 50, 40)];
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
    tabl.frame = CGRectMake(0,labeunder.frame.origin.y+labeunder.frame.size.height+10, footerview.frame.size.width, 157);
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.tag=3;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //  [tabl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [footerview addSubview:tabl];
}




#pragma mark - Collection View Delegates


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrimages.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ORGArticleCollectionViewCell" forIndexPath:indexPath];
    
    cell.articleImage.image = [arrimages objectAtIndex:indexPath.row];
    cell.articleImage.contentMode = UIViewContentModeScaleAspectFill;
    
    
    [cell.arbutton setTag:indexPath.row];
    [cell.arbutton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.coverphotobutt setTag:indexPath.row];
    cell.coverphotobutt.hidden=YES;
    
    return cell;
}


-(void) delete :(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [[NSUserDefaults standardUserDefaults]setInteger:btn.tag forKey:@"tag"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Photo" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete",@"Choose Cover Photo", nil];
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView==exitalert)
    {
        if (buttonIndex== [alertView firstOtherButtonIndex])
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        
        if (buttonIndex == 1)
        {
            NSString *strvalue= [[NSUserDefaults standardUserDefaults]objectForKey:@"tag"];
            int k=(int)[strvalue integerValue];
            NSString *location=[arrlocations objectAtIndex:k];
            
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
            NSString *post = [NSString stringWithFormat:@"path=%@",location];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,fileDelete,arabic,strCityId];
            [requested DeleteFileRequest:post withUrl:strurl];
            
            [arrimages removeObjectAtIndex:k];
            [arrlocations removeObjectAtIndex:k];
            [arrurls removeObjectAtIndex:k];
            [_collectionView reloadData];
            
            if (arrurls.count==0)
            {
                strCoverPhoto=nil;
                coverphotoview.hidden=YES;
                chooselab.hidden=NO;
            }
            else if (arrurls.count==1)
            {
                strCoverPhoto=[arrlocations objectAtIndex:0];
                coverphotoview.hidden=NO;
                chooselab.hidden=YES;
                [CoverPhotoImage sd_setImageWithURL:[NSURL URLWithString:[arrurls objectAtIndex:0]]
                                   placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
            }
            else
            {
                if ([arrlocations containsObject:strCoverPhoto])
                {
                    coverphotoview.hidden=NO;
                    chooselab.hidden=YES;
                }
                else
                {
                    strCoverPhoto=[arrlocations objectAtIndex:0];
                    coverphotoview.hidden=NO;
                    chooselab.hidden=YES;
                    [CoverPhotoImage sd_setImageWithURL:[NSURL URLWithString:[arrurls objectAtIndex:0]]
                                       placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
                }
            }
        }
        else if (buttonIndex == 2)
        {
            cell.coverphotobutt.hidden=YES;
            
            NSString *strvalue= [[NSUserDefaults standardUserDefaults]objectForKey:@"tag"];
            int k=(int)[strvalue integerValue];
            strCoverPhoto=[arrlocations objectAtIndex:k];
            
            //        [[NSUserDefaults standardUserDefaults]setObject:strCoverPhoto forKey:@"coverphoto"];
            //        [[NSUserDefaults standardUserDefaults]synchronize];
            
            NSString *strurl=[arrurls objectAtIndex:k];
            [CoverPhotoImage sd_setImageWithURL:[NSURL URLWithString:strurl]
                               placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
        }
    }
}

-(void)responsewithDeleteFile:(NSMutableDictionary *)responseToken
{
    NSLog(@"%@",responseToken);
    
    NSLog(@"locations: %@",arrlocations);
    
    NSLog(@"Url's: %@",arrurls);
    
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc]init];
    [postDict setValue:arrlocations forKey:@"locations"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrlocations options:0 error:nil];
    strUploadPic=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Json Format String: %@",strUploadPic);
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 70);
}





#pragma mark - Table View Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1)
    {
        return DataCarMakeArray.count;
    }
    else if(tableView.tag==2)
    {
        return DataCarModelArray.count;
    }
    else if(tableView.tag==3)
    {
        return arrlocalitylist.count;
    }
    else if(tableView.tag==4)
    {
        return _arrChildCategory.count;
    }
    else if(tableView.tag==5)
    {
        return arrsubcatlist.count;
    }
    else if (tableView.tag==6)
    {
        return arrsubcatlist2.count;
    }
    else if (tableView.tag==7)
    {
        return arrsubcatlist3.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"Cell1";
    static NSString *CellIdentifier2 = @"Cell2";
    static NSString *CellIdentifier3 = @"Cell3";
    static NSString *CellIdentifier4 = @"Cell4";
    static NSString *CellIdentifier5 = @"Cell5";
    static NSString *CellIdentifier6 = @"Cell6";
    static NSString *CellIdentifier7 = @"Cell7";
    
    
    if (tableView.tag==1)
    {
        cells = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cells == nil) {
            cells = [[UITableViewCell alloc]
                     initWithStyle:UITableViewCellStyleDefault
                     reuseIdentifier:CellIdentifier1];
        }
        cells.textLabel.numberOfLines=2;
        cells.textLabel.text=[[DataCarMakeArray objectAtIndex:indexPath.row] valueForKey:@"name"];
        cells.textLabel.textAlignment=NSTextAlignmentRight;
    }
    else if (tableView.tag==2)
    {
        cells = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cells == nil) {
            cells = [[UITableViewCell alloc]
                     initWithStyle:UITableViewCellStyleDefault
                     reuseIdentifier:CellIdentifier2];
        }
        cells.textLabel.numberOfLines=2;
        cells.textLabel.text=[[DataCarModelArray objectAtIndex:indexPath.row] valueForKey:@"name"];
        cells.textLabel.textAlignment=NSTextAlignmentRight;
    }
    else if (tableView.tag==3)
    {
        cells = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cells == nil) {
            cells = [[UITableViewCell alloc]
                     initWithStyle:UITableViewCellStyleDefault
                     reuseIdentifier:CellIdentifier3];
        }
        cells.textLabel.numberOfLines=2;
        cells.textLabel.text=[[arrlocalitylist objectAtIndex:indexPath.row] valueForKey:@"name"];
        cells.textLabel.textAlignment=NSTextAlignmentRight;
    }
    else if (tableView.tag==4)
    {
        cells = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
        if (cells == nil) {
            cells = [[UITableViewCell alloc]
                     initWithStyle:UITableViewCellStyleDefault
                     reuseIdentifier:CellIdentifier4];
        }
        cells.textLabel.numberOfLines=2;
        cells.textLabel.text=[[_arrChildCategory objectAtIndex:indexPath.row] valueForKey:@"name"];
        cells.textLabel.textAlignment=NSTextAlignmentRight;
    }
    else if (tableView.tag==5)
    {
        cells = [tableView dequeueReusableCellWithIdentifier:CellIdentifier5];
        if (cells == nil) {
            cells = [[UITableViewCell alloc]
                     initWithStyle:UITableViewCellStyleDefault
                     reuseIdentifier:CellIdentifier5];
        }
        cells.textLabel.numberOfLines=2;
        cells.textLabel.text=[[arrsubcatlist objectAtIndex:indexPath.row] valueForKey:@"name"];
        cells.textLabel.textAlignment=NSTextAlignmentRight;
    }
    else if (tableView.tag==6)
    {
        cells = [tableView dequeueReusableCellWithIdentifier:CellIdentifier6];
        if (cells == nil) {
            cells = [[UITableViewCell alloc]
                     initWithStyle:UITableViewCellStyleDefault
                     reuseIdentifier:CellIdentifier6];
        }
        cells.textLabel.numberOfLines=2;
        cells.textLabel.text=[[arrsubcatlist2 objectAtIndex:indexPath.row] valueForKey:@"name"];
        cells.textLabel.textAlignment=NSTextAlignmentRight;
    }
    else if (tableView.tag==7)
    {
        cells = [tableView dequeueReusableCellWithIdentifier:CellIdentifier7];
        if (cells == nil) {
            cells = [[UITableViewCell alloc]
                     initWithStyle:UITableViewCellStyleDefault
                     reuseIdentifier:CellIdentifier7];
        }
        cells.textLabel.numberOfLines=2;
        cells.textLabel.text=[[arrsubcatlist3 objectAtIndex:indexPath.row] valueForKey:@"name"];
        cells.textLabel.textAlignment=NSTextAlignmentRight;
    }
    
    
    
    return cells;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1)
    {
        [tabl deselectRowAtIndexPath:indexPath animated:YES];
        
        strSubModule=[[DataCarMakeArray valueForKey:@"name"]objectAtIndex:indexPath.row];
        
        txtmake.text=strSubModule;
        
        
        strSubModule=[[DataCarMakeArray valueForKey:@"id"]objectAtIndex:indexPath.row];
        NSLog(@"%@",strSubModule);
        
        strmakeid=[[DataCarMakeArray valueForKey:@"id"]objectAtIndex:indexPath.row];
        
        [footerview removeFromSuperview];
        popview.hidden = YES;
        [tabl reloadData];
        
    }
    else if(tableView.tag==2)
    {
        
        [tabl deselectRowAtIndexPath:indexPath animated:YES];
        NSString *strSubModule2=[[DataCarModelArray valueForKey:@"name"]objectAtIndex:indexPath.row];
        
        txtModel.text=strSubModule2;
        
        strSubModule2=[[DataCarModelArray valueForKey:@"id"]objectAtIndex:indexPath.row];
        strmodelid=[[DataCarModelArray valueForKey:@"id"]objectAtIndex:indexPath.row];
        NSLog(@"%@",strSubModule2);
        
        [footerview1 removeFromSuperview];
        popview1.hidden = YES;
    }
    
    else if (tableView.tag==3)
    {
        [tabl deselectRowAtIndexPath:indexPath animated:YES];
        
        NSString *strSubModule2=[[arrlocalitylist valueForKey:@"name"]objectAtIndex:indexPath.row];
        
        txtlocality.text=strSubModule2;
        
        strSubModule=[[arrlocalitylist valueForKey:@"locality_id"]objectAtIndex:indexPath.row];
        
        strlocalityid=[[arrlocalitylist valueForKey:@"locality_id"]objectAtIndex:indexPath.row];
        NSLog(@"%@",strSubModule);
        
        [footerview removeFromSuperview];
        popview.hidden = YES;
        [tabl reloadData];
        
    }
    else if (tableView.tag==4)
    {
        [motorView removeFromSuperview];
        [CommonView3 removeFromSuperview];
        [_collectionView removeFromSuperview];
        [MotorPostAdbutt removeFromSuperview];
        [arrimages removeAllObjects];
        [arrurls removeAllObjects];
        [arrlocations removeAllObjects];
        [view3 removeFromSuperview];
        [view4 removeFromSuperview];
        [view5 removeFromSuperview];
        [carpostdict removeAllObjects];
        
        _strCategoryIdForPost=[NSString stringWithFormat:@"%@",[[_arrChildCategory valueForKey:@"id"]objectAtIndex:indexPath.row]];
        
        [tabl deselectRowAtIndexPath:indexPath animated:YES];
        
        strsubCategoryname=[[_arrChildCategory valueForKey:@"name"]objectAtIndex:indexPath.row];
        
        txtSubCate.text=strsubCategoryname;
        
        strSubModule=[NSString stringWithFormat:@"%@",[[_arrChildCategory valueForKey:@"haschild"]objectAtIndex:indexPath.row]];
        
        [footerview removeFromSuperview];
        popview.hidden = YES;
        
        if ([strSubModule isEqualToString:[NSString stringWithFormat:@"%@",@"1"]])
        {
            strsubCategoryid=[[_arrChildCategory valueForKey:@"id"]objectAtIndex:indexPath.row];
            
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,arabic,strCityId,_strcategeoryTypeurl_parameter,@"category",strsubCategoryid];
            [requested SubCategoryRequest:nil withUrl:strurl];
        }
        else
        {
            [view3 removeFromSuperview];
            
            strsubCategoryid=[[_arrChildCategory valueForKey:@"id"]objectAtIndex:indexPath.row];
            
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&category=%@",BaseUrl,strtoken,CategoryOption,arabic,strCityId,_strcategeoryTypeurl_parameter,strsubCategoryid];
            [requested CategoryOptionRequest:nil withUrl:strurl];
        }
        
        [tabl reloadData];
        
    }
    else if (tableView.tag==5)
    {
        [motorView removeFromSuperview];
        [CommonView3 removeFromSuperview];
        [MotorPostAdbutt removeFromSuperview];
        [_collectionView removeFromSuperview];
        [arrimages removeAllObjects];
        [arrurls removeAllObjects];
        [arrlocations removeAllObjects];
        [view4 removeFromSuperview];
        [view5 removeFromSuperview];
        [carpostdict removeAllObjects];
        
        [tabl deselectRowAtIndexPath:indexPath animated:YES];
        
        _strCategoryIdForPost=[NSString stringWithFormat:@"%@",[[arrsubcatlist valueForKey:@"id"]objectAtIndex:indexPath.row]];
        
        strsubCategoryname2=[[arrsubcatlist valueForKey:@"name"]objectAtIndex:indexPath.row];
        
        txtsubCate2.text=strsubCategoryname2;
        
        strSubModule=[NSString stringWithFormat:@"%@",[[arrsubcatlist valueForKey:@"haschild"]objectAtIndex:indexPath.row]];
        
        [footerview removeFromSuperview];
        popview.hidden = YES;
        
        if ([strSubModule isEqualToString:[NSString stringWithFormat:@"%@",@"1"]])
        {
            strsubCategoryid2=[[arrsubcatlist valueForKey:@"id"]objectAtIndex:indexPath.row];
            
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,arabic,strCityId,_strcategeoryTypeurl_parameter,@"category",strsubCategoryid2];
            [requested SubCategoryRequest2:nil withUrl:strurl];
        }
        else
        {
            strsubCategoryid2=[[arrsubcatlist valueForKey:@"id"]objectAtIndex:indexPath.row];
            
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&category=%@",BaseUrl,strtoken,CategoryOption,arabic,strCityId,_strcategeoryTypeurl_parameter,strsubCategoryid2];
            [requested CategoryOptionRequest2:nil withUrl:strurl];
            
        }
        
        [tabl reloadData];
        
    }
    else if (tableView.tag==6)
    {
        [motorView removeFromSuperview];
        [CommonView3 removeFromSuperview];
        [MotorPostAdbutt removeFromSuperview];
        [_collectionView removeFromSuperview];
        [arrimages removeAllObjects];
        [arrurls removeAllObjects];
        [arrlocations removeAllObjects];
        [view5 removeFromSuperview];
        [carpostdict removeAllObjects];
        
        [tabl deselectRowAtIndexPath:indexPath animated:YES];
        
        _strCategoryIdForPost=[NSString stringWithFormat:@"%@",[[arrsubcatlist2 valueForKey:@"id"]objectAtIndex:indexPath.row]];
        
        strsubCategoryname3=[[arrsubcatlist2 valueForKey:@"name"]objectAtIndex:indexPath.row];
        
        txtsubCate3.text=strsubCategoryname3;
        
        strSubModule=[NSString stringWithFormat:@"%@",[[arrsubcatlist2 valueForKey:@"haschild"]objectAtIndex:indexPath.row]];
        
        [footerview removeFromSuperview];
        popview.hidden = YES;
        
        if ([strSubModule isEqualToString:[NSString stringWithFormat:@"%@",@"1"]])
        {
            strsubCategoryid3=[[arrsubcatlist2 valueForKey:@"id"]objectAtIndex:indexPath.row];
            
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&submodule=%@&parent=%@",BaseUrl,strtoken,Categoty,arabic,strCityId,_strcategeoryTypeurl_parameter,@"category",strsubCategoryid3];
            [requested SubCategoryRequest3:nil withUrl:strurl];
        }
        else
        {
            strsubCategoryid3=[[arrsubcatlist2 valueForKey:@"id"]objectAtIndex:indexPath.row];
            
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&category=%@",BaseUrl,strtoken,CategoryOption,arabic,strCityId,_strcategeoryTypeurl_parameter,strsubCategoryid3];
            [requested CategoryOptionRequest3:nil withUrl:strurl];
        }
        
        [tabl reloadData];
        
    }
    else if (tableView.tag==7)
    {
        [motorView removeFromSuperview];
        [CommonView3 removeFromSuperview];
        [MotorPostAdbutt removeFromSuperview];
        [_collectionView removeFromSuperview];
        [arrimages removeAllObjects];
        [arrurls removeAllObjects];
        [arrlocations removeAllObjects];
        [carpostdict removeAllObjects];
        
        [tabl deselectRowAtIndexPath:indexPath animated:YES];
        
        _strCategoryIdForPost=[NSString stringWithFormat:@"%@",[[arrsubcatlist3 valueForKey:@"id"]objectAtIndex:indexPath.row]];
        
        strsubCategoryname4=[[arrsubcatlist3 valueForKey:@"name"]objectAtIndex:indexPath.row];
        
        txtsubCate4.text=strsubCategoryname4;
        
        strSubModule=[NSString stringWithFormat:@"%@",[[arrsubcatlist3 valueForKey:@"haschild"]objectAtIndex:indexPath.row]];
        
        [footerview removeFromSuperview];
        popview.hidden = YES;
        
        if ([strSubModule isEqualToString:[NSString stringWithFormat:@"%@",@"1"]])
        {
            
        }
        else
        {
            strsubCategoryid4=[[arrsubcatlist3 valueForKey:@"id"]objectAtIndex:indexPath.row];
            
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?module=%@&category=%@",BaseUrl,strtoken,CategoryOption,arabic,strCityId,_strcategeoryTypeurl_parameter,strsubCategoryid4];
            [requested CategoryOptionRequest4:nil withUrl:strurl];
        }
        [tabl reloadData];
    }
}







#pragma mark - Back Clicked

-(IBAction)BackbuttClicked:(id)sender
{
    exitalert=[[UIAlertView alloc] initWithTitle:@"Exit" message:@"Are You Sure don't Want to Post an Ad" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [exitalert show];
}


#pragma mark - TextView Delegate Methods

- (void)textViewDidBeginEditing:(UITextView *)txtView
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    if (showPlaceHolder == YES)
    {
        txtadDesc.textColor = [UIColor blackColor];
        txtadDesc.text = @"";
        showPlaceHolder = NO;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (txtadDesc.text.length == 0)
    {
        [self setPlaceholder];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


- (void)resignKeyboard
{
    [txtadDesc resignFirstResponder];
    if (txtadDesc.text.length == 0)
    {
        [self setPlaceholder];
    }
}


#pragma mark - TextField Delegates


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==txtadtitle)
    {
        
    }
    else
    {
        [(ACFloatingTextField *)textField textFieldDidBeginEditing];
        [self animateTextField:textField up:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==txtadtitle)
    {
        
    }
    else
    {
        [(ACFloatingTextField *)textField textFieldDidEndEditing];
        [self animateTextField:textField up:NO];
    }
}

- (void)dismissKeyboard
{
    //   [txtcity resignFirstResponder];
    [txtadDesc resignFirstResponder];
    [txtadtitle resignFirstResponder];
    [txtlocality resignFirstResponder];
    [txtName resignFirstResponder];
    [txtemail resignFirstResponder];
    //    [txtccode resignFirstResponder];
    [txtmobile resignFirstResponder];
    [CompanyName resignFirstResponder];
    [color resignFirstResponder];
    [txtprice resignFirstResponder];
    [txtareasquare resignFirstResponder];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -140;
    const float movementDuration = 0.3f;
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}




#pragma mark - DropDown Menu Delegates


-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple
{
    [[NSUserDefaults standardUserDefaults]setObject:@"post" forKey:@"Options"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:popview animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    // [Dropobj SetBackGroundDropDown_R:0.0 G:108.0 B:194.0 alpha:0.70];
    Dropobj.backgroundColor=[UIColor lightGrayColor];
}


- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex
{
    /*----------------Get Selected Value[Single selection]-----------------*/
    
    UILabel *fCopyWidthLabel = (UILabel *)[motorView viewWithTag:b];
    
    fCopyWidthLabel.text=[arrfueltype objectAtIndex:anIndex];
    
    popview.hidden = YES;
    
    
    //   NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    NSArray *arr1=[[[DataMotorOptions objectAtIndex:b-1] valueForKey:@"values"] objectAtIndex:anIndex];
    
    NSString *strrep=[NSString stringWithFormat:@"%@",[arr1 valueForKey:@"id"]];
    
    if (carpostdict[stridforpost])
    {
        [carpostdict removeObjectForKey:stridforpost];
        [carpostdict setObject:strrep forKey:stridforpost];
    }
    else
    {
        [carpostdict setObject:strrep forKey:stridforpost];
    }
    
    NSLog(@"Car post Dictionary: %@",carpostdict);
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:carpostdict
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonStringOptions = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonString: %@",jsonStringOptions);
    }
    
}

-(void)DropDownListView2:(DropDownListView *)dropdownListView Datalist:(NSMutableArray *)ArryData
{
    if (ArryData.count>0)
    {
        
        NSMutableArray *arrids=[[NSMutableArray alloc]init];
        
        for (int i=0; i<ArryData.count; i++)
        {
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            
            NSArray *arr1=[[DataMotorOptions objectAtIndex:b-1] valueForKey:@"values"];
            
            NSString *str1=[ArryData objectAtIndex:i];
            int j=(int)[str1 integerValue];
            
            [arr addObject:[[arr1 objectAtIndex:j]valueForKey:@"id"]];
            
            arrids=[[arrids arrayByAddingObjectsFromArray:arr] mutableCopy];
        }
        
        NSLog(@"%@",arrids);
        
        NSString *result = [arrids  componentsJoinedByString:@","];
        
        if (carpostdict[stridforpost])
        {
            [carpostdict removeObjectForKey:stridforpost];
            [carpostdict setObject:result forKey:stridforpost];
        }
        else
        {
            [carpostdict setObject:result forKey:stridforpost];
        }
        
        NSLog(@"Car post Dictionary: %@",carpostdict);
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:carpostdict
                                                           options:0 // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            jsonStringOptions = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"jsonString: %@",jsonStringOptions);
        }
    }
    else
    {
        
    }
    
}

- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData
{
    /*----------------Get Selected Value[Multiple selection]-----------------*/
    
    if (ArryData.count>0)
    {
        UILabel *fCopyWidthLabel = (UILabel *)[motorView viewWithTag:b];
        
        fCopyWidthLabel.text=[ArryData componentsJoinedByString:@", "];
    }
    else
    {
        
    }
    
    [footerview removeFromSuperview];
    popview.hidden = YES;
}

-(void)DropDownListView3:(DropDownListView *)dropdownListView Datalist:(NSMutableArray *)ArryData
{
    
    if (ArryData.count>0)
    {
        
    }
    else
    {
        
    }
}

- (void)DropDownListViewDidCancel
{
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[UIView class]]) {
        [Dropobj fadeOut];
        popview.hidden = YES;
    }
}

-(CGSize)GetHeightDyanamic:(UILabel*)lbl
{
    NSRange range = NSMakeRange(0, [lbl.text length]);
    CGSize constraint;
    constraint= CGSizeMake(288 ,MAXFLOAT);
    CGSize size;
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)) {
        NSDictionary *attributes = [lbl.attributedText attributesAtIndex:0 effectiveRange:&range];
        CGSize boundingBox = [lbl.text boundingRectWithSize:constraint options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    }
    else
    {
        CGRect textRect = [lbl.text boundingRectWithSize:size
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:14]}
                                                 context:nil];
        size = textRect.size;
    }
    return size;
}




#pragma mark - Validation


-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSString *trimmedString = [checkString stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    return [emailTest evaluateWithObject:trimmedString];
}



#pragma mark - Images Uploading


- (void)setupAlertCtrl
{
    self.alertCtrl = [UIAlertController alertControllerWithTitle:@"Select One Option"
                                                         message:nil
                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    //Create an action
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Take a Photo"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action)
                             {
                                 [self handleCamera];
                             }];
    UIAlertAction *imageGallery = [UIAlertAction actionWithTitle:@"Choose from Gallery"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       [self handleImageGallery];
                                   }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action)
                             {
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    
    //Add action to alertCtrl
    [self.alertCtrl addAction:camera];
    [self.alertCtrl addAction:imageGallery];
    [self.alertCtrl addAction:cancel];
    
    //    self.alertCtrl.popoverPresentationController.sourceView = self.view;
    //    [self presentViewController:self.alertCtrl animated:YES completion:nil];
}

- (void)handleCamera
{
#if TARGET_IPHONE_SIMULATOR
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Camera is not available on simulator"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action)
                         {
                             [self dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
#elif TARGET_OS_IPHONE
    //Some code for iPhone
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
#endif
}

- (void)handleImageGallery
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSData *dataImage = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],1);
    UIImage *img = [[UIImage alloc] initWithData:dataImage];
    currentSelectedImage=img;
    [Profileimage setImage:img];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    [arr addObject:img];
    arrimages=[[arrimages arrayByAddingObjectsFromArray:arr] mutableCopy];
    [_collectionView reloadData];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
//    currentSelectedImage = [self imageWithReduceImage:currentSelectedImage
//                                          scaleToSize:CGSizeMake(20, 20)];
    
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //Set Params
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    //Create boundary, it can be anything
    NSString *boundary = @"------VohpleBoundary4QuqLuM1cE5lMwCy";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    //Populate a dictionary with all the regular values you would like to send.
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    [parameters setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"] forKey:@"user"];
    
    //  [parameters setValue:txtFirstname.text forKey:@"firstname"];
    
    //  [parameters setValue:txtlastName.text forKey:@"lastname"];
    
    //   [parameters setValue:@"" forKey:@"profile_pic"];
    
    // add params (all params are strings)
    for (NSString *param in parameters)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [parameters objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSString *FileParamConstant = @"file";
    
    NSData *imageData = UIImageJPEGRepresentation(currentSelectedImage, 1);
    
    //Assuming data is not nil we add this to the multipart form
    if (imageData)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //Close off the request with the boundary
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the request
    [request setHTTPBody:body];
    
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,file,arabic,strCityId];
    
    
    // set URL
    [request setURL:[NSURL URLWithString:strurl]];
    
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    [self parseJSONR:data];
                }
            }
        });
    }] resume];
    
}


-(void)parseJSONR:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    [DejalBezelActivityView removeView];
    NSLog(@"%@",responseJSON);
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    [arr addObject:[responseJSON valueForKey:@"location"]];
    arrlocations=[[arrlocations arrayByAddingObjectsFromArray:arr] mutableCopy];
    NSLog(@"locations: %@",arrlocations);
    
    NSMutableArray *arr1=[[NSMutableArray alloc]init];
    [arr1 addObject:[responseJSON valueForKey:@"url"]];
    arrurls=[[arrurls arrayByAddingObjectsFromArray:arr1] mutableCopy];
    NSLog(@"Url's: %@",arrurls);
    
    
    
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc]init];
    [postDict setValue:arrlocations forKey:@"locations"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrlocations options:0 error:nil];
    strUploadPic=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Json Format String: %@",strUploadPic);
    
    
    if (arrurls.count==0)
    {
        strCoverPhoto=nil;
        coverphotoview.hidden=YES;
        chooselab.hidden=NO;
    }
    else if (arrurls.count==1)
    {
        strCoverPhoto=[arrlocations objectAtIndex:0];
        coverphotoview.hidden=NO;
        chooselab.hidden=YES;
        [CoverPhotoImage sd_setImageWithURL:[NSURL URLWithString:[arrurls objectAtIndex:0]]
                           placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
    }
    else
    {
        if ([arrlocations containsObject:strCoverPhoto])
        {
            coverphotoview.hidden=NO;
            chooselab.hidden=YES;
        }
        else
        {
            strCoverPhoto=[arrlocations objectAtIndex:0];
            coverphotoview.hidden=NO;
            chooselab.hidden=YES;
            [CoverPhotoImage sd_setImageWithURL:[NSURL URLWithString:[arrurls objectAtIndex:0]]
                               placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
        }
    }
    
    coverphotoview.hidden=NO;
    chooselab.hidden=YES;
    [CoverPhotoImage sd_setImageWithURL:[NSURL URLWithString:[arrurls objectAtIndex:0]]
                       placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
}




#pragma mark -Reduce Image Size

-(UIImage*)imageWithReduceImage: (UIImage*)imageName scaleToSize: (CGSize)newsize
{
    UIGraphicsBeginImageContextWithOptions(newsize, NO, 12.0);
    [imageName drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}


-(void)viewWillAppear:(BOOL)animated
{
    NSString *strlat=[[NSUserDefaults standardUserDefaults]objectForKey:@"latlong"];
    
    if (strlat == (id)[NSNull null] || strlat.length == 0 )
    {
        
    }
    else
    {
        txtlocality.text=strlat;
        [self getLocationFromAddressString6:strlat];
    }
}


-(void) getLocationFromAddressString6: (NSString*) addressStr
{
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result)
    {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanFloat:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanFloat:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    //    NSLog(@"View Controller get Location Latitude : %f",center.latitude);
    //    NSLog(@"View Controller get Location Longitude : %f",center.longitude);
    NSLog(@"latitude: %f",latitude);
    NSLog(@"longitude: %f",longitude);
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
