//
//  FavoritelistViewController.h
//  BoxBazar
//
//  Created by bharat on 21/11/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritelistViewController : UIViewController
{
    NSMutableArray *arrCarslist;
     NSString *imagena;
}
@property(nonatomic,retain) NSString *strtitle;
@property(nonatomic,retain) NSArray *arrChildCategory;
@property(nonatomic,retain) NSString *strpage;
@end
