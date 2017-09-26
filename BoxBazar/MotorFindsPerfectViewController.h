//
//  MotorFindsPerfectViewController.h
//  BoxBazar
//
//  Created by bharat on 04/08/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MotorFindsPerfectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *DataArray;
    NSMutableArray *imageArray;
    
    NSString *strtilelab;
    NSString *Strcarsubmodule;
    NSString *isInternetConnectionAvailable;
}
@property (weak, nonatomic) IBOutlet UIButton *backbutton;
@property (weak, nonatomic) IBOutlet UIButton *crossbutt;

@property (weak, nonatomic) IBOutlet UIView *citylistView;
@property (weak, nonatomic) IBOutlet UISearchBar *CustomSearchbar;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *dohaButt;
@end
