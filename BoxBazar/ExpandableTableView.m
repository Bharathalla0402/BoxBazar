//
//  ExpandableTableView.m
//  ExpandableTableView
//
//  Created by Warif Akhand Rishi on 4/13/16.
//  Copyright © 2016 Warif Akhand Rishi. All rights reserved.
//

#import "ExpandableTableView.h"
#import "HeaderView.h"

@interface ExpandableTableView () <HeaderViewDelegate>


@property (nonatomic, strong) NSMutableDictionary *sectionStatusDic;

@end

@implementation ExpandableTableView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _sectionStatusDic = [[NSMutableDictionary alloc] init];
    self.initiallyExpandedSection = -1;
}

- (HeaderView *)headerView {
    
    HeaderView *headerView  = [self dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    
    if (!headerView) {
        CGRect frame = CGRectMake(10, 0, CGRectGetWidth(self.frame)-20, 60);
        headerView = [[HeaderView alloc] initWithReuseIdentifier:@"Header" andFrame:frame];
        headerView.delegate = self;
    }
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 59, CGRectGetWidth(self.frame), 1)];
    lab.backgroundColor=[UIColor lightGrayColor];
    [headerView addSubview:lab];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
    {
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-42,14,32,32)];
        image.image=[UIImage imageNamed:@"right.png"];
        [headerView addSubview:image];
        
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
    {
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(10,14,32,32)];
        image.image=[UIImage imageNamed:@"left.png"];
        [headerView addSubview:image];
    }
    else
    {
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-42,14,32,32)];
        image.image=[UIImage imageNamed:@"right.png"];
        [headerView addSubview:image];
    }
    
    
    return headerView;
}

- (BOOL)collapsedForSection:(NSInteger)section
{
    NSString *key = [NSString stringWithFormat:@"%ld", (long)section];

    if (self.sectionStatusDic[key]) {
        return ((NSNumber *)self.sectionStatusDic[key]).boolValue;
    }
    
    return (self.initiallyExpandedSection == section) ? NO : self.allHeadersInitiallyCollapsed;
}

- (NSInteger)totalNumberOfRows:(NSInteger)total inSection:(NSInteger)section; {
    
    return ([self collapsedForSection:section]) ? 0 : total;
}

- (UIView *)headerWithTitle:(NSString *)title totalRows:(NSInteger)row inSection:(NSInteger)section
{

    BOOL isCollapsed = [self collapsedForSection:section];
    
    HeaderView *headerView = self.headerView;
    [headerView updateWithTitle:title isCollapsed:isCollapsed totalRows:row andSection:section];
    
    return headerView;
}

#pragma mark - HeaderViewDelegate

- (void)didTapHeader:(HeaderView *)headerView
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"pathid"];
    if(object != nil)
    {
        NSString *keych = [NSString stringWithFormat:@"%ld", (long)headerView.section];
        NSString *key1=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"pathid"]];
        NSString *rowsp=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"pathid1"]];
        
        if ([keych isEqualToString:key1])
        {
            NSString *key = [NSString stringWithFormat:@"%ld", (long)headerView.section];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"pathid"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"pathid1"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            BOOL isCollapsed = [self collapsedForSection:headerView.section];
            isCollapsed = !isCollapsed;
            
            [self.sectionStatusDic setObject:@(isCollapsed) forKey:key];
            
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < headerView.totalRows; i++) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:headerView.section]];
            }
            
            [self beginUpdates];
            
            if (isCollapsed) {
                [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            } else {
                [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            }
            
            [self endUpdates];
        }
        else
        {
            
            
            
            NSInteger a=[key1 integerValue];
            BOOL isCollapsed1 = [self collapsedForSection:a];
            isCollapsed1 = !isCollapsed1;
            
            [self.sectionStatusDic setObject:@(isCollapsed1) forKey:key1];
            
            NSMutableArray *indexPaths1 = [[NSMutableArray alloc] init];
            
           
            
            
            NSString *key = [NSString stringWithFormat:@"%ld", (long)headerView.section];
            
             NSString *rows = [NSString stringWithFormat:@"%ld", (long)headerView.totalRows];
            
            [[NSUserDefaults standardUserDefaults]setObject:key forKey:@"pathid"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setObject:rows forKey:@"pathid1"];
            [[NSUserDefaults standardUserDefaults]synchronize];

            
            
            BOOL isCollapsed = [self collapsedForSection:headerView.section];
            isCollapsed = !isCollapsed;
            
            [self.sectionStatusDic setObject:@(isCollapsed) forKey:key];
            
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            
            NSInteger b=[rowsp integerValue];

            for (int i = 0; i < b; i++) {
                [indexPaths1 addObject:[NSIndexPath indexPathForRow:i inSection:a]];
            }

           
            
            for (int i = 0; i < headerView.totalRows; i++) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:headerView.section]];
            }
            
            
            [self beginUpdates];
            
            
            if (isCollapsed1) {
                [self deleteRowsAtIndexPaths:indexPaths1 withRowAnimation:UITableViewRowAnimationTop];
            } else {
                [self insertRowsAtIndexPaths:indexPaths1 withRowAnimation:UITableViewRowAnimationTop];
            }
            
            
            if (isCollapsed) {
                [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            } else {
                [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            }
            
            [self endUpdates];
            
        }
        
        
    }
    else
    {
    
    
    NSString *key = [NSString stringWithFormat:@"%ld", (long)headerView.section];
        
    NSString *rows = [NSString stringWithFormat:@"%ld", (long)headerView.totalRows];
    
    [[NSUserDefaults standardUserDefaults]setObject:key forKey:@"pathid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
        
    [[NSUserDefaults standardUserDefaults]setObject:rows forKey:@"pathid1"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    BOOL isCollapsed = [self collapsedForSection:headerView.section];
    isCollapsed = !isCollapsed;
    
    [self.sectionStatusDic setObject:@(isCollapsed) forKey:key];
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < headerView.totalRows; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:headerView.section]];
    }
    
    [self beginUpdates];
    
    if (isCollapsed) {
        [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    } else {
        [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    }
    
    [self endUpdates];
    }
}

@end
