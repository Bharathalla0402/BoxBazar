//
//  PostingArabicViewController.m
//  BoxBazar
//
//  Created by bharat on 30/08/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "PostingArabicViewController.h"
#import "ApiRequest.h"

@interface PostingArabicViewController ()<ApiRequestdelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UIImageView *Profileimage;
    ApiRequest *requested;
    UIScrollView *scrollMainView;
    
    UIView *view1,*motorView,*PropertyonRentView;
    UIButton *button1,*button2,*button3,*button4,*button5,*button6,*button7;
    NSString *straccount,*strowners,*strsellingoptions;
    
    BOOL showPlaceHolder;
    UITextView *txtadDesc;
    UITextField *txtadtitle,*color;
    UILabel *brandname,*FuelType,*YearofReg,*kmsDriven,*price,*insuranceValid;
    
    UIView *popview;
    UIView *footerview;
    UIDatePicker *datePicker;
    
    UIView *CommonView3;
    UILabel *city,*locality,*name,*email,*mobile,*pluslabel;
    UITextField *txtcity,*txtlocality,*txtName,*txtemail,*txtccode,*txtmobile;
    
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
}
@end

@implementation PostingArabicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   
                                   initWithTarget:self
                                   
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    [self setupAlertCtrl];
    [self moreaction];
}

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
    [Profileimage setImage:img];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)moreaction
{
    UIView *topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    topview.backgroundColor=[UIColor darkGrayColor];
    [self.view addSubview:topview];
    
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(10, topview.frame.size.height/2-8, topview.frame.size.width-20, 30)];
    titlelabel.text=@"Post Ad";
    titlelabel.textAlignment=NSTextAlignmentCenter;
    [titlelabel setFont:[UIFont boldSystemFontOfSize:15]];
    titlelabel.textColor=[UIColor whiteColor];
    [topview addSubview:titlelabel];
    
    
    UIButton *Backbutt=[[UIButton alloc] initWithFrame:CGRectMake(10, topview.frame.size.height/2-5, 25, 25)];
    [Backbutt setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    Backbutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [Backbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Backbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Backbutt addTarget:self action:@selector(BackbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt];
    
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
    if ([_strCategeoryUrlparameter isEqualToString:@"motors"])
    {
        scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 1450);
        
        motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view1.frame.origin.y+view1.frame.size.height+15, self.view.frame.size.width, 750)];
        motorView.backgroundColor=[UIColor whiteColor];
        [scrollMainView addSubview:motorView];
        
        [self motorView];
        [self commonView3];
        
        UIButton *MotorPostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
        [MotorPostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
        MotorPostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [MotorPostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        MotorPostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        MotorPostAdbutt.layer.cornerRadius = 19;
        MotorPostAdbutt.clipsToBounds = YES;
        [MotorPostAdbutt addTarget:self action:@selector(MotorPostButtClicked:) forControlEvents:UIControlEventTouchUpInside];
        MotorPostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
        [scrollMainView addSubview:MotorPostAdbutt];
    }
    else if ([_strCategeoryUrlparameter isEqualToString:@"jobs"])
    {
        scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 1250);
        
        motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view1.frame.origin.y+view1.frame.size.height+15, self.view.frame.size.width, 550)];
        motorView.backgroundColor=[UIColor whiteColor];
        [scrollMainView addSubview:motorView];
        
        [self JobsView];
        [self commonView3];
        
        UIButton *JobpostAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
        [JobpostAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
        JobpostAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [JobpostAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        JobpostAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        JobpostAdbutt.layer.cornerRadius = 19;
        JobpostAdbutt.clipsToBounds = YES;
        [JobpostAdbutt addTarget:self action:@selector(JobsPostButtClicked:) forControlEvents:UIControlEventTouchUpInside];
        JobpostAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
        [scrollMainView addSubview:JobpostAdbutt];
    }
    else if ([_strCategeoryUrlparameter isEqualToString:@"property_rent"])
    {
        scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 1330);
        
        motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view1.frame.origin.y+view1.frame.size.height+5, self.view.frame.size.width, 650)];
        motorView.backgroundColor=[UIColor clearColor];
        [scrollMainView addSubview:motorView];
        
        
        UILabel *AdDetailslab=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, motorView.frame.size.width-20, 30)];
        AdDetailslab.text=@"AD Details";
        AdDetailslab.textAlignment=NSTextAlignmentRight;
        [AdDetailslab setFont:[UIFont systemFontOfSize:15]];
        AdDetailslab.textColor=[UIColor blackColor];
        [motorView addSubview:AdDetailslab];
        
        
        PropertyonRentView=[[UIView alloc]initWithFrame:CGRectMake(0, AdDetailslab.frame.origin.y+AdDetailslab.frame.size.height+5, self.view.frame.size.width, 615)];
        PropertyonRentView.backgroundColor=[UIColor whiteColor];
        [motorView addSubview:PropertyonRentView];
        
        
        [self PropertyOnRentandsellView];
        [self commonView3];
        
        UIButton *propertyonrentAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
        [propertyonrentAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
        propertyonrentAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [propertyonrentAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        propertyonrentAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        propertyonrentAdbutt.layer.cornerRadius = 19;
        propertyonrentAdbutt.clipsToBounds = YES;
        [propertyonrentAdbutt addTarget:self action:@selector(PropertyonrentButtClicked:) forControlEvents:UIControlEventTouchUpInside];
        propertyonrentAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
        [scrollMainView addSubview:propertyonrentAdbutt];
    }
    else if ([_strCategeoryUrlparameter isEqualToString:@"property_sale"])
    {
        scrollMainView.contentSize = CGSizeMake(self.view.frame.size.width, 1330);
        
        motorView=[[UIView alloc]initWithFrame:CGRectMake(0, view1.frame.origin.y+view1.frame.size.height+5, self.view.frame.size.width, 650)];
        motorView.backgroundColor=[UIColor clearColor];
        [scrollMainView addSubview:motorView];
        
        
        UILabel *AdDetailslab=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, motorView.frame.size.width-20, 30)];
        AdDetailslab.text=@"AD Details";
        AdDetailslab.textAlignment=NSTextAlignmentRight;
        [AdDetailslab setFont:[UIFont systemFontOfSize:15]];
        AdDetailslab.textColor=[UIColor blackColor];
        [motorView addSubview:AdDetailslab];
        
        
        PropertyonRentView=[[UIView alloc]initWithFrame:CGRectMake(0, AdDetailslab.frame.origin.y+AdDetailslab.frame.size.height+5, self.view.frame.size.width, 615)];
        PropertyonRentView.backgroundColor=[UIColor whiteColor];
        [motorView addSubview:PropertyonRentView];
        
        
        [self PropertyOnRentandsellView];
        [self commonView3];
        
        UIButton *propertyonsaleAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, CommonView3.frame.origin.y+CommonView3.frame.size.height+20, self.view.frame.size.width-80, 50)];
        [propertyonsaleAdbutt setTitle:@"Post Ad" forState:UIControlStateNormal];
        propertyonsaleAdbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [propertyonsaleAdbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        propertyonsaleAdbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        propertyonsaleAdbutt.layer.cornerRadius = 19;
        propertyonsaleAdbutt.clipsToBounds = YES;
        [propertyonsaleAdbutt addTarget:self action:@selector(PropertyonsaleButtClicked:) forControlEvents:UIControlEventTouchUpInside];
        propertyonsaleAdbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
        [scrollMainView addSubview:propertyonsaleAdbutt];
    }
}


#pragma mark - Post Ads Different Categeory


-(IBAction)MotorPostButtClicked:(id)sender
{
    [requested showMessage:@"Motor Post Ad Clicked" withTitle:@"Post Ad"];
}

-(IBAction)JobsPostButtClicked:(id)sender
{
    [requested showMessage:@"Jobs Post Ad Clicked" withTitle:@"Jobs Ad"];
}
-(IBAction)PropertyonrentButtClicked:(id)sender
{
    [requested showMessage:@"Property on Rent Clicked" withTitle:@"Property on rent"];
}
-(IBAction)PropertyonsaleButtClicked:(id)sender
{
    [requested showMessage:@"Property on sale Clicked" withTitle:@"Property on sale"];
}


#pragma mark - Common view3

-(void)commonView3
{
    CommonView3=[[UIView alloc]initWithFrame:CGRectMake(0, motorView.frame.origin.y+motorView.frame.size.height+5, self.view.frame.size.width, 320)];
    CommonView3.backgroundColor=[UIColor clearColor];
    [scrollMainView addSubview:CommonView3];
    
    UILabel *contactlab=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, CommonView3.frame.size.width-20, 30)];
    contactlab.text=@"Your Contact information";
    contactlab.textAlignment=NSTextAlignmentRight;
    [contactlab setFont:[UIFont boldSystemFontOfSize:15]];
    contactlab.textColor=[UIColor blackColor];
    [CommonView3 addSubview:contactlab];
    
    
    UIView *ContactView=[[UIView alloc]initWithFrame:CGRectMake(0, contactlab.frame.origin.y+contactlab.frame.size.height+5, CommonView3.frame.size.width, 245)];
    ContactView.backgroundColor=[UIColor whiteColor];
    [CommonView3 addSubview:ContactView];
    
    city=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, ContactView.frame.size.width-20, 15)];
    if (txtcity.text.length==0)
    {
        city.hidden=YES;
    }
    else
    {
        city.hidden=NO;
    }
    city.text=@"City";
    city.textAlignment=NSTextAlignmentRight;
    [city setFont:[UIFont systemFontOfSize:13]];
    city.textColor=[UIColor lightGrayColor];
    [ContactView addSubview:city];
    
    txtcity=[[UITextField alloc]initWithFrame:CGRectMake(10, 25, CommonView3.frame.size.width-20, 15)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Select City" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtcity.attributedPlaceholder = str;
    txtcity.textAlignment=NSTextAlignmentRight;
    txtcity.textColor=[UIColor blackColor];
    txtcity.font = [UIFont systemFontOfSize:15];
    txtcity.backgroundColor=[UIColor clearColor];
    txtcity.delegate=self;
    [ContactView addSubview:txtcity];
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 16,16, 16)];
    image1.image=[UIImage imageNamed:@"left.png"];
    [ContactView addSubview:image1];
    
    UILabel *Categorytypeunderlinelab=[[UILabel alloc]initWithFrame:CGRectMake(10, txtcity.frame.origin.y+txtcity.frame.size.height+6, ContactView.frame.size.width-20, 1)];
    Categorytypeunderlinelab.backgroundColor=[UIColor lightGrayColor];
    [ContactView addSubview:Categorytypeunderlinelab];
    
    
    
    locality=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab.frame.size.height+Categorytypeunderlinelab.frame.origin.y+5, ContactView.frame.size.width-20, 15)];
    if (txtlocality.text.length==0)
    {
        locality.hidden=YES;
    }
    else
    {
        locality.hidden=NO;
    }
    locality.text=@"Locality";
    locality.textAlignment=NSTextAlignmentRight;
    [locality setFont:[UIFont systemFontOfSize:13]];
    locality.textColor=[UIColor lightGrayColor];
    [ContactView addSubview:locality];
    
    txtlocality=[[UITextField alloc]initWithFrame:CGRectMake(10,Categorytypeunderlinelab.frame.size.height+Categorytypeunderlinelab.frame.origin.y+25, ContactView.frame.size.width-20, 15)];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Locality" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtlocality.attributedPlaceholder = str1;
    txtlocality.textAlignment=NSTextAlignmentRight;
    txtlocality.textColor=[UIColor blackColor];
    txtlocality.font = [UIFont systemFontOfSize:15];
    txtlocality.backgroundColor=[UIColor clearColor];
    txtlocality.delegate=self;
    [ContactView addSubview:txtlocality];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab.frame.size.height+Categorytypeunderlinelab.frame.origin.y+16,16, 16)];
    image2.image=[UIImage imageNamed:@"left.png"];
    [ContactView addSubview:image2];
    
    UILabel *Categorytypeunderlinelab1=[[UILabel alloc]initWithFrame:CGRectMake(10, txtlocality.frame.origin.y+txtlocality.frame.size.height+6, ContactView.frame.size.width-20, 1)];
    Categorytypeunderlinelab1.backgroundColor=[UIColor lightGrayColor];
    [ContactView addSubview:Categorytypeunderlinelab1];
    
    
    
    name=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab1.frame.size.height+Categorytypeunderlinelab1.frame.origin.y+5, ContactView.frame.size.width-20, 15)];
    if (txtName.text.length==0)
    {
        name.hidden=YES;
    }
    else
    {
        name.hidden=NO;
    }
    name.text=@"Name";
    name.textAlignment=NSTextAlignmentRight;
    [name setFont:[UIFont systemFontOfSize:13]];
    name.textColor=[UIColor lightGrayColor];
    [ContactView addSubview:name];
    
    txtName=[[UITextField alloc]initWithFrame:CGRectMake(10,Categorytypeunderlinelab1.frame.size.height+Categorytypeunderlinelab1.frame.origin.y+25, ContactView.frame.size.width-20, 15)];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtName.attributedPlaceholder = str2;
    txtName.textAlignment=NSTextAlignmentRight;
    txtName.textColor=[UIColor blackColor];
    txtName.font = [UIFont systemFontOfSize:15];
    txtName.backgroundColor=[UIColor clearColor];
    txtName.delegate=self;
    [ContactView addSubview:txtName];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab1.frame.size.height+Categorytypeunderlinelab1.frame.origin.y+16,16, 16)];
    image3.image=[UIImage imageNamed:@"left.png"];
    [ContactView addSubview:image3];
    
    UILabel *Categorytypeunderlinelab2=[[UILabel alloc]initWithFrame:CGRectMake(10, txtName.frame.origin.y+txtName.frame.size.height+6, ContactView.frame.size.width-20, 1)];
    Categorytypeunderlinelab2.backgroundColor=[UIColor lightGrayColor];
    [ContactView addSubview:Categorytypeunderlinelab2];
    
    
    
    email=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+5, ContactView.frame.size.width-20, 15)];
    if (txtemail.text.length==0)
    {
        email.hidden=YES;
    }
    else
    {
        email.hidden=NO;
    }
    email.text=@"Email";
    email.textAlignment=NSTextAlignmentRight;
    [email setFont:[UIFont systemFontOfSize:13]];
    email.textColor=[UIColor lightGrayColor];
    [ContactView addSubview:email];
    
    txtemail=[[UITextField alloc]initWithFrame:CGRectMake(10,Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+25, ContactView.frame.size.width-20, 15)];
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtemail.attributedPlaceholder = str3;
    txtemail.textAlignment=NSTextAlignmentRight;
    txtemail.textColor=[UIColor blackColor];
    txtemail.font = [UIFont systemFontOfSize:15];
    txtemail.backgroundColor=[UIColor clearColor];
    txtemail.delegate=self;
    [ContactView addSubview:txtemail];
    
    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+16,16, 16)];
    image4.image=[UIImage imageNamed:@"left.png"];
    [ContactView addSubview:image4];
    
    UILabel *Categorytypeunderlinelab3=[[UILabel alloc]initWithFrame:CGRectMake(10, txtemail.frame.origin.y+txtemail.frame.size.height+6, ContactView.frame.size.width-20, 1)];
    Categorytypeunderlinelab3.backgroundColor=[UIColor lightGrayColor];
    [ContactView addSubview:Categorytypeunderlinelab3];
    
    
    mobile=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+5, ContactView.frame.size.width-20, 15)];
    if (txtmobile.text.length==0)
    {
        mobile.hidden=YES;
    }
    else
    {
        mobile.hidden=NO;
    }
    mobile.text=@"Mobile";
    mobile.textAlignment=NSTextAlignmentRight;
    [mobile setFont:[UIFont systemFontOfSize:13]];
    mobile.textColor=[UIColor lightGrayColor];
    [ContactView addSubview:mobile];
    
   
    pluslabel=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width-20, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+25, 10, 15)];
    pluslabel.text=@"+";
    pluslabel.textColor=[UIColor blackColor];
    pluslabel.backgroundColor=[UIColor clearColor];
    [ContactView addSubview:pluslabel];
    
    
    txtccode=[[UITextField alloc]initWithFrame:CGRectMake(motorView.frame.size.width-77, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+25,55, 15)];
    NSAttributedString *str4 = [[NSAttributedString alloc] initWithString:@"CCode" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtccode.attributedPlaceholder = str4;
    txtccode.textAlignment=NSTextAlignmentRight;
    txtccode.textColor=[UIColor blackColor];
    txtccode.font = [UIFont systemFontOfSize:15];
    txtccode.backgroundColor=[UIColor clearColor];
    [txtccode setKeyboardType:UIKeyboardTypeNumberPad];
    txtccode.delegate=self;
    [ContactView addSubview:txtccode];
    
    
    txtmobile=[[UITextField alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+25, motorView.frame.size.width-97, 15)];
    NSAttributedString *str9 = [[NSAttributedString alloc] initWithString:@"Mobile Number" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txtmobile.attributedPlaceholder = str9;
    txtmobile.textAlignment=NSTextAlignmentRight;
    txtmobile.textColor=[UIColor blackColor];
    txtmobile.font = [UIFont systemFontOfSize:15];
    txtmobile.backgroundColor=[UIColor clearColor];
    txtmobile.delegate=self;
    [txtmobile setKeyboardType:UIKeyboardTypeNumberPad];
    txtmobile.returnKeyType = UIReturnKeyNext;
    [ContactView addSubview:txtmobile];
    
    UIImageView *image5=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+16,16, 16)];
    image5.image=[UIImage imageNamed:@"left.png"];
    [ContactView addSubview:image5];
    
    
    
    UILabel *Categorytypeunderlinelab4=[[UILabel alloc]initWithFrame:CGRectMake(10, txtmobile.frame.origin.y+txtmobile.frame.size.height+6, ContactView.frame.size.width-97, 1)];
    Categorytypeunderlinelab4.backgroundColor=[UIColor lightGrayColor];
    [ContactView addSubview:Categorytypeunderlinelab4];
    
   
    UILabel *Categorytypeunderlinelab5=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width-77, txtmobile.frame.origin.y+txtmobile.frame.size.height+6, 65, 1)];
    Categorytypeunderlinelab5.backgroundColor=[UIColor lightGrayColor];
    [ContactView addSubview:Categorytypeunderlinelab5];
    
    
    
    UILabel *Otplab=[[UILabel alloc]initWithFrame:CGRectMake(10, ContactView.frame.size.height+ContactView.frame.origin.y+5, CommonView3.frame.size.width-20, 30)];
    Otplab.text=@"An OTP will sent if given number is not verified";
    Otplab.textAlignment=NSTextAlignmentRight;
    [Otplab setFont:[UIFont systemFontOfSize:13]];
    Otplab.textColor=[UIColor blackColor];
    [CommonView3 addSubview:Otplab];
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    txtccode.inputAccessoryView = numberToolbar;
    txtmobile.inputAccessoryView=numberToolbar;
}



-(void)doneWithNumberPad
{
    [txtccode resignFirstResponder];
    [txtmobile resignFirstResponder];
}


#pragma mark - Motor-Categeory view

-(void)motorView
{
    brandname=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, motorView.frame.size.width-20, 30)];
    brandname.text=@"Brand Name";
    brandname.textAlignment=NSTextAlignmentRight;
    [brandname setFont:[UIFont systemFontOfSize:15]];
    brandname.textColor=[UIColor blackColor];
    [motorView addSubview:brandname];
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 12,16, 16)];
    image1.image=[UIImage imageNamed:@"left.png"];
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
    FuelType.textAlignment=NSTextAlignmentRight;
    [FuelType setFont:[UIFont systemFontOfSize:15]];
    FuelType.textColor=[UIColor blackColor];
    [motorView addSubview:FuelType];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab.frame.size.height+Categorytypeunderlinelab.frame.origin.y+12,16, 16)];
    image2.image=[UIImage imageNamed:@"left.png"];
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
    YearofReg.textAlignment=NSTextAlignmentRight;
    [YearofReg setFont:[UIFont systemFontOfSize:15]];
    YearofReg.textColor=[UIColor blackColor];
    [motorView addSubview:YearofReg];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab1.frame.size.height+Categorytypeunderlinelab1.frame.origin.y+12,16, 16)];
    image3.image=[UIImage imageNamed:@"left.png"];
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
    kmsDriven.textAlignment=NSTextAlignmentRight;
    [kmsDriven setFont:[UIFont systemFontOfSize:15]];
    kmsDriven.textColor=[UIColor blackColor];
    [motorView addSubview:kmsDriven];
    
    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+12,16, 16)];
    image4.image=[UIImage imageNamed:@"left.png"];
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
    price.textAlignment=NSTextAlignmentRight;
    [price setFont:[UIFont systemFontOfSize:15]];
    price.textColor=[UIColor blackColor];
    [motorView addSubview:price];
    
    UIImageView *image5=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+12,16, 16)];
    image5.image=[UIImage imageNamed:@"left.png"];
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
    YouAre.textAlignment=NSTextAlignmentRight;
    [YouAre setFont:[UIFont systemFontOfSize:15]];
    YouAre.textColor=[UIColor blackColor];
    [motorView addSubview:YouAre];
    
    
    button1=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width-34, YouAre.frame.size.height+YouAre.frame.origin.y+5, 24, 24)];
    [button1 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button1.backgroundColor=[UIColor clearColor];
    [button1 addTarget:self action:@selector(Button11Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:button1];
    
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width-119, YouAre.frame.size.height+YouAre.frame.origin.y+5, 80, 24)];
    lab1.text=@"Individual";
    lab1.textColor=[UIColor blackColor];
    lab1.textAlignment=NSTextAlignmentRight;
    lab1.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab1];
    
    button2=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width-173, YouAre.frame.size.height+YouAre.frame.origin.y+5, 24, 24)];
    [button2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button2.backgroundColor=[UIColor clearColor];
    [button2 addTarget:self action:@selector(Button22Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:button2];
    
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width-258, YouAre.frame.size.height+YouAre.frame.origin.y+5, 80, 24)];
    lab2.text=@"Dealer";
    lab2.textColor=[UIColor blackColor];
    lab2.textAlignment=NSTextAlignmentRight;
    lab2.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab2];
    
    
    
    txtadtitle=[[UITextField alloc]initWithFrame:CGRectMake(10, lab1.frame.size.height+lab1.frame.origin.y+10, motorView.frame.size.width-20, 40)];
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
    txtadtitle.leftView = paddingView;
    txtadtitle.leftViewMode = UITextFieldViewModeAlways;
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
    
    
    UILabel *numberofowners=[[UILabel alloc]initWithFrame:CGRectMake(10, txtadDesc.frame.size.height+txtadDesc.frame.origin.y+5, motorView.frame.size.width-20, 30)];
    numberofowners.text=@"Number of owners";
    numberofowners.textAlignment=NSTextAlignmentRight;
    [numberofowners setFont:[UIFont systemFontOfSize:15]];
    numberofowners.textColor=[UIColor blackColor];
    [motorView addSubview:numberofowners];
    
    
    button3=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width-34, numberofowners.frame.size.height+numberofowners.frame.origin.y+5, 24, 24)];
    [button3 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button3.backgroundColor=[UIColor clearColor];
    [button3 addTarget:self action:@selector(Button33Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:button3];
    
    UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width-99, numberofowners.frame.size.height+numberofowners.frame.origin.y+5, 60, 24)];
    lab3.text=@"One";
    lab3.textColor=[UIColor blackColor];
    lab3.textAlignment=NSTextAlignmentRight;
    lab3.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab3];
    
    button4=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width-143, numberofowners.frame.size.height+numberofowners.frame.origin.y+5, 24, 24)];
    [button4 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button4.backgroundColor=[UIColor clearColor];
    [button4 addTarget:self action:@selector(Button44Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:button4];
    
    UILabel *lab4=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width-209, numberofowners.frame.size.height+numberofowners.frame.origin.y+5, 60, 24)];
    lab4.text=@"Two";
    lab4.textColor=[UIColor blackColor];
    lab4.textAlignment=NSTextAlignmentRight;
    lab4.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab4];
    
    button5=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width-253, numberofowners.frame.size.height+numberofowners.frame.origin.y+5, 24, 24)];
    [button5 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button5.backgroundColor=[UIColor clearColor];
    [button5 addTarget:self action:@selector(Button55Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:button5];
    
    UILabel *lab5=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width-319, numberofowners.frame.size.height+numberofowners.frame.origin.y+5, 60, 24)];
    lab5.text=@"Three";
    lab5.textColor=[UIColor blackColor];
    lab5.textAlignment=NSTextAlignmentRight;
    lab5.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab5];
    
    
    
    UILabel *Categorytypeunderlinelab5=[[UILabel alloc]initWithFrame:CGRectMake(10, lab3.frame.size.height+lab3.frame.origin.y+15, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab5.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab5];
    
    
    
    insuranceValid=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab5.frame.size.height+Categorytypeunderlinelab5.frame.origin.y+5, motorView.frame.size.width-20, 30)];
    insuranceValid.text=@"Insurance Valid Till";
    insuranceValid.textAlignment=NSTextAlignmentRight;
    [insuranceValid setFont:[UIFont systemFontOfSize:15]];
    insuranceValid.textColor=[UIColor blackColor];
    [motorView addSubview:insuranceValid];
    
    UIImageView *image6=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab5.frame.size.height+Categorytypeunderlinelab5.frame.origin.y+12,16, 16)];
    image6.image=[UIImage imageNamed:@"left.png"];
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
    color.textAlignment=NSTextAlignmentRight;
    color.textColor=[UIColor blackColor];
    color.font = [UIFont systemFontOfSize:15];
    color.backgroundColor=[UIColor clearColor];
    color.delegate=self;
    [motorView addSubview:color];
    
    UIImageView *image7=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab6.frame.size.height+Categorytypeunderlinelab6.frame.origin.y+12,16, 16)];
    image7.image=[UIImage imageNamed:@"left.png"];
    [motorView addSubview:image7];
    
    UILabel *Categorytypeunderlinelab7=[[UILabel alloc]initWithFrame:CGRectMake(10, color.frame.size.height+color.frame.origin.y+2, motorView.frame.size.width-20, 1)];
    Categorytypeunderlinelab7.backgroundColor=[UIColor lightGrayColor];
    [motorView addSubview:Categorytypeunderlinelab7];
    
    //    UIButton *Colorbutt=[[UIButton alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab6.frame.size.height+Categorytypeunderlinelab6.frame.origin.y+5, motorView.frame.size.width-10, 30)];
    //    [Colorbutt addTarget:self action:@selector(ColourbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    Colorbutt.backgroundColor=[UIColor clearColor];
    //    [motorView addSubview:Colorbutt];
    
    
    
    button6=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width-34, Categorytypeunderlinelab7.frame.size.height+Categorytypeunderlinelab7.frame.origin.y+15, 24, 24)];
    [button6 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button6.backgroundColor=[UIColor clearColor];
    [button6 addTarget:self action:@selector(Button66Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:button6];
    
    UILabel *lab6=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width-139, Categorytypeunderlinelab7.frame.size.height+Categorytypeunderlinelab7.frame.origin.y+15, 100, 24)];
    lab6.text=@"I Want to sell";
    lab6.textColor=[UIColor blackColor];
    lab6.textAlignment=NSTextAlignmentRight;
    lab6.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab6];
    
    button7=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width-34, lab6.frame.size.height+lab6.frame.origin.y+5, 24, 24)];
    [button7 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button7.backgroundColor=[UIColor clearColor];
    [button7 addTarget:self action:@selector(Button77Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:button7];
    
    UILabel *lab7=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width-139, lab6.frame.size.height+lab6.frame.origin.y+5, 100, 24)];
    lab7.text=@"I Want to buy";
    lab7.textColor=[UIColor blackColor];
    lab7.textAlignment=NSTextAlignmentRight;
    lab7.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab7];
    
    UILabel *Categorytypeunderlinelab8=[[UILabel alloc]initWithFrame:CGRectMake(10, lab7.frame.size.height+lab7.frame.origin.y+6, motorView.frame.size.width-20, 1)];
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
    [requested showMessage:@"fuel Type Clicked" withTitle:@"Fuel Type"];
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
    buttonj1=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width-34, 10, 24, 24)];
    [buttonj1 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    buttonj1.backgroundColor=[UIColor clearColor];
    [buttonj1 addTarget:self action:@selector(Buttonj1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:buttonj1];
    
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, motorView.frame.size.width-49, 24)];
    lab1.text=@"I am an employer";
    lab1.textColor=[UIColor blackColor];
    lab1.textAlignment=NSTextAlignmentRight;
    lab1.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab1];
    
    buttonj2=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width-34, lab1.frame.size.height+lab1.frame.origin.y+5, 24, 24)];
    [buttonj2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    buttonj2.backgroundColor=[UIColor clearColor];
    [buttonj2 addTarget:self action:@selector(Buttonj2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [motorView addSubview:buttonj2];
    
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(10, lab1.frame.size.height+lab1.frame.origin.y+5, motorView.frame.size.width-49, 24)];
    lab2.text=@"I need a Job";
    lab2.textColor=[UIColor blackColor];
    lab2.textAlignment=NSTextAlignmentRight;
    lab2.font=[UIFont systemFontOfSize:15];
    [motorView addSubview:lab2];
    
    
    
    CompanyName=[[UITextField alloc]initWithFrame:CGRectMake(10, lab2.frame.size.height+lab2.frame.origin.y+15, motorView.frame.size.width-20, 30)];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Company Name" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    CompanyName.attributedPlaceholder = str1;
    CompanyName.textAlignment=NSTextAlignmentRight;
    CompanyName.textColor=[UIColor blackColor];
    CompanyName.font = [UIFont systemFontOfSize:15];
    CompanyName.backgroundColor=[UIColor clearColor];
    CompanyName.delegate=self;
    [motorView addSubview:CompanyName];
    
    imagej=[[UIImageView alloc]initWithFrame:CGRectMake(10, lab2.frame.size.height+lab2.frame.origin.y+22,16, 16)];
    imagej.image=[UIImage imageNamed:@"left.png"];
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
    Role.textAlignment=NSTextAlignmentRight;
    [Role setFont:[UIFont systemFontOfSize:15]];
    Role.textColor=[UIColor blackColor];
    [motorView addSubview:Role];
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab.frame.size.height+Categorytypeunderlinelab.frame.origin.y+12,16, 16)];
    image1.image=[UIImage imageNamed:@"left.png"];
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
    education.textAlignment=NSTextAlignmentRight;
    [education setFont:[UIFont systemFontOfSize:15]];
    education.textColor=[UIColor blackColor];
    [motorView addSubview:education];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab1.frame.size.height+Categorytypeunderlinelab1.frame.origin.y+12,16, 16)];
    image2.image=[UIImage imageNamed:@"left.png"];
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
    experience.textAlignment=NSTextAlignmentRight;
    [experience setFont:[UIFont systemFontOfSize:15]];
    experience.textColor=[UIColor blackColor];
    [motorView addSubview:experience];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+12,16, 16)];
    image3.image=[UIImage imageNamed:@"left.png"];
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
    compensation.textAlignment=NSTextAlignmentRight;
    [compensation setFont:[UIFont systemFontOfSize:15]];
    compensation.textColor=[UIColor blackColor];
    [motorView addSubview:compensation];
    
    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+12,16, 16)];
    image4.image=[UIImage imageNamed:@"left.png"];
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
    txtadtitle.textAlignment=NSTextAlignmentRight;
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
    txtadDesc.textAlignment=NSTextAlignmentRight;
    [self setPlaceholder];
    txtadDesc.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    txtadDesc.layer.borderWidth=1.0;
    txtadDesc.font = [UIFont systemFontOfSize:15];
    txtadDesc.backgroundColor=[UIColor clearColor];
    txtadDesc.delegate=self;
    [motorView addSubview:txtadDesc];
    
    
    ChoosefileAdbutt=[[UIButton alloc]initWithFrame:CGRectMake(motorView.frame.size.width-110, txtadDesc.frame.origin.y+txtadDesc.frame.size.height+15, 100, 20)];
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
    
    nofilelab=[[UILabel alloc]initWithFrame:CGRectMake(motorView.frame.size.width-295, txtadDesc.frame.size.height+txtadDesc.frame.origin.y+15,180, 20)];
    nofilelab.text=@"no file selected";
    nofilelab.textAlignment=NSTextAlignmentRight;
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
    buttonpr1=[[UIButton alloc]initWithFrame:CGRectMake(PropertyonRentView.frame.size.width-34, 10, 24, 24)];
    [buttonpr1 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    buttonpr1.backgroundColor=[UIColor clearColor];
    [buttonpr1 addTarget:self action:@selector(Buttonpr1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [PropertyonRentView addSubview:buttonpr1];
    
    labP1=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, PropertyonRentView.frame.size.width-49, 24)];
    if ([_strCategeoryUrlparameter isEqualToString:@"property_rent"])
    {
        labP1.text=@"I want to give on rent i am a landlord";
    }
    else if ([_strCategeoryUrlparameter isEqualToString:@"property_sale"])
    {
        labP1.text=@"I am a seller";
    }
    labP1.textColor=[UIColor blackColor];
    labP1.textAlignment=NSTextAlignmentRight;
    labP1.font=[UIFont systemFontOfSize:15];
    [PropertyonRentView addSubview:labP1];
    
    buttonpr2=[[UIButton alloc]initWithFrame:CGRectMake(PropertyonRentView.frame.size.width-34, labP1.frame.size.height+labP1.frame.origin.y+5, 24, 24)];
    [buttonpr2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    buttonpr2.backgroundColor=[UIColor clearColor];
    [buttonpr2 addTarget:self action:@selector(Buttonpr2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [PropertyonRentView addSubview:buttonpr2];
    
    labP2=[[UILabel alloc]initWithFrame:CGRectMake(10, labP1.frame.size.height+labP1.frame.origin.y+5, PropertyonRentView.frame.size.width-49, 24)];
    if ([_strCategeoryUrlparameter isEqualToString:@"property_rent"])
    {
        labP2.text=@"I want to take on rent i am a tenant";
    }
    else if ([_strCategeoryUrlparameter isEqualToString:@"property_sale"])
    {
        labP2.text=@"I am a buyer";
    }
    labP2.textColor=[UIColor blackColor];
    labP2.textAlignment=NSTextAlignmentRight;
    labP2.font=[UIFont systemFontOfSize:15];
    [PropertyonRentView addSubview:labP2];
    
    UILabel *Categorytypeunderlinelab=[[UILabel alloc]initWithFrame:CGRectMake(10, labP2.frame.size.height+labP2.frame.origin.y+10, PropertyonRentView.frame.size.width-20, 1)];
    Categorytypeunderlinelab.backgroundColor=[UIColor lightGrayColor];
    [PropertyonRentView addSubview:Categorytypeunderlinelab];
    
    UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab.frame.size.height+Categorytypeunderlinelab.frame.origin.y+5, PropertyonRentView.frame.size.width-20, 24)];
    lab3.text=@"You are:";
    lab3.textColor=[UIColor blackColor];
    lab3.textAlignment=NSTextAlignmentRight;
    lab3.font=[UIFont systemFontOfSize:15];
    [PropertyonRentView addSubview:lab3];
    
    
    
    buttonpr3=[[UIButton alloc]initWithFrame:CGRectMake(PropertyonRentView.frame.size.width-34, lab3.frame.size.height+lab3.frame.origin.y+6, 24, 24)];
    [buttonpr3 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    buttonpr3.backgroundColor=[UIColor clearColor];
    [buttonpr3 addTarget:self action:@selector(Buttonpr3Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [PropertyonRentView addSubview:buttonpr3];
    
    UILabel *lab4=[[UILabel alloc]initWithFrame:CGRectMake(10, lab3.frame.size.height+lab3.frame.origin.y+6, PropertyonRentView.frame.size.width-49, 24)];
    lab4.text=@"Individual";
    lab4.textColor=[UIColor blackColor];
    lab4.textAlignment=NSTextAlignmentRight;
    lab4.font=[UIFont systemFontOfSize:15];
    [PropertyonRentView addSubview:lab4];
    
    buttonpr4=[[UIButton alloc]initWithFrame:CGRectMake(PropertyonRentView.frame.size.width-34, lab4.frame.size.height+lab4.frame.origin.y+5, 24, 24)];
    [buttonpr4 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    buttonpr4.backgroundColor=[UIColor clearColor];
    [buttonpr4 addTarget:self action:@selector(Buttonpr4Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [PropertyonRentView addSubview:buttonpr4];
    
    UILabel *lab5=[[UILabel alloc]initWithFrame:CGRectMake(10, lab4.frame.size.height+lab4.frame.origin.y+5, PropertyonRentView.frame.size.width-49, 24)];
    lab5.text=@"Broker";
    lab5.textColor=[UIColor blackColor];
    lab5.textAlignment=NSTextAlignmentRight;
    lab5.font=[UIFont systemFontOfSize:15];
    [PropertyonRentView addSubview:lab5];
    
    
    buttonpr5=[[UIButton alloc]initWithFrame:CGRectMake(PropertyonRentView.frame.size.width-34, lab5.frame.size.height+lab5.frame.origin.y+5, 24, 24)];
    [buttonpr5 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    buttonpr5.backgroundColor=[UIColor clearColor];
    [buttonpr5 addTarget:self action:@selector(Buttonpr5Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [PropertyonRentView addSubview:buttonpr5];
    
    UILabel *lab6=[[UILabel alloc]initWithFrame:CGRectMake(10, lab5.frame.size.height+lab5.frame.origin.y+5, PropertyonRentView.frame.size.width-49, 24)];
    lab6.text=@"Builder";
    lab6.textColor=[UIColor blackColor];
    lab6.textAlignment=NSTextAlignmentRight;
    lab6.font=[UIFont systemFontOfSize:15];
    [PropertyonRentView addSubview:lab6];
    
    UILabel *Categorytypeunderlinelab1=[[UILabel alloc]initWithFrame:CGRectMake(10, lab6.frame.size.height+lab6.frame.origin.y+10, PropertyonRentView.frame.size.width-20, 1)];
    Categorytypeunderlinelab1.backgroundColor=[UIColor lightGrayColor];
    [PropertyonRentView addSubview:Categorytypeunderlinelab1];
    
    
    
    txtprice=[[UITextField alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab1.frame.size.height+Categorytypeunderlinelab1.frame.origin.y+5, PropertyonRentView.frame.size.width-20, 30)];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Price" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtprice.attributedPlaceholder = str1;
    txtprice.textAlignment=NSTextAlignmentRight;
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
    noofroomslab.textAlignment=NSTextAlignmentRight;
    [noofroomslab setFont:[UIFont systemFontOfSize:15]];
    noofroomslab.textColor=[UIColor blackColor];
    [PropertyonRentView addSubview:noofroomslab];
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(10, Categorytypeunderlinelab2.frame.size.height+Categorytypeunderlinelab2.frame.origin.y+12,16, 16)];
    image.image=[UIImage imageNamed:@"left.png"];
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
    txtareasquare.textAlignment=NSTextAlignmentRight;
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
    furnishedlab.textAlignment=NSTextAlignmentRight;
    [furnishedlab setFont:[UIFont systemFontOfSize:15]];
    furnishedlab.textColor=[UIColor blackColor];
    [PropertyonRentView addSubview:furnishedlab];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(motorView.frame.size.width-26, Categorytypeunderlinelab3.frame.size.height+Categorytypeunderlinelab3.frame.origin.y+12,16, 16)];
    image2.image=[UIImage imageNamed:@"left.png"];
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
    txtadtitle.textAlignment=NSTextAlignmentRight;
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
    txtadDesc.textAlignment=NSTextAlignmentRight;
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
    if ([_strCategeoryUrlparameter isEqualToString:@"property_rent"])
    {
        strwanttogive=@"I want to give on rent i am a landlord";
    }
    else if ([_strCategeoryUrlparameter isEqualToString:@"property_sale"])
    {
        strsellerbuyer=@"I am a seller";
    }
    
    [buttonpr1 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
    [buttonpr2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
}


-(IBAction)Buttonpr2Clicked:(id)sender
{
    if ([_strCategeoryUrlparameter isEqualToString:@"property_rent"])
    {
        strwanttogive=@"I want to take on rent i am a tenant";
    }
    else if ([_strCategeoryUrlparameter isEqualToString:@"property_sale"])
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






#pragma mark - Back Clicked

-(IBAction)BackbuttClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    if (textField==txtcity)
    {
        city.hidden=NO;
    }
    else if (textField==txtlocality)
    {
        locality.hidden=NO;
    }
    else if (textField==txtName)
    {
        name.hidden=NO;
    }
    else if (textField==txtemail)
    {
        email.hidden=NO;
    }
    else if (textField==txtccode || textField==txtmobile)
    {
        mobile.hidden=NO;
    }
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==txtcity)
    {
        if (txtcity.text.length==0)
        {
            city.hidden=YES;
        }
    }
    else if (textField==txtlocality)
    {
        if (txtlocality.text.length==0)
        {
            locality.hidden=YES;
        }
    }
    else if (textField==txtName)
    {
        if (txtName.text.length==0)
        {
            name.hidden=YES;
        }
    }
    else if (textField==txtemail)
    {
        if (txtemail.text.length==0)
        {
            email.hidden=YES;
        }
    }
    else if (textField==txtccode || textField==txtmobile)
    {
        if (txtmobile.text.length==0)
        {
            mobile.hidden=YES;
        }
    }
    [self animateTextField:textField up:NO];
}

- (void)dismissKeyboard
{
    [txtcity resignFirstResponder];
    [txtadDesc resignFirstResponder];
    [txtadtitle resignFirstResponder];
    [txtlocality resignFirstResponder];
    [txtName resignFirstResponder];
    [txtemail resignFirstResponder];
    [txtccode resignFirstResponder];
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
