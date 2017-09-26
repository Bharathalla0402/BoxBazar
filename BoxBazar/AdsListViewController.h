//
//  AdsListViewController.h
//  BoxBazar
//
//  Created by bharat on 22/11/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdsListViewController : UIViewController
{
    NSMutableArray *arrCarslist;
    NSString *imagena;
    
     int count,lastCount;
}
@property(nonatomic,retain) NSString *strtitle;
@property(nonatomic,retain) NSArray *arrChildCategory;
@property(nonatomic,retain) NSString *strpage;
@end
