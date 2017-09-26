//
//  LoginandRegisterViewController.m
//  BoxBazar
//
//  Created by bharat on 27/07/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "LoginandRegisterViewController.h"
#import "ApiRequest.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import "OAuthLoginView.h"
#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "BoxBazarUrl.pch"
#import "DejalActivityView.h"
#import "ACFloatingTextField.h"
#import "SettingsViewController.h"
#import "SocialRegistrationViewController.h"
#import "SLCountryPickerViewController.h"
#import "HMDiallingCode.h"
#import<CoreTelephony/CTCallCenter.h>
#import<CoreTelephony/CTCall.h>
#import<CoreTelephony/CTCarrier.h>
#import<CoreTelephony/CTTelephonyNetworkInfo.h>
#import <GoogleSignIn/GoogleSignIn.h>

@interface LoginandRegisterViewController ()<ApiRequestdelegate,HMDiallingCodeDelegate,GIDSignInDelegate,GIDSignInUIDelegate>
{
    ApiRequest *request;
    
    UISegmentedControl *segmentedControl;
    
    UIView *topview;
    
    UIScrollView *LoginScrollView,*RegistrationScrollView;
    
    UIView *loginView,*RegistrationView;
    
   // UITextField *txtEmail,*txtPassword;
    ACFloatingTextField *txtEmail,*txtPassword;
    UILabel *EmailUnderlabel,*PasswordUnderlabel;
    
    ACFloatingTextField *txtRegEmail,*txtConformRegEmail,*txtRegPassword,*txtConformRegPassword,*txtFirstName,*txtLastName,*txtGender,*txtDob,*txtCountryCode,*txtMobileNumber,*txtPassportNumber;
    UILabel *RegEmailUnderlabel,*ConformRegEmailUnderlabel,*RegPasswordlabel,*ConformRegPasswordlabel,*FirstNameUnderlabel,*LastNameUnderlabel,*GenderUnderlabel,*DobUnderlabel,*MobileUnderlabel,*MobileUnderlabel2,*PassportUnderlabel;
   // UILabel *pluslabel;
    
    UIButton *GenderButt,*DobButt;
    
    UIView *popview;
    UIView *footerview;
    UIDatePicker *datePicker;
    UIBarButtonItem *rightBtn;
    
    ACFloatingTextField *forgotPasswordMobile,*pluslabel;
    UILabel *forgotPasswordMobileUnderlabel;
    
    OAuthLoginView *linkedInLoginView;
    NSString *_id,*profileUrl,*email,*industry,*name,*pictureUrl;
    NSString *strgender;
    
    ACFloatingTextField *txtverifycode,*txtNewPassword,*txtConformNewPassword;
    NSString *struserid,*email1;
    NSString *struseridnumer,*strnewpassword;
    int G;
    NSURL *imageURL;
}
@property (strong, nonatomic) HMDiallingCode *diallingCode;
@end


static NSString * const kClientId = @"433510102849-7n6nldao4af40fs0uf9aj8v0a975o423.apps.googleusercontent.com";

static NSString * const kClientSecret = @"JQPrFc_bW6W84QpW1H5EBfHT";

@implementation LoginandRegisterViewController



- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setUp];
      
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
       
    }
    return self;
}

- (void)setUp {
      [GIDSignInButton class];
    
    GIDSignIn *signIn = [GIDSignIn sharedInstance];
    signIn.shouldFetchBasicProfile = YES;
    signIn.delegate = self;
    signIn.uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].uiDelegate=self;

}

- (id) init //designated initializer
{
    if (self)
    {
        locationManager = [[CLLocationManager alloc] init];
        ceo = [[CLGeocoder alloc] init];
        locationManager.delegate = self;
        [locationManager startMonitoringSignificantLocationChanges];
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [GIDSignInButton class];
//    
//    GIDSignIn *signIn = [GIDSignIn sharedInstance];
//    signIn.shouldFetchBasicProfile = YES;
//    signIn.delegate = self;
//    signIn.uiDelegate = self;
//    [GIDSignIn sharedInstance].delegate = self;
//    [GIDSignIn sharedInstance].uiDelegate=self;
    
    [self CurrentLocationIdentifier];
    
    
    self.diallingCode = [[HMDiallingCode alloc] initWithDelegate:self];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    request=[[ApiRequest alloc]init];
    request.delegate=self;
    G=1;
    
    
    CTTelephonyNetworkInfo *info = [CTTelephonyNetworkInfo new];
    
    CTCarrier *carrier = info.subscriberCellularProvider;
    
    NSLog(@"Country code is: %@",carrier.mobileCountryCode);
    
    
    NSString *countryCode = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
    NSLog(@"countryCode :%@",countryCode);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   
                                   initWithTarget:self
                                   
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [self customView];
    
    FBSDKLoginManager *loginmanager= [[FBSDKLoginManager alloc]init];
    [loginmanager logOut];
}


-(void)CurrentLocationIdentifier
{
    //---- For getting current gps location
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    //------
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSLog(@"\nCurrent Location Detected\n");
             NSLog(@"placemark %@",placemark);
             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             NSString *Address = [[NSString alloc]initWithString:locatedAt];
             NSString *Area = [[NSString alloc]initWithString:placemark.locality];
             NSString *Country = [[NSString alloc]initWithString:placemark.country];
             NSString *CountryArea = [NSString stringWithFormat:@"%@, %@", Area,Country];
             NSString *strcountrycode2=[NSString stringWithFormat:@"%@",placemark.ISOcountryCode];
             NSLog(@"%@",strcountrycode2);
             NSLog(@"%@",Address);
             NSLog(@"%@",CountryArea);
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
             //return;
             
         }
         /*---- For more results
          placemark.region);
          placemark.country);
          placemark.locality);
          placemark.name);
          placemark.ocean);
          placemark.postalCode);
          placemark.subLocality);
          placemark.location);
          ------*/
     }];
}

-(void)customView
{
    topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 82)];
    topview.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [self.view addSubview:topview];
    
    
    UIButton *Backbutt=[[UIButton alloc] initWithFrame:CGRectMake(10, topview.frame.size.height/2-5, 32, 32)];
    [Backbutt setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    Backbutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [Backbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Backbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Backbutt addTarget:self action:@selector(BackbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt];
    
    
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"Login", @"Register", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(60, topview.frame.size.height/2-10, topview.frame.size.width-120, 40);
    [segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont boldSystemFontOfSize:17], NSFontAttributeName,
                                    [UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0], NSForegroundColorAttributeName, nil];
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateSelected];
    
    NSDictionary *attributes1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:17], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [segmentedControl setTitleTextAttributes:attributes1 forState:UIControlStateNormal];
    
    UIColor *selectedColor = [UIColor whiteColor];
    UIColor *deselectedColor = [UIColor whiteColor];
    
    for (id subview in [segmentedControl subviews]) {
        if ([subview isSelected])
            [subview setTintColor:selectedColor];
        else
            [subview setTintColor:deselectedColor];
    }
    [topview addSubview:segmentedControl];
    
    
    RegistrationView.hidden=YES;
    RegistrationScrollView.hidden=YES;
    [self Login];
}


#pragma mark - TextField Delegates


- (void)setupOutlets1
{
    
    txtFirstName.delegate=self;
    txtFirstName.tag=1;
    
    txtRegEmail.delegate=self;
    txtRegEmail.tag=2;
    
//    txtConformRegEmail.delegate=self;
//    txtConformRegEmail.tag=2;
    
    txtRegPassword.delegate=self;
    txtRegPassword.tag=3;
    
    txtConformRegPassword.delegate=self;
    txtConformRegPassword.tag=4;
    
   
//    txtLastName.delegate=self;
//    txtLastName.tag=6;
    
//    txtCountryCode.delegate=self;
//    txtCountryCode.tag=7;
    
    txtMobileNumber.delegate=self;
    txtMobileNumber.tag=5;
    
//    txtPassportNumber.delegate=self;
//    txtPassportNumber.tag=9;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [(ACFloatingTextField *)textField textFieldDidBeginEditing];
    
    if (textField==txtEmail)
    {
        EmailUnderlabel.backgroundColor=[UIColor blackColor];
        [(ACFloatingTextField *)textField textFieldDidBeginEditing];
         [self animateTextField:textField up:YES];
    }
    else if (textField==txtPassword)
    {
        PasswordUnderlabel.backgroundColor=[UIColor blackColor];
        [(ACFloatingTextField *)textField textFieldDidBeginEditing];
         [self animateTextField:textField up:YES];
    }
    else if (textField==txtRegEmail)
    {
        RegEmailUnderlabel.backgroundColor=[UIColor blackColor];
        RegistrationScrollView.contentOffset = CGPointMake(0, textField.frame.origin.y);
    }
    else if (textField==txtConformRegEmail)
    {
        ConformRegEmailUnderlabel.backgroundColor=[UIColor blackColor];
         RegistrationScrollView.contentOffset = CGPointMake(0, textField.frame.origin.y);
    }
    else if (textField==txtRegPassword)
    {
        RegPasswordlabel.backgroundColor=[UIColor blackColor];
         RegistrationScrollView.contentOffset = CGPointMake(0, textField.frame.origin.y);
    }
    else if (textField==txtConformRegPassword)
    {
        ConformRegPasswordlabel.backgroundColor=[UIColor blackColor];
         RegistrationScrollView.contentOffset = CGPointMake(0, textField.frame.origin.y);
    }
    else if (textField==txtFirstName)
    {
        FirstNameUnderlabel.backgroundColor=[UIColor blackColor];
         RegistrationScrollView.contentOffset = CGPointMake(0, textField.frame.origin.y);
    }
    else if (textField==txtLastName)
    {
        LastNameUnderlabel.backgroundColor=[UIColor blackColor];
         RegistrationScrollView.contentOffset = CGPointMake(0, textField.frame.origin.y);
    }
    else if (textField==txtCountryCode)
    {
        MobileUnderlabel.backgroundColor=[UIColor blackColor];
         RegistrationScrollView.contentOffset = CGPointMake(0, textField.frame.origin.y);
    }
    else if (textField==txtMobileNumber)
    {
        MobileUnderlabel2.backgroundColor=[UIColor blackColor];
         RegistrationScrollView.contentOffset = CGPointMake(0, textField.frame.origin.y);
    }
    else if (textField==txtPassportNumber)
    {
        PassportUnderlabel.backgroundColor=[UIColor blackColor];
         RegistrationScrollView.contentOffset = CGPointMake(0, textField.frame.origin.y);
    }
    else if (textField==forgotPasswordMobile)
    {
        forgotPasswordMobileUnderlabel.backgroundColor=[UIColor blackColor];
       [self animateTextField:textField up:YES];
    }
    else if (textField==txtNewPassword)
    {
        forgotPasswordMobileUnderlabel.backgroundColor=[UIColor blackColor];
        [self animateTextField:textField up:YES];
    }
    else if (textField==txtConformNewPassword)
    {
        forgotPasswordMobileUnderlabel.backgroundColor=[UIColor blackColor];
        [self animateTextField:textField up:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [(ACFloatingTextField *)textField textFieldDidEndEditing];
    
    if (textField==txtEmail)
    {
        EmailUnderlabel.backgroundColor=[UIColor lightGrayColor];
        [(ACFloatingTextField *)textField textFieldDidEndEditing];
        [self animateTextField:textField up:NO];
    }
    else if (textField==txtPassword)
    {
        PasswordUnderlabel.backgroundColor=[UIColor lightGrayColor];
        [(ACFloatingTextField *)textField textFieldDidEndEditing];
        [self animateTextField:textField up:NO];
    }
    else if (textField==txtRegEmail)
    {
        RegEmailUnderlabel.backgroundColor=[UIColor lightGrayColor];
        RegistrationScrollView.contentOffset = CGPointMake(0, 0);
    }
    else if (textField==txtConformRegEmail)
    {
        ConformRegEmailUnderlabel.backgroundColor=[UIColor lightGrayColor];
        RegistrationScrollView.contentOffset = CGPointMake(0, 0);
    }
    else if (textField==txtRegPassword)
    {
        RegPasswordlabel.backgroundColor=[UIColor lightGrayColor];
        RegistrationScrollView.contentOffset = CGPointMake(0, 0);
    }
    else if (textField==txtConformRegPassword)
    {
        ConformRegPasswordlabel.backgroundColor=[UIColor lightGrayColor];
        RegistrationScrollView.contentOffset = CGPointMake(0, 0);
    }
    else if (textField==txtFirstName)
    {
        FirstNameUnderlabel.backgroundColor=[UIColor lightGrayColor];
        RegistrationScrollView.contentOffset = CGPointMake(0, 0);
    }
    else if (textField==txtLastName)
    {
        LastNameUnderlabel.backgroundColor=[UIColor lightGrayColor];
        RegistrationScrollView.contentOffset = CGPointMake(0, 0);
    }
    else if (textField==txtCountryCode )
    {
        MobileUnderlabel.backgroundColor=[UIColor lightGrayColor];
        RegistrationScrollView.contentOffset = CGPointMake(0, 0);
    }
    else if (textField==txtMobileNumber)
    {
        MobileUnderlabel2.backgroundColor=[UIColor lightGrayColor];
        RegistrationScrollView.contentOffset = CGPointMake(0, 0);
    }
    else if (textField==txtPassportNumber)
    {
        PassportUnderlabel.backgroundColor=[UIColor lightGrayColor];
        RegistrationScrollView.contentOffset = CGPointMake(0, 0);
    }
    else if (textField==forgotPasswordMobile)
    {
        forgotPasswordMobileUnderlabel.backgroundColor=[UIColor lightGrayColor];
       [self animateTextField:textField up:NO];
    }
    else if (textField==txtNewPassword)
    {
        forgotPasswordMobileUnderlabel.backgroundColor=[UIColor blackColor];
        [self animateTextField:textField up:NO];
    }
    else if (textField==txtConformNewPassword)
    {
        forgotPasswordMobileUnderlabel.backgroundColor=[UIColor blackColor];
        [self animateTextField:textField up:NO];
    }
    
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    if (textField==forgotPasswordMobile)
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
   else if (textField==txtEmail)
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
   else if (textField==txtPassword)
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
       const int movementDistance = -100;
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
    [txtEmail resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtRegEmail resignFirstResponder];
    [txtConformRegEmail resignFirstResponder];
    [txtRegPassword resignFirstResponder];
    [txtConformRegPassword resignFirstResponder];
    [txtFirstName resignFirstResponder];
    [txtLastName resignFirstResponder];
    [txtCountryCode resignFirstResponder];
    [txtMobileNumber resignFirstResponder];
    [txtPassportNumber resignFirstResponder];
    [forgotPasswordMobile resignFirstResponder];
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
    if (textField==txtEmail)
    {
        [textField resignFirstResponder];
        return YES;
    }
    else if (textField==txtPassword)
    {
        [textField resignFirstResponder];
        return YES;
    }
    else if (textField==forgotPasswordMobile)
    {
        [textField resignFirstResponder];
        return YES;
    }
    else
    {
    NSInteger nextTag = textField.tag + 1;
    [self jumpToNextTextField:textField withTag:nextTag];
    return NO;
    }
    return NO;
}




#pragma mark - Segment Changed

- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    UIColor *selectedColor = [UIColor whiteColor];
    UIColor *deselectedColor = [UIColor whiteColor];
    
    for (id subview in [segmentedControl subviews]) {
        if ([subview isSelected])
            [subview setTintColor:selectedColor];
        else
            [subview setTintColor:deselectedColor];
    }
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:17], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    if(segment.selectedSegmentIndex == 0)
    {
        G=1;
        [self.view endEditing:YES];
        RegistrationView.hidden=YES;
        RegistrationScrollView.hidden=YES;
        [self Login];
    }
    else if(segment.selectedSegmentIndex == 1)
    {
        G=2;
         [self.view endEditing:YES];
        loginView.hidden=YES;
        LoginScrollView.hidden=YES;
        [self Registration];
        [self setupOutlets1];
        
        NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
        NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
        
        NSLog(@"%@",countryCode);
        
        NSString *strcode=[[NSUserDefaults standardUserDefaults]objectForKey:@"countryCode"];
        
        [self.diallingCode getDiallingCodeForCountry:strcode];
    }
}

#pragma mark - Login


-(void)Login
{
    LoginScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, topview.frame.size.height+topview.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    LoginScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 810);
    [self.view addSubview:LoginScrollView];
    
    loginView=[[UIView alloc]initWithFrame:CGRectMake(10, 20, self.view.frame.size.width-20, 620)];
    loginView.backgroundColor=[UIColor whiteColor];
    loginView.layer.cornerRadius = 5;
    loginView.clipsToBounds = YES;
    loginView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    loginView.layer.borderWidth = 1.0f;
    [LoginScrollView addSubview:loginView];
    
    UIImageView *logoimage=[[UIImageView alloc] initWithFrame:CGRectMake(loginView.frame.size.width/2-65, 40, 130, 130)];
    logoimage.image=[UIImage imageNamed:@"150x150.png"];
    [loginView addSubview:logoimage];
    
    
    txtEmail=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, logoimage.frame.size.height+logoimage.frame.origin.y+40, loginView.frame.size.width-20, 50)];
//    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Email ID / Mobile Number" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
//    txtEmail.attributedPlaceholder = str;
    [txtEmail setTextFieldPlaceholderText:@"Email ID / Mobile Number"];
    txtEmail.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtEmail.textColor=[UIColor blackColor];
    txtEmail.font = [UIFont systemFontOfSize:15];
    txtEmail.backgroundColor=[UIColor clearColor];
    txtEmail.delegate=self;
    [loginView addSubview:txtEmail];
    
    EmailUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtEmail.frame.size.height+txtEmail.frame.origin.y+1, loginView.frame.size.width-20, 2)];
    EmailUnderlabel.backgroundColor=[UIColor lightGrayColor];
    EmailUnderlabel.hidden=YES;
    [loginView addSubview:EmailUnderlabel];
    
    
    txtPassword=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, EmailUnderlabel.frame.size.height+EmailUnderlabel.frame.origin.y+5, loginView.frame.size.width-20, 50)];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtPassword.attributedPlaceholder = str1;
    txtPassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtPassword.textColor=[UIColor blackColor];
    txtPassword.font = [UIFont systemFontOfSize:15];
    txtPassword.backgroundColor=[UIColor clearColor];
    txtPassword.secureTextEntry=YES;
    txtPassword.delegate=self;
    txtPassword.returnKeyType = UIReturnKeyDone;
    [loginView addSubview:txtPassword];
    
    PasswordUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtPassword.frame.size.height+txtPassword.frame.origin.y+1, loginView.frame.size.width-20, 2)];
    PasswordUnderlabel.backgroundColor=[UIColor lightGrayColor];
    PasswordUnderlabel.hidden=YES;
    [loginView addSubview:PasswordUnderlabel];

    
    UIButton *forgotPasswordbutt=[[UIButton alloc]initWithFrame:CGRectMake(loginView.frame.size.width-150, PasswordUnderlabel.frame.origin.y+PasswordUnderlabel.frame.size.height+10, 140, 40)];
    [forgotPasswordbutt setTitle:@"Forgot Password?" forState:UIControlStateNormal];
    forgotPasswordbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [forgotPasswordbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgotPasswordbutt.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [forgotPasswordbutt addTarget:self action:@selector(forgotPasswordClicked:) forControlEvents:UIControlEventTouchUpInside];
    forgotPasswordbutt.backgroundColor=[UIColor clearColor];
    [loginView addSubview:forgotPasswordbutt];
    
    UIButton *loginbutt=[[UIButton alloc]initWithFrame:CGRectMake(10, forgotPasswordbutt.frame.origin.y+forgotPasswordbutt.frame.size.height+10, loginView.frame.size.width-20, 50)];
    [loginbutt setTitle:@"Login" forState:UIControlStateNormal];
    loginbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [loginbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginbutt.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [loginbutt addTarget:self action:@selector(loginButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    loginbutt.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [loginView addSubview:loginbutt];
    
    
    UILabel *Orlabel=[[UILabel alloc] initWithFrame:CGRectMake(loginView.frame.size.width/2-15, loginbutt.frame.size.height+loginbutt.frame.origin.y+20,30, 30)];
    Orlabel.text=@"Or";
    Orlabel.textColor=[UIColor blackColor];
    Orlabel.font = [UIFont systemFontOfSize:15];
    Orlabel.textAlignment = NSTextAlignmentCenter;
    Orlabel.backgroundColor=[UIColor clearColor];
    Orlabel.layer.cornerRadius = 15;
    Orlabel.clipsToBounds = YES;
    Orlabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    Orlabel.layer.borderWidth = 1.0f;
    [loginView addSubview:Orlabel];
    
    
    UIButton *Facebookbutt=[[UIButton alloc]initWithFrame:CGRectMake(loginView.frame.size.width/2-85, Orlabel.frame.size.height+Orlabel.frame.origin.y+20, 50, 50)];
    [Facebookbutt setTitle:@"f" forState:UIControlStateNormal];
    Facebookbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [Facebookbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Facebookbutt.titleLabel.font = [UIFont boldSystemFontOfSize:40];
    [Facebookbutt addTarget:self action:@selector(FacebookButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    Facebookbutt.backgroundColor=[UIColor colorWithRed:59.0/255.0f green:89.0/255.0f blue:152.0/255.0f alpha:1.0];
    Facebookbutt.layer.cornerRadius = 8; // this value vary as per your desire
    Facebookbutt.clipsToBounds = YES;
    [loginView addSubview:Facebookbutt];
    
    UIButton *linkedinbutt=[[UIButton alloc]initWithFrame:CGRectMake(Facebookbutt.frame.origin.x+Facebookbutt.frame.size.width+10, Orlabel.frame.size.height+Orlabel.frame.origin.y+20, 50, 50)];
    [linkedinbutt setTitle:@"in" forState:UIControlStateNormal];
    linkedinbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [linkedinbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    linkedinbutt.titleLabel.font = [UIFont boldSystemFontOfSize:40];
    [linkedinbutt addTarget:self action:@selector(LinkedinButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    linkedinbutt.backgroundColor=[UIColor colorWithRed:0.0/255.0f green:119.0/255.0f blue:181.0/255.0f alpha:1.0];
    linkedinbutt.layer.cornerRadius = 8; // this value vary as per your desire
    linkedinbutt.clipsToBounds = YES;
    [loginView addSubview:linkedinbutt];
    
    
    UIView *google=[[UIView alloc]initWithFrame:CGRectMake(linkedinbutt.frame.origin.x+linkedinbutt.frame.size.width+10, Orlabel.frame.size.height+Orlabel.frame.origin.y+20, 50, 50)];
    google.backgroundColor=[UIColor lightGrayColor];
    google.layer.cornerRadius = 8; // this value vary as per your desire
    google.clipsToBounds = YES;
    [loginView addSubview:google];
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
    image.image=[UIImage imageNamed:@"appbg.png"];
    [google addSubview:image];
    
    
    UIButton *googlebutt=[[UIButton alloc]initWithFrame:CGRectMake(linkedinbutt.frame.origin.x+linkedinbutt.frame.size.width+10, Orlabel.frame.size.height+Orlabel.frame.origin.y+20, 50, 50)];
 //   [googlebutt setTitle:@"G" forState:UIControlStateNormal];
 //   [googlebutt setBackgroundImage:[UIImage imageNamed:@"appbg.png"] forState:UIControlStateNormal];
    googlebutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [googlebutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    googlebutt.titleLabel.font = [UIFont boldSystemFontOfSize:40];
    [googlebutt addTarget:self action:@selector(RegisterGoogleButtClicked:) forControlEvents:UIControlEventTouchUpInside];
  //  googlebutt.backgroundColor=[UIColor colorWithRed:211.0/255.0f green:72.0/255.0f blue:54.0/255.0f alpha:1.0];
    
    googlebutt.layer.cornerRadius = 8; // this value vary as per your desire
    googlebutt.clipsToBounds = YES;
    [loginView addSubview:googlebutt];
    
    
    UIButton *loginThroughOtpbutt=[[UIButton alloc]initWithFrame:CGRectMake(40, Facebookbutt.frame.origin.y+Facebookbutt.frame.size.height+15, loginView.frame.size.width-80, 50)];
    [loginThroughOtpbutt setTitle:@"Login through OTP?" forState:UIControlStateNormal];
    loginThroughOtpbutt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [loginThroughOtpbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginThroughOtpbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [loginThroughOtpbutt addTarget:self action:@selector(loginThroughOtpButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    loginThroughOtpbutt.backgroundColor=[UIColor clearColor];
    loginThroughOtpbutt.hidden=YES;
    [loginView addSubview:loginThroughOtpbutt];

}

#pragma mark - Login view Multiple Actions

-(IBAction)forgotPasswordClicked:(id)sender
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
    forgotPasswordMobile.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [butt addTarget:self action:@selector(CancelButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    butt.backgroundColor=[UIColor grayColor];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width+butt.frame.origin.x+10, forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35, footerview.frame.size.width/2-15, 40)];
    [butt1 setTitle:@"Done" forState:UIControlStateNormal];
    butt1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [butt1 addTarget:self action:@selector(DoneButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    butt1.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [footerview addSubview:butt1];
    
    
//    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
//    numberToolbar.tintColor=[UIColor whiteColor];
//    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
//    numberToolbar.items = [NSArray arrayWithObjects:
//                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
//                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad2)],
//                           nil];
//    [numberToolbar sizeToFit];
//    
//    forgotPasswordMobile.inputAccessoryView = numberToolbar;

}

-(void)doneWithNumberPad2
{
    [forgotPasswordMobile resignFirstResponder];
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
        [request showMessage:@"Please Enter Your Registered Email Id/Mobile Number" withTitle:@"Warning"];
    }
    else
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user=%@",BaseUrl,strtoken,forgetPassword,english,strCityId,forgotPasswordMobile.text];
        [request forgotPasswordRequest:nil withUrl:strurl];
    }
}


-(void)responseForgetPassword:(NSMutableDictionary *)responseToken
{
    NSLog(@"%@",responseToken);
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        struseridnumer=[NSString stringWithFormat:@"%@",[[responseToken valueForKey:@"data"]objectForKey:@"user_id"]];
        
        [request showMessage:[responseToken valueForKey:@"message"] withTitle:@"BoxBazar"];
        
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
            [request showMessage:[responseToken valueForKey:@"message"] withTitle:@"Message"];
             [self ReverifyAccount];
        }
        else
        {
            [request showMessage:[responseToken valueForKey:@"message"] withTitle:@"Message"];
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
    lab.text=@"Forget Password?";
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
    forgotPasswordMobile.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [butt addTarget:self action:@selector(CancelButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    butt.backgroundColor=[UIColor grayColor];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width+butt.frame.origin.x+10, forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35, footerview.frame.size.width/2-15, 40)];
    [butt1 setTitle:@"Done" forState:UIControlStateNormal];
    butt1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:18];
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


-(IBAction)DoneButtClicked4:(id)sender
{
    if (forgotPasswordMobile.text.length==0)
    {
        [request showMessage:@"Please Enter Your OTP" withTitle:@"Warning"];
    }
    else
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
         NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
   //     NSString *struid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&otp=%@",BaseUrl,strtoken,VerifyPasswordOtp,english,strCityId,struseridnumer,forgotPasswordMobile.text];
        [request CitysRequest:nil withUrl:strurl];
    }
}


-(void)responsewithCitylist:(NSMutableDictionary *)responseToken
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
      
//            [[self navigationController] setNavigationBarHidden:NO animated:YES];
//            SettingsViewController *setting=[self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
//            setting.hidesBottomBarWhenPushed=YES;
//            setting.struid=struseridnum;
//            [self.navigationController pushViewController:setting animated:YES];
        
    }
    else
    {
        [request showMessage:[responseToken valueForKey:@"message"] withTitle:@"BoxBazar"];
        
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
    txtNewPassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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
    txtConformNewPassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [butt addTarget:self action:@selector(CancelButtClickedf:) forControlEvents:UIControlEventTouchUpInside];
    butt.backgroundColor=[UIColor grayColor];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width+butt.frame.origin.x+10, txtConformNewPassword.frame.origin.y+txtConformNewPassword.frame.size.height+25, footerview.frame.size.width/2-15, 40)];
    [butt1 setTitle:@"Done" forState:UIControlStateNormal];
    butt1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:18];
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
        [request showMessage:@"Please Enter Your New Password" withTitle:@"Warning"];
    }
    else if (txtConformNewPassword.text.length==0)
    {
        [request showMessage:@"Please Confirm Your New Password" withTitle:@"Warning"];
    }
    else if (![txtNewPassword.text isEqualToString:txtConformNewPassword.text])
    {
        [request showMessage:@"Confirm New Password is not matching" withTitle:@"Warning"];
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
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,editprofile,english,strCityId];
        [request sendRequest:post withUrl:strurl];
    }
}

-(void)responsewithToken:(NSMutableDictionary *)responseToken
{
    NSLog(@"Edit Response :%@",responseToken);
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"status"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:struseridnumer forKey:@"userid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self.navigationController popViewControllerAnimated:YES];
        [request showMessage:[responseToken valueForKey:@"message"] withTitle:@"Profile Update"];
    }
    else
    {
        [request showMessage:[responseToken valueForKey:@"message"] withTitle:@"Profile Update"];
    }
}



-(IBAction)loginButtClicked:(id)sender
{
    [self.view endEditing:YES];
    
    if (txtEmail.text.length==0)
    {
        [request showMessage:@"Please Enter Your Email Id / Mobile Number" withTitle:@"Warning"];
    }
//    else if (![self NSStringIsValidEmail:txtEmail.text])
//    {
//        [request showMessage:@"Please Enter Valid Email Id" withTitle:@"Warning"];
//    }
    else if (txtPassword.text.length==0)
    {
        [request showMessage:@"Please Enter Your Password" withTitle:@"Warning"];
    }
    else
    {
        NSString *string =txtEmail.text;
        string = [string stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
        txtEmail.text=string;
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *post = [NSString stringWithFormat:@"user=%@&login_with=%@&password=%@",txtEmail.text,@"form",txtPassword.text];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,userlogin,english,strCityId];
        [request loginRequest:post withUrl:strurl];
    }
}

-(void)responseLogin:(NSMutableDictionary *)responseToken
{
    [[GIDSignIn sharedInstance] signOut];
    
    NSLog(@"%@",responseToken);
    NSString *strstatus=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"code"]];
    
    if ([strstatus isEqualToString:@"1"])
    {
        NSString *strmessage=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"status"]];
        
        if ([strmessage isEqualToString:@"0"])
        {
            [request showMessage:[responseToken valueForKey:@"message"] withTitle:@"BoxBazar"];
        }
        else
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[responseToken valueForKey:@"data"]objectForKey:@"user_id"]];
            [[NSUserDefaults standardUserDefaults]setObject:struseridnum forKey:@"userid"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if([strstatus isEqualToString:@"2"])
    {
        struseridnumer=[NSString stringWithFormat:@"%@",[[responseToken valueForKey:@"data"]objectForKey:@"user_id"]];
        [self ReverifyAccount];
    }
    else
    {
        [request showMessage:[responseToken valueForKey:@"message"] withTitle:@"Message"];
    }
}


-(IBAction)FacebookButtClicked:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email",@"public_profile",@"user_friends"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
            //self.lblReturn.text = [NSString stringWithFormat:@"FB: %@", error];
            NSLog(@"%@",error);
            [DejalBezelActivityView removeView];
            
        } else if (result.isCancelled) {
            // Handle cancellations
            NSLog(@"FB Cancelled");
            [DejalBezelActivityView removeView];
            
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
                         
                
                         NSString *post = [NSString stringWithFormat:@"user=%@&login_with=%@",[result valueForKey:@"email"],@"social"];
                         NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
                          NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
                         NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,userlogin,english,strCityId];
                         [request loginRequest:post withUrl:strurl];
                     }
                 }];
            }
        }
    }];
}



-(IBAction)LinkedinButtClicked:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
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
        [DejalBezelActivityView removeView];
        NSLog(@"null Responsse");
    }
    else
    {
        NSLog(@"Full Response");
        
        NSString *post = [NSString stringWithFormat:@"user=%@&login_with=%@",email,@"social"];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
         NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,userlogin,english,strCityId];
        [request loginRequest:post withUrl:strurl];
    }
}


-(IBAction)loginThroughOtpButtClicked:(id)sender
{
    [request showMessage:@"Login Through OTP Clicked" withTitle:@"Login Through OTP"];
}


#pragma mark - Registration


-(void)Registration
{
    RegistrationScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, topview.frame.size.height+topview.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    RegistrationScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 690);
    [self.view addSubview:RegistrationScrollView];
    
    RegistrationView=[[UIView alloc]initWithFrame:CGRectMake(2, 2, self.view.frame.size.width-4, 550)];
    RegistrationView.backgroundColor=[UIColor whiteColor];
    RegistrationView.layer.cornerRadius = 5;
    RegistrationView.clipsToBounds = YES;
    RegistrationView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    RegistrationView.layer.borderWidth = 1.0f;
    [RegistrationScrollView addSubview:RegistrationView];
    

    
    UIButton *RegisterFacebookbutt=[[UIButton alloc]initWithFrame:CGRectMake(6,15, RegistrationView.frame.size.width/3-8, 50)];
    [RegisterFacebookbutt setTitle:@"f" forState:UIControlStateNormal];
    RegisterFacebookbutt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    RegisterFacebookbutt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [RegisterFacebookbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    RegisterFacebookbutt.titleLabel.font = [UIFont boldSystemFontOfSize:40];
    [RegisterFacebookbutt addTarget:self action:@selector(RegisterFacebookButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    RegisterFacebookbutt.backgroundColor=[UIColor colorWithRed:59.0/255.0f green:89.0/255.0f blue:152.0/255.0f alpha:1.0];
    RegisterFacebookbutt.layer.cornerRadius = 8; // this value vary as per your desire
    RegisterFacebookbutt.clipsToBounds = YES;
    [RegistrationView addSubview:RegisterFacebookbutt];
    
    
    UIButton *Registerlinkedinbutt=[[UIButton alloc]initWithFrame:CGRectMake(RegisterFacebookbutt.frame.origin.x+RegisterFacebookbutt.frame.size.width+6, 15, RegistrationView.frame.size.width/3-8, 50)];
    [Registerlinkedinbutt setTitle:@"in" forState:UIControlStateNormal];
    Registerlinkedinbutt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    Registerlinkedinbutt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [Registerlinkedinbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Registerlinkedinbutt.titleLabel.font = [UIFont boldSystemFontOfSize:40];
    [Registerlinkedinbutt addTarget:self action:@selector(RegisterLinkedinButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    Registerlinkedinbutt.backgroundColor=[UIColor colorWithRed:0.0/255.0f green:119.0/255.0f blue:181.0/255.0f alpha:1.0];
    Registerlinkedinbutt.layer.cornerRadius = 8; // this value vary as per your desire
    Registerlinkedinbutt.clipsToBounds = YES;
    [RegistrationView addSubview:Registerlinkedinbutt];
    
    
    UIView *google=[[UIView alloc]initWithFrame:CGRectMake(Registerlinkedinbutt.frame.origin.x+Registerlinkedinbutt.frame.size.width+6, 15, RegistrationView.frame.size.width/3-8, 50)];
    google.backgroundColor=[UIColor lightGrayColor];
    google.layer.cornerRadius = 8; // this value vary as per your desire
    google.clipsToBounds = YES;
    [RegistrationView addSubview:google];
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(google.frame.size.width/2-20, google.frame.size.height/2-20, 40, 40)];
    image.image=[UIImage imageNamed:@"appbg.png"];
    [google addSubview:image];
    
    
    
    UIButton *RegisterGooglebutt=[[UIButton alloc]initWithFrame:CGRectMake(Registerlinkedinbutt.frame.origin.x+Registerlinkedinbutt.frame.size.width+6, 15, RegistrationView.frame.size.width/3-8, 50)];
    //  [RegisterGooglebutt setTitle:@"Connect With Google" forState:UIControlStateNormal];
    RegisterGooglebutt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    RegisterGooglebutt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [RegisterGooglebutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    RegisterGooglebutt.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [RegisterGooglebutt addTarget:self action:@selector(loginWithGMClick:) forControlEvents:UIControlEventTouchUpInside];
    RegisterGooglebutt.backgroundColor=[UIColor clearColor];
    [RegistrationView addSubview:RegisterGooglebutt];

    
    
    
//    signInButton=[[GIDSignInButton alloc]initWithFrame:CGRectMake(Registerlinkedinbutt.frame.origin.x+Registerlinkedinbutt.frame.size.width+6, 15, RegistrationView.frame.size.width/3-10, 50)];
//  //  [RegisterGooglebutt setTitle:@"Connect With Google" forState:UIControlStateNormal];
////    signInButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
////    signInButton.titleLabel.textAlignment = NSTextAlignmentCenter;
////    [signInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
////    signInButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
// //   [signInButton addTarget:self action:@selector(RegisterGoogleButtClicked:) forControlEvents:UIControlEventTouchUpInside];
// //  [signInButton addTarget:self action:@selector(loginWithGMClick:) forControlEvents:UIControlEventTouchUpInside];
//    [signInButton setStyle:kGIDSignInButtonStyleStandard];
//   // [signInButton setColorScheme:kGIDSignInButtonColorSchemeDark];
//    signInButton.backgroundColor=[UIColor clearColor];
//    [RegistrationView addSubview:signInButton];
    
    
    UILabel *Orlabel=[[UILabel alloc] initWithFrame:CGRectMake(RegistrationView.frame.size.width/2-15, RegisterFacebookbutt.frame.size.height+RegisterFacebookbutt.frame.origin.y+20,34, 34)];
    Orlabel.text=@"Or";
    Orlabel.textColor=[UIColor blackColor];
    Orlabel.font = [UIFont systemFontOfSize:15];
    Orlabel.textAlignment = NSTextAlignmentCenter;
    Orlabel.backgroundColor=[UIColor clearColor];
    Orlabel.layer.cornerRadius = 17;
    Orlabel.clipsToBounds = YES;
    Orlabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    Orlabel.layer.borderWidth = 2.0f;
    [RegistrationView addSubview:Orlabel];
    
    
    
    
    txtFirstName=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, Orlabel.frame.size.height+Orlabel.frame.origin.y+15, RegistrationView.frame.size.width-20, 40)];
    NSAttributedString *str4 = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtFirstName.attributedPlaceholder = str4;
    txtFirstName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtFirstName.textColor=[UIColor blackColor];
    txtFirstName.font = [UIFont systemFontOfSize:15];
    txtFirstName.backgroundColor=[UIColor clearColor];
    txtFirstName.delegate=self;
    txtFirstName.returnKeyType = UIReturnKeyNext;
    [RegistrationView addSubview:txtFirstName];
    
    FirstNameUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtFirstName.frame.size.height+txtFirstName.frame.origin.y+1, RegistrationView.frame.size.width-20, 2)];
    FirstNameUnderlabel.backgroundColor=[UIColor lightGrayColor];
    FirstNameUnderlabel.hidden=YES;
    [RegistrationView addSubview:FirstNameUnderlabel];
    
    
    
    txtLastName=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(txtFirstName.frame.size.width+txtFirstName.frame.origin.x+10, Orlabel.frame.size.height+Orlabel.frame.origin.y+15, RegistrationView.frame.size.width/2-15, 40)];
    NSAttributedString *str5 = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtLastName.attributedPlaceholder = str5;
    txtLastName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtLastName.textColor=[UIColor blackColor];
    txtLastName.font = [UIFont systemFontOfSize:15];
    txtLastName.backgroundColor=[UIColor clearColor];
    txtLastName.delegate=self;
    txtLastName.returnKeyType = UIReturnKeyNext;
    txtLastName.hidden=YES;
    [RegistrationView addSubview:txtLastName];
    
    LastNameUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtLastName.frame.size.height+txtLastName.frame.origin.y+1, RegistrationView.frame.size.width-20, 2)];
    LastNameUnderlabel.backgroundColor=[UIColor lightGrayColor];
    LastNameUnderlabel.hidden=YES;
    [RegistrationView addSubview:LastNameUnderlabel];
    

    
    
    txtRegEmail=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, txtFirstName.frame.size.height+txtFirstName.frame.origin.y+15, RegistrationView.frame.size.width-20, 40)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Email ID" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtRegEmail.attributedPlaceholder = str;
    txtRegEmail.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtRegEmail.textColor=[UIColor blackColor];
    txtRegEmail.font = [UIFont systemFontOfSize:15];
    txtRegEmail.backgroundColor=[UIColor clearColor];
    txtRegEmail.delegate=self;
    [txtRegEmail setKeyboardType:UIKeyboardTypeEmailAddress];
    txtRegEmail.returnKeyType = UIReturnKeyNext;
    [RegistrationView addSubview:txtRegEmail];
    
    RegEmailUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtRegEmail.frame.size.height+txtRegEmail.frame.origin.y+1, RegistrationView.frame.size.width-20, 2)];
    RegEmailUnderlabel.backgroundColor=[UIColor lightGrayColor];
    RegEmailUnderlabel.hidden=YES;
    [RegistrationView addSubview:RegEmailUnderlabel];

    
    
    txtConformRegEmail=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, RegEmailUnderlabel.frame.size.height+RegEmailUnderlabel.frame.origin.y+15, RegistrationView.frame.size.width-20, 40)];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Confirm Email ID" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtConformRegEmail.attributedPlaceholder = str1;
    txtConformRegEmail.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtConformRegEmail.textColor=[UIColor blackColor];
    txtConformRegEmail.font = [UIFont systemFontOfSize:15];
    txtConformRegEmail.backgroundColor=[UIColor clearColor];
    txtConformRegEmail.delegate=self;
    [txtConformRegEmail setKeyboardType:UIKeyboardTypeEmailAddress];
    txtConformRegEmail.returnKeyType = UIReturnKeyNext;
    txtConformRegEmail.hidden=YES;
    [RegistrationView addSubview:txtConformRegEmail];
    
    ConformRegEmailUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtConformRegEmail.frame.size.height+txtConformRegEmail.frame.origin.y+1, RegistrationView.frame.size.width-20, 2)];
    ConformRegEmailUnderlabel.backgroundColor=[UIColor lightGrayColor];
    ConformRegEmailUnderlabel.hidden=YES;
    [RegistrationView addSubview:ConformRegEmailUnderlabel];
    
    
    
    txtRegPassword=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, txtRegEmail.frame.size.height+txtRegEmail.frame.origin.y+15, RegistrationView.frame.size.width-20, 40)];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtRegPassword.attributedPlaceholder = str2;
    txtRegPassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtRegPassword.textColor=[UIColor blackColor];
    txtRegPassword.font = [UIFont systemFontOfSize:15];
    txtRegPassword.backgroundColor=[UIColor clearColor];
    txtRegPassword.secureTextEntry=YES;
    txtRegPassword.delegate=self;
    txtRegPassword.returnKeyType = UIReturnKeyNext;
    [RegistrationView addSubview:txtRegPassword];
    
    RegPasswordlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtRegPassword.frame.size.height+txtRegPassword.frame.origin.y+1, RegistrationView.frame.size.width-20, 2)];
    RegPasswordlabel.backgroundColor=[UIColor lightGrayColor];
    RegPasswordlabel.hidden=YES;
    [RegistrationView addSubview:RegPasswordlabel];
    
    
    
    txtConformRegPassword=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, RegPasswordlabel.frame.size.height+RegPasswordlabel.frame.origin.y+15, RegistrationView.frame.size.width-20, 40)];
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtConformRegPassword.attributedPlaceholder = str3;
    txtConformRegPassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtConformRegPassword.textColor=[UIColor blackColor];
    txtConformRegPassword.font = [UIFont systemFontOfSize:15];
    txtConformRegPassword.backgroundColor=[UIColor clearColor];
    txtConformRegPassword.secureTextEntry=YES;
    txtConformRegPassword.delegate=self;
    txtConformRegPassword.returnKeyType = UIReturnKeyNext;
    [RegistrationView addSubview:txtConformRegPassword];
    
    ConformRegPasswordlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtConformRegPassword.frame.size.height+txtConformRegPassword.frame.origin.y+1, RegistrationView.frame.size.width-20, 2)];
    ConformRegPasswordlabel.backgroundColor=[UIColor lightGrayColor];
    ConformRegPasswordlabel.hidden=YES;
    [RegistrationView addSubview:ConformRegPasswordlabel];
    
    
    
    
    
    txtGender=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, ConformRegPasswordlabel.frame.size.height+ConformRegPasswordlabel.frame.origin.y+15, RegistrationView.frame.size.width-20, 40)];
    NSAttributedString *str6 = [[NSAttributedString alloc] initWithString:@"Select Gender" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtGender.attributedPlaceholder = str6;
    txtGender.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtGender.textColor=[UIColor blackColor];
    txtGender.font = [UIFont systemFontOfSize:15];
    txtGender.backgroundColor=[UIColor clearColor];
    txtGender.hidden=YES;
    [RegistrationView addSubview:txtGender];
    
    GenderButt=[[UIButton alloc]initWithFrame:CGRectMake(10, ConformRegPasswordlabel.frame.size.height+ConformRegPasswordlabel.frame.origin.y+15, RegistrationView.frame.size.width-20, 40)];
    [GenderButt addTarget:self action:@selector(GenderbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    GenderButt.backgroundColor=[UIColor clearColor];
    GenderButt.hidden=YES;
    [RegistrationView addSubview:GenderButt];
    
    GenderUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, GenderButt.frame.size.height+GenderButt.frame.origin.y+1, RegistrationView.frame.size.width-20, 2)];
    GenderUnderlabel.backgroundColor=[UIColor lightGrayColor];
    GenderUnderlabel.hidden=YES;
    [RegistrationView addSubview:GenderUnderlabel];
    
    
    
    
    txtDob=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, GenderUnderlabel.frame.size.height+GenderUnderlabel.frame.origin.y+15, RegistrationView.frame.size.width-20, 40)];
    NSAttributedString *str7 = [[NSAttributedString alloc] initWithString:@"DOB" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtDob.attributedPlaceholder = str7;
    txtDob.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtDob.textColor=[UIColor blackColor];
    txtDob.font = [UIFont systemFontOfSize:15];
    txtDob.backgroundColor=[UIColor clearColor];
    txtDob.hidden=YES;
    [RegistrationView addSubview:txtDob];
    
    DobButt=[[UIButton alloc]initWithFrame:CGRectMake(10, GenderUnderlabel.frame.size.height+GenderUnderlabel.frame.origin.y+15, RegistrationView.frame.size.width-20, 40)];
    [DobButt addTarget:self action:@selector(DobbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    DobButt.backgroundColor=[UIColor clearColor];
    DobButt.hidden=YES;
    [RegistrationView addSubview:DobButt];
    
    DobUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtDob.frame.size.height+txtDob.frame.origin.y+1, RegistrationView.frame.size.width-20, 2)];
    DobUnderlabel.backgroundColor=[UIColor lightGrayColor];
    DobUnderlabel.hidden=YES;
    [RegistrationView addSubview:DobUnderlabel];
    
    
    
    pluslabel=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, txtConformRegPassword.frame.size.height+txtConformRegPassword.frame.origin.y+15, 10, 40)];
    NSAttributedString *str18 = [[NSAttributedString alloc] initWithString:@"" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtCountryCode.attributedPlaceholder = str18;
    pluslabel.text=@"+";
    pluslabel.textColor=[UIColor blackColor];
    pluslabel.userInteractionEnabled=NO;
    pluslabel.backgroundColor=[UIColor clearColor];
    [RegistrationView addSubview:pluslabel];
    
    txtCountryCode=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(20, txtConformRegPassword.frame.size.height+txtConformRegPassword.frame.origin.y+15,55, 40)];
    NSAttributedString *str8 = [[NSAttributedString alloc] initWithString:@"CCode" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtCountryCode.attributedPlaceholder = str8;
    txtCountryCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtCountryCode.textColor=[UIColor blackColor];
    txtCountryCode.font = [UIFont systemFontOfSize:15];
    txtCountryCode.backgroundColor=[UIColor clearColor];
    txtCountryCode.delegate=self;
    [txtCountryCode setKeyboardType:UIKeyboardTypeNumberPad];
    txtCountryCode.returnKeyType = UIReturnKeyNext;
    [RegistrationView addSubview:txtCountryCode];
    
    DobButt=[[UIButton alloc]initWithFrame:CGRectMake(20, txtConformRegPassword.frame.size.height+txtConformRegPassword.frame.origin.y+15,55, 40)];
    [DobButt addTarget:self action:@selector(DobbuttClicked2:) forControlEvents:UIControlEventTouchUpInside];
    DobButt.backgroundColor=[UIColor clearColor];
    [RegistrationView addSubview:DobButt];
    
    
    txtMobileNumber=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(85, txtConformRegPassword.frame.size.height+txtConformRegPassword.frame.origin.y+15, RegistrationView.frame.size.width-97, 40)];
    NSAttributedString *str9 = [[NSAttributedString alloc] initWithString:@"Mobile Number" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtMobileNumber.attributedPlaceholder = str9;
    txtMobileNumber.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtMobileNumber.textColor=[UIColor blackColor];
    txtMobileNumber.font = [UIFont systemFontOfSize:15];
    txtMobileNumber.backgroundColor=[UIColor clearColor];
    txtMobileNumber.delegate=self;
    [txtMobileNumber setKeyboardType:UIKeyboardTypeNumberPad];
    txtMobileNumber.returnKeyType = UIReturnKeyNext;
    [RegistrationView addSubview:txtMobileNumber];
    
    MobileUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtMobileNumber.frame.size.height+txtMobileNumber.frame.origin.y+1, 65, 2)];
    MobileUnderlabel.backgroundColor=[UIColor lightGrayColor];
    MobileUnderlabel.hidden=YES;
    [RegistrationView addSubview:MobileUnderlabel];
    
    MobileUnderlabel2=[[UILabel alloc] initWithFrame:CGRectMake(10, txtMobileNumber.frame.size.height+txtMobileNumber.frame.origin.y+1, RegistrationView.frame.size.width-20, 2)];
    MobileUnderlabel2.backgroundColor=[UIColor lightGrayColor];
    MobileUnderlabel2.hidden=YES;
    [RegistrationView addSubview:MobileUnderlabel2];

    
    
    txtPassportNumber=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, MobileUnderlabel.frame.size.height+MobileUnderlabel.frame.origin.y+15, RegistrationView.frame.size.width-20, 40)];
    NSAttributedString *str10 = [[NSAttributedString alloc] initWithString:@"Passport Number" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtPassportNumber.attributedPlaceholder = str10;
    txtPassportNumber.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtPassportNumber.textColor=[UIColor blackColor];
    txtPassportNumber.font = [UIFont systemFontOfSize:15];
    txtPassportNumber.backgroundColor=[UIColor clearColor];
    txtPassportNumber.delegate=self;
    txtPassportNumber.returnKeyType = UIReturnKeyDone;
    txtPassword.hidden=YES;
    [RegistrationView addSubview:txtPassportNumber];
    
    PassportUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtPassportNumber.frame.size.height+txtPassportNumber.frame.origin.y+1, RegistrationView.frame.size.width-20, 2)];
    PassportUnderlabel.backgroundColor=[UIColor lightGrayColor];
    PassportUnderlabel.hidden=YES;
    [RegistrationView addSubview:PassportUnderlabel];
    
    
    
    UIButton *Registrationbutt=[[UIButton alloc]initWithFrame:CGRectMake(10, MobileUnderlabel2.frame.size.height+MobileUnderlabel2.frame.origin.y+30, RegistrationView.frame.size.width-20, 50)];
    [Registrationbutt setTitle:@"Register" forState:UIControlStateNormal];
    Registrationbutt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    Registrationbutt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [Registrationbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Registrationbutt.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [Registrationbutt addTarget:self action:@selector(RegistrationButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    Registrationbutt.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [RegistrationView addSubview:Registrationbutt];
    
    
    
    UIView *termsView=[[UIView alloc]initWithFrame:CGRectMake(2, Registrationbutt.frame.size.height+Registrationbutt.frame.origin.y+10, RegistrationView.frame.size.width-4, 30)];
    termsView.backgroundColor=[UIColor clearColor];
    [RegistrationView addSubview:termsView];
    
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
    
    txtCountryCode.inputAccessoryView = numberToolbar;
    txtMobileNumber.inputAccessoryView=numberToolbar;
    
    [self setupOutlets1];
}

-(void)doneWithNumberPad
{
    [txtCountryCode resignFirstResponder];
    [txtMobileNumber resignFirstResponder];
}


#pragma mark - Registration view Multiple Actions

-(IBAction)RegisterFacebookButtClicked:(id)sender
{
      [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email",@"public_profile",@"user_friends"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
            //self.lblReturn.text = [NSString stringWithFormat:@"FB: %@", error];
            NSLog(@"%@",error);
            [DejalBezelActivityView removeView];
            
        } else if (result.isCancelled) {
            // Handle cancellations
            NSLog(@"FB Cancelled");
            [DejalBezelActivityView removeView];
            
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if ([result.grantedPermissions containsObject:@"email"]) {
                // Do work
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields" : @"email,name,first_name,last_name,gender,birthday,picture.width(100).height(100)"}]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         NSLog(@"fetched user:%@", result);
                         
                         NSString *imageStringOfLoginUser = [[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
                         NSURL *url = [NSURL URLWithString:imageStringOfLoginUser];
                         NSLog(@"%@",url);
                         
                         [[NSUserDefaults standardUserDefaults]setObject:[result valueForKey:@"name"] forKey:@"name"];
                         [[NSUserDefaults standardUserDefaults]synchronize];
                         
                         [[NSUserDefaults standardUserDefaults]setObject:[result valueForKey:@"email"] forKey:@"email"];
                         [[NSUserDefaults standardUserDefaults]synchronize];
                         
                         [[NSUserDefaults standardUserDefaults]setObject:[result valueForKey:@"id"] forKey:@"ID"];
                         [[NSUserDefaults standardUserDefaults]synchronize];
                         
                          [DejalBezelActivityView removeView];
                         SocialRegistrationViewController *social=[self.storyboard instantiateViewControllerWithIdentifier:@"SocialRegistrationViewController"];
                         social.strUrl=url;
                         social.strTitle=@"Registration With Facebook";
                         social.strName=[result valueForKey:@"name"];
                         social.strEmail=[result valueForKey:@"email"];
                         social.hidesBottomBarWhenPushed=YES;
                         [self.navigationController pushViewController:social animated:YES];
                     }
                 }];
                
            }
        }
        
    }];
}

-(IBAction)RegisterLinkedinButtClicked:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
   [self getProfileDetailsFromLinkedIn1];
}


-(void)getProfileDetailsFromLinkedIn1
{
    linkedInLoginView=[[OAuthLoginView alloc] init];
    linkedInLoginView.view.frame=CGRectMake(10, 10, self.view.frame.size.width-20, self.view.frame.size.height-20);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailsOfProfile1:) name:@"loginViewDidFinish" object:nil];
    [self presentViewController:linkedInLoginView animated:YES completion:nil];
}


-(void)showDetailsOfProfile1:(NSNotification *)notification{
    
    NSDictionary *jsonResponse = notification.userInfo;
    
    NSLog(@"notification user : %@", notification.userInfo);
    
    _id=[jsonResponse objectForKey:@"id"];
    profileUrl=[jsonResponse objectForKey:@"publicProfileUrl"];
    email=[jsonResponse objectForKey:@"emailAddress"];
    industry=[jsonResponse objectForKey:@"industry"];
    name=[jsonResponse objectForKey:@"formattedName"];
    pictureUrl=[jsonResponse objectForKey:@"pictureUrl"];
    
    NSLog(@"id: %@",_id);
    NSLog(@"ProfileUrl: %@",profileUrl);
    NSLog(@"email: %@",email);
    NSLog(@"Industry: %@",industry);
    NSLog(@"name: %@",name);
    NSLog(@"Picture Url: %@",pictureUrl);
    
    
    
    
    if (email == nil)
    {
        [DejalBezelActivityView removeView];
        NSLog(@"null Responsse");
    }
    else
    {
        
        [DejalBezelActivityView removeView];
        NSLog(@"Full Response");
        SocialRegistrationViewController *social=[self.storyboard instantiateViewControllerWithIdentifier:@"SocialRegistrationViewController"];
        social.strTitle=@"Registration With LinkedIn";
        NSURL *urllink=[jsonResponse objectForKey:@"pictureUrl"];
        social.strUrl=urllink;
        social.strName=name;
        social.strEmail=email;
        social.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:social animated:YES];
    }
}

-(void)responseSubCategory4:(NSMutableDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    [DejalBezelActivityView removeView];
    NSLog(@"Full Response");
    SocialRegistrationViewController *social=[self.storyboard instantiateViewControllerWithIdentifier:@"SocialRegistrationViewController"];
    social.strTitle=@"Registration With LinkedIn";
    social.strName=name;
    social.strEmail=email;
    [self.navigationController pushViewController:social animated:YES];

}


-(IBAction)RegisterGoogleButtClicked:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    
     [[GIDSignIn sharedInstance] signIn];
    
//   [[self navigationController] setNavigationBarHidden:NO animated:YES];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0]];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
//    GTMOAuth2ViewControllerTouch *authController;
//    authController = [[GTMOAuth2ViewControllerTouch alloc]
//                      initWithScope:@"https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/plus.me"
//                      clientID:kClientId
//                      clientSecret:kClientSecret
//                      keychainItemName:[GPPSignIn sharedInstance].keychainName
//                      delegate:self
//                      finishedSelector:@selector(viewController:finishedWithAuth:error:)];
//    [[self navigationController] pushViewController:authController animated:YES];
    
}

//- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error{
//    if (error != nil) {
//        // Authentication failed
//         [DejalBezelActivityView removeView];
//        NSLog(@"Authentication Error %@", error.localizedDescription);
//        self.auth=nil;
//        return;
//    }
//    else
//    {
//        self.auth = auth;
//        [self finishedWithAuth:auth error:error];
//    }
//    
//}
//- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth
//                   error:(NSError *)error
//{
//    if (error) {
//        // Do some error handling here.
//         [DejalBezelActivityView removeView];
//    } else {
//        [self refreshInterfaceBasedOnSignIn];
//    }
//}
//-(void)refreshInterfaceBasedOnSignIn{
//    // The user is signed in.
//    // NSLog(@"user email - %@",[GPPSignIn sharedInstance].authentication.userEmail);
//    GTLServicePlus* plusService = [[GTLServicePlus alloc] init] ;
//    plusService.retryEnabled = YES;
//    // 2. Set a valid |GTMOAuth2Authentication| object as the authorizer.
//    [plusService setAuthorizer:self.auth];
//    
//    GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
//    
//    [plusService executeQuery:query
//            completionHandler:^(GTLServiceTicket *ticket,
//                                GTLPlusPerson *person,
//                                NSError *error) {
//                if (error)
//                {
//                     [DejalBezelActivityView removeView];
//                }
//                else
//                {
//                    NSLog(@" person%@",person);
//                    
//                    [[self navigationController] setNavigationBarHidden:YES animated:YES];
//                    [self performLoginWIthGoogle:person];
//                    
//                }
//            }];
//    
//    // Perform other actions here, such as showing a sign-out button
//    
//}
//-(void)performLoginWIthGoogle:(GTLPlusPerson *)me
//{
//    
//    email = self.auth.userEmail;
//    NSString *userid = me.identifier;
//    NSString *firstname = me.name.givenName;
//    NSString *lastname = me.name.familyName;
//    NSString *fullname = [firstname stringByAppendingString:lastname];
//    
//    NSLog(@"\n%@\n%@\n%@\n%@\n%@",email,userid,firstname,lastname,fullname);
//    
//    
//    if (G==1)
//    {
//        NSString *post = [NSString stringWithFormat:@"user=%@&login_with=%@",email,@"social"];
//        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
//        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
//        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,userlogin,english,strCityId];
//        [request loginRequest:post withUrl:strurl];
//    }
//    else
//    {
//        
////        NSString *strurl=[NSString stringWithFormat:@"https://www.googleapis.com/plus/v1/people/%@?fields=image&key=%@",userid,@"AIzaSyA1iYRmlwYPMgyT1FWVwLgJU69xQco7b8U"];
////        NSMutableURLRequest *requeste = [[NSMutableURLRequest alloc] init];
////        [requeste setURL:[NSURL URLWithString:strurl]];
////        [requeste setHTTPMethod:@"GET"];
////        [requeste addValue:@"json" forHTTPHeaderField:@"Accept"];
////        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
////        [[session dataTaskWithRequest:requeste completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
////            dispatch_async (dispatch_get_main_queue(), ^{
////                
////                if (error)
////                {
////                    
////                } else
////                {
////                    if(data != nil) {
////                        NSError *err;
////                        NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
////                        NSLog(@"%@",responseJSON);
////                        [DejalBezelActivityView removeView];
////                    }
////                }
////            });
////        }] resume];
//        
//        [DejalBezelActivityView removeView];
//        SocialRegistrationViewController *social=[self.storyboard instantiateViewControllerWithIdentifier:@"SocialRegistrationViewController"];
//        social.strTitle=@"Registration With Google";
//        social.strName=fullname;
//        social.hidesBottomBarWhenPushed=YES;
//        social.strEmail=email;
//        [self.navigationController pushViewController:social animated:YES];
//    }
//    
//    
// //   [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
//}
//

//

#pragma mark - GIDSignInDelegate


//- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error
//{
//    
//}
//
//- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController
//{
//    [self presentViewController:viewController animated:YES completion:nil];
//}
//
//- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}


-(IBAction)loginWithGMClick:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    [[GIDSignIn sharedInstance] signIn];
}


- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)cc
     withError:(NSError *)error
{
    NSString *userId = cc.userID;                  // For client-side use only!
    
    NSString *idToken = cc.authentication.idToken; // Safe to send to the server
    
    NSString *fullName = cc.profile.name;
    
    NSString *givenName = cc.profile.givenName;
    
    NSString *familyName = cc.profile.familyName;
    
    email1 = cc.profile.email;
    
    
    NSLog(@"%@",userId);
    NSLog(@"%@",idToken);
    NSLog(@"%@",fullName);
    NSLog(@"%@",givenName);
    NSLog(@"%@",familyName);
    NSLog(@"%@",email1);
    
    
    NSString *gmailProfilePic;
    
    if ([GIDSignIn sharedInstance].currentUser.profile.hasImage)
        
    {
        
        NSUInteger dimension = round(79 * [[UIScreen mainScreen] scale]);
        
        imageURL = [cc.profile imageURLWithDimension:dimension];
        
        NSLog(@"Image Url : %@",imageURL);
        
        gmailProfilePic = [imageURL absoluteString];
        
    }
    
    
    if (G==1)
    {
        if (email1 == (id)[NSNull null] || email1.length == 0 )
        {
             [DejalBezelActivityView removeView];
        }
        else
        {
             [DejalBezelActivityView removeView];
            NSString *post = [NSString stringWithFormat:@"user=%@&login_with=%@",email1,@"social"];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,userlogin,english,strCityId];
            [request loginRequest:post withUrl:strurl];
        }
    }
    else
    {
        if (email1 == (id)[NSNull null] || email1.length == 0 )
        {
             [DejalBezelActivityView removeView];
        }
        else
        {
            [[GIDSignIn sharedInstance] signOut];
            
            [DejalBezelActivityView removeView];
            SocialRegistrationViewController *social=[self.storyboard instantiateViewControllerWithIdentifier:@"SocialRegistrationViewController"];
            social.strTitle=@"Registration With Google";
            social.strUrl=imageURL;
            social.strName=fullName;
            social.hidesBottomBarWhenPushed=YES;
            social.strEmail=email1;
            [self.navigationController pushViewController:social animated:YES];
        }
    }
}

//- (void)signIn:(GIDSignIn *)signIn
//
//didSignInForUser:(GIDGoogleUser *)user
//
//     withError:(NSError *)error {
//    
//    
//    
//    // Perform any operations on signed in user here.
//    
//    NSString *userId = user.userID;                  // For client-side use only!
//    
//    NSString *idToken = user.authentication.idToken; // Safe to send to the server
//    
//    NSString *fullName = user.profile.name;
//    
//    NSString *givenName = user.profile.givenName;
//    
//    NSString *familyName = user.profile.familyName;
//    
//    NSString *email = user.profile.email;
//    
//    
//    
//    if(email != nil && userId != nil)
//        
//    {
//        
//        NSDictionary *gmailDict = [[NSDictionary alloc]init];
//        
//        gmailDict = @{
//                      
//                      @"id" : userId,
//                      
//                      @"token" : idToken,
//                      
//                      @"name" : fullName,
//                      
//                      @"firstName" : givenName,
//                      
//                      @"lastName" : familyName,
//                      
//                      @"email" : email
//                      
//                      };
//        
//        
//        
//        NSString *gmailProfilePic;
//        
//        if ([GIDSignIn sharedInstance].currentUser.profile.hasImage)
//            
//        {
//            
//            NSUInteger dimension = round(79 * [[UIScreen mainScreen] scale]);
//            
//            NSURL *imageURL = [user.profile imageURLWithDimension:dimension];
//            
//            gmailProfilePic = [imageURL absoluteString];
//            
//        }
//    }


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

-(IBAction)DobbuttClicked:(id)sender
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
    txtDob.text=str;
}

-(IBAction)Doneclicked:(id)sender
{
    [datePicker removeFromSuperview];
    [footerview removeFromSuperview];
    popview.hidden = YES;
}




-(IBAction)RegistrationButtClicked:(id)sender
{
    [self.view endEditing:YES];
    
    if (txtRegEmail.text.length==0)
    {
        [request showMessage:@"Please Enter Your Email Id" withTitle:@"Warning"];
    }
    else if (![self NSStringIsValidEmail:txtRegEmail.text])
    {
        [request showMessage:@"Please Enter Valid Email Id" withTitle:@"Warning"];
    }
    else if (txtRegPassword.text.length==0)
    {
        [request showMessage:@"Please Enter Your Password" withTitle:@"Warning"];
    }
    else if (txtConformRegPassword.text.length==0)
    {
        [request showMessage:@"Please Confirm Your Password" withTitle:@"Warning"];
    }
    else if (![txtRegPassword.text isEqualToString:txtConformRegPassword.text])
    {
        [request showMessage:@"Confirm Password is not matching" withTitle:@"Warning"];
    }
    else if (txtCountryCode.text.length==0)
    {
        [request showMessage:@"Please Enter Your Country Code" withTitle:@"Warning"];
    }
    else if (txtMobileNumber.text.length==0)
    {
        [request showMessage:@"Please Enter Your Mobile Number" withTitle:@"Warning"];
    }
    else
    {
        NSString *string = txtRegEmail.text;
        NSString *string1 = txtConformRegEmail.text;
        string = [string stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
        string1 = [string1 stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceCharacterSet]];
        txtRegEmail.text=string;
        txtConformRegEmail.text=string1;
        
        NSString *strCountryCode=[NSString stringWithFormat:@"+%@",txtCountryCode.text];
        
        strCountryCode = [strCountryCode stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *post = [NSString stringWithFormat:@"firstname=%@&password=%@&emailid=%@&mobile=%@&reg_with=%@&gender=%@&country_code=%@",txtFirstName.text,txtRegPassword.text,txtRegEmail.text,txtMobileNumber.text,@"form",strgender,strCountryCode];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,userRegister,english,strCityId];
        [request RegistrationRequest:post withUrl:strurl];
    }
}


-(void)responseRegistration:(NSMutableDictionary *)responseToken
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
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [butt addTarget:self action:@selector(CancelButtClicked1:) forControlEvents:UIControlEventTouchUpInside];
    butt.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width+butt.frame.origin.x+6, forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35, footerview.frame.size.width/3-8, 40)];
    [butt1 setTitle:@"Done" forState:UIControlStateNormal];
    butt1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [butt1 addTarget:self action:@selector(DoneButtClicked1:) forControlEvents:UIControlEventTouchUpInside];
    butt1.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [footerview addSubview:butt1];
    
    
    UIButton *butt2=[[UIButton alloc]initWithFrame:CGRectMake(butt1.frame.size.width+butt1.frame.origin.x+6, forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35, footerview.frame.size.width/3-8, 40)];
    [butt2 setTitle:@"Re-Send" forState:UIControlStateNormal];
    butt2.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt2.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt2.titleLabel.font = [UIFont boldSystemFontOfSize:18];
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
        [self.navigationController popViewControllerAnimated:YES];
        
        [request showMessage:@"OTP has been Successfully Verified" withTitle:@"Message"];
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



-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"userid"];
    if(object != nil)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
       
    }

}



//-(void)viewDidAppear:(BOOL)animated
//{
//    
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    NSObject * object = [prefs objectForKey:@"countryCode"];
//    if(object != nil)
//    {
//        
//    }
//    else
//    {
//        
//        ceo= [[CLGeocoder alloc]init];
//        [locationManager requestWhenInUseAuthorization];
//        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//            [locationManager requestWhenInUseAuthorization];
//        }
//        CLLocationCoordinate2D coordinate;
//        
//        coordinate.latitude=locationManager.location.coordinate.latitude;
//        coordinate.longitude=locationManager.location.coordinate.longitude;
//        
//        CLLocation *loc = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude
//                           ];
//        [ceo reverseGeocodeLocation:loc
//                  completionHandler:^(NSArray *placemarks, NSError *error) {
//                      CLPlacemark *placemark = [placemarks objectAtIndex:0];
//                      NSLog(@"placemark %@",placemark);
//                      //String to hold address
//                      NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
//                      NSLog(@"addressDictionary %@", placemark.addressDictionary);
//                      
//                      NSLog(@"placemark %@",placemark.region);
//                      NSLog(@"placemark %@",placemark.country);  // Give Country Name
//                      NSLog(@"placemark %@",placemark.locality); // Extract the city name
//                      NSLog(@"location %@",placemark.name);
//                      NSLog(@"location %@",placemark.ocean);
//                      NSLog(@"location %@",placemark.postalCode);
//                      NSLog(@"location %@",placemark.subLocality);
//                      NSLog(@"location %@",placemark.ISOcountryCode);
//                      
//                      NSLog(@"location %@",placemark.location);
//                      //Print the location to console
//                      NSLog(@"I am currently at %@",locatedAt);
//                      NSString *strcountrycode2=[NSString stringWithFormat:@"%@",placemark.ISOcountryCode];
//                      
//                      [[NSUserDefaults standardUserDefaults]setObject:strcountrycode2 forKey:@"countryCode"];
//                      [[NSUserDefaults standardUserDefaults]synchronize];
//                      
//                      [self.diallingCode getDiallingCodeForCountry:placemark.ISOcountryCode];
//                      
//                      //   _City.text=[placemark.addressDictionary objectForKey:@"City"];
//                      [locationManager stopUpdatingLocation];
//                  }
//         
//         ];
//        
//        
//    }
//    
//}
//


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
