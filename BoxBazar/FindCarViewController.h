//
//  FindCarViewController.h
//  BoxBazar
//
//  Created by bharat on 05/08/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindCarViewController : UIViewController
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
