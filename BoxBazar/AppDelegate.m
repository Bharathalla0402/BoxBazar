//
//  AppDelegate.m
//  BoxBazar
//
//  Created by bharat on 20/07/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "ApiRequest.h"
#import "BoxBazarUrl.pch"
#import "DejalActivityView.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import <GoogleMaps/GoogleMaps.h>
@import GoogleMaps;

@interface AppDelegate ()<ApiRequestdelegate,GIDSignInDelegate,CLLocationManagerDelegate>
{
    ApiRequest *requested;
    UITabBarController *tabBarController;
}

@end

@implementation AppDelegate

static NSString * const kClientID =
@"433510102849-5tjlm21pfktshq1mkap42idk18690jcs.apps.googleusercontent.com";


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"image"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Makeids"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Modelids"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"indexcheck"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"kk"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    [self CurrentLocationIdentifier];
    
    [GIDSignIn sharedInstance].delegate = self ;
    [GIDSignIn sharedInstance].clientID = kClientID;
    
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0]];
        
        application.statusBarHidden=NO;
        [GMSServices provideAPIKey:@"AIzaSyAdGRX5tONL2jVRCHDuNv5BZjuW-vLMwF4"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pathid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"first"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pathid1"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
        
        [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
        {
            //        NSString *post = [NSString stringWithFormat:@"user=%@&password=%@",@"rajinder",@"123456"];
            //        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,@"123456",user,english,@"1"];
            //        [requested sendRequest:post withUrl:strurl];
            
            self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"english"];
            [self.window makeKeyAndVisible];
        }
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
        {
            //        NSString *post = [NSString stringWithFormat:@"user=%@&password=%@",@"rajinder",@"123456"];
            //        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,@"123456",user,arabic,@"1"];
            //        [requested sendRequest:post withUrl:strurl];
            
            self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainArabic" bundle:nil];
            UITabBarController *tbc = [storyboard instantiateViewControllerWithIdentifier:@"arabic"];
            self.window.rootViewController = tbc;
            tbc.selectedIndex=4;
            [self.window makeKeyAndVisible];
        }
        else
        {
            //        NSString *post = [NSString stringWithFormat:@"user=%@&password=%@",@"rajinder",@"123456"];
            //        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,@"123456",user,english,@"1"];
            //        [requested sendRequest:post withUrl:strurl];
            
            self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"english"];
            [self.window makeKeyAndVisible];
        }
    return YES;
}

-(void)CurrentLocationIdentifier
{
    //---- For getting current gps location
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locationManager requestWhenInUseAuthorization];
    }
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
//             NSLog(@"\nCurrent Location Detected\n");
//             NSLog(@"placemark %@",placemark);
//             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
//             NSString *Address = [[NSString alloc]initWithString:locatedAt];
//             NSString *Area = [[NSString alloc]initWithString:placemark.locality];
//             NSString *Country = [[NSString alloc]initWithString:placemark.country];
//             NSString *CountryArea = [NSString stringWithFormat:@"%@, %@", Area,Country];
             NSString *strcountrycode2=[NSString stringWithFormat:@"%@",placemark.ISOcountryCode];
            
             [[NSUserDefaults standardUserDefaults]setObject:strcountrycode2 forKey:@"countryCode"];
             [[NSUserDefaults standardUserDefaults]synchronize];
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


- (BOOL)application:(UIApplication *)app

            openURL:(NSURL *)url

            options:(NSDictionary *)options {
    
    [[FBSDKApplicationDelegate sharedInstance] application:app
                                                   openURL:url
                                         sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];

    
    return [[GIDSignIn sharedInstance] handleURL:url
            
                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
            
                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}


//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
//    return [[FBSDKApplicationDelegate sharedInstance] application:app
//                                                          openURL:url
//                                                sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                                       annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
//}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation
            ];
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)cc
     withError:(NSError *)error
{
}

-(void)responsewithToken:(NSMutableDictionary *)responseToken
{
    NSString *stringtoken=[[responseToken valueForKey:@"data"] valueForKey:@"token"];
    NSLog(@"Token: %@",stringtoken);
    [[NSUserDefaults standardUserDefaults]setObject:stringtoken forKey:@"Token"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSLog(@"Token Response :%@",responseToken);
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strurl1=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,homeSlider,english,@"1"];
        [requested HomeSliderRequest:nil withUrl:strurl1];
        
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,citylist,english,@"1"];
        [requested CitysRequest:nil withUrl:strurl];
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strurl1=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,homeSlider,arabic,@"1"];
        [requested HomeSliderRequest:nil withUrl:strurl1];
        
     
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,citylist,arabic,@"1"];
        [requested CitysRequest:nil withUrl:strurl];
    }
    else
    {
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strurl1=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,homeSlider,english,@"1"];
        [requested HomeSliderRequest:nil withUrl:strurl1];

        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,citylist,english,@"1"];
        [requested CitysRequest:nil withUrl:strurl];
    }
}

-(void)responsewithHomeSlider:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"Slider Response: %@",responseDictionary);
    
    NSArray *urls=[responseDictionary valueForKey:@"data"];
    
    NSLog(@"URL's%@",urls);
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:urls];
    
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"URL"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


-(void)responsewithCitylist:(NSMutableDictionary *)responseDict
{
    NSMutableDictionary *responseDictionary=[[NSMutableDictionary alloc]init];
    responseDictionary=responseDict;
    NSLog(@"City list Response: %@",responseDictionary);
    NSMutableArray *arrCitys=[[NSMutableArray alloc]init];
    arrCitys=[responseDict valueForKey:@"data"];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrCitys];
    
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"Citys"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//  //   [GPPURLHandler handleURL:url sourceApplication:sourceApplication annotation:annotation];
//    return [[FBSDKApplicationDelegate sharedInstance] application:application
//                                                          openURL:url
//                                                sourceApplication:sourceApplication
//                                                       annotation:annotation];
//
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//    [[NSUserDefaults standardUserDefaults] setObject:@"f1" forKey:@"first"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  //  [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"first"];
     [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
