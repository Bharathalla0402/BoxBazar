//
//  FindArabicViewController.h
//  BoxBazar
//
//  Created by bharat on 01/09/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindArabicViewController : UIViewController
{
    NSString *strminRange;
    NSString *strmaxrange;
    NSMutableArray *DataArray;
    NSString *strSubModuleId;
}
@property(nonatomic,retain) NSString *strtitle;
@property(nonatomic,retain) NSString *strimage;
@property(nonatomic,retain) NSString *strCarSubModule;

@end
