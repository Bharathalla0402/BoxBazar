//
//  YSLScrollMenuView.m
//  YSLContainerViewController
//
//  Created by Bharat on 2016/11/11.
//  Copyright (c) 2016 bharat. All rights reserved.
//

#import "YSLScrollMenuView.h"

static const CGFloat kYSLScrollMenuViewWidth  = 180;
static const CGFloat kYSLScrollMenuViewMargin = 5;
static const CGFloat kYSLIndicatorHeight = 3;

@interface YSLScrollMenuView ()
{
    UILabel *itemView;
}

@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation YSLScrollMenuView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // default
        _viewbackgroudColor = [UIColor whiteColor];
        _itemfont = [UIFont systemFontOfSize:16];
        _itemTitleColor = [UIColor colorWithRed:0.866667 green:0.866667 blue:0.866667 alpha:1.0];
        _itemSelectedTitleColor = [UIColor colorWithRed:0.333333 green:0.333333 blue:0.333333 alpha:1.0];
      //  _itemIndicatorColor = [UIColor colorWithRed:0.168627 green:0.498039 blue:0.839216 alpha:1.0];
        _itemIndicatorColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
        
        self.backgroundColor = _viewbackgroudColor;
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    return self;
}

#pragma mark -- Setter

- (void)setViewbackgroudColor:(UIColor *)viewbackgroudColor
{
    if (!viewbackgroudColor) { return; }
    _viewbackgroudColor = viewbackgroudColor;
    self.backgroundColor = viewbackgroudColor;
}

- (void)setItemfont:(UIFont *)itemfont
{
    if (!itemfont) { return; }
    _itemfont = itemfont;
    for (UILabel *label in _itemTitleArray) {
        label.font = itemfont;
    }
}

- (void)setItemTitleColor:(UIColor *)itemTitleColor
{
    if (!itemTitleColor) { return; }
    _itemTitleColor = itemTitleColor;
    for (UILabel *label in _itemTitleArray) {
        label.textColor = itemTitleColor;
    }
}

- (void)setItemIndicatorColor:(UIColor *)itemIndicatorColor
{
    if (!itemIndicatorColor) { return; }
    _itemIndicatorColor = itemIndicatorColor;
    _indicatorView.backgroundColor = itemIndicatorColor;
}

- (void)setItemTitleArray:(NSArray *)itemTitleArray
{
    if (_itemTitleArray != itemTitleArray) {
        _itemTitleArray = itemTitleArray;
        NSMutableArray *views = [NSMutableArray array];
        
        for (int i = 0; i < itemTitleArray.count; i++)
        {
            
            NSString *strname=itemTitleArray[i];
            
            if ([strname isEqualToString:@"Motors"])
            {
                CGRect frame = CGRectMake(0, 0, kYSLScrollMenuViewWidth, CGRectGetHeight(self.frame));
                itemView = [[UILabel alloc] initWithFrame:frame];
                
                NSTextAttachment *attachment = [NSTextAttachment new];
                attachment.image = [UIImage imageNamed:@"motor-120x120.png"];
                attachment.bounds = CGRectMake(-85, -7, 25, 25);
                NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@"Motors"];
                [myString appendAttributedString:attachmentString];
                itemView.attributedText = myString;
                itemView.textAlignment = NSTextAlignmentCenter;
            }
            else if ([strname isEqualToString:@"Classifieds"])
            {
                CGRect frame = CGRectMake(0, 0, kYSLScrollMenuViewWidth, CGRectGetHeight(self.frame));
                itemView = [[UILabel alloc] initWithFrame:frame];
                
                NSTextAttachment *attachment = [NSTextAttachment new];
                attachment.image = [UIImage imageNamed:@"classifieds-120x120.jpg"];
                attachment.bounds = CGRectMake(-105, -5, 20, 20);
                NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@"Classifieds"];
                [myString appendAttributedString:attachmentString];
                itemView.attributedText = myString;
                itemView.textAlignment = NSTextAlignmentCenter;
            }
            else if ([strname isEqualToString:@"Jobs"])
            {
                CGRect frame = CGRectMake(0, 0, kYSLScrollMenuViewWidth, CGRectGetHeight(self.frame));
                itemView = [[UILabel alloc] initWithFrame:frame];
                
                NSTextAttachment *attachment = [NSTextAttachment new];
                attachment.image = [UIImage imageNamed:@"jobs-120x120.png"];
                attachment.bounds = CGRectMake(-60, -5, 20, 20);
                NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@"Jobs"];
                [myString appendAttributedString:attachmentString];
                itemView.attributedText = myString;
                itemView.textAlignment = NSTextAlignmentCenter;
            }
            else if ([strname isEqualToString:@"Jobs Wanted"])
            {
                CGRect frame = CGRectMake(0, 0, kYSLScrollMenuViewWidth, CGRectGetHeight(self.frame));
                itemView = [[UILabel alloc] initWithFrame:frame];
                
                NSTextAttachment *attachment = [NSTextAttachment new];
                attachment.image = [UIImage imageNamed:@"jobs-120x120.png"];
                attachment.bounds = CGRectMake(-120, -5, 20, 20);
                NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@"Jobs Wanted"];
                [myString appendAttributedString:attachmentString];
                itemView.attributedText = myString;
                itemView.textAlignment = NSTextAlignmentCenter;
            }
            else if ([strname isEqualToString:@"Property on Rent"])
            {
                CGRect frame = CGRectMake(0, 0, kYSLScrollMenuViewWidth, CGRectGetHeight(self.frame));
                itemView = [[UILabel alloc] initWithFrame:frame];
                
                NSTextAttachment *attachment = [NSTextAttachment new];
                attachment.image = [UIImage imageNamed:@"propertyonrent-120x120.png"];
                attachment.bounds = CGRectMake(-150, -5, 20, 20);
                NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@"Property on Rent"];
                [myString appendAttributedString:attachmentString];
                itemView.attributedText = myString;
                itemView.textAlignment = NSTextAlignmentRight;
            }
            else if ([strname isEqualToString:@"Property on Sale"])
            {
                CGRect frame = CGRectMake(0, 0, kYSLScrollMenuViewWidth, CGRectGetHeight(self.frame));
                itemView = [[UILabel alloc] initWithFrame:frame];
                
                NSTextAttachment *attachment = [NSTextAttachment new];
                attachment.image = [UIImage imageNamed:@"propertyonsale-120x120.png"];
                attachment.bounds = CGRectMake(-150, -5, 20, 20);
                NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@"Property on Sale"];
                [myString appendAttributedString:attachmentString];
                itemView.attributedText = myString;
                itemView.textAlignment = NSTextAlignmentRight;
            }
            else if ([strname isEqualToString:@"Community"])
            {
                CGRect frame = CGRectMake(0, 0, kYSLScrollMenuViewWidth, CGRectGetHeight(self.frame));
                itemView = [[UILabel alloc] initWithFrame:frame];
                
                NSTextAttachment *attachment = [NSTextAttachment new];
                attachment.image = [UIImage imageNamed:@"xxxhdpi.png"];
                attachment.bounds = CGRectMake(-110, -5, 20, 20);
                NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@"Community"];
                [myString appendAttributedString:attachmentString];
                itemView.attributedText = myString;
                itemView.textAlignment = NSTextAlignmentCenter;
            }
            
            itemView.tag = i;
         //   itemView.text = itemTitleArray[i];
            itemView.userInteractionEnabled = YES;
            itemView.backgroundColor = [UIColor clearColor];
            
            itemView.font = self.itemfont;
            itemView.textColor = _itemTitleColor;
            [self.scrollView addSubview:itemView];
            [views addObject:itemView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemViewTapAction:)];
            [itemView addGestureRecognizer:tapGesture];
            
            //[self.delegate scrollMenuViewSelectedIndex:[tapGesture view].tag];
        }
        
        self.itemViewArray = [NSArray arrayWithArray:views];
        
        // indicator
        _indicatorView = [[UIView alloc]init];
        
        NSString *strv=[[NSUserDefaults standardUserDefaults]objectForKey:@"index"];
        int a=(int)[strv integerValue];
        
        if (a==0)
        {
            _indicatorView.frame = CGRectMake(10, _scrollView.frame.size.height - kYSLIndicatorHeight, kYSLScrollMenuViewWidth, kYSLIndicatorHeight);
        }
        else if (a==1)
        {
             _indicatorView.frame = CGRectMake(190, _scrollView.frame.size.height - kYSLIndicatorHeight, kYSLScrollMenuViewWidth, kYSLIndicatorHeight);
        }
        else if (a==2)
        {
             _indicatorView.frame = CGRectMake(375, _scrollView.frame.size.height - kYSLIndicatorHeight, kYSLScrollMenuViewWidth, kYSLIndicatorHeight);
        }
        else if (a==3)
        {
             _indicatorView.frame = CGRectMake(560, _scrollView.frame.size.height - kYSLIndicatorHeight, kYSLScrollMenuViewWidth, kYSLIndicatorHeight);
        }else if (a==4)
        {
             _indicatorView.frame = CGRectMake(745, _scrollView.frame.size.height - kYSLIndicatorHeight, kYSLScrollMenuViewWidth, kYSLIndicatorHeight);
        }
        else if (a==5)
        {
             _indicatorView.frame = CGRectMake(930, _scrollView.frame.size.height - kYSLIndicatorHeight, kYSLScrollMenuViewWidth, kYSLIndicatorHeight);
        }
        else if (a==6)
        {
             _indicatorView.frame = CGRectMake(1115, _scrollView.frame.size.height - kYSLIndicatorHeight, kYSLScrollMenuViewWidth, kYSLIndicatorHeight);
        }

        
        
        _indicatorView.backgroundColor = self.itemIndicatorColor;
        [_scrollView addSubview:_indicatorView];
    }
    
    
}

#pragma mark -- public

- (void)setIndicatorViewFrameWithRatio:(CGFloat)ratio isNextItem:(BOOL)isNextItem toIndex:(NSInteger)toIndex
{
    
    CGFloat indicatorX = 0.0;
    if (isNextItem) {
        indicatorX = ((kYSLScrollMenuViewMargin + kYSLScrollMenuViewWidth) * ratio ) + (toIndex * kYSLScrollMenuViewWidth) + ((toIndex + 1) * kYSLScrollMenuViewMargin);
    } else {
        indicatorX =  ((kYSLScrollMenuViewMargin + kYSLScrollMenuViewWidth) * (1 - ratio) ) + (toIndex * kYSLScrollMenuViewWidth) + ((toIndex + 1) * kYSLScrollMenuViewMargin);
    }
    
    if (indicatorX < kYSLScrollMenuViewMargin || indicatorX > self.scrollView.contentSize.width - (kYSLScrollMenuViewMargin + kYSLScrollMenuViewWidth)) {
        return;
    }
    _indicatorView.frame = CGRectMake(indicatorX, _scrollView.frame.size.height - kYSLIndicatorHeight, kYSLScrollMenuViewWidth, kYSLIndicatorHeight);
    //  NSLog(@"retio : %f",_indicatorView.frame.origin.x);
}

- (void)setItemTextColor:(UIColor *)itemTextColor
    seletedItemTextColor:(UIColor *)selectedItemTextColor
            currentIndex:(NSInteger)currentIndex
{
    if (itemTextColor) { _itemTitleColor = itemTextColor; }
    if (selectedItemTextColor) { _itemSelectedTitleColor = selectedItemTextColor; }
    
    for (int i = 0; i < self.itemViewArray.count; i++) {
        UILabel *label = self.itemViewArray[i];
        if (i == currentIndex) {
            label.alpha = 0.0;
            [UIView animateWithDuration:0.75
                                  delay:0.0
                                options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 label.alpha = 1.0;
                                 label.textColor = _itemSelectedTitleColor;
                              
                              //   NSLog(@"%@",label.text);
                                 
                              //   NSString *strname=label.text;
                                 
                             //   NSLog(@"%@",strname);
                                 
                                 NSString *firstLetter = [label.text substringToIndex:2];
                                 
                                
                                 
                             //    NSLog(@"%@",firstLetter);
                                 
                                 if ([firstLetter isEqualToString:@"Mo"])
                                 {
                                     NSTextAttachment *attachment = [NSTextAttachment new];
                                     attachment.image = [UIImage imageNamed:@"motor-120x120.png"];
                                     attachment.bounds = CGRectMake(-85, -7, 25, 25);
                                     NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                                     NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:label.text];
                                     [myString appendAttributedString:attachmentString];
                                     label.attributedText = myString;
                                 }
                                 else if ([firstLetter isEqualToString:@"Cl"])
                                 {
                                     NSTextAttachment *attachment = [NSTextAttachment new];
                                     attachment.image = [UIImage imageNamed:@"classifieds-120x120.jpg"];
                                     attachment.bounds = CGRectMake(-105, -5, 20, 20);
                                     NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                                     NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@"Classifieds"];
                                     [myString appendAttributedString:attachmentString];
                                     label.attributedText = myString;
                                 }
                                 else if ([firstLetter isEqualToString:@"Jo"])
                                 {
                                     NSString *strl=[NSString stringWithFormat:@"%@",label.text];
                                     
                                     NSString *t_st = @"W";
                                     NSRange rang =[strl rangeOfString:t_st options:NSCaseInsensitiveSearch];
                                     
                                     if (rang.length == [t_st length])
                                     {
                                         NSTextAttachment *attachment = [NSTextAttachment new];
                                         attachment.image = [UIImage imageNamed:@"jobs-120x120.png"];
                                         attachment.bounds = CGRectMake(-120, -5, 20, 20);
                                         NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                                         NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:label.text];
                                         [myString appendAttributedString:attachmentString];
                                         label.attributedText = myString;
                                     }
                                     else
                                     {
                                         NSTextAttachment *attachment = [NSTextAttachment new];
                                         attachment.image = [UIImage imageNamed:@"jobs-120x120.png"];
                                         attachment.bounds = CGRectMake(-60, -5, 20, 20);
                                         NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                                         NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:label.text];
                                         [myString appendAttributedString:attachmentString];
                                         label.attributedText = myString;
                                     }
                                     
                                 }
                                 else if ([firstLetter isEqualToString:@"Pr"])
                                 {
                                     NSString *firstLetter2 = [label.text substringToIndex:16];
                                     
                                   //  NSLog(@"%@",firstLetter2);
                                     
                                     if ([firstLetter2 isEqualToString:@"Property on Rent"])
                                     {
                                         NSTextAttachment *attachment = [NSTextAttachment new];
                                         attachment.image = [UIImage imageNamed:@"propertyonrent-120x120.png"];
                                         attachment.bounds = CGRectMake(-150, -5, 20, 20);
                                         NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                                         NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:label.text];
                                         [myString appendAttributedString:attachmentString];
                                         label.attributedText = myString;
                                         label.textAlignment=NSTextAlignmentRight;
                                     }
                                     else
                                     {
                                         NSTextAttachment *attachment = [NSTextAttachment new];
                                         attachment.image = [UIImage imageNamed:@"propertyonsale-120x120.png"];
                                         attachment.bounds = CGRectMake(-150, -5, 20, 20);
                                         NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                                         NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:label.text];
                                         [myString appendAttributedString:attachmentString];
                                         label.attributedText = myString;
                                         label.textAlignment=NSTextAlignmentRight;
                                     }
                                     
                                 }
                                 else if ([firstLetter isEqualToString:@"Co"])
                                 {
                                     NSTextAttachment *attachment = [NSTextAttachment new];
                                     attachment.image = [UIImage imageNamed:@"xxxhdpi.png"];
                                     attachment.bounds = CGRectMake(-110, -5, 20, 20);
                                     NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                                     NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@"Community"];
                                     [myString appendAttributedString:attachmentString];
                                     label.attributedText = myString;
                                 }

    
                             } completion:^(BOOL finished) {
                             }];
        } else {
            label.textColor = _itemTitleColor;
            
            NSString *firstLetter = [label.text substringToIndex:2];
            
         //   NSLog(@"%@",firstLetter);
            
            
            if ([firstLetter isEqualToString:@"Mo"])
            {
                NSTextAttachment *attachment = [NSTextAttachment new];
                attachment.image = [UIImage imageNamed:@"carb.png"];
                attachment.bounds = CGRectMake(-85, -7, 25, 25);
                NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@"Motors"];
                [myString appendAttributedString:attachmentString];
                label.attributedText = myString;
            }
            else if ([firstLetter isEqualToString:@"Cl"])
            {
                NSTextAttachment *attachment = [NSTextAttachment new];
                attachment.image = [UIImage imageNamed:@"classifiedb.png"];
                attachment.bounds = CGRectMake(-105, -5, 20, 20);
                NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@"Classifieds"];
                [myString appendAttributedString:attachmentString];
                label.attributedText = myString;
            }
            else if ([firstLetter isEqualToString:@"Jo"])
            {
                NSString *strl=[NSString stringWithFormat:@"%@",label.text];
                
                NSString *t_st = @"W";
                NSRange rang =[strl rangeOfString:t_st options:NSCaseInsensitiveSearch];
                
                if (rang.length == [t_st length])
                {
                    NSTextAttachment *attachment = [NSTextAttachment new];
                    attachment.image = [UIImage imageNamed:@"jobsb.png"];
                    attachment.bounds = CGRectMake(-120, -5, 20, 20);
                    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                    NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:label.text];
                    [myString appendAttributedString:attachmentString];
                    label.attributedText = myString;

                }
                else
                {
                    NSTextAttachment *attachment = [NSTextAttachment new];
                    attachment.image = [UIImage imageNamed:@"jobsb.png"];
                    attachment.bounds = CGRectMake(-60, -5, 20, 20);
                    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                    NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:label.text];
                    [myString appendAttributedString:attachmentString];
                    label.attributedText = myString;

                }
            }
            else if ([firstLetter isEqualToString:@"Pr"])
            {
                NSString *firstLetter2 = [label.text substringToIndex:16];
                
              //  NSLog(@"%@",firstLetter2);
                
                if ([firstLetter2 isEqualToString:@"Property on Rent"])
                {
                    NSTextAttachment *attachment = [NSTextAttachment new];
                    attachment.image = [UIImage imageNamed:@"property on rentb.png"];
                    attachment.bounds = CGRectMake(-150, -5, 20, 20);
                    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                    NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:label.text];
                    [myString appendAttributedString:attachmentString];
                    label.attributedText = myString;
                    label.textAlignment=NSTextAlignmentRight;
                }
                else
                {
                    NSTextAttachment *attachment = [NSTextAttachment new];
                    attachment.image = [UIImage imageNamed:@"propertyon saleb.png"];
                    attachment.bounds = CGRectMake(-150, -5, 20, 20);
                    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                    NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:label.text];
                    [myString appendAttributedString:attachmentString];
                    label.attributedText = myString;
                    label.textAlignment=NSTextAlignmentRight;
                }
                
            }
            else if ([firstLetter isEqualToString:@"Co"])
            {
                NSTextAttachment *attachment = [NSTextAttachment new];
                attachment.image = [UIImage imageNamed:@"xxxhdpi2.png"];
                attachment.bounds = CGRectMake(-110, -5, 20, 20);
                NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@"Community"];
                [myString appendAttributedString:attachmentString];
                label.attributedText = myString;
            }
        }
        
    }
}

#pragma mark -- private

// menu shadow
- (void)setShadowView
{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, self.frame.size.height - 0.5, CGRectGetWidth(self.frame), 0.5);
    view.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:view];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = kYSLScrollMenuViewMargin;
    for (NSUInteger i = 0; i < self.itemViewArray.count; i++) {
        CGFloat width = kYSLScrollMenuViewWidth;
        UIView *itemView2 = self.itemViewArray[i];
        itemView2.frame = CGRectMake(x, 0, width, self.scrollView.frame.size.height);
        x += width + kYSLScrollMenuViewMargin;
    }
    self.scrollView.contentSize = CGSizeMake(x, self.scrollView.frame.size.height);
    
    CGRect frame = self.scrollView.frame;
    if (self.frame.size.width > x) {
        frame.origin.x = (self.frame.size.width - x) / 2;
        frame.size.width = x;
    } else {
        frame.origin.x = 0;
        frame.size.width = self.frame.size.width;
    }
    self.scrollView.frame = frame;
    
    NSString *strv=[[NSUserDefaults standardUserDefaults]objectForKey:@"index"];
    int a=(int)[strv integerValue];
    
    if (a==0)
    {
         [UIView animateWithDuration:1.2 animations:^{_scrollView.contentOffset = CGPointMake(10, 0);}];
    }
    else if (a==1)
    {
         [UIView animateWithDuration:1.2 animations:^{_scrollView.contentOffset = CGPointMake(190, 0);}];
    }
    else if (a==2)
    {
         [UIView animateWithDuration:1.2 animations:^{_scrollView.contentOffset = CGPointMake(375, 0);}];
    }
    else if (a==3)
    {
         [UIView animateWithDuration:1.2 animations:^{_scrollView.contentOffset = CGPointMake(560, 0);}];
        
    }else if (a==4)
    {
         [UIView animateWithDuration:1.2 animations:^{_scrollView.contentOffset = CGPointMake(745, 0);}];
    }
    else if (a==5)
    {
         [UIView animateWithDuration:1.2 animations:^{_scrollView.contentOffset = CGPointMake(930, 0);}];
    }
    else if (a==6)
    {
         [UIView animateWithDuration:1.2 animations:^{_scrollView.contentOffset = CGPointMake(1115, 0);}];
    }
  
}

#pragma mark -- Selector --------------------------------------- //
- (void)itemViewTapAction:(UITapGestureRecognizer *)Recongnizer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollMenuViewSelectedIndex:)]) {
        [self.delegate scrollMenuViewSelectedIndex:[(UIGestureRecognizer*) Recongnizer view].tag];
    }
}

@end
