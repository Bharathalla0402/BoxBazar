//
//  ApiRequest.m
//  BoxBazar
//
//  Created by bharat on 20/07/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "ApiRequest.h"
#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "DejalActivityView.h"
#import "BoxBazarUrl.pch"

@implementation ApiRequest

#pragma mark -- checkNetworkStatus

-(void)checkNetworkStatus
{
    Reachability* internetAvailable = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [internetAvailable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            _isInternetConnectionAvailable = NO;
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"internet"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            break;
        }
        case ReachableViaWiFi:
        {
            _isInternetConnectionAvailable = YES;
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"internet"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            break;
        }
        case ReachableViaWWAN:
        {
            _isInternetConnectionAvailable = YES;
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"internet"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            break;
        }
    }
}


#pragma mark -- UIAlertView Method

-(void)showMessage:(NSString*)message withTitle:(NSString *)title
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
    }]];
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
}


#pragma mark -- Web Services API Calling


-(void)sendRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSData *postData = [parameters dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                NSError *err;
                NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                [_delegate responsewithToken:responseJSON];
                [DejalBezelActivityView removeView];
            }
            
        });
    }] resume];
}


-(void)sendRequest1:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSData *postData = [parameters dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                NSError *err;
                NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                [_delegate responsewithToken1:responseJSON];
                [DejalBezelActivityView removeView];
            }
            
        });
    }] resume];
}


-(void)sendRequest2:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSData *postData = [parameters dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                NSError *err;
                NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                [_delegate responsewithToken2:responseJSON];
                [DejalBezelActivityView removeView];
            }
            
        });
    }] resume];
}


-(void)sendRequest3:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSData *postData = [parameters dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                NSError *err;
                NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                [_delegate responsewithToken3:responseJSON];
                [DejalBezelActivityView removeView];
            }
            
        });
    }] resume];
}


-(void)sendRequest4:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSData *postData = [parameters dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                NSError *err;
                NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                [_delegate responsewithToken4:responseJSON];
                [DejalBezelActivityView removeView];
            }
            
        });
    }] resume];
}


-(void)PostAddRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSData *postData = [parameters dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                NSError *err;
                NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                [_delegate PostAddResponse:responseJSON];
                [DejalBezelActivityView removeView];
            }
            
        });
    }] resume];
}


-(void)RegistrationRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSData *postData = [parameters dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                NSError *err;
                NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                [_delegate responseRegistration:responseJSON];
                [DejalBezelActivityView removeView];
            }
            
        });
    }] resume];
}

-(void)OtpVerifyRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseRegistrationotp:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}

-(void)ResendOtpRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseResendotp:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}


-(void)loginRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSData *postData = [parameters dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                NSError *err;
                NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                [_delegate responseLogin:responseJSON];
                [DejalBezelActivityView removeView];
            }
            
        });
    }] resume];
}

-(void)forgotPasswordRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseForgetPassword:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}



-(void)motorsRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responsewithData:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}


-(void)motorsEngRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responsewithDataEng:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}

-(void)motorsMakeRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responsewithDataMakeMotor:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}



-(void)CitysRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                NSError *err;
                NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                [_delegate responsewithCitylist:responseJSON];
                [DejalBezelActivityView removeView];
            }
            
        });
    }] resume];
}

-(void)HomeSliderRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responsewithHomeSlider:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}


-(void)DeleteFileRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSData *postData = [parameters dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                NSError *err;
                NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                [_delegate responsewithDeleteFile:responseJSON];
                [DejalBezelActivityView removeView];
            }
            
        });
    }] resume];
}

-(void)LocalityRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responsewithlocalitylist:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}



#pragma mark -- SubCategeory API Calling

-(void)SubCategoryRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseSubCategory:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}

-(void)SubCategoryRequest2:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseSubCategory2:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}
-(void)SubCategoryRequest3:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseSubCategory3:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}
-(void)SubCategoryRequest4:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseSubCategory4:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}



-(void)SubCategoryRequest5:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseSubCategory5:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}


-(void)SubCategoryRequest6:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseSubCategory6:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}


-(void)SubCategoryRequest7:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseSubCategory7:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}


-(void)SubCategoryRequest8:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseSubCategory8:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}


-(void)SubCategoryRequest9:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseSubCategory9:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}




#pragma mark -- Category Option API Calling

-(void)emptyCategoryOptionRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate emptyresponseCategoryOption:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}

-(void)CategoryOptionRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseCategoryOption:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}

-(void)CategoryOptionRequest2:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseCategoryOption2:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}

-(void)CategoryOptionRequest3:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseCategoryOption3:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}

-(void)CategoryOptionRequest4:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseCategoryOption4:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}




#pragma mark -- Option Request API Calling

-(void)emptyOptionRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate emptyresponseOption:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}


-(void)OptionRequest:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseOption:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}

-(void)OptionRequest2:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseOption2:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}

-(void)OptionRequest3:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseOption3:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}

-(void)OptionRequest4:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseOption4:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}


-(void)OptionRequest5:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseOption5:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}


-(void)OptionRequest6:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseOption6:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}


-(void)OptionRequest7:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseOption7:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}


-(void)OptionRequest8:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseOption8:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}


-(void)OptionRequest9:(NSString*)parameters withUrl:(NSString *)strUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *err;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                    [_delegate responseOption9:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];
}






@end
