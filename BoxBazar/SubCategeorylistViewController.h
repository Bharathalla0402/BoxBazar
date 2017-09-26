//
//  SubCategeorylistViewController.h
//  BoxBazar
//
//  Created by bharat on 20/10/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubCategeorylistViewController : UIViewController
{
      NSString *isInternetConnectionAvailable;
}
@property(nonatomic,retain) NSString *strtitle;
@property(nonatomic,retain) NSString *strModule;
@property(nonatomic,retain) NSArray *arrChildCategory;

@end
