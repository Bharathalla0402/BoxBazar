//
//  JobslistArabicViewController.h
//  BoxBazar
//
//  Created by bharat on 15/12/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobslistArabicViewController : UIViewController
{
    NSString *isInternetConnectionAvailable;
}
@property(nonatomic,retain) NSString *strtitle;
@property(nonatomic,retain) NSString *strModule;
@property(nonatomic,retain) NSMutableArray *arrChildCategory;
@end
