//
//  AccountInformarabicViewController.m
//  BoxBazar
//
//  Created by bharat on 29/08/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "AccountInformarabicViewController.h"
#import "UIImageView+WebCache.h"
#import "ApiRequest.h"
#import "ArabicloginRegisterViewController.h"
#import <Foundation/Foundation.h>
#import "OAuthLoginView.h"
#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "BoxBazarUrl.pch"
#import "DejalActivityView.h"
#import "AdsListArabicViewController.h"
#import "FavoritearabicViewController.h"
#import "ACFloatingTextField.h"
#import "SLCountryPickerViewController.h"
#import "HMDiallingCode.h"

@interface AccountInformarabicViewController ()<ApiRequestdelegate,UITextFieldDelegate,HMDiallingCodeDelegate>
{
    UIImageView *Profileimage;
    ApiRequest *requested;
    
    UIImage *currentSelectedImage;
    
    OAuthLoginView *linkedInLoginView;
    NSString *_id,*profileUrl,*email,*industry,*name;
    
    UIButton *logoutbutt,*DobButt,*cancelbutt,*Savebutt,*imagebutton;
    UITextField *txtName,*MobileNumber,*txtEmailId;
    
    UILabel *AdsPostLabel,*MyShortlistLabel;
    UIView *popview;
    UIView *footerview;
    
    UITextField *txtCurrentPassword,*txtNewPassword,*txtConformNewPassword;
    UILabel *CurrentPasswordUnderlabel,*NewPasswordUnderlabel,*ConformNewPasswordUnderlabel;
    
    NSString *strUserid,*strlocation;
    
    ACFloatingTextField *forgotPasswordMobile,*pluslabel,*txtverifycode,*txtCountryCode,*txtMobileNumber;
    UILabel *forgotPasswordMobileUnderlabel;
    
    NSString *struseridnumer,*strnewpassword,*struserid;
    int b;
    BOOL isClicked2;
}
@property (strong, nonatomic) HMDiallingCode *diallingCode;
@end

@implementation AccountInformarabicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    isClicked2=YES;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.desiredAccuracy = 45;
    locationManager.distanceFilter = 100;
    [locationManager startUpdatingLocation];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.diallingCode = [[HMDiallingCode alloc] initWithDelegate:self];
    
    self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    
    self.ScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 550);
    
    [self customView];
    [self setupAlertCtrl];
}

-(void)responsewithCitylist:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=[responseDict objectForKey:@"data"];
    NSLog(@"Profile Response: %@",responseDictionary);
    NSString *strname=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"firstname"]];
    txtName.text=strname;
    MobileNumber.text=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"mobile"]];
    txtEmailId.text=[responseDictionary valueForKey:@"email"];
    AdsPostLabel.text=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"ads_posted"]];
    MyShortlistLabel.text=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"shortlisted"]];
    [logoutbutt setTitle:@"Logout" forState:UIControlStateNormal];
    [Profileimage sd_setImageWithURL:[NSURL URLWithString:[responseDictionary valueForKey:@"profile_pic"]]
                    placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
    
    
    
    imagebutton.hidden=YES;
    txtName.userInteractionEnabled=NO;
    
    logoutbutt.hidden=NO;
    cancelbutt.hidden=YES;
    Savebutt.hidden=YES;
}


- (void)setupAlertCtrl
{
    self.alertCtrl = [UIAlertController alertControllerWithTitle:@"قم بتحديد خيار واحد"
                                                         message:nil
                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    //Create an action
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"التقاط صورة"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action)
                             {
                                 [self handleCamera];
                             }];
    UIAlertAction *imageGallery = [UIAlertAction actionWithTitle:@"الاختيار من معرض الصور"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       [self handleImageGallery];
                                   }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"إلغاء الأمر"
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

#pragma mark
#pragma mark -- Reduce Image Size

-(UIImage*)imageWithReduceImage: (UIImage*)imageName scaleToSize: (CGSize)newsize
{
    UIGraphicsBeginImageContextWithOptions(newsize, NO, 12.0);
    [imageName drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    NSData *dataImage = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],1);
//    UIImage *img = [[UIImage alloc] initWithData:dataImage];
//    [Profileimage setImage:img];
//    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:@"image" forKey:@"image"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    NSData *dataImage = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],1);
    currentSelectedImage = [[UIImage alloc] initWithData:dataImage];
    [Profileimage setImage:currentSelectedImage];
    //    currentSelectedImage = [self imageWithReduceImage:currentSelectedImage
    //                                          scaleToSize:CGSizeMake(40, 40)];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    
    
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
    
    strlocation=[responseJSON valueForKey:@"url"];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"image"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}




-(void)customView
{
    UIView *topview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
     topview.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [self.view addSubview:topview];
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(topview.frame.size.width/2-40, topview.frame.size.height/2-8, 80, 30)];
    titlelabel.text=@"ملف التعريف الخاص بي";
    titlelabel.textAlignment=NSTextAlignmentCenter;
    [titlelabel setFont:[UIFont boldSystemFontOfSize:15]];
    titlelabel.textColor=[UIColor whiteColor];
    [topview addSubview:titlelabel];
    
    UIImageView *imaged2=[[UIImageView alloc] initWithFrame:CGRectMake(10, topview.frame.size.height/2-5, 24, 24)];
    imaged2.image=[UIImage imageNamed:@"menu-2.png"];
    [topview addSubview:imaged2];
    
    UIButton *Backbutt3=[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
    [Backbutt3 addTarget:self action:@selector(EditbuttlogClicked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt3.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt3];
    
    
    UIView *topview1=[[UIView alloc] initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, 180)];
    topview1.backgroundColor=[UIColor lightGrayColor];
    [_ScrollView addSubview:topview1];
    
    Profileimage=[[UIImageView alloc]initWithFrame:CGRectMake(topview1.frame.size.width/2-40, topview1.frame.size.height/2-80, 80, 80)];
    [Profileimage sd_setImageWithURL:[NSURL URLWithString:@""]
                    placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
    Profileimage.layer.cornerRadius = Profileimage.frame.size.height /2;
    Profileimage.contentMode = UIViewContentModeScaleAspectFill;
    Profileimage.layer.masksToBounds = YES;
    Profileimage.layer.borderWidth = 0;
    [topview1 addSubview:Profileimage];
    
    UIImageView *editnameimage=[[UIImageView alloc] initWithFrame:CGRectMake(topview1.frame.size.width-22, 8, 16, 16)];
    editnameimage.image=[UIImage imageNamed:@"pencil-edit-button-2.png"];
    editnameimage.hidden=YES;
    [topview1 addSubview:editnameimage];
    
    UIButton *Editbutton=[[UIButton alloc]initWithFrame:CGRectMake(topview.frame.size.width-40, 0, 50, 50)];
    Editbutton.hidden=YES;
    Editbutton.backgroundColor=[UIColor clearColor];
    [Editbutton addTarget:self action:@selector(EditbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    [topview1 addSubview:Editbutton];
    
    imagebutton=[[UIButton alloc]initWithFrame:CGRectMake(topview1.frame.size.width/2-40, topview1.frame.size.height/2-80, 80, 80)];
    imagebutton.backgroundColor=[UIColor clearColor];
    [imagebutton addTarget:self action:@selector(ProfileImageClicked:) forControlEvents:UIControlEventTouchUpInside];
    [topview1 addSubview:imagebutton];
    
    
    
    txtName=[[UITextField alloc]initWithFrame:CGRectMake(10, imagebutton.frame.origin.y+imagebutton.frame.size.height+5, topview1.frame.size.width-20, 22)];
    txtName.placeholder=@"UserName";
    txtName.textAlignment = NSTextAlignmentCenter;
    txtName.textColor=[UIColor blackColor];
    txtName.userInteractionEnabled=NO;
    txtName.delegate=self;
    txtName.font = [UIFont systemFontOfSize:15];
    txtName.backgroundColor=[UIColor clearColor];
    [topview1 addSubview:txtName];
    
    UIView *numberView=[[UIView alloc] initWithFrame:CGRectMake(topview1.frame.size.width/2-75, txtName.frame.origin.y+txtName.frame.size.height+1, 38, 22)];
    numberView.hidden=YES;
    numberView.backgroundColor=[UIColor clearColor];
    [topview1 addSubview:numberView];
    
    UILabel *labelplus=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 8, 22)];
    labelplus.text=@"+";
    labelplus.textColor=[UIColor blackColor];
    labelplus.font = [UIFont systemFontOfSize:15];
    labelplus.textAlignment = NSTextAlignmentLeft;
    labelplus.backgroundColor=[UIColor clearColor];
    [numberView addSubview:labelplus];
    
    UITextField *CountryCode=[[UITextField alloc]initWithFrame:CGRectMake(11, 0,30, 22)];
    //  CountryCode.placeholder=@"CCode";
    CountryCode.text=@"91";
    CountryCode.textAlignment = NSTextAlignmentLeft;
    CountryCode.textColor=[UIColor blackColor];
    CountryCode.font = [UIFont systemFontOfSize:15];
    CountryCode.backgroundColor=[UIColor clearColor];
    [numberView addSubview:CountryCode];
    
    //    UITextField *MobileNumber=[[UITextField alloc]initWithFrame:CGRectMake(numberView.frame.origin.x+numberView.frame.size.width-2, txtName.frame.origin.y+txtName.frame.size.height+1,120, 22)];
    //    MobileNumber.placeholder=@"Mobile Number";
    //    MobileNumber.textAlignment = NSTextAlignmentCenter;
    //    MobileNumber.textColor=[UIColor blackColor];
    //    MobileNumber.font = [UIFont systemFontOfSize:15];
    //    MobileNumber.backgroundColor=[UIColor clearColor];
    //    [topview1 addSubview:MobileNumber];
    
    MobileNumber=[[UITextField alloc]initWithFrame:CGRectMake(topview1.frame.size.width/2-100, txtName.frame.origin.y+txtName.frame.size.height+1,200, 22)];
    MobileNumber.placeholder=@"User Mobile Number";
    MobileNumber.textAlignment = NSTextAlignmentCenter;
    MobileNumber.textColor=[UIColor blackColor];
    MobileNumber.font = [UIFont systemFontOfSize:15];
    MobileNumber.userInteractionEnabled=NO;
    MobileNumber.backgroundColor=[UIColor clearColor];
    [topview1 addSubview:MobileNumber];
    
    
    txtEmailId=[[UITextField alloc]initWithFrame:CGRectMake(10, numberView.frame.origin.y+numberView.frame.size.height+5, topview1.frame.size.width-20, 22)];
    txtEmailId.placeholder=@"User Email Id";
    txtEmailId.textAlignment = NSTextAlignmentCenter;
    txtEmailId.textColor=[UIColor blackColor];
    txtEmailId.font = [UIFont systemFontOfSize:15];
    txtEmailId.userInteractionEnabled=NO;
    txtEmailId.backgroundColor=[UIColor clearColor];
    [topview1 addSubview:txtEmailId];
    
    
    
    
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(5, topview1.frame.size.height+topview1.frame.origin.y+5, self.view.frame.size.width-10, 210)];
    view2.backgroundColor=[UIColor whiteColor];
    view2.layer.cornerRadius = 5;
    view2.clipsToBounds = YES;
    view2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view2.layer.borderWidth = 1.0f;
    [_ScrollView addSubview:view2];
    
    UIButton *AdsPostbutt=[[UIButton alloc]initWithFrame:CGRectMake(6, 1, view2.frame.size.width-12, 50)];
    [AdsPostbutt setTitle:@"Ads Posted" forState:UIControlStateNormal];
    AdsPostbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [AdsPostbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    AdsPostbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [AdsPostbutt addTarget:self action:@selector(AdsPostedClickednew:) forControlEvents:UIControlEventTouchUpInside];
    AdsPostbutt.backgroundColor=[UIColor clearColor];
    [view2 addSubview:AdsPostbutt];
    
    AdsPostLabel=[[UILabel alloc]initWithFrame:CGRectMake(6, 1, 50, 50)];
    AdsPostLabel.text=@"0";
    AdsPostLabel.textColor=[UIColor blackColor];
    AdsPostLabel.font = [UIFont systemFontOfSize:15];
    AdsPostLabel.textAlignment = NSTextAlignmentLeft;
    AdsPostLabel.backgroundColor=[UIColor clearColor];
    [view2 addSubview:AdsPostLabel];
    
    
    
    
    UILabel *label6=[[UILabel alloc] initWithFrame:CGRectMake(6, AdsPostbutt.frame.origin.y+AdsPostbutt.frame.size.height+1, view2.frame.size.width-12, 1)];
    label6.backgroundColor=[UIColor lightGrayColor];
    [view2 addSubview:label6];
    
    
    UIButton *AdsRespondedbutt=[[UIButton alloc]initWithFrame:CGRectMake(6, label6.frame.origin.y+label6.frame.size.height+1, view2.frame.size.width-60, 30)];
    [AdsRespondedbutt setTitle:@"Ads Responded" forState:UIControlStateNormal];
    AdsRespondedbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [AdsRespondedbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    AdsRespondedbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    AdsRespondedbutt.hidden=YES;
    [AdsRespondedbutt addTarget:self action:@selector(AdsRespondedClicked:) forControlEvents:UIControlEventTouchUpInside];
    AdsRespondedbutt.backgroundColor=[UIColor clearColor];
    [view2 addSubview:AdsRespondedbutt];
    
    UILabel *AdsRespondedLabel=[[UILabel alloc]initWithFrame:CGRectMake(view2.frame.size.width-60,label6.frame.origin.y+label6.frame.size.height+1, 50, 30)];
    AdsRespondedLabel.text=@"0";
    AdsRespondedLabel.hidden=YES;
    AdsRespondedLabel.textColor=[UIColor blackColor];
    AdsRespondedLabel.font = [UIFont systemFontOfSize:15];
    AdsRespondedLabel.textAlignment = NSTextAlignmentRight;
    AdsRespondedLabel.backgroundColor=[UIColor clearColor];
    [view2 addSubview:AdsRespondedLabel];
    
    UILabel *label7=[[UILabel alloc] initWithFrame:CGRectMake(6, AdsRespondedbutt.frame.origin.y+AdsRespondedbutt.frame.size.height+1, view2.frame.size.width-12, 1)];
    label7.backgroundColor=[UIColor lightGrayColor];
    label7.hidden=YES;
    [view2 addSubview:label7];
    
    
    
    UIButton *MyShortlistbutt=[[UIButton alloc]initWithFrame:CGRectMake(6, label6.frame.origin.y+label6.frame.size.height+1, view2.frame.size.width-12, 50)];
    [MyShortlistbutt setTitle:@"My Shortlist" forState:UIControlStateNormal];
    MyShortlistbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [MyShortlistbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    MyShortlistbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [MyShortlistbutt addTarget:self action:@selector(MyShortlistbuttClickedn:) forControlEvents:UIControlEventTouchUpInside];
    MyShortlistbutt.backgroundColor=[UIColor clearColor];
    [view2 addSubview:MyShortlistbutt];
    
    MyShortlistLabel=[[UILabel alloc]initWithFrame:CGRectMake(6,label6.frame.origin.y+label6.frame.size.height+1, 50, 50)];
    MyShortlistLabel.text=@"0";
    MyShortlistLabel.textColor=[UIColor blackColor];
    MyShortlistLabel.font = [UIFont systemFontOfSize:15];
    MyShortlistLabel.textAlignment = NSTextAlignmentLeft;
    MyShortlistLabel.backgroundColor=[UIColor clearColor];
    [view2 addSubview:MyShortlistLabel];
    
    UILabel *label8=[[UILabel alloc] initWithFrame:CGRectMake(6, MyShortlistbutt.frame.origin.y+MyShortlistbutt.frame.size.height+1, view2.frame.size.width-12, 1)];
    label8.backgroundColor=[UIColor lightGrayColor];
    [view2 addSubview:label8];
    
    
    UIButton *ChangePasswordbutt=[[UIButton alloc]initWithFrame:CGRectMake(6, label8.frame.origin.y+label8.frame.size.height+1, view2.frame.size.width-12, 50)];
    [ChangePasswordbutt setTitle:@"Change Password" forState:UIControlStateNormal];
    ChangePasswordbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [ChangePasswordbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ChangePasswordbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [ChangePasswordbutt addTarget:self action:@selector(ChangePasswordbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    ChangePasswordbutt.backgroundColor=[UIColor clearColor];
    [view2 addSubview:ChangePasswordbutt];
    
    UILabel *label18=[[UILabel alloc] initWithFrame:CGRectMake(6, ChangePasswordbutt.frame.origin.y+ChangePasswordbutt.frame.size.height+1, view2.frame.size.width-12, 1)];
    label18.backgroundColor=[UIColor lightGrayColor];
    [view2 addSubview:label18];
    
    UIButton *forgotpasswordbutt=[[UIButton alloc]initWithFrame:CGRectMake(6, label18.frame.origin.y+label18.frame.size.height+1, view2.frame.size.width-12, 50)];
    [forgotpasswordbutt setTitle:@"Forgot Password" forState:UIControlStateNormal];
    forgotpasswordbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [forgotpasswordbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgotpasswordbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [forgotpasswordbutt addTarget:self action:@selector(forgotPasswordbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    forgotpasswordbutt.hidden=YES;
    forgotpasswordbutt.backgroundColor=[UIColor clearColor];
    [view2 addSubview:forgotpasswordbutt];
    
    
    UILabel *label28=[[UILabel alloc] initWithFrame:CGRectMake(6, forgotpasswordbutt.frame.origin.y+forgotpasswordbutt.frame.size.height+1, view2.frame.size.width-12, 1)];
    label28.backgroundColor=[UIColor lightGrayColor];
    label28.hidden=YES;
    [view2 addSubview:label28];
    
    UIButton *changeMobilebutt=[[UIButton alloc]initWithFrame:CGRectMake(6, label18.frame.origin.y+label18.frame.size.height+1, view2.frame.size.width-12, 50)];
    [changeMobilebutt setTitle:@"Change Mobile Number" forState:UIControlStateNormal];
    changeMobilebutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [changeMobilebutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    changeMobilebutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [changeMobilebutt addTarget:self action:@selector(changeMobilebuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    changeMobilebutt.backgroundColor=[UIColor clearColor];
    [view2 addSubview:changeMobilebutt];

    
    
    
    UIButton *MyAlertsbutt=[[UIButton alloc]initWithFrame:CGRectMake(6, label8.frame.origin.y+label8.frame.size.height+1, view2.frame.size.width-60, 30)];
    [MyAlertsbutt setTitle:@"My Alerts" forState:UIControlStateNormal];
    MyAlertsbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [MyAlertsbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    MyAlertsbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [MyAlertsbutt addTarget:self action:@selector(MyAlertsbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    MyAlertsbutt.hidden=YES;
    MyAlertsbutt.backgroundColor=[UIColor clearColor];
    [view2 addSubview:MyAlertsbutt];
    
    UILabel *MyAlertsLabel=[[UILabel alloc]initWithFrame:CGRectMake(view2.frame.size.width-60,label8.frame.origin.y+label8.frame.size.height+1, 50, 30)];
    MyAlertsLabel.text=@"0";
    MyAlertsLabel.textColor=[UIColor blackColor];
    MyAlertsLabel.font = [UIFont systemFontOfSize:15];
    MyAlertsLabel.hidden=YES;
    MyAlertsLabel.textAlignment = NSTextAlignmentRight;
    MyAlertsLabel.backgroundColor=[UIColor clearColor];
    [view2 addSubview:MyAlertsLabel];
    
    
    
    
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(5, view2.frame.size.height+view2.frame.origin.y+5, self.view.frame.size.width-10, 95)];
    view3.backgroundColor=[UIColor whiteColor];
    view3.layer.cornerRadius = 5;
    view3.clipsToBounds = YES;
    view3.hidden=YES;
    view3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view3.layer.borderWidth = 1.0f;
    [_ScrollView addSubview:view3];
    
    
    UIButton *MyCartbutt=[[UIButton alloc]initWithFrame:CGRectMake(6, 1, view3.frame.size.width-30, 30)];
    [MyCartbutt setTitle:@"My Cart" forState:UIControlStateNormal];
    MyCartbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [MyCartbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    MyCartbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [MyCartbutt addTarget:self action:@selector(MyCartClicked:) forControlEvents:UIControlEventTouchUpInside];
    MyCartbutt.backgroundColor=[UIColor clearColor];
    [view3 addSubview:MyCartbutt];
    
    UIImageView *image9=[[UIImageView alloc]initWithFrame:CGRectMake(view3.frame.size.width-22,8, 16, 16)];
    image9.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [view3 addSubview:image9];
    
    UILabel *label10=[[UILabel alloc] initWithFrame:CGRectMake(6, MyCartbutt.frame.origin.y+MyCartbutt.frame.size.height+1, view3.frame.size.width-12, 1)];
    label10.backgroundColor=[UIColor lightGrayColor];
    [view3 addSubview:label10];
    
    
    UIButton *MyOrdersbutt=[[UIButton alloc]initWithFrame:CGRectMake(6, label10.frame.size.height+label10.frame.origin.y+1, view3.frame.size.width-30, 30)];
    [MyOrdersbutt setTitle:@"My Orders" forState:UIControlStateNormal];
    MyOrdersbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [MyOrdersbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    MyOrdersbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [MyOrdersbutt addTarget:self action:@selector(MyOrdersClicked:) forControlEvents:UIControlEventTouchUpInside];
    MyOrdersbutt.backgroundColor=[UIColor clearColor];
    [view3 addSubview:MyOrdersbutt];
    
    UIImageView *image10=[[UIImageView alloc]initWithFrame:CGRectMake(view3.frame.size.width-22,label10.frame.size.height+label10.frame.origin.y+9, 16, 16)];
    image10.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [view3 addSubview:image10];
    
    UILabel *label11=[[UILabel alloc] initWithFrame:CGRectMake(6, MyOrdersbutt.frame.origin.y+MyOrdersbutt.frame.size.height+1, view3.frame.size.width-12, 1)];
    label11.backgroundColor=[UIColor lightGrayColor];
    [view3 addSubview:label11];
    
    
    UIButton *MyOffersbutt=[[UIButton alloc]initWithFrame:CGRectMake(6, label11.frame.size.height+label11.frame.origin.y+1, view3.frame.size.width-30, 30)];
    [MyOffersbutt setTitle:@"My Offers" forState:UIControlStateNormal];
    MyOffersbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [MyOffersbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    MyOffersbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [MyOffersbutt addTarget:self action:@selector(MyOffersClicked:) forControlEvents:UIControlEventTouchUpInside];
    MyOffersbutt.backgroundColor=[UIColor clearColor];
    [view3 addSubview:MyOffersbutt];
    
    UIImageView *image12=[[UIImageView alloc]initWithFrame:CGRectMake(view3.frame.size.width-22,label11.frame.size.height+label11.frame.origin.y+9, 16, 16)];
    image12.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [view3 addSubview:image12];
    
    
    
    
    UILabel *ConnectWithlabel=[[UILabel alloc]initWithFrame:CGRectMake(10, view3.frame.size.height+view3.frame.origin.y+5, self.view.frame.size.width-20, 30)];
    ConnectWithlabel.text=@"Connect With:";
    ConnectWithlabel.textAlignment=NSTextAlignmentLeft;
    [ConnectWithlabel setFont:[UIFont boldSystemFontOfSize:15]];
    ConnectWithlabel.textColor=[UIColor blackColor];
    ConnectWithlabel.hidden=YES;
    [_ScrollView addSubview:ConnectWithlabel];
    
    
    UIButton *facebookbutt=[[UIButton alloc]initWithFrame:CGRectMake(10, ConnectWithlabel.frame.origin.y+ConnectWithlabel.frame.size.height+5, self.view.frame.size.width-20, 40)];
    [facebookbutt setTitle:@"Facebook" forState:UIControlStateNormal];
    facebookbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [facebookbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    facebookbutt.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [facebookbutt addTarget:self action:@selector(facebookbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    facebookbutt.backgroundColor=[UIColor lightGrayColor];
    facebookbutt.hidden=YES;
    [_ScrollView addSubview:facebookbutt];
    
    
    
    UIButton *linkedinbutt=[[UIButton alloc]initWithFrame:CGRectMake(10, facebookbutt.frame.origin.y+facebookbutt.frame.size.height+10, self.view.frame.size.width-20, 40)];
    [linkedinbutt setTitle:@"Linkedin" forState:UIControlStateNormal];
    linkedinbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [linkedinbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    linkedinbutt.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [linkedinbutt addTarget:self action:@selector(linkedinbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    linkedinbutt.backgroundColor=[UIColor blackColor];
    linkedinbutt.hidden=YES;
    [_ScrollView addSubview:linkedinbutt];
    
    
    cancelbutt=[[UIButton alloc]initWithFrame:CGRectMake(10,view2.frame.origin.y+view2.frame.size.height+35,self.view.frame.size.width/2-15,50)];
    [cancelbutt setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelbutt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cancelbutt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [cancelbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelbutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [cancelbutt addTarget:self action:@selector(CancelButteClicked:) forControlEvents:UIControlEventTouchUpInside];
    cancelbutt.backgroundColor=[UIColor darkGrayColor];
    cancelbutt.hidden=YES;
    [_ScrollView addSubview:cancelbutt];
    
    Savebutt=[[UIButton alloc]initWithFrame:CGRectMake(cancelbutt.frame.size.width+cancelbutt.frame.origin.x+10, view2.frame.origin.y+view2.frame.size.height+35, self.view.frame.size.width/2-15, 50)];
    [Savebutt setTitle:@"Save" forState:UIControlStateNormal];
    Savebutt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    Savebutt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [Savebutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Savebutt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [Savebutt addTarget:self action:@selector(DoneButteClicked:) forControlEvents:UIControlEventTouchUpInside];
    Savebutt.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    Savebutt.hidden=YES;
    [_ScrollView addSubview:Savebutt];
    
    
    
    logoutbutt=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, view2.frame.origin.y+view2.frame.size.height+35, 200, 50)];
    [logoutbutt setTitle:@"Login/Register" forState:UIControlStateNormal];
    logoutbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [logoutbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logoutbutt.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [logoutbutt addTarget:self action:@selector(logoutbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    logoutbutt.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    logoutbutt.layer.cornerRadius = 8; // this value vary as per your desire
    logoutbutt.clipsToBounds = YES;
    [_ScrollView addSubview:logoutbutt];
    
    UILabel *logoutlabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, logoutbutt.frame.origin.y+logoutbutt.frame.size.height+1, 100, 1)];
    [logoutlabel setFont:[UIFont boldSystemFontOfSize:15]];
    logoutlabel.backgroundColor=[UIColor blackColor];
    logoutlabel.hidden=YES;
    [_ScrollView addSubview:logoutlabel];
}

-(IBAction)EditbuttClicked:(id)sender
{
    [requested showMessage:@"Edit button Clicked" withTitle:@"Edit butt"];
}

-(IBAction)ProfileImageClicked:(id)sender
{
    self.alertCtrl.popoverPresentationController.sourceView = self.view;
    [self presentViewController:self.alertCtrl animated:YES completion:nil];
}


-(IBAction)AdsPostedClickednew:(id)sender
{
    
    //   [request showMessage:@"We will Update Soon" withTitle:@"Ads Posted List"];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"userid"];
    if(object != nil)
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *post = [NSString stringWithFormat:@"user_id=%@",struseridnum];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,userPosts,arabic,strCityId];
        [requested sendRequest3:post withUrl:strurl];
    }
    else
    {
        
    }
    
}


-(void)responsewithToken3:(NSMutableDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        AdsListArabicViewController *lr=[self.storyboard instantiateViewControllerWithIdentifier:@"AdsListArabicViewController"];
        lr.arrChildCategory=[responseDict valueForKey:@"data"];
        lr.strtitle=@"Adds Posted";
        lr.strpage=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"nextPage"]];
        lr.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:lr animated:YES];
    }
    else
    {
        [requested showMessage:[responseDict valueForKey:@"message"] withTitle:@""];
    }
}

-(IBAction)MyShortlistbuttClickedn:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"userid"];
    if(object != nil)
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *post = [NSString stringWithFormat:@"user_id=%@",struseridnum];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,userFavorites,arabic,strCityId];
        [requested sendRequest4:post withUrl:strurl];
    }
    else
    {
        
    }
    
}


-(void)responsewithToken4:(NSMutableDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        FavoritearabicViewController *lr=[self.storyboard instantiateViewControllerWithIdentifier:@"FavoritearabicViewController"];
        lr.arrChildCategory=[responseDict valueForKey:@"data"];
        lr.strtitle=@"List of Favorites";
        lr.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:lr animated:YES];    }
    else
    {
        [requested showMessage:[responseDict valueForKey:@"message"] withTitle:@""];
    }
}





#pragma mark - change password

-(IBAction)ChangePasswordbuttClicked:(id)sender
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-120, 300, 240)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 40)];
    lab.text=@"Change Password";
    lab.textColor=[UIColor blackColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(0, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width, 2)];
    labeunder.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:labeunder];
    
    
    txtCurrentPassword=[[UITextField alloc]initWithFrame:CGRectMake(10, labeunder.frame.size.height+labeunder.frame.origin.y+15, footerview.frame.size.width-20, 40)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Current Password" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtCurrentPassword.attributedPlaceholder = str;
    txtCurrentPassword.textAlignment = NSTextAlignmentRight;
    txtCurrentPassword.textColor=[UIColor blackColor];
    txtCurrentPassword.font = [UIFont systemFontOfSize:15];
    txtCurrentPassword.backgroundColor=[UIColor clearColor];
    txtCurrentPassword.delegate=self;
    txtCurrentPassword.hidden=YES;
    txtCurrentPassword.returnKeyType = UIReturnKeyNext;
    [footerview addSubview:txtCurrentPassword];
    
    CurrentPasswordUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtCurrentPassword.frame.size.height+txtCurrentPassword.frame.origin.y+1, footerview.frame.size.width-20, 2)];
    CurrentPasswordUnderlabel.backgroundColor=[UIColor lightGrayColor];
    CurrentPasswordUnderlabel.hidden=YES;
    [footerview addSubview:CurrentPasswordUnderlabel];
    
    
    txtNewPassword=[[UITextField alloc]initWithFrame:CGRectMake(10, labeunder.frame.size.height+labeunder.frame.origin.y+15, footerview.frame.size.width-20, 40)];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"New Password" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtNewPassword.attributedPlaceholder = str1;
    txtNewPassword.textAlignment = NSTextAlignmentRight;
    txtNewPassword.textColor=[UIColor blackColor];
    txtNewPassword.font = [UIFont systemFontOfSize:15];
    txtNewPassword.backgroundColor=[UIColor clearColor];
    txtNewPassword.delegate=self;
    txtNewPassword.returnKeyType = UIReturnKeyNext;
    [footerview addSubview:txtNewPassword];
    
    NewPasswordUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtNewPassword.frame.size.height+txtNewPassword.frame.origin.y+1, footerview.frame.size.width-20, 2)];
    NewPasswordUnderlabel.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:NewPasswordUnderlabel];
    
    
    txtConformNewPassword=[[UITextField alloc]initWithFrame:CGRectMake(10, NewPasswordUnderlabel.frame.size.height+NewPasswordUnderlabel.frame.origin.y+15, footerview.frame.size.width-20, 40)];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"Confirm New Password" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtConformNewPassword.attributedPlaceholder = str2;
    txtConformNewPassword.textAlignment = NSTextAlignmentRight;
    txtConformNewPassword.textColor=[UIColor blackColor];
    txtConformNewPassword.font = [UIFont systemFontOfSize:15];
    txtConformNewPassword.backgroundColor=[UIColor clearColor];
    txtConformNewPassword.delegate=self;
    txtConformNewPassword.returnKeyType = UIReturnKeyDone;
    [footerview addSubview:txtConformNewPassword];
    
    ConformNewPasswordUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtConformNewPassword.frame.size.height+txtConformNewPassword.frame.origin.y+1, footerview.frame.size.width-20, 2)];
    ConformNewPasswordUnderlabel.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:ConformNewPasswordUnderlabel];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(10,ConformNewPasswordUnderlabel.frame.origin.y+ConformNewPasswordUnderlabel.frame.size.height+25,footerview.frame.size.width/2-15,40)];
    [butt setTitle:@"Cancel" forState:UIControlStateNormal];
    butt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [butt addTarget:self action:@selector(CancelButt3Clicked:) forControlEvents:UIControlEventTouchUpInside];
    butt.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width+butt.frame.origin.x+10, ConformNewPasswordUnderlabel.frame.origin.y+ConformNewPasswordUnderlabel.frame.size.height+25, footerview.frame.size.width/2-15, 40)];
    [butt1 setTitle:@"Done" forState:UIControlStateNormal];
    butt1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [butt1 addTarget:self action:@selector(DoneButt3Clicked:) forControlEvents:UIControlEventTouchUpInside];
    butt1.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [footerview addSubview:butt1];
    
    [self setupOutlets];
}


-(IBAction)CancelButt3Clicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}

-(IBAction)DoneButt3Clicked:(id)sender
{
    if (txtNewPassword.text.length==0)
    {
        [requested showMessage:@"Please Enter Your New Password" withTitle:@"Warning"];
    }
    else if (txtConformNewPassword.text.length==0)
    {
        [requested showMessage:@"Please Confirm Your New Password" withTitle:@"Warning"];
    }
    else if (![txtNewPassword.text isEqualToString:txtConformNewPassword.text])
    {
        [requested showMessage:@"Confirm New Password is not matching" withTitle:@"Warning"];
    }
    else
    {
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *post = [NSString stringWithFormat:@"user=%@&password=%@",struseridnum,txtNewPassword.text];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,editprofile,arabic,strCityId];
        [requested sendRequest:post withUrl:strurl];
        
        
        // strnewpassword=txtNewPassword.text;
    }
}


-(void)responsewithToken:(NSMutableDictionary *)responseToken
{
    NSLog(@"Edit Response :%@",responseToken);
    //  NSString *strmessage=[responseToken valueForKey:@"message"];
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        
        [requested showMessage:@"Your Profile has been Updated" withTitle:@"Profile Update"];
        [footerview removeFromSuperview];
        popview.hidden = YES;
    }
    else
    {
        [requested showMessage:[responseToken valueForKey:@"message"] withTitle:@"Profile Update"];
    }
    
}

#pragma mark - TextField Delegates

- (void)setupOutlets
{
    txtCurrentPassword.delegate = self;
    txtCurrentPassword.tag = 1;
    
    txtNewPassword.delegate=self;
    txtNewPassword.tag=2;
    
    txtConformNewPassword.delegate=self;
    txtConformNewPassword.tag=3;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField==txtCurrentPassword)
    {
        CurrentPasswordUnderlabel.backgroundColor=[UIColor blackColor];
    }
    else if (textField==txtNewPassword)
    {
        NewPasswordUnderlabel.backgroundColor=[UIColor blackColor];
    }
    else if (textField==txtConformNewPassword)
    {
        ConformNewPasswordUnderlabel.backgroundColor=[UIColor blackColor];
    }
    else if (textField==txtName)
    {
        
    }
    else
    {
        [(ACFloatingTextField *)textField textFieldDidBeginEditing];
    }
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==txtCurrentPassword)
    {
        CurrentPasswordUnderlabel.backgroundColor=[UIColor lightGrayColor];
    }
    else if (textField==txtNewPassword)
    {
        NewPasswordUnderlabel.backgroundColor=[UIColor lightGrayColor];
    }
    else if (textField==txtConformNewPassword)
    {
        ConformNewPasswordUnderlabel.backgroundColor=[UIColor lightGrayColor];
    }
    else if (textField==txtName)
    {
        
    }
    else
    {
        [(ACFloatingTextField *)textField textFieldDidEndEditing];
    }
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    if (textField==txtCurrentPassword)
    {
        const int movementDistance = -50;
        const float movementDuration = 0.3f;
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
    else if (textField==txtNewPassword)
    {
        const int movementDistance = -100;
        const float movementDuration = 0.3f;
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
    else if (textField==txtConformNewPassword)
    {
        const int movementDistance = -150;
        const float movementDuration = 0.3f;
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
}


- (void)dismissKeyboard
{
    [txtCurrentPassword resignFirstResponder];
    [txtNewPassword resignFirstResponder];
    [txtConformNewPassword resignFirstResponder];
    //    [txtFirstname resignFirstResponder];
    //    [txtlastName resignFirstResponder];
}

- (void)jumpToNextTextField:(UITextField *)textField withTag:(NSInteger)tag
{
    UIResponder *nextResponder = [self.view viewWithTag:tag];
    
    if ([nextResponder isKindOfClass:[UITextField class]])
    {
        [nextResponder becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==txtName)
    {
        [textField resignFirstResponder];
    }
    else
    {
        NSInteger nextTag = textField.tag + 1;
        [self jumpToNextTextField:textField withTag:nextTag];
        return NO;
    }
    return NO;
}




#pragma mark - forgot password


-(IBAction)forgotPasswordbuttClicked:(id)sender
{
    
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-100, 300, 200)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 40)];
    lab.text=@"Forget Password?";
    lab.textColor=[UIColor blackColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(0, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width, 2)];
    labeunder.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:labeunder];
    
    
    forgotPasswordMobile=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, labeunder.frame.size.height+labeunder.frame.origin.y+15, footerview.frame.size.width-20, 40)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Enter Your Registered Email Id/Mobile Number" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    forgotPasswordMobile.attributedPlaceholder = str;
    forgotPasswordMobile.textAlignment = NSTextAlignmentRight;
    forgotPasswordMobile.textColor=[UIColor blackColor];
    forgotPasswordMobile.font = [UIFont systemFontOfSize:15];
    forgotPasswordMobile.backgroundColor=[UIColor clearColor];
    forgotPasswordMobile.delegate=self;
    //    [forgotPasswordMobile setKeyboardType:UIKeyboardTypeNumberPad];
    forgotPasswordMobile.returnKeyType = UIReturnKeyDone;
    [footerview addSubview:forgotPasswordMobile];
    
    forgotPasswordMobileUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, forgotPasswordMobile.frame.size.height+forgotPasswordMobile.frame.origin.y+1, footerview.frame.size.width-20, 2)];
    forgotPasswordMobileUnderlabel.backgroundColor=[UIColor lightGrayColor];
    forgotPasswordMobileUnderlabel.hidden=YES;
    [footerview addSubview:forgotPasswordMobileUnderlabel];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(10,forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35,footerview.frame.size.width/2-15,40)];
    [butt setTitle:@"Cancel" forState:UIControlStateNormal];
    butt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt addTarget:self action:@selector(CancelButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    butt.backgroundColor=[UIColor grayColor];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width+butt.frame.origin.x+10, forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35, footerview.frame.size.width/2-15, 40)];
    [butt1 setTitle:@"Done" forState:UIControlStateNormal];
    butt1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt1 addTarget:self action:@selector(DoneButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    butt1.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [footerview addSubview:butt1];
    
}



-(IBAction)CancelButtClicked:(id)sender
{
    [footerview endEditing:YES];
    [footerview removeFromSuperview];
    popview.hidden = YES;
}

-(IBAction)DoneButtClicked:(id)sender
{
    [footerview endEditing:YES];
    if (forgotPasswordMobile.text.length==0)
    {
        [requested showMessage:@"Please Enter Your Registered Email Id/Mobile Number" withTitle:@"Warning"];
    }
    else
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user=%@",BaseUrl,strtoken,forgetPassword,arabic,strCityId,forgotPasswordMobile.text];
        [requested forgotPasswordRequest:nil withUrl:strurl];
    }
}


-(void)responseForgetPassword:(NSMutableDictionary *)responseToken
{
    NSLog(@"%@",responseToken);
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        struseridnumer=[NSString stringWithFormat:@"%@",[[responseToken valueForKey:@"data"]objectForKey:@"user_id"]];
        
        [requested showMessage:[responseToken valueForKey:@"message"] withTitle:@"BoxBazar"];
        
        [footerview removeFromSuperview];
        popview.hidden = YES;
        
        [self ReverifyPasswordAccount];
    }
    else
    {
        [footerview removeFromSuperview];
        popview.hidden = YES;
        
        NSString *strmessage=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"code"]];
        
        if ([strmessage isEqualToString:@"2"])
        {
            struseridnumer=[NSString stringWithFormat:@"%@",[[responseToken valueForKey:@"data"]objectForKey:@"user_id"]];
            [requested showMessage:[responseToken valueForKey:@"message"] withTitle:@"Message"];
            [self ReverifyAccount];
        }
        else
        {
            [requested showMessage:[responseToken valueForKey:@"message"] withTitle:@"Message"];
        }
    }
}


-(void)ReverifyPasswordAccount
{
    
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-100, 300, 200)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 40)];
    if (b==2)
    {
        lab.text=@"Change Mobile Number";
    }
    else
    {
        lab.text=@"Forget Password?";
    }
    lab.textColor=[UIColor blackColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(0, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width, 2)];
    labeunder.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:labeunder];
    
    
    forgotPasswordMobile=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, labeunder.frame.size.height+labeunder.frame.origin.y+15, footerview.frame.size.width-20, 40)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Enter Your OTP" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    forgotPasswordMobile.attributedPlaceholder = str;
    forgotPasswordMobile.textAlignment = NSTextAlignmentRight;
    forgotPasswordMobile.textColor=[UIColor blackColor];
    forgotPasswordMobile.font = [UIFont systemFontOfSize:15];
    forgotPasswordMobile.backgroundColor=[UIColor clearColor];
    forgotPasswordMobile.delegate=self;
    [forgotPasswordMobile setKeyboardType:UIKeyboardTypeNumberPad];
    forgotPasswordMobile.returnKeyType = UIReturnKeyDone;
    [footerview addSubview:forgotPasswordMobile];
    
    forgotPasswordMobileUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, forgotPasswordMobile.frame.size.height+forgotPasswordMobile.frame.origin.y+1, footerview.frame.size.width-20, 2)];
    forgotPasswordMobileUnderlabel.backgroundColor=[UIColor lightGrayColor];
    forgotPasswordMobileUnderlabel.hidden=YES;
    [footerview addSubview:forgotPasswordMobileUnderlabel];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(10,forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35,footerview.frame.size.width/2-15,40)];
    [butt setTitle:@"Cancel" forState:UIControlStateNormal];
    butt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt addTarget:self action:@selector(CancelButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    butt.backgroundColor=[UIColor grayColor];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width+butt.frame.origin.x+10, forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35, footerview.frame.size.width/2-15, 40)];
    [butt1 setTitle:@"Done" forState:UIControlStateNormal];
    butt1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt1 addTarget:self action:@selector(DoneButtClicked4:) forControlEvents:UIControlEventTouchUpInside];
    butt1.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [footerview addSubview:butt1];
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad2)],
                           nil];
    [numberToolbar sizeToFit];
    
    forgotPasswordMobile.inputAccessoryView = numberToolbar;
    
}

-(void)doneWithNumberPad2
{
    [forgotPasswordMobile resignFirstResponder];
    [txtMobileNumber resignFirstResponder];
}



-(IBAction)DoneButtClicked4:(id)sender
{
    if (forgotPasswordMobile.text.length==0)
    {
        [requested showMessage:@"Please Enter Your OTP" withTitle:@"Warning"];
    }
    else
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        //     NSString *struid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&otp=%@",BaseUrl,strtoken,VerifyPasswordOtp,arabic,strCityId,struseridnumer,forgotPasswordMobile.text];
        [requested OptionRequest6:nil withUrl:strurl];
    }
}


-(void)responseOption6:(NSMutableDictionary *)responseToken
{
    NSLog(@"%@",responseToken);
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        struseridnumer=[NSString stringWithFormat:@"%@",[[responseToken valueForKey:@"data"]objectForKey:@"user_id"]];
        //        [[NSUserDefaults standardUserDefaults]setObject:struseridnum forKey:@"userid"];
        //        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [footerview removeFromSuperview];
        popview.hidden = YES;
        
        [self changepassword];
    }
    else
    {
        [requested showMessage:[responseToken valueForKey:@"message"] withTitle:@"BoxBazar"];
        
    }
}


-(void)changepassword
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-120, 300, 240)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 40)];
    lab.text=@"Change Password";
    lab.textColor=[UIColor blackColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(0, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width, 2)];
    labeunder.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:labeunder];
    
    
    txtNewPassword=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, labeunder.frame.size.height+labeunder.frame.origin.y+15, footerview.frame.size.width-20, 40)];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"New Password" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtNewPassword.attributedPlaceholder = str1;
    txtNewPassword.textAlignment = NSTextAlignmentRight;
    txtNewPassword.textColor=[UIColor blackColor];
    txtNewPassword.font = [UIFont systemFontOfSize:15];
    txtNewPassword.backgroundColor=[UIColor clearColor];
    txtNewPassword.secureTextEntry=YES;
    txtNewPassword.delegate=self;
    txtNewPassword.returnKeyType = UIReturnKeyNext;
    [footerview addSubview:txtNewPassword];
    
    
    
    txtConformNewPassword=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, txtNewPassword.frame.size.height+txtNewPassword.frame.origin.y+15, footerview.frame.size.width-20, 40)];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"Confirm New Password" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtConformNewPassword.attributedPlaceholder = str2;
    txtConformNewPassword.textAlignment = NSTextAlignmentRight;
    txtConformNewPassword.textColor=[UIColor blackColor];
    txtConformNewPassword.font = [UIFont systemFontOfSize:15];
    txtConformNewPassword.backgroundColor=[UIColor clearColor];
    txtConformNewPassword.secureTextEntry=YES;
    txtConformNewPassword.delegate=self;
    txtConformNewPassword.returnKeyType = UIReturnKeyDone;
    [footerview addSubview:txtConformNewPassword];
    
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(10,txtConformNewPassword.frame.origin.y+txtConformNewPassword.frame.size.height+25,footerview.frame.size.width/2-15,40)];
    [butt setTitle:@"Cancel" forState:UIControlStateNormal];
    butt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt addTarget:self action:@selector(CancelButtClickedf:) forControlEvents:UIControlEventTouchUpInside];
    butt.backgroundColor=[UIColor grayColor];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width+butt.frame.origin.x+10, txtConformNewPassword.frame.origin.y+txtConformNewPassword.frame.size.height+25, footerview.frame.size.width/2-15, 40)];
    [butt1 setTitle:@"Done" forState:UIControlStateNormal];
    butt1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt1 addTarget:self action:@selector(DoneButtClickedf:) forControlEvents:UIControlEventTouchUpInside];
    butt1.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [footerview addSubview:butt1];
    
}

-(IBAction)CancelButtClickedf:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}

-(IBAction)DoneButtClickedf:(id)sender
{
    if (txtNewPassword.text.length==0)
    {
        [requested showMessage:@"Please Enter Your New Password" withTitle:@"Warning"];
    }
    else if (txtConformNewPassword.text.length==0)
    {
        [requested showMessage:@"Please Confirm Your New Password" withTitle:@"Warning"];
    }
    else if (![txtNewPassword.text isEqualToString:txtConformNewPassword.text])
    {
        [requested showMessage:@"Confirm New Password is not matching" withTitle:@"Warning"];
    }
    else
    {
        [footerview removeFromSuperview];
        popview.hidden = YES;
        strnewpassword=txtNewPassword.text;
        
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *post = [NSString stringWithFormat:@"user=%@&password=%@",struseridnumer,strnewpassword];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,editprofile,arabic,strCityId];
        [requested sendRequest1:post withUrl:strurl];
    }
}

-(void)responsewithToken1:(NSMutableDictionary *)responseToken
{
    NSLog(@"Edit Response :%@",responseToken);
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:struseridnumer forKey:@"userid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        //[self.navigationController popViewControllerAnimated:YES];
        [requested showMessage:[responseToken valueForKey:@"message"] withTitle:@"Profile Update"];
    }
    else
    {
        [requested showMessage:[responseToken valueForKey:@"message"] withTitle:@"Profile Update"];
    }
}


-(void)ReverifyAccount
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-100, 300, 200)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 40)];
    lab.text=@"Verify Account";
    lab.textColor=[UIColor blackColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(0, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width, 2)];
    labeunder.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:labeunder];
    
    
    txtverifycode=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, labeunder.frame.size.height+labeunder.frame.origin.y+15, footerview.frame.size.width-20, 40)];
    NSAttributedString *strw = [[NSAttributedString alloc] initWithString:@"Enter Your Verification Code" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtverifycode.attributedPlaceholder = strw;
    txtverifycode.textAlignment = NSTextAlignmentRight;
    txtverifycode.textColor=[UIColor blackColor];
    txtverifycode.font = [UIFont systemFontOfSize:15];
    txtverifycode.backgroundColor=[UIColor clearColor];
    txtverifycode.delegate=self;
    [txtverifycode setKeyboardType:UIKeyboardTypeNumberPad];
    txtverifycode.returnKeyType = UIReturnKeyDone;
    [footerview addSubview:txtverifycode];
    
    forgotPasswordMobileUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtverifycode.frame.size.height+txtverifycode.frame.origin.y+1, footerview.frame.size.width-20, 2)];
    forgotPasswordMobileUnderlabel.backgroundColor=[UIColor lightGrayColor];
    forgotPasswordMobileUnderlabel.hidden=YES;
    [footerview addSubview:forgotPasswordMobileUnderlabel];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(6,forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35,footerview.frame.size.width/3-8,40)];
    [butt setTitle:@"Cancel" forState:UIControlStateNormal];
    butt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt addTarget:self action:@selector(CancelButtClicked1:) forControlEvents:UIControlEventTouchUpInside];
    butt.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width+butt.frame.origin.x+6, forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35, footerview.frame.size.width/3-8, 40)];
    [butt1 setTitle:@"Done" forState:UIControlStateNormal];
    butt1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt1 addTarget:self action:@selector(DoneButtClicked1:) forControlEvents:UIControlEventTouchUpInside];
    butt1.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [footerview addSubview:butt1];
    
    
    UIButton *butt2=[[UIButton alloc]initWithFrame:CGRectMake(butt1.frame.size.width+butt1.frame.origin.x+6, forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35, footerview.frame.size.width/3-8, 40)];
    [butt2 setTitle:@"Re-Send" forState:UIControlStateNormal];
    butt2.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt2.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt2 addTarget:self action:@selector(ResendButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    butt2.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:butt2];
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad3)],
                           nil];
    [numberToolbar sizeToFit];
    
    txtverifycode.inputAccessoryView = numberToolbar;
}


-(void)doneWithNumberPad3
{
    [txtverifycode resignFirstResponder];
}


-(IBAction)CancelButtClicked1:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}


-(IBAction)DoneButtClicked1:(id)sender
{
    if (txtverifycode.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Enter Your  Verification Code" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        //   NSString *strid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
      //  NSString *post = [NSString stringWithFormat:@"user_id=%@&otp=%@",struseridnumer,txtverifycode.text];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&otp=%@",BaseUrl,strtoken,verify_mobile_otp,arabic,strCityId,struseridnumer,txtverifycode.text];
        [requested OtpVerifyRequest:nil withUrl:strurl];
    }
}

-(void)responseRegistrationotp:(NSMutableDictionary *)responseToken
{
    NSLog(@"%@",responseToken);
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"status"]];
    
    if([strstatus isEqualToString:@"1"])
    {
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[responseToken valueForKey:@"data"]objectForKey:@"user_id"]];
        [[NSUserDefaults standardUserDefaults]setObject:struseridnum forKey:@"userid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [footerview removeFromSuperview];
        popview.hidden = YES;
        //  [self.navigationController popViewControllerAnimated:YES];
        
        [requested showMessage:@"OTP has been Successfully Verified" withTitle:@"Message"];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *struseridnu=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user=%@",BaseUrl,strtoken,userProfile,arabic,strCityId,struseridnu];
        [requested CitysRequest:nil withUrl:strurl];
    }
    else
    {
        [requested showMessage:[responseToken valueForKey:@"message"] withTitle:@""];
    }
}

-(IBAction)ResendButtClicked:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    //   NSString *strid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@",BaseUrl,strtoken,resend_mobile_otp,arabic,strCityId,struseridnumer];
    [requested ResendOtpRequest:nil withUrl:strurl];
}


-(void)responseResendotp:(NSMutableDictionary *)responseToken
{
    NSLog(@"Resend OTP Response:%@",responseToken);
}


#pragma mark - Change Mobile Number


-(IBAction)changeMobilebuttClicked:(id)sender
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-100, 300, 200)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 40)];
    lab.text=@"Change Mobile Number";
    lab.textColor=[UIColor blackColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(0, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width, 2)];
    labeunder.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:labeunder];
    
    
    pluslabel=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(footerview.frame.size.width-20, labeunder.frame.size.height+labeunder.frame.origin.y+15, 10, 40)];
    NSAttributedString *str18 = [[NSAttributedString alloc] initWithString:@"" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtCountryCode.attributedPlaceholder = str18;
    pluslabel.text=@"+";
    pluslabel.textColor=[UIColor blackColor];
    pluslabel.userInteractionEnabled=NO;
    pluslabel.backgroundColor=[UIColor clearColor];
    [footerview addSubview:pluslabel];
    
    
    txtCountryCode=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(footerview.frame.size.width-75, labeunder.frame.size.height+labeunder.frame.origin.y+15,55, 40)];
    NSAttributedString *str8 = [[NSAttributedString alloc] initWithString:@"CCode" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtCountryCode.attributedPlaceholder = str8;
    txtCountryCode.textAlignment = NSTextAlignmentRight;
    txtCountryCode.textColor=[UIColor blackColor];
    txtCountryCode.font = [UIFont systemFontOfSize:15];
    txtCountryCode.backgroundColor=[UIColor clearColor];
    txtCountryCode.delegate=self;
    [txtCountryCode setKeyboardType:UIKeyboardTypeNumberPad];
    txtCountryCode.returnKeyType = UIReturnKeyNext;
    [footerview addSubview:txtCountryCode];

    
    DobButt=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-75, labeunder.frame.size.height+labeunder.frame.origin.y+15,55, 40)];
    [DobButt addTarget:self action:@selector(DobbuttClicked2:) forControlEvents:UIControlEventTouchUpInside];
    DobButt.backgroundColor=[UIColor clearColor];
    [footerview addSubview:DobButt];
    
    
    txtMobileNumber=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, labeunder.frame.size.height+labeunder.frame.origin.y+15, footerview.frame.size.width-97, 40)];
    NSAttributedString *str9 = [[NSAttributedString alloc] initWithString:@"Mobile Number" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtMobileNumber.attributedPlaceholder = str9;
    txtMobileNumber.textAlignment = NSTextAlignmentRight;
    txtMobileNumber.textColor=[UIColor blackColor];
    txtMobileNumber.font = [UIFont systemFontOfSize:15];
    txtMobileNumber.backgroundColor=[UIColor clearColor];
    txtMobileNumber.delegate=self;
    [txtMobileNumber setKeyboardType:UIKeyboardTypeNumberPad];
    txtMobileNumber.returnKeyType = UIReturnKeyNext;
    [footerview addSubview:txtMobileNumber];
    
    
    NSString *strcode=[[NSUserDefaults standardUserDefaults]objectForKey:@"countryCode"];
    [self.diallingCode getDiallingCodeForCountry:strcode];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(10,txtCountryCode.frame.origin.y+txtCountryCode.frame.size.height+35,footerview.frame.size.width/2-15,40)];
    [butt setTitle:@"Cancel" forState:UIControlStateNormal];
    butt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [butt addTarget:self action:@selector(CancelButtClickedforj:) forControlEvents:UIControlEventTouchUpInside];
    butt.backgroundColor=[UIColor grayColor];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width+butt.frame.origin.x+10, txtCountryCode.frame.origin.y+txtCountryCode.frame.size.height+35, footerview.frame.size.width/2-15, 40)];
    [butt1 setTitle:@"Done" forState:UIControlStateNormal];
    butt1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [butt1 addTarget:self action:@selector(UpdateDoneButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    butt1.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [footerview addSubview:butt1];
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad2)],
                           nil];
    [numberToolbar sizeToFit];
    
    txtMobileNumber.inputAccessoryView = numberToolbar;
}

-(IBAction)CancelButtClickedforj:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden=YES;
}

-(IBAction)DobbuttClicked2:(id)sender
{
    [self.view endEditing:YES];
    
    //  [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    SLCountryPickerViewController *vc = [[SLCountryPickerViewController alloc]init];
    vc.hidesBottomBarWhenPushed=YES;
    vc.completionBlock = ^(NSString *country, NSString *code){
        
        //    txtCountryCode.text = code;
        
        //    [[self navigationController] setNavigationBarHidden:YES animated:YES];
        
        [self.diallingCode getDiallingCodeForCountry:code];
        
        
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - HMDiallingCodeDelegate

- (void)didGetDiallingCode:(NSString *)diallingCode forCountry:(NSString *)countryCode {
    txtCountryCode.text = [NSString stringWithFormat:@"%@",diallingCode];
}

- (void)failedToGetDiallingCode {
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Whoops! Something went wrong." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    //    [alert show];
    
    txtCountryCode.text=@"";
}



-(IBAction)UpdateDoneButtClicked:(id)sender
{
    [footerview endEditing:YES];
    if (txtMobileNumber.text.length==0)
    {
        [requested showMessage:@"Please Enter Mobile Number" withTitle:@"Warning"];
    }
    else
    {
        
        [footerview removeFromSuperview];
        popview.hidden=YES;
        
        b=2;
        
        NSString *strCountryCode=[NSString stringWithFormat:@"+%@",txtCountryCode.text];
        
        strCountryCode = [strCountryCode stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *post = [NSString stringWithFormat:@"user=%@&country_code=%@&mobile=%@",struseridnum,strCountryCode,txtMobileNumber.text];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,updateMobile,arabic,strCityId];
        [requested sendRequest2:post withUrl:strurl];
    }
    
}

-(void)responsewithToken2:(NSMutableDictionary *)responseToken
{
    NSLog(@"Registration Response: %@",responseToken);
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"status"]];
    
    if([strstatus isEqualToString:@"1"])
    {
        struserid=[[responseToken valueForKey:@"data"] valueForKey:@"user_id"];
        struseridnumer=[NSString stringWithFormat:@"%@",[[responseToken valueForKey:@"data"]objectForKey:@"user_id"]];
        //        [[NSUserDefaults standardUserDefaults]setObject:struserid forKey:@"userid"];
        //        [[NSUserDefaults standardUserDefaults]synchronize];
        [self ReverifyAccount];
    }
    else
    {
        [requested showMessage:[responseToken valueForKey:@"message"] withTitle:@""];
    }
}










-(IBAction)AdsPostedClicked:(id)sender
{
    
}

-(IBAction)AdsRespondedClicked:(id)sender
{
    
}

-(IBAction)MyShortlistbuttClicked:(id)sender
{
    NSLog(@"My Short List");
}

-(IBAction)MyAlertsbuttClicked:(id)sender
{
    
}

-(IBAction)MyCartClicked:(id)sender
{
    
}

-(IBAction)MyOrdersClicked:(id)sender
{
    
}

-(IBAction)MyOffersClicked:(id)sender
{
    
}



-(IBAction)facebookbuttClicked:(id)sender
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email",@"public_profile",@"user_friends"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
            //self.lblReturn.text = [NSString stringWithFormat:@"FB: %@", error];
            NSLog(@"%@",error);
            
        } else if (result.isCancelled) {
            // Handle cancellations
            NSLog(@"FB Cancelled");
            
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if ([result.grantedPermissions containsObject:@"email"]) {
                // Do work
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields" : @"email,name,first_name,last_name,gender,birthday"}]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         NSLog(@"fetched user:%@", result);
                         
                         [[NSUserDefaults standardUserDefaults]setObject:[result valueForKey:@"name"] forKey:@"name"];
                         [[NSUserDefaults standardUserDefaults]synchronize];
                         
                         [[NSUserDefaults standardUserDefaults]setObject:[result valueForKey:@"email"] forKey:@"email"];
                         [[NSUserDefaults standardUserDefaults]synchronize];
                         
                         [[NSUserDefaults standardUserDefaults]setObject:[result valueForKey:@"id"] forKey:@"ID"];
                         [[NSUserDefaults standardUserDefaults]synchronize];
                     }
                 }];
                
            }
        }
        
    }];
}

-(IBAction)linkedinbuttClicked:(id)sender
{
    [self getProfileDetailsFromLinkedIn];
}


-(void)getProfileDetailsFromLinkedIn
{
    linkedInLoginView=[[OAuthLoginView alloc] init];
    linkedInLoginView.view.frame=CGRectMake(10, 10, self.view.frame.size.width-20, self.view.frame.size.height-20);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailsOfProfile:) name:@"loginViewDidFinish" object:nil];
    [self presentViewController:linkedInLoginView animated:YES completion:nil];
}


-(void)showDetailsOfProfile:(NSNotification *)notification{
    
    NSDictionary *jsonResponse = notification.userInfo;
    
    NSLog(@"notification user : %@", notification.userInfo);
    
    _id=[jsonResponse objectForKey:@"id"];
    profileUrl=[jsonResponse objectForKey:@"publicProfileUrl"];
    email=[jsonResponse objectForKey:@"emailAddress"];
    industry=[jsonResponse objectForKey:@"industry"];
    name=[jsonResponse objectForKey:@"formattedName"];
    
    NSLog(@"id: %@",_id);
    NSLog(@"ProfileUrl: %@",profileUrl);
    NSLog(@"email: %@",email);
    NSLog(@"Industry: %@",industry);
    NSLog(@"name: %@",name);
    
    if (email == nil)
    {
        NSLog(@"null Responsse");
    }
    else
    {
        NSLog(@"Full Response");
    }
}


-(IBAction)logoutbuttClicked:(id)sender
{
    
    txtName.text=@"";
    MobileNumber.text=@"";
    txtEmailId.text=@"";
    [Profileimage sd_setImageWithURL:[NSURL URLWithString:@""]
                    placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
    [logoutbutt setTitle:@"Login/Register" forState:UIControlStateNormal];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userid"];
    [[NSUserDefaults standardUserDefaults]synchronize];


    ArabicloginRegisterViewController *lr=[self.storyboard instantiateViewControllerWithIdentifier:@"ArabicloginRegisterViewController"];
    [self.navigationController pushViewController:lr animated:YES];
}



#pragma mark - View Controller life Cycle


-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"userid"];
    if(object != nil)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSObject * object2 = [prefs objectForKey:@"image"];
        if(object2 != nil)
        {
            
        }else
        {
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user=%@",BaseUrl,strtoken,userProfile,arabic,strCityId,struseridnum];
            [requested CitysRequest:nil withUrl:strurl];
            
        }
    }
    else
    {
        ArabicloginRegisterViewController *lr=[self.storyboard instantiateViewControllerWithIdentifier:@"ArabicloginRegisterViewController"];
        [self.navigationController pushViewController:lr animated:YES];
    }
}


#pragma mark - Edit butt Clicked

-(IBAction)EditbuttlogClicked:(id)sender
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //  popview.backgroundColor = [UIColor clearColor];
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(0, 60, 120, 100)];
    footerview.backgroundColor=[UIColor whiteColor];
    [popview addSubview:footerview];
    
    UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, footerview.frame.size.height/2-2)];
    [btn addTarget:self action:@selector(hideBtnTappede) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Edit" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footerview addSubview:btn];
    
    UILabel *la1=[[UILabel alloc]initWithFrame:CGRectMake(0, 49, footerview.frame.size.width, 2)];
    [la1 setBackgroundColor:[UIColor lightGrayColor]];
    [footerview addSubview:la1];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 51, footerview.frame.size.width, footerview.frame.size.height/2+1)];
    [btn1 addTarget:self action:@selector(hideBtnTapped1e) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"Cancel" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footerview addSubview:btn1];
}

- (void)hideBtnTappede
{
    imagebutton.hidden=NO;
    txtName.userInteractionEnabled=YES;
    
    logoutbutt.hidden=YES;
    cancelbutt.hidden=NO;
    Savebutt.hidden=NO;
    
    [footerview removeFromSuperview];
    popview.hidden = YES;
}

- (void)hideBtnTapped1e
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}



-(IBAction)CancelButteClicked:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user=%@",BaseUrl,strtoken,userProfile,arabic,strCityId,struseridnum];
    [requested CitysRequest:nil withUrl:strurl];
    
}

-(IBAction)DoneButteClicked:(id)sender
{
    if (strlocation == (id)[NSNull null] || strlocation.length == 0)
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *post = [NSString stringWithFormat:@"user=%@&firstname=%@",struseridnum,txtName.text];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,editprofile,arabic,strCityId];
        [requested PostAddRequest:post withUrl:strurl];
    }
    else
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *post = [NSString stringWithFormat:@"user=%@&firstname=%@&profile_pic=%@",struseridnum,txtName.text,strlocation];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,editprofile,arabic,strCityId];
        [requested PostAddRequest:post withUrl:strurl];
    }
}


-(void)PostAddResponse:(NSMutableDictionary *)responseToken
{
    NSLog(@"Edit Response :%@",responseToken);
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        imagebutton.hidden=YES;
        txtName.userInteractionEnabled=NO;
        
        logoutbutt.hidden=NO;
        cancelbutt.hidden=YES;
        Savebutt.hidden=YES;
        
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user=%@",BaseUrl,strtoken,userProfile,arabic,strCityId,struseridnum];
        [requested CitysRequest:nil withUrl:strurl];
        
        
        [requested showMessage:@"Your Profile has been Updated" withTitle:@"Profile Update"];
        
    }
    else
    {
        [requested showMessage:[responseToken valueForKey:@"message"] withTitle:@"Profile Update"];
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
