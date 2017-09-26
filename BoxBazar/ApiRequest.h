//
//  ApiRequest.h
//  BoxBazar
//
//  Created by bharat on 20/07/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ApiRequestdelegate;
@protocol ApiRequestdelegate <NSObject>
@optional

- (void)responsewithToken: (NSMutableDictionary *)responseToken;
- (void)responsewithToken1: (NSMutableDictionary *)responseToken;
- (void)responsewithToken2: (NSMutableDictionary *)responseToken;
- (void)responsewithToken3: (NSMutableDictionary *)responseToken;
- (void)responsewithToken4: (NSMutableDictionary *)responseToken;

- (void)PostAddResponse: (NSMutableDictionary *)responseDict;

- (void)responseRegistration: (NSMutableDictionary *)responseDict;
- (void)responseRegistrationotp: (NSMutableDictionary *)responseDict;
- (void)responseResendotp: (NSMutableDictionary *)responseDict;

- (void)responseLogin: (NSMutableDictionary *)responseDict;
- (void)responseForgetPassword: (NSMutableDictionary *)responseDict;

- (void)responsewithData: (NSMutableDictionary *)responseDict;
- (void)responsewithDataEng: (NSMutableDictionary *)responseDict;
- (void)responsewithDataMakeMotor: (NSMutableDictionary *)responseDict;
- (void)responsewithCitylist: (NSMutableDictionary *)responseDict;

- (void)responsewithHomeSlider: (NSMutableDictionary *)responseDict;

- (void)responsewithDeleteFile: (NSMutableDictionary *)responseDict;

- (void)responsewithlocalitylist: (NSMutableDictionary *)responseDict;

- (void)responseSubCategory: (NSMutableDictionary *)responseDict;
- (void)responseSubCategory2: (NSMutableDictionary *)responseDict;
- (void)responseSubCategory3: (NSMutableDictionary *)responseDict;
- (void)responseSubCategory4: (NSMutableDictionary *)responseDict;

- (void)responseSubCategory5: (NSMutableDictionary *)responseDict;
- (void)responseSubCategory6: (NSMutableDictionary *)responseDict;
- (void)responseSubCategory7: (NSMutableDictionary *)responseDict;
- (void)responseSubCategory8: (NSMutableDictionary *)responseDict;
- (void)responseSubCategory9: (NSMutableDictionary *)responseDict;

- (void)emptyresponseCategoryOption: (NSMutableDictionary *)responseDict;
- (void)responseCategoryOption: (NSMutableDictionary *)responseDict;
- (void)responseCategoryOption2: (NSMutableDictionary *)responseDict;
- (void)responseCategoryOption3: (NSMutableDictionary *)responseDict;
- (void)responseCategoryOption4: (NSMutableDictionary *)responseDict;

- (void)emptyresponseOption: (NSMutableDictionary *)responseDict;
- (void)responseOption: (NSMutableDictionary *)responseDict;
- (void)responseOption2: (NSMutableDictionary *)responseDict;
- (void)responseOption3: (NSMutableDictionary *)responseDict;
- (void)responseOption4: (NSMutableDictionary *)responseDict;

- (void)responseOption5: (NSMutableDictionary *)responseDict;
- (void)responseOption6: (NSMutableDictionary *)responseDict;
- (void)responseOption7: (NSMutableDictionary *)responseDict;
- (void)responseOption8: (NSMutableDictionary *)responseDict;
- (void)responseOption9: (NSMutableDictionary *)responseDict;

@end



@interface ApiRequest : NSObject

@property (nonatomic, assign) id <ApiRequestdelegate> delegate;
@property BOOL isInternetConnectionAvailable;

-(void)checkNetworkStatus;

-(void)showMessage:(NSString*)message withTitle:(NSString *)title;

-(void)sendRequest:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)sendRequest1:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)sendRequest2:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)sendRequest3:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)sendRequest4:(NSString*)parameters withUrl:(NSString *)strUrl;

-(void)PostAddRequest:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)RegistrationRequest:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)OtpVerifyRequest:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)ResendOtpRequest:(NSString*)parameters withUrl:(NSString *)strUrl;

-(void)loginRequest:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)forgotPasswordRequest:(NSString*)parameters withUrl:(NSString *)strUrl;

-(void)motorsRequest:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)motorsEngRequest:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)motorsMakeRequest:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)CitysRequest:(NSString*)parameters withUrl:(NSString *)strUrl;

-(void)HomeSliderRequest:(NSString*)parameters withUrl:(NSString *)strUrl;

-(void)DeleteFileRequest:(NSString*)parameters withUrl:(NSString *)strUrl;

-(void)LocalityRequest:(NSString*)parameters withUrl:(NSString *)strUrl;

-(void)SubCategoryRequest:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)SubCategoryRequest2:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)SubCategoryRequest3:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)SubCategoryRequest4:(NSString*)parameters withUrl:(NSString *)strUrl;

-(void)SubCategoryRequest5:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)SubCategoryRequest6:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)SubCategoryRequest7:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)SubCategoryRequest8:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)SubCategoryRequest9:(NSString*)parameters withUrl:(NSString *)strUrl;

-(void)emptyCategoryOptionRequest:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)CategoryOptionRequest:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)CategoryOptionRequest2:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)CategoryOptionRequest3:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)CategoryOptionRequest4:(NSString*)parameters withUrl:(NSString *)strUrl;


-(void)emptyOptionRequest:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)OptionRequest:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)OptionRequest2:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)OptionRequest3:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)OptionRequest4:(NSString*)parameters withUrl:(NSString *)strUrl;

-(void)OptionRequest5:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)OptionRequest6:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)OptionRequest7:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)OptionRequest8:(NSString*)parameters withUrl:(NSString *)strUrl;
-(void)OptionRequest9:(NSString*)parameters withUrl:(NSString *)strUrl;

@end
