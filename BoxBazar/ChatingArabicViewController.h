//
//  ChatingArabicViewController.h
//  BoxBazar
//
//  Created by bharat on 22/12/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatingArabicViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSString *userid;
    NSString *driverid;
    
    NSMutableArray *tripdriverinfo;
    
    NSMutableArray *arrmessage;
    
    NSMutableArray *arrids;
    
    NSMutableArray *arrimage;
}

@property (weak, nonatomic) IBOutlet UIView *messageView;

@property (weak, nonatomic) IBOutlet UITextField *TextMessage;

@property (weak, nonatomic) IBOutlet UITableView *ChatTable;

@property(nonatomic,retain) NSString *strConversionId;
@property(nonatomic,retain) NSString *strPostUserId;

@end
