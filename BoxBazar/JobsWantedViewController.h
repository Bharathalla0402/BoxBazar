//
//  JobsWantedViewController.h
//  BoxBazar
//
//  Created by bharat on 29/11/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobsWantedViewController : UIViewController
{
    NSString *isInternetConnectionAvailable;
}

@property(nonatomic,retain) NSString *strtitle;
@property(nonatomic,retain) NSString *strModule;
@property(nonatomic,retain) NSMutableArray *arrChildCategory;
@end
