//
//  PostingViewController.h
//  BoxBazar
//
//  Created by bharat on 09/08/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
@interface PostingViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,kDropDownListViewDelegate>
{
    NSArray *arryList;
    DropDownListView * Dropobj;
     UIButton *btnSelected;
    UILabel *btnSelecte;
    
    IBOutlet UIButton *coverphotobutt;
    
    float			latitude;
    float			longitude;
}

@property(nonatomic,retain) NSString *strCategeory;
@property(nonatomic,retain) NSString *strcategeoryType;

@property(nonatomic,retain) NSString *strCategeoryid;
@property(nonatomic,retain) NSString *strCategeoryUrlparameter;

@property(nonatomic,retain) NSString *strcategeoryTypeid;
@property(nonatomic,retain) NSString *strcategeoryTypeisCatgory;
@property(nonatomic,retain) NSString *strcategeoryTypeurl_parameter;

@property(nonatomic,retain) NSArray *arrChildCategory;
@property(nonatomic,retain) NSString *strmessage;

@property(nonatomic,retain) NSString *strCategoryIdForPost;

@property (strong, nonatomic) UIAlertController *alertCtrl;
@property (strong, nonatomic) UIImagePickerController *imagePicker;

@end
