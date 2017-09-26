//
//  SettingsViewController.h
//  BoxBazar
//
//  Created by bharat on 21/07/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UIAlertController *alertCtrl;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property(nonatomic,retain) NSString *struid;
@end
