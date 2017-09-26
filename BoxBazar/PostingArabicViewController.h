//
//  PostingArabicViewController.h
//  BoxBazar
//
//  Created by bharat on 30/08/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostingArabicViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,retain) NSString *strCategeory;
@property(nonatomic,retain) NSString *strcategeoryType;

@property(nonatomic,retain) NSString *strCategeoryid;
@property(nonatomic,retain) NSString *strCategeoryUrlparameter;

@property(nonatomic,retain) NSString *strcategeoryTypeid;
@property(nonatomic,retain) NSString *strcategeoryTypeisCatgory;
@property(nonatomic,retain) NSString *strcategeoryTypeurl_parameter;


@property (strong, nonatomic) UIAlertController *alertCtrl;
@property (strong, nonatomic) UIImagePickerController *imagePicker;

@end
