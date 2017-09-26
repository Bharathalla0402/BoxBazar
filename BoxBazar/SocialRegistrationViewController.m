//
//  SocialRegistrationViewController.m
//  BoxBazar
//
//  Created by bharat on 03/10/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "SocialRegistrationViewController.h"
#import "ApiRequest.h"
#import "ACFloatingTextField.h"
#import "DejalActivityView.h"
#import "BoxBazarUrl.pch"
#import "HMDiallingCode.h"
#import "SLCountryPickerViewController.h"

@interface SocialRegistrationViewController ()<ApiRequestdelegate,UITextFieldDelegate,HMDiallingCodeDelegate>
{
    ApiRequest *request;
    UIScrollView *LoginScrollView;
    
    UIView *topview,*loginView;
    
    ACFloatingTextField *txtFirstName,*txtEmail,*txtGender,*txtMobileNumber,*txtverifycode,*pluslabel,*txtCountryCode;
    
    UIButton *GenderButt;
    
    UIView *popview;
    UIView *footerview;
    NSString *strgender;
    
    NSString *struseridnumer;
    
    UILabel *forgotPasswordMobileUnderlabel;
}
@property (strong, nonatomic) HMDiallingCode *diallingCode;
@end

@implementation SocialRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.diallingCode = [[HMDiallingCode alloc] initWithDelegate:self];
    self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    request=[[ApiRequest alloc]init];
    request.delegate=self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   
                                   initWithTarget:self
                                   
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [self customView];
    
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    NSLog(@"%@",countryCode);
    
    NSString *strcode=[[NSUserDefaults standardUserDefaults]objectForKey:@"countryCode"];
    
    [self.diallingCode getDiallingCodeForCountry:strcode];

    NSLog(@"%@",_strUrl);
}

-(void)customView
{
    topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    topview.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [self.view addSubview:topview];
    
    
    UIButton *Backbutt=[[UIButton alloc] initWithFrame:CGRectMake(10, topview.frame.size.height/2-5, 20, 20)];
    [Backbutt setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    Backbutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [Backbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Backbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Backbutt addTarget:self action:@selector(BackbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt];
    
    UIButton *Backbutt2=[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 55, 55)];
    [Backbutt2 addTarget:self action:@selector(BackbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt2.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt2];
    
    UILabel *labtitle=[[UILabel alloc]initWithFrame:CGRectMake(topview.frame.size.width/2-120, topview.frame.size.height/2-10, 240, 30)];
    labtitle.text=_strTitle;
    labtitle.font=[UIFont boldSystemFontOfSize:17];
    labtitle.textColor=[UIColor whiteColor];
    labtitle.textAlignment=NSTextAlignmentCenter;
    [topview addSubview:labtitle];
    
    
    LoginScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, topview.frame.size.height+topview.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    LoginScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 620);
    [self.view addSubview:LoginScrollView];
    
    loginView=[[UIView alloc]initWithFrame:CGRectMake(2, 10, self.view.frame.size.width-4, 485)];
    loginView.backgroundColor=[UIColor whiteColor];
    loginView.layer.cornerRadius = 5;
    loginView.clipsToBounds = YES;
    loginView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    loginView.layer.borderWidth = 1.0f;
    [LoginScrollView addSubview:loginView];
    
    UIImageView *logoimage=[[UIImageView alloc] initWithFrame:CGRectMake(loginView.frame.size.width/2-65, 40, 130, 130)];
    logoimage.image=[UIImage imageNamed:@"150x150.png"];
    [loginView addSubview:logoimage];
    
    txtFirstName=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, logoimage.frame.size.height+logoimage.frame.origin.y+15, loginView.frame.size.width-20, 40)];
    NSAttributedString *str4 = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtFirstName.attributedPlaceholder = str4;
    txtFirstName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtFirstName.textColor=[UIColor blackColor];
    txtFirstName.font = [UIFont systemFontOfSize:15];
    txtFirstName.backgroundColor=[UIColor clearColor];
    txtFirstName.userInteractionEnabled=NO;
    txtFirstName.text=_strName;
    txtFirstName.returnKeyType = UIReturnKeyNext;
    [loginView addSubview:txtFirstName];
    
    txtEmail=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, txtFirstName.frame.size.height+txtFirstName.frame.origin.y+15, loginView.frame.size.width-20, 40)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Email ID" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtEmail.attributedPlaceholder = str;
    txtEmail.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtEmail.textColor=[UIColor blackColor];
    txtEmail.font = [UIFont systemFontOfSize:15];
    txtEmail.backgroundColor=[UIColor clearColor];
    txtEmail.userInteractionEnabled=NO;
    txtEmail.text=_strEmail;
    [txtEmail setKeyboardType:UIKeyboardTypeEmailAddress];
    txtEmail.returnKeyType = UIReturnKeyNext;
    [loginView addSubview:txtEmail];
    
    
    txtGender=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, txtEmail.frame.size.height+txtEmail.frame.origin.y+15, loginView.frame.size.width-20, 40)];
    NSAttributedString *str6 = [[NSAttributedString alloc] initWithString:@"Select Gender" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtGender.attributedPlaceholder = str6;
    txtGender.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtGender.textColor=[UIColor blackColor];
    txtGender.font = [UIFont systemFontOfSize:15];
    txtGender.hidden=YES;
    txtGender.backgroundColor=[UIColor clearColor];
    [loginView addSubview:txtGender];
    
    GenderButt=[[UIButton alloc]initWithFrame:CGRectMake(10, txtEmail.frame.size.height+txtEmail.frame.origin.y+15, loginView.frame.size.width-20, 40)];
    [GenderButt addTarget:self action:@selector(GenderbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    GenderButt.backgroundColor=[UIColor clearColor];
    GenderButt.hidden=YES;
    [loginView addSubview:GenderButt];
    
    
    
    pluslabel=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, txtEmail.frame.size.height+txtEmail.frame.origin.y+15, 10, 40)];
    NSAttributedString *str18 = [[NSAttributedString alloc] initWithString:@"" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtCountryCode.attributedPlaceholder = str18;
    pluslabel.text=@"+";
    pluslabel.textColor=[UIColor blackColor];
    pluslabel.userInteractionEnabled=NO;
    pluslabel.backgroundColor=[UIColor clearColor];
    [loginView addSubview:pluslabel];
    
    txtCountryCode=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(20, txtEmail.frame.size.height+txtEmail.frame.origin.y+15,55, 40)];
    NSAttributedString *str8 = [[NSAttributedString alloc] initWithString:@"CCode" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtCountryCode.attributedPlaceholder = str8;
    txtCountryCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtCountryCode.textColor=[UIColor blackColor];
    txtCountryCode.font = [UIFont systemFontOfSize:15];
    txtCountryCode.backgroundColor=[UIColor clearColor];
    txtCountryCode.delegate=self;
    [txtCountryCode setKeyboardType:UIKeyboardTypeNumberPad];
    txtCountryCode.returnKeyType = UIReturnKeyNext;
    [loginView addSubview:txtCountryCode];
    
    GenderButt=[[UIButton alloc]initWithFrame:CGRectMake(20, txtEmail.frame.size.height+txtEmail.frame.origin.y+15,55, 40)];
    [GenderButt addTarget:self action:@selector(DobbuttClicked3:) forControlEvents:UIControlEventTouchUpInside];
    GenderButt.backgroundColor=[UIColor clearColor];
    [loginView addSubview:GenderButt];
    
    txtMobileNumber=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(85, txtEmail.frame.size.height+txtEmail.frame.origin.y+15, loginView.frame.size.width-20, 40)];
    NSAttributedString *str9 = [[NSAttributedString alloc] initWithString:@"Mobile Number" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtMobileNumber.attributedPlaceholder = str9;
    txtMobileNumber.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtMobileNumber.textColor=[UIColor blackColor];
    txtMobileNumber.font = [UIFont systemFontOfSize:15];
    txtMobileNumber.backgroundColor=[UIColor clearColor];
    txtMobileNumber.delegate=self;
    [txtMobileNumber setKeyboardType:UIKeyboardTypeNumberPad];
    txtMobileNumber.returnKeyType = UIReturnKeyNext;
    [loginView addSubview:txtMobileNumber];


    UIButton *Registrationbutt=[[UIButton alloc]initWithFrame:CGRectMake(10, txtMobileNumber.frame.size.height+txtMobileNumber.frame.origin.y+30, loginView.frame.size.width-20, 50)];
    [Registrationbutt setTitle:@"Register" forState:UIControlStateNormal];
    Registrationbutt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    Registrationbutt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [Registrationbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Registrationbutt.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [Registrationbutt addTarget:self action:@selector(RegistrationButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    Registrationbutt.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [loginView addSubview:Registrationbutt];
    
    
    
    UIView *termsView=[[UIView alloc]initWithFrame:CGRectMake(2, Registrationbutt.frame.size.height+Registrationbutt.frame.origin.y+10, loginView.frame.size.width-4, 30)];
    termsView.backgroundColor=[UIColor clearColor];
    [loginView addSubview:termsView];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(7,0, termsView.frame.size.width/2+20, 30)];
    label1.text=@"By signing up, you agree to our";
    label1.textColor=[UIColor blackColor];
    label1.font = [UIFont systemFontOfSize:12];
    label1.textAlignment = NSTextAlignmentRight;
    label1.backgroundColor=[UIColor clearColor];
    [termsView addSubview:label1];
    
    UIButton *Termsbutt=[[UIButton alloc]initWithFrame:CGRectMake(label1.frame.size.width+label1.frame.origin.x-4, 0, 130, 30)];
    [Termsbutt setTitle:@"Terms & Conditions" forState:UIControlStateNormal];
    Termsbutt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    Termsbutt.titleLabel.textAlignment = NSTextAlignmentLeft;
    [Termsbutt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    Termsbutt.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [Termsbutt addTarget:self action:@selector(TermsButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    Termsbutt.backgroundColor=[UIColor clearColor];
    [termsView addSubview:Termsbutt];

    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    txtCountryCode.inputAccessoryView=numberToolbar;
    txtMobileNumber.inputAccessoryView=numberToolbar;
}


-(void)doneWithNumberPad
{
    [txtCountryCode resignFirstResponder];
    [txtMobileNumber resignFirstResponder];
}


-(IBAction)DobbuttClicked3:(id)sender
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




-(IBAction)GenderbuttClicked:(id)sender
{
    [self.view endEditing:YES];
    
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-62, 300, 134)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 40)];
    lab.text=@"Select Gender";
    lab.textColor=[UIColor blackColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(1, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width-2, 1)];
    labeunder.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:labeunder];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(14,labeunder.frame.origin.y+5,footerview.frame.size.width-30,40)];
    [butt setTitle:@"Male" forState:UIControlStateNormal];
    butt.titleLabel.font = [UIFont systemFontOfSize:15];
    butt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(MaleClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(15, butt.frame.origin.y+butt.frame.size.height+2, footerview.frame.size.width-30, 40)];
    [butt1 setTitle:@"Female" forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont systemFontOfSize:15];
    butt1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [butt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt1 addTarget:self action:@selector(Femaleclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt1];
    
}

-(IBAction)MaleClicked:(id)sender
{
    txtGender.text=@"Male";
    strgender=@"male";
    [footerview removeFromSuperview];
    popview.hidden = YES;
    
}

-(IBAction)Femaleclicked:(id)sender
{
    txtGender.text=@"Female";
    strgender=@"female";
    [footerview removeFromSuperview];
    popview.hidden = YES;
}


-(IBAction)RegistrationButtClicked:(id)sender
{
    [self.view endEditing:YES];
    
    if (txtCountryCode.text.length==0)
    {
        [request showMessage:@"Please Enter Your Country Code" withTitle:@"Warning"];
    }
    else if (txtMobileNumber.text.length==0)
    {
        [request showMessage:@"Please Enter Your Mobile Number" withTitle:@"Warning"];
    }
    else
    {
        NSString *strCountryCode=[NSString stringWithFormat:@"+%@",txtCountryCode.text];
        
        strCountryCode = [strCountryCode stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        
        NSString *strurlforcheck=[NSString stringWithFormat:@"%@",_strUrl];
        NSString *encodetitle=[strurlforcheck stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        
        if (strurlforcheck == (id)[NSNull null] || strurlforcheck.length == 0 )
        {
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *post = [NSString stringWithFormat:@"firstname=%@&emailid=%@&mobile=%@&reg_with=%@&country_code=%@",txtFirstName.text,txtEmail.text,txtMobileNumber.text,@"social",strCountryCode];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,userRegister,english,strCityId];
            [request RegistrationRequest:post withUrl:strurl];
            
        }
        else
        {
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *post = [NSString stringWithFormat:@"firstname=%@&emailid=%@&mobile=%@&reg_with=%@&country_code=%@&profile_pic=%@",txtFirstName.text,txtEmail.text,txtMobileNumber.text,@"social",strCountryCode,encodetitle];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,userRegister,english,strCityId];
            [request RegistrationRequest:post withUrl:strurl];
        }
    }
}


-(void)responseRegistration:(NSMutableDictionary *)responseToken
{
    NSLog(@"Registration Response: %@",responseToken);
    
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"status"]];
    
    if([strstatus isEqualToString:@"1"])
    {
        struseridnumer=[NSString stringWithFormat:@"%@",[[responseToken valueForKey:@"data"]objectForKey:@"user_id"]];
       
        [self ReverifyAccount];
    }
    else
    {
        [request showMessage:[responseToken valueForKey:@"message"] withTitle:@""];
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
    txtverifycode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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
    butt.backgroundColor=[UIColor grayColor];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width+butt.frame.origin.x+6, forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35, footerview.frame.size.width/3-8, 40)];
    [butt1 setTitle:@"Done" forState:UIControlStateNormal];
    butt1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt1 addTarget:self action:@selector(DoneButtClicked1:) forControlEvents:UIControlEventTouchUpInside];
    butt1.backgroundColor=[UIColor lightGrayColor];
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
        NSString *post = [NSString stringWithFormat:@"user_id=%@&otp=%@",struseridnumer,txtverifycode.text];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&otp=%@",BaseUrl,strtoken,verifyotp,english,strCityId,struseridnumer,txtverifycode.text];
        [request OtpVerifyRequest:post withUrl:strurl];
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
        
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *tbc=[storyboard instantiateViewControllerWithIdentifier:@"english"];
        self.window.rootViewController = tbc;
        tbc.selectedIndex=1;
        [self.window makeKeyAndVisible];
        
    }
    else
    {
        [request showMessage:[responseToken valueForKey:@"message"] withTitle:@""];
    }
}

-(IBAction)ResendButtClicked:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    //   NSString *strid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
    NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@",BaseUrl,strtoken,resendOtp,english,strCityId,struseridnumer];
    [request ResendOtpRequest:nil withUrl:strurl];
}


-(void)responseResendotp:(NSMutableDictionary *)responseToken
{
    NSLog(@"Resend OTP Response:%@",responseToken);
}




-(IBAction)TermsButtClicked:(id)sender
{
    [self.view endEditing:YES];
    [request showMessage:@"Terms Clicked" withTitle:@"Terms"];
}



#pragma mark - Back Clicked

-(IBAction)BackbuttClicked:(id)sender
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - TextField Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==txtMobileNumber)
    {
        [(ACFloatingTextField *)textField textFieldDidBeginEditing];
        [self animateTextField:textField up:YES];
    }
    else if (textField==txtCountryCode)
    {
        [(ACFloatingTextField *)textField textFieldDidBeginEditing];
        [self animateTextField:textField up:YES];
    }
    else if (textField==txtverifycode)
    {
        [(ACFloatingTextField *)textField textFieldDidBeginEditing];
        [self animateTextField:textField up:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==txtMobileNumber)
    {
        [(ACFloatingTextField *)textField textFieldDidEndEditing];
        [self animateTextField:textField up:NO];
    }
    else if (textField==txtCountryCode)
    {
        [(ACFloatingTextField *)textField textFieldDidBeginEditing];
        [self animateTextField:textField up:NO];
    }
    else if (textField==txtverifycode)
    {
        [(ACFloatingTextField *)textField textFieldDidBeginEditing];
        [self animateTextField:textField up:NO];
    }
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
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

- (void)dismissKeyboard
{
    [txtEmail resignFirstResponder];
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
