//
//  JobFilterArabicViewController.h
//  BoxBazar
//
//  Created by bharat on 01/09/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobFilterArabicViewController : UIViewController
{
    NSMutableArray *listjobs;
    NSMutableArray *arrlistofjobs;
    IBOutlet UITableView *table;
    IBOutlet UITableView *tabl2;
    
    NSString *strminRange;
    NSString *strmaxrange;
    
    NSString *strminsalaryRange;
    NSString *strmaxsalaryrange;
    
    NSMutableArray *arrcategeoryfilterby;
    NSMutableArray *arrlocalities;
    NSMutableArray *arrroles;
    NSMutableArray *arreducation;
}
@property (weak, nonatomic) IBOutlet UISearchBar *CustomSearchbar;
@property (weak, nonatomic) IBOutlet UIButton *backbutt;
@property (weak, nonatomic) IBOutlet UIButton *crossbutt;
@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property(nonatomic,retain) NSString *strtitle;

@end
