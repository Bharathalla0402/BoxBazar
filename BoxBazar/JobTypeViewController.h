//
//  JobTypeViewController.h
//  BoxBazar
//
//  Created by bharat on 24/08/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobTypeViewController : UIViewController
{
    NSMutableArray *arrlistofjobs;
}
@property (weak, nonatomic) IBOutlet UIView *topview;

@property (weak, nonatomic) IBOutlet UISearchBar *CustomSearchbar;


@end
