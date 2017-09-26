//
//  SettingsViewController.m
//  BoxBazar
//
//  Created by bharat on 21/07/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "SettingsViewController.h"
#import "UIImageView+WebCache.h"
#import "ApiRequest.h"
#import "DejalActivityView.h"
#import "BoxBazarUrl.pch"
#import "ACFloatingTextField.h"

@interface SettingsViewController ()<ApiRequestdelegate>
{
    UIImageView *Profileimage;
    ApiRequest *requested;
    UIImage *currentSelectedImage;
    UIView *popview;
    UIView *footerview;
    
    UITextField *txtCurrentPassword,*txtNewPassword,*txtConformNewPassword;
    UILabel *CurrentPasswordUnderlabel,*NewPasswordUnderlabel,*ConformNewPasswordUnderlabel;
    
    
    UITextField *txtName;
    
    UIButton *button1,*button2,*button3,*button4,*button5,*button6;
    NSString *DeleteAccountReason;
    
    ACFloatingTextField *txtFirstname,*txtlastName,*MobileNumber,*txtEmailId;
    UIBarButtonItem *backButton2;
    BOOL isClicked;
    UIButton *imagebutton,*Cancelbutt,*Donebutt;
    NSString *strlocation;
    NSString *strnewpassword;
}

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"Settings";
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    isClicked=YES;
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   
                                   initWithTarget:self
                                   
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [self customView];
    [self setupAlertCtrl];
    
    backButton2 = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                  action:@selector(barButtonBackPressed2:)];
    
    [backButton2 setImage:[UIImage imageNamed:@"menu-2.png"]];
    
 //   self.navigationItem.rightBarButtonItem = backButton2;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    self.title=@"Settings";
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"userid"];
    if(object != nil)
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user=%@",BaseUrl,strtoken,userProfile,english,strCityId,struseridnum];
        [requested CitysRequest:nil withUrl:strurl];
    }
    else
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user=%@",BaseUrl,strtoken,userProfile,english,strCityId,_struid];
        [requested CitysRequest:nil withUrl:strurl];
    }

}


-(void)barButtonBackPressed2:(id)sender
{
    
    if (isClicked==YES)
    {
        // self.navigationItem.rightBarButtonItem.enabled = NO;
        
        popview = [[ UIView alloc]init];
        popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //  popview.backgroundColor = [UIColor clearColor];
        popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
        
        [self.view addSubview:popview];
        
        footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-120, 60, 120, 100)];
        footerview.backgroundColor=[UIColor whiteColor];
        [popview addSubview:footerview];
        
        UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, footerview.frame.size.height/2-2)];
        [btn addTarget:self action:@selector(hideBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"Edit" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [footerview addSubview:btn];
        
        UILabel *la1=[[UILabel alloc]initWithFrame:CGRectMake(0, 49, footerview.frame.size.width, 2)];
        [la1 setBackgroundColor:[UIColor lightGrayColor]];
        [footerview addSubview:la1];
        
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 51, footerview.frame.size.width, footerview.frame.size.height/2+1)];
        [btn1 addTarget:self action:@selector(hideBtnTapped1) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle:@"Logout" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [footerview addSubview:btn1];
        
        isClicked=NO;
    }
    else
    {
        [footerview removeFromSuperview];
        popview.hidden = YES;
        isClicked=YES;
    }
    
    
}


- (void)hideBtnTapped
{
     imagebutton.hidden=NO;
   txtFirstname.userInteractionEnabled=YES;
    txtlastName.userInteractionEnabled=YES;
    Donebutt.hidden=NO;
    Cancelbutt.hidden=NO;
    
    [footerview removeFromSuperview];
    popview.hidden = YES;
    
}

- (IBAction)CancelClickedbutt:(id)sender
{
    imagebutton.hidden=YES;
    txtFirstname.userInteractionEnabled=NO;
    txtlastName.userInteractionEnabled=NO;
    Donebutt.hidden=YES;
    Cancelbutt.hidden=YES;

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"userid"];
    if(object != nil)
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user=%@",BaseUrl,strtoken,userProfile,english,strCityId,struseridnum];
        [requested CitysRequest:nil withUrl:strurl];
    }

    isClicked=YES;
}


- (void)hideBtnTapped1
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Are You Sure Want to Logout" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Signout", nil];
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView firstOtherButtonIndex])
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userid"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    }
}




-(void)barButtonBackPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
   currentSelectedImage = [[UIImage alloc] initWithData:dataImage];
    [Profileimage setImage:currentSelectedImage];
    currentSelectedImage = [self imageWithReduceImage:currentSelectedImage
                                                       scaleToSize:CGSizeMake(40, 40)];
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
    
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,file,english,strCityId];
    
    
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
}


-(void)customView
{
    UIView *topview=[[UIView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 120)];
    topview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:topview];
    
    Profileimage=[[UIImageView alloc]initWithFrame:CGRectMake(topview.frame.size.width/2-40, topview.frame.size.height/2-50, 80, 80)];
    [Profileimage sd_setImageWithURL:[NSURL URLWithString:@""]
                   placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
    Profileimage.layer.cornerRadius = Profileimage.frame.size.height /2;
    Profileimage.layer.masksToBounds = YES;
    Profileimage.layer.borderWidth = 0;
    Profileimage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
  //  Profileimage.backgroundColor=[UIColor colorWithRed:255.0/255.0f green:174.0/255.0f blue:185.0/255.0f alpha:1.0];
    Profileimage.contentMode = UIViewContentModeScaleAspectFill;
  //  Profileimage.contentMode = UIViewContentModeScaleAspectFit;
    [topview addSubview:Profileimage];
    
    imagebutton=[[UIButton alloc]initWithFrame:CGRectMake(topview.frame.size.width/2-40, topview.frame.size.height/2-50, 80, 80)];
    imagebutton.backgroundColor=[UIColor clearColor];
  //  imagebutton.hidden=YES;
    [imagebutton addTarget:self action:@selector(ProfileImageClicked:) forControlEvents:UIControlEventTouchUpInside];
    [topview addSubview:imagebutton];
    
    UIButton *Editbutt=[[UIButton alloc] initWithFrame:CGRectMake(topview.frame.size.width/2-15, imagebutton.frame.size.height+imagebutton.frame.origin.y+3, 30, 30)];
    [Editbutt setTitle:@"Edit" forState:UIControlStateNormal];
    Editbutt.hidden=YES;
    Editbutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [Editbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Editbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Editbutt addTarget:self action:@selector(EditbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    Editbutt.backgroundColor=[UIColor clearColor];
    [topview addSubview:Editbutt];
    
    
    
    
    UIView *detailsView=[[UIView alloc]initWithFrame:CGRectMake(5, topview.frame.size.height+topview.frame.origin.y+10, self.view.frame.size.width-10, 170)];
    detailsView.backgroundColor=[UIColor whiteColor];
    detailsView.layer.cornerRadius = 5;
    detailsView.clipsToBounds = YES;
    detailsView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    detailsView.layer.borderWidth = 1.0f;
    [self.view addSubview:detailsView];
    
//    txtName=[[UITextField alloc]initWithFrame:CGRectMake(6, 2, detailsView.frame.size.width-30, 30)];
//    txtName.text=@"Alla Bharath Kumar Reddy";
//    txtName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    txtName.textColor=[UIColor blackColor];
//    txtName.font = [UIFont systemFontOfSize:15];
//    txtName.backgroundColor=[UIColor clearColor];
//    txtName.delegate=self;
//    [detailsView addSubview:txtName];
    
    txtFirstname=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(6, 2, detailsView.frame.size.width-12, 40)];
    [txtFirstname setTextFieldPlaceholderText:@"Name"];
    txtFirstname.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtFirstname.textColor=[UIColor blackColor];
    txtFirstname.font = [UIFont systemFontOfSize:15];
    txtFirstname.backgroundColor=[UIColor clearColor];
    txtFirstname.delegate=self;
   // txtFirstname.userInteractionEnabled=NO;
    [detailsView addSubview:txtFirstname];
    
    txtlastName=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(txtFirstname.frame.size.width+txtFirstname.frame.origin.x+6, 2, detailsView.frame.size.width/2-9, 30)];
    [txtlastName setTextFieldPlaceholderText:@"Last Name"];
    txtlastName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtlastName.textColor=[UIColor blackColor];
    txtlastName.font = [UIFont systemFontOfSize:15];
    txtlastName.backgroundColor=[UIColor clearColor];
    txtlastName.delegate=self;
    txtlastName.hidden=YES;
    txtlastName.userInteractionEnabled=NO;
    [detailsView addSubview:txtlastName];
    
    UIImageView *imag=[[UIImageView alloc]initWithFrame:CGRectMake(detailsView.frame.size.width-22, 17, 16, 16)];
    imag.image=[UIImage imageNamed:@"right-arrow-2.png"];
    imag.hidden=YES;
    [detailsView addSubview:imag];
    
    UIImageView *editnameimage=[[UIImageView alloc] initWithFrame:CGRectMake(detailsView.frame.size.width-22, 17, 16, 16)];
    editnameimage.image=[UIImage imageNamed:@"pencil-edit-button-2.png"];
    editnameimage.hidden=NO;
    [detailsView addSubview:editnameimage];
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(6, txtFirstname.frame.size.height+txtFirstname.frame.origin.y+1, detailsView.frame.size.width/2-9, 1)];
    label1.hidden=YES;
    label1.backgroundColor=[UIColor lightGrayColor];
    [detailsView addSubview:label1];
    
    UILabel *label11=[[UILabel alloc] initWithFrame:CGRectMake(txtFirstname.frame.size.width+txtFirstname.frame.origin.x+6, txtFirstname.frame.size.height+txtFirstname.frame.origin.y+1, detailsView.frame.size.width/2-9, 1)];
    label11.backgroundColor=[UIColor lightGrayColor];
    label11.hidden=YES;
    [detailsView addSubview:label11];
    
    
    
    UILabel *citylabel=[[UILabel alloc] initWithFrame:CGRectMake(6, label1.frame.size.height+label1.frame.origin.y+1, detailsView.frame.size.width-30, 30)];
    citylabel.text=@"Ajman";
    citylabel.textColor=[UIColor blackColor];
    citylabel.font = [UIFont systemFontOfSize:15];
    citylabel.textAlignment = NSTextAlignmentLeft;
    citylabel.backgroundColor=[UIColor clearColor];
    citylabel.hidden=YES;
    [detailsView addSubview:citylabel];
    
    UIButton *PlaceCitybutt=[[UIButton alloc]initWithFrame:CGRectMake(6, label1.frame.size.height+label1.frame.origin.y+1, detailsView.frame.size.width-30, 30)];
    PlaceCitybutt.hidden=YES;
    [PlaceCitybutt addTarget:self action:@selector(PlaceCityClicked:) forControlEvents:UIControlEventTouchUpInside];
    PlaceCitybutt.backgroundColor=[UIColor clearColor];
    [detailsView addSubview:PlaceCitybutt];

    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(detailsView.frame.size.width-22, label1.frame.size.height+label1.frame.origin.y+9, 16, 16)];
    image2.image=[UIImage imageNamed:@"right-arrow-2.png"];
    image2.hidden=YES;
    [detailsView addSubview:image2];
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(6, citylabel.frame.origin.y+citylabel.frame.size.height+1, detailsView.frame.size.width-12, 1)];
    label2.backgroundColor=[UIColor lightGrayColor];
    label2.hidden=YES;
    [detailsView addSubview:label2];
    
    
    
    
    UILabel *countryCode=[[UILabel alloc] initWithFrame:CGRectMake(6, label2.frame.size.height+label2.frame.origin.y+1, 40, 30)];
    countryCode.text=@"+97";
    countryCode.hidden=YES;
    countryCode.textColor=[UIColor blackColor];
    countryCode.font = [UIFont systemFontOfSize:15];
    countryCode.textAlignment = NSTextAlignmentLeft;
    countryCode.backgroundColor=[UIColor clearColor];
    [detailsView addSubview:countryCode];
    
    UILabel *txtMobilenumber=[[UILabel alloc] initWithFrame:CGRectMake(countryCode.frame.origin.x+countryCode.frame.size.width+6, label2.frame.size.height+label2.frame.origin.y+1, detailsView.frame.size.width-80, 40)];
    txtMobilenumber.text=@"8143547797";
    txtMobilenumber.hidden=YES;
    txtMobilenumber.textColor=[UIColor blackColor];
    txtMobilenumber.font = [UIFont systemFontOfSize:15];
    txtMobilenumber.textAlignment = NSTextAlignmentLeft;
    txtMobilenumber.backgroundColor=[UIColor clearColor];
    [detailsView addSubview:txtMobilenumber];
    
    MobileNumber=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(6, txtFirstname.frame.size.height+txtFirstname.frame.origin.y+2, detailsView.frame.size.width-12, 40)];
    [MobileNumber setTextFieldPlaceholderText:@"Mobile Number"];
    MobileNumber.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    MobileNumber.textColor=[UIColor blackColor];
    MobileNumber.font = [UIFont systemFontOfSize:15];
    MobileNumber.backgroundColor=[UIColor clearColor];
    MobileNumber.delegate=self;
    MobileNumber.userInteractionEnabled=NO;
    [detailsView addSubview:MobileNumber];
    
    UILabel *pluslabel=[[UILabel alloc]initWithFrame:CGRectMake(detailsView.frame.size.width-22, label2.frame.size.height+label2.frame.origin.y+9, 16, 16)];
    pluslabel.text=@"+";
    pluslabel.hidden=YES;
    pluslabel.textColor=[UIColor blackColor];
    pluslabel.font = [UIFont systemFontOfSize:15];
    pluslabel.textAlignment = NSTextAlignmentCenter;
    pluslabel.backgroundColor=[UIColor clearColor];
    [detailsView addSubview:pluslabel];
    
    UILabel *label3=[[UILabel alloc] initWithFrame:CGRectMake(6, txtMobilenumber.frame.origin.y+txtMobilenumber.frame.size.height+1, detailsView.frame.size.width-12, 1)];
    label3.hidden=YES;
    label3.backgroundColor=[UIColor lightGrayColor];
    [detailsView addSubview:label3];
    
    
    
    UILabel *txtEmail=[[UILabel alloc] initWithFrame:CGRectMake(6, label3.frame.size.height+label3.frame.origin.y+1, detailsView.frame.size.width-30, 40)];
    txtEmail.hidden=YES;
    txtEmail.text=@"bharath.think360@gmail.com";
    txtEmail.textColor=[UIColor blackColor];
    txtEmail.font = [UIFont systemFontOfSize:15];
    txtEmail.textAlignment = NSTextAlignmentLeft;
    txtEmail.backgroundColor=[UIColor clearColor];
    [detailsView addSubview:txtEmail];
    
    txtEmailId=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(6, MobileNumber.frame.size.height+MobileNumber.frame.origin.y+2, detailsView.frame.size.width-12, 40)];
    [txtEmailId setTextFieldPlaceholderText:@"Email Id"];
    txtEmailId.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtEmailId.textColor=[UIColor blackColor];
    txtEmailId.font = [UIFont systemFontOfSize:15];
    txtEmailId.backgroundColor=[UIColor clearColor];
    txtEmailId.delegate=self;
    txtEmailId.userInteractionEnabled=NO;
    [detailsView addSubview:txtEmailId];
    
    UILabel *pluslabel1=[[UILabel alloc]initWithFrame:CGRectMake(detailsView.frame.size.width-22, label3.frame.size.height+label3.frame.origin.y+9, 16, 16)];
    pluslabel1.text=@"+";
    pluslabel1.hidden=YES;
    pluslabel1.textColor=[UIColor blackColor];
    pluslabel1.font = [UIFont systemFontOfSize:15];
    pluslabel1.textAlignment = NSTextAlignmentCenter;
    pluslabel1.backgroundColor=[UIColor clearColor];
    [detailsView addSubview:pluslabel1];
    
    UILabel *label4=[[UILabel alloc] initWithFrame:CGRectMake(6, txtEmail.frame.origin.y+txtEmail.frame.size.height+1, detailsView.frame.size.width-12, 1)];
    label4.backgroundColor=[UIColor lightGrayColor];
    label4.hidden=YES;
    [detailsView addSubview:label4];
    
    
    
    UIButton *ChangePasswordbutt=[[UIButton alloc]initWithFrame:CGRectMake(6, txtEmailId.frame.origin.y+txtEmailId.frame.size.height+2, detailsView.frame.size.width-30, 40)];
    [ChangePasswordbutt setTitle:@"Change Password" forState:UIControlStateNormal];
    ChangePasswordbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [ChangePasswordbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ChangePasswordbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [ChangePasswordbutt addTarget:self action:@selector(ChangePasswordClicked:) forControlEvents:UIControlEventTouchUpInside];
    ChangePasswordbutt.backgroundColor=[UIColor clearColor];
    [detailsView addSubview:ChangePasswordbutt];
    
    UIImageView *image5=[[UIImageView alloc]initWithFrame:CGRectMake(detailsView.frame.size.width-22,txtEmailId.frame.origin.y+txtEmailId.frame.size.height+17, 16, 16)];
    image5.image=[UIImage imageNamed:@"right-arrow-2.png"];
    [detailsView addSubview:image5];
    
    UILabel *label5=[[UILabel alloc] initWithFrame:CGRectMake(6, ChangePasswordbutt.frame.origin.y+ChangePasswordbutt.frame.size.height+1, detailsView.frame.size.width-12, 1)];
    label5.backgroundColor=[UIColor blackColor];
    label5.hidden=NO;
    [detailsView addSubview:label5];
    
    
    
    UIButton *DeleteAccountbutt=[[UIButton alloc]initWithFrame:CGRectMake(6, label5.frame.origin.y+label5.frame.size.height+1, detailsView.frame.size.width-30, 30)];
    [DeleteAccountbutt setTitle:@"Delete Account" forState:UIControlStateNormal];
    DeleteAccountbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [DeleteAccountbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    DeleteAccountbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [DeleteAccountbutt addTarget:self action:@selector(DeleteAccountClicked:) forControlEvents:UIControlEventTouchUpInside];
    DeleteAccountbutt.backgroundColor=[UIColor clearColor];
    DeleteAccountbutt.hidden=YES;
    [detailsView addSubview:DeleteAccountbutt];
    
    UIImageView *image6=[[UIImageView alloc]initWithFrame:CGRectMake(detailsView.frame.size.width-22,label5.frame.origin.y+label5.frame.size.height+9, 16, 16)];
    image6.image=[UIImage imageNamed:@"right-arrow-2.png"];
    image6.hidden=YES;
    [detailsView addSubview:image6];
    
    
    Cancelbutt=[[UIButton alloc]initWithFrame:CGRectMake(10, detailsView.frame.origin.y+detailsView.frame.size.height+15, self.view.frame.size.width/2-15, 40)];
    [Cancelbutt setTitle:@"Cancel" forState:UIControlStateNormal];
    Cancelbutt.hidden=YES;
    Cancelbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [Cancelbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Cancelbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Cancelbutt addTarget:self action:@selector(CancelClickedbutt:) forControlEvents:UIControlEventTouchUpInside];
    Cancelbutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    Cancelbutt.hidden=YES;
    [self.view addSubview:Cancelbutt];
    
    Donebutt=[[UIButton alloc]initWithFrame:CGRectMake(10, detailsView.frame.origin.y+detailsView.frame.size.height+20, self.view.frame.size.width-20, 50)];
    [Donebutt setTitle:@"Save" forState:UIControlStateNormal];
 //   Donebutt.hidden=YES;
    Donebutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [Donebutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Donebutt.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [Donebutt addTarget:self action:@selector(DoneClickedbutt:) forControlEvents:UIControlEventTouchUpInside];
    Donebutt.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    Donebutt.layer.cornerRadius = 8; // this value vary as per your desire
    Donebutt.clipsToBounds = YES;
    [self.view addSubview:Donebutt];
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


- (IBAction)DoneClickedbutt:(id)sender
{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"userid"];
    if(object != nil)
    {
        
        if ((strlocation == (id)[NSNull null] || strlocation.length == 0) || (strnewpassword == (id)[NSNull null] || strnewpassword.length == 0))
        {
            
            if (strlocation == (id)[NSNull null] || strlocation.length == 0)
            {
                if (strnewpassword == (id)[NSNull null] || strnewpassword.length == 0)
                {
                    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *post = [NSString stringWithFormat:@"user=%@&firstname=%@",struseridnum,txtFirstname.text];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,editprofile,english,strCityId];
                    [requested sendRequest:post withUrl:strurl];
                }
                else
                {
                    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                    NSString *post = [NSString stringWithFormat:@"user=%@&firstname=%@&password=%@",struseridnum,txtFirstname.text,strnewpassword];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,editprofile,english,strCityId];
                    [requested sendRequest:post withUrl:strurl];
                }
            }
            else
            {
               
                    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
                    NSString *post = [NSString stringWithFormat:@"user=%@&firstname=%@&profile_pic=%@",struseridnum,txtFirstname.text,strlocation];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,editprofile,english,strCityId];
                    [requested sendRequest:post withUrl:strurl];
            }
        }
        else
        {
        
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            NSString *post = [NSString stringWithFormat:@"user=%@&firstname=%@&profile_pic=%@&password=%@",struseridnum,txtFirstname.text,strlocation,strnewpassword];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,editprofile,english,strCityId];
            [requested sendRequest:post withUrl:strurl];
        }

    }
    else
    {
        if ((strlocation == (id)[NSNull null] || strlocation.length == 0) || (strnewpassword == (id)[NSNull null] || strnewpassword.length == 0))
        {
            
            if (strlocation == (id)[NSNull null] || strlocation.length == 0)
            {
                if (strnewpassword == (id)[NSNull null] || strnewpassword.length == 0)
                {
                    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *post = [NSString stringWithFormat:@"user=%@&firstname=%@",_struid,txtFirstname.text];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,editprofile,english,strCityId];
                    [requested sendRequest:post withUrl:strurl];
                }
                else
                {
                    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                    NSString *post = [NSString stringWithFormat:@"user=%@&firstname=%@&password=%@",_struid,txtFirstname.text,strnewpassword];
                    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,editprofile,english,strCityId];
                    [requested sendRequest:post withUrl:strurl];
                }
            }
            else
            {
                
                [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
                NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                NSString *post = [NSString stringWithFormat:@"user=%@&firstname=%@&profile_pic=%@",_struid,txtFirstname.text,strlocation];
                NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,editprofile,english,strCityId];
                [requested sendRequest:post withUrl:strurl];
            }
        }
        else
        {
            
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *post = [NSString stringWithFormat:@"user=%@&firstname=%@&profile_pic=%@&password=%@",_struid,txtFirstname.text,strlocation,strnewpassword];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,editprofile,english,strCityId];
            [requested sendRequest:post withUrl:strurl];
        }

    }
}



-(void)responsewithToken:(NSMutableDictionary *)responseToken
{
    NSLog(@"Edit Response :%@",responseToken);
  //  NSString *strmessage=[responseToken valueForKey:@"message"];
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
//        if ([strmessage isEqualToString:@"Your Profile Update"])
//        {
            [self.navigationController popViewControllerAnimated:YES];
            [requested showMessage:@"Your Profile has been Updated" withTitle:@"Profile Update"];
   //     }
    }
    else
    {
        [requested showMessage:[responseToken valueForKey:@"message"] withTitle:@"Profile Update"];
    }
    
}



-(IBAction)EditbuttClicked:(id)sender
{
     [requested showMessage:@"Edit Clicked" withTitle:@"Edit"];
}


-(IBAction)ProfileImageClicked:(id)sender
{
    self.alertCtrl.popoverPresentationController.sourceView = self.view;
    [self presentViewController:self.alertCtrl animated:YES completion:^{}];
}

-(IBAction)PlaceCityClicked:(id)sender
{
    [requested showMessage:@"City Place Cicked" withTitle:@" Select Place"];
}



#pragma mark - Change Password



-(IBAction)ChangePasswordClicked:(id)sender
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
    txtCurrentPassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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
    txtNewPassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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
    txtConformNewPassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt addTarget:self action:@selector(CancelButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    butt.backgroundColor=[UIColor grayColor];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width+butt.frame.origin.x+10, ConformNewPasswordUnderlabel.frame.origin.y+ConformNewPasswordUnderlabel.frame.size.height+25, footerview.frame.size.width/2-15, 40)];
    [butt1 setTitle:@"Done" forState:UIControlStateNormal];
    butt1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt1 addTarget:self action:@selector(DoneButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    butt1.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:butt1];
    
    [self setupOutlets];
}

-(IBAction)CancelButtClicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}

-(IBAction)DoneButtClicked:(id)sender
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
    [txtFirstname resignFirstResponder];
    [txtlastName resignFirstResponder];
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





#pragma mark - Delete Account



-(IBAction)DeleteAccountClicked:(id)sender
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-155, self.view.frame.size.height/2-180, 310, 360)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 40)];
    lab.text=@"Delete Account";
    lab.textColor=[UIColor blackColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(0, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width, 2)];
    labeunder.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:labeunder];
    
    
    button1=[[UIButton alloc]initWithFrame:CGRectMake(3, labeunder.frame.size.height+labeunder.frame.origin.y+15, 24, 24)];
    [button1 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button1.backgroundColor=[UIColor clearColor];
    [button1 addTarget:self action:@selector(Button1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:button1];
    
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(button1.frame.size.width+button1.frame.origin.x+4, labeunder.frame.size.height+labeunder.frame.origin.y+15, footerview.frame.size.width-30, 24)];
    lab1.text=@"I Don't Understand how to use Boxbazar";
    lab1.textColor=[UIColor blackColor];
    lab1.textAlignment=NSTextAlignmentLeft;
    lab1.font=[UIFont systemFontOfSize:15];
    [footerview addSubview:lab1];
    
    
    button2=[[UIButton alloc]initWithFrame:CGRectMake(3, lab1.frame.size.height+lab1.frame.origin.y+15, 24, 24)];
    [button2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button2.backgroundColor=[UIColor clearColor];
    [button2 addTarget:self action:@selector(Button2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:button2];
    
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(button2.frame.size.width+button2.frame.origin.x+4, lab1.frame.size.height+lab1.frame.origin.y+15, footerview.frame.size.width-30, 24)];
    lab2.text=@"I Get too many emails from Boxbazar";
    lab2.textColor=[UIColor blackColor];
    lab2.textAlignment=NSTextAlignmentLeft;
    lab2.font=[UIFont systemFontOfSize:15];
    [footerview addSubview:lab2];
    
    
    button3=[[UIButton alloc]initWithFrame:CGRectMake(3, lab2.frame.size.height+lab2.frame.origin.y+15, 24, 24)];
    [button3 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button3.backgroundColor=[UIColor clearColor];
    [button3 addTarget:self action:@selector(Button3Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:button3];
    
    UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(button3.frame.size.width+button3.frame.origin.x+4, lab2.frame.size.height+lab2.frame.origin.y+15, footerview.frame.size.width-30, 24)];
    lab3.text=@"I Did not Create This Account";
    lab3.textColor=[UIColor blackColor];
    lab3.textAlignment=NSTextAlignmentLeft;
    lab3.font=[UIFont systemFontOfSize:15];
    [footerview addSubview:lab3];
    
    
    button4=[[UIButton alloc]initWithFrame:CGRectMake(3, lab3.frame.size.height+lab3.frame.origin.y+15, 24, 24)];
    [button4 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button4.backgroundColor=[UIColor clearColor];
    [button4 addTarget:self action:@selector(Button4Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:button4];
    
    UILabel *lab4=[[UILabel alloc]initWithFrame:CGRectMake(button4.frame.size.width+button4.frame.origin.x+4, lab3.frame.size.height+lab3.frame.origin.y+15, footerview.frame.size.width-30, 24)];
    lab4.text=@"I Did not Get any emails from Boxbazar";
    lab4.textColor=[UIColor blackColor];
    lab4.textAlignment=NSTextAlignmentLeft;
    lab4.font=[UIFont systemFontOfSize:15];
    [footerview addSubview:lab4];
    
    
    button5=[[UIButton alloc]initWithFrame:CGRectMake(3, lab4.frame.size.height+lab4.frame.origin.y+15, 24, 24)];
    [button5 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button5.backgroundColor=[UIColor clearColor];
    [button5 addTarget:self action:@selector(Button5Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:button5];
    
    UILabel *lab5=[[UILabel alloc]initWithFrame:CGRectMake(button5.frame.size.width+button5.frame.origin.x+4, lab4.frame.size.height+lab4.frame.origin.y+15, footerview.frame.size.width-30, 24)];
    lab5.text=@"I Don't find Boxbazar use friendly";
    lab5.textColor=[UIColor blackColor];
    lab5.textAlignment=NSTextAlignmentLeft;
    lab5.font=[UIFont systemFontOfSize:15];
    [footerview addSubview:lab5];
    
    
    button6=[[UIButton alloc]initWithFrame:CGRectMake(3, lab5.frame.size.height+lab5.frame.origin.y+15, 24, 24)];
    [button6 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    button6.backgroundColor=[UIColor clearColor];
    [button6 addTarget:self action:@selector(Button6Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:button6];
    
    UILabel *lab6=[[UILabel alloc]initWithFrame:CGRectMake(button6.frame.size.width+button6.frame.origin.x+4, lab5.frame.size.height+lab5.frame.origin.y+15, footerview.frame.size.width-30, 24)];
    lab6.text=@"My Account was hacked";
    lab6.textColor=[UIColor blackColor];
    lab6.textAlignment=NSTextAlignmentLeft;
    lab6.font=[UIFont systemFontOfSize:15];
    [footerview addSubview:lab6];
    
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(10,lab6.frame.origin.y+lab6.frame.size.height+25,footerview.frame.size.width/2-15,40)];
    [butt setTitle:@"Cancel" forState:UIControlStateNormal];
    butt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt addTarget:self action:@selector(CancelButt1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    butt.backgroundColor=[UIColor grayColor];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width+butt.frame.origin.x+10, lab6.frame.origin.y+lab6.frame.size.height+25, footerview.frame.size.width/2-15, 40)];
    [butt1 setTitle:@"Delete Account" forState:UIControlStateNormal];
    butt1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt1 addTarget:self action:@selector(DeleteAccountButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    butt1.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:butt1];
}

-(IBAction)Button1Clicked:(id)sender
{
   DeleteAccountReason=@"I Don't Understand how to use Boxbazar";
   [button1 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
   [button2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
   [button3 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
   [button4 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
   [button5 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
   [button6 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
}

-(IBAction)Button2Clicked:(id)sender
{
    DeleteAccountReason=@"I Get too many emails from Boxbazar";
    [button1 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button4 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button5 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button6 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
}

-(IBAction)Button3Clicked:(id)sender
{
    DeleteAccountReason=@"I Did not Create This Account";
    [button1 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
    [button4 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button5 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button6 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
}

-(IBAction)Button4Clicked:(id)sender
{
    DeleteAccountReason=@"I Did not Get any emails from Boxbazar";
    [button1 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button4 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
    [button5 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button6 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
}

-(IBAction)Button5Clicked:(id)sender
{
    DeleteAccountReason=@"I Don't find Boxbazar use friendly";
    [button1 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button4 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button5 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
    [button6 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
}

-(IBAction)Button6Clicked:(id)sender
{
    DeleteAccountReason=@"My Account was hacked";
    [button1 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button4 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button5 setImage:[UIImage imageNamed:@"circle-shape-outline.png"] forState:UIControlStateNormal];
    [button6 setImage:[UIImage imageNamed:@"dot-inside-a-circle.png"] forState:UIControlStateNormal];
}

-(IBAction)CancelButt1Clicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}

-(IBAction)DeleteAccountButtClicked:(id)sender
{
    [requested showMessage:[NSString stringWithFormat:@"Reason:  %@",DeleteAccountReason] withTitle:@"Account Deleted"];
    [footerview removeFromSuperview];
    popview.hidden = YES;
}




#pragma mark - View Controller life cycles



-(void)viewDidDisappear:(BOOL)animated
{
    self.title = @"";
}


-(void)viewWillAppear:(BOOL)animated
{
    self.title=@"Settings";
}

-(void)responsewithCitylist:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=[responseDict objectForKey:@"data"];
    NSLog(@"Profile Response: %@",responseDictionary);
   
    txtFirstname.text=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"firstname"]];
 //   txtlastName.text=[responseDictionary valueForKey:@"lastname"];
    MobileNumber.text=[NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"mobile"]];
    txtEmailId.text=[responseDictionary valueForKey:@"email"];
    
    [Profileimage sd_setImageWithURL:[NSURL URLWithString:[responseDictionary valueForKey:@"profile_pic"]]
                    placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
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
