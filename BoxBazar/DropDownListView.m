//
//  DropDownListView.m
//  KDropDownMultipleSelection
//
//  Created by macmini17 on 03/01/14.
//  Copyright (c) 2014 macmini17. All rights reserved.
//

#import "DropDownListView.h"
#import "DropDownViewCell.h"

#define DROPDOWNVIEW_SCREENINSET 0
#define DROPDOWNVIEW_HEADER_HEIGHT 50.
#define RADIUS 5.0f


@interface DropDownListView (private)
- (void)fadeIn;
- (void)fadeOut;

@end
@implementation DropDownListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




- (id)initWithTitle:(NSString *)aTitle options:(NSArray *)aOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple
{
    
    
    isMultipleSelection=isMultiple;
    NSString *strmessage=[[NSUserDefaults standardUserDefaults]objectForKey:@"Options"];
    if ([strmessage isEqualToString:@"filter"])
    {
        NSString *strmessage2=[[NSUserDefaults standardUserDefaults]objectForKey:@"checking"];
        
        if ([strmessage2 isEqualToString:@"Check"])
        {
            
        height = MIN(size.height, DROPDOWNVIEW_HEADER_HEIGHT+[aOptions count]*44);
        }
        else
        {
         height = MIN(size.height, DROPDOWNVIEW_HEADER_HEIGHT+[aOptions count]*44+44);
        }
      
    }
    else
    {
        height = MIN(size.height, DROPDOWNVIEW_HEADER_HEIGHT+[aOptions count]*44);
    }
    CGRect rect = CGRectMake(point.x, point.y, size.width, height);
    if (self = [super initWithFrame:rect])
    {
        self.backgroundColor = [UIColor clearColor];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(2.5, 2.5);
        self.layer.shadowRadius = 2.0f;
        self.layer.shadowOpacity = 0.5f;
        
        _kTitleText = [aTitle copy];
        _kDropDownOption = [aOptions copy];
        self.arryData=[[NSMutableArray alloc]init];
        self.arryData2=[[NSMutableArray alloc]init];
        [self.arryData2 removeAllObjects];
        _kTableView = [[UITableView alloc] initWithFrame:CGRectMake(DROPDOWNVIEW_SCREENINSET,
                                                                   DROPDOWNVIEW_SCREENINSET + DROPDOWNVIEW_HEADER_HEIGHT,
                                                                   rect.size.width - 2 * DROPDOWNVIEW_SCREENINSET,
                                                                   rect.size.height - 2 * DROPDOWNVIEW_SCREENINSET - DROPDOWNVIEW_HEADER_HEIGHT - RADIUS)];
        _kTableView.separatorColor = [UIColor colorWithWhite:1 alpha:.2];
        _kTableView.separatorInset = UIEdgeInsetsZero;
        _kTableView.backgroundColor = [UIColor clearColor];
        _kTableView.dataSource = self;
        _kTableView.delegate = self;
        [self addSubview:_kTableView];
        
        
        
        if (isMultipleSelection)
        {
            if ([UIScreen mainScreen].bounds.size.width < 700 )
            {
                NSString *strmessage=[[NSUserDefaults standardUserDefaults]objectForKey:@"Options"];
                
                if ([strmessage isEqualToString:@"filter"])
                {
                    // _kTitleText = @"";
//                    UIButton *btnDone=[UIButton  buttonWithType:UIButtonTypeCustom];
//                    [btnDone setFrame:CGRectMake(size.width-87,10, 82, 31)];
//                    [btnDone setImage:[UIImage imageNamed:@"done@2x.png"] forState:UIControlStateNormal];
//                    [btnDone addTarget:self action:@selector(Click_Done) forControlEvents: UIControlEventTouchUpInside];
//                    [self addSubview:btnDone];
                    
                    NSString *strmessage2=[[NSUserDefaults standardUserDefaults]objectForKey:@"checking"];
                    
                    if ([strmessage2 isEqualToString:@"Check"])
                    {
                        [self.searchController.searchBar resignFirstResponder];
                        
                        [_kTableView endEditing:YES];
                    }
                    else
                    {
                        data=[[NSMutableArray alloc]init];
                        searchResults=[[NSMutableArray alloc]init];
                        arrChildCategory=[[NSMutableArray alloc]init];
                        NSMutableArray *arr=[aOptions copy];
                        arrChildCategory=arr;
                        
                        self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
                        self.searchController.searchResultsUpdater = self;
                        self.searchController.dimsBackgroundDuringPresentation = NO;
                        self.searchController.searchBar.delegate = self;
                        
                        
                        _kTableView.tableHeaderView = self.searchController.searchBar;
                    }
                }
                else
                {
                    UIButton *btnDone=[UIButton  buttonWithType:UIButtonTypeCustom];
                    [btnDone setFrame:CGRectMake(size.width-87,10, 82, 31)];
                    [btnDone setImage:[UIImage imageNamed:@"done@2x.png"] forState:UIControlStateNormal];
                    [btnDone addTarget:self action:@selector(Click_Done) forControlEvents: UIControlEventTouchUpInside];
                    [self addSubview:btnDone];

                }
            }
            else
            {
//                UIButton *btnDone=[UIButton  buttonWithType:UIButtonTypeCustom];
//                [btnDone setFrame:CGRectMake(size.width-87,10, 82, 31)];
//                [btnDone setImage:[UIImage imageNamed:@"done@2x.png"] forState:UIControlStateNormal];
//                [btnDone addTarget:self action:@selector(Click_Done) forControlEvents: UIControlEventTouchUpInside];
//                [self addSubview:btnDone];
                
                
                
                NSString *strmessage=[[NSUserDefaults standardUserDefaults]objectForKey:@"Options"];
                
                if ([strmessage isEqualToString:@"filter"])
                {
                    // _kTitleText = @"";
                    //                    UIButton *btnDone=[UIButton  buttonWithType:UIButtonTypeCustom];
                    //                    [btnDone setFrame:CGRectMake(size.width-87,10, 82, 31)];
                    //                    [btnDone setImage:[UIImage imageNamed:@"done@2x.png"] forState:UIControlStateNormal];
                    //                    [btnDone addTarget:self action:@selector(Click_Done) forControlEvents: UIControlEventTouchUpInside];
                    //                    [self addSubview:btnDone];
                    
                    NSString *strmessage2=[[NSUserDefaults standardUserDefaults]objectForKey:@"checking"];
                    
                    if ([strmessage2 isEqualToString:@"Check"])
                    {
                        [self.searchController.searchBar resignFirstResponder];
                        
                        [_kTableView endEditing:YES];
                    }
                    else
                    {
                        data=[[NSMutableArray alloc]init];
                        searchResults=[[NSMutableArray alloc]init];
                        arrChildCategory=[[NSMutableArray alloc]init];
                        NSMutableArray *arr=[aOptions copy];
                        arrChildCategory=arr;
                        
                        self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
                        self.searchController.searchResultsUpdater = self;
                        self.searchController.dimsBackgroundDuringPresentation = NO;
                        self.searchController.searchBar.delegate = self;
                        
                        
                        _kTableView.tableHeaderView = self.searchController.searchBar;
                    }
                }
                else
                {
                    UIButton *btnDone=[UIButton  buttonWithType:UIButtonTypeCustom];
                    [btnDone setFrame:CGRectMake(size.width-87,10, 82, 31)];
                    [btnDone setImage:[UIImage imageNamed:@"done@2x.png"] forState:UIControlStateNormal];
                    [btnDone addTarget:self action:@selector(Click_Done) forControlEvents: UIControlEventTouchUpInside];
                    [self addSubview:btnDone];
                    
                }

            }
        }
    }
    return self;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
   
    NSString *searchString = searchController.searchBar.text;
 //   NSLog(@"%@",searchString);
    [self filterContentForSearchText:searchString
                               scope:[[self.searchController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchController.searchBar
                                                     selectedScopeButtonIndex]]];
    [_kTableView reloadData];
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    if (searchResults.count != 0)
    {
        [searchResults removeAllObjects];
        _kTableView.tag=1;
    }
    for (int i=0; i< [_kDropDownOption count]; i++)
    {
        // [searchResults removeAllObjects];
        NSString *string = [[_kDropDownOption objectAtIndex:i] valueForKey:@"name"];
        NSRange rangeValue = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (rangeValue.length > 0)
        {
          //  NSLog(@"string contains bla!");
            
            _kTableView.tag=2;
            [searchResults addObject:[_kDropDownOption objectAtIndex:i]];
        }
        else
        {
         //   NSLog(@"string does not contain bla");
        }
    }
    NSLog(@"fiilterArray : %@",searchResults);
}


-(void)Click_Done{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(DropDownListView:Datalist:)]) {
        NSMutableArray *arryResponceData=[[NSMutableArray alloc]init];
       // NSLog(@"%@",self.arryData);
        NSMutableArray *arrimages=[[NSMutableArray alloc]init];
        for (int k=0; k<self.arryData.count; k++) {
            NSIndexPath *path=[self.arryData objectAtIndex:k];
            [arryResponceData addObject:[_kDropDownOption objectAtIndex:path.row]];
         //   NSLog(@"pathRow=%ld",(long)path.row);
            
            NSMutableArray *arr=[[NSMutableArray alloc] init];
            [arr addObject:[NSString stringWithFormat:@"%ld",(long)path.row ]];
            
           
            arrimages=[[arrimages arrayByAddingObjectsFromArray:arr] mutableCopy];
            
            NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:arrimages,@"key", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"anyname" object:self userInfo:dict];

        }
    
        [self.delegate DropDownListView2:self Datalist:arrimages];
        [self.delegate DropDownListView:self Datalist:arryResponceData];
    }
    // dismiss self
    [self fadeOut];
}
#pragma mark - Private Methods
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - Instance Methods
- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
    }
}

#pragma mark - Tableview datasource & delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_kTableView.tag==2) {
        return [searchResults count];
        
    } else {
        return [_kDropDownOption count];
        
    }
    return [_kDropDownOption count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity = @"DropDownViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    cell = [[DropDownViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    
    if (isMultipleSelection)
    {
        int row = (int)[indexPath row];
        UIImageView *imgarrow=[[UIImageView alloc]init ];
        imgarrow.frame=CGRectMake(10,5, 30, 30);
        imgarrow.image=[UIImage imageNamed:@"remember Check.png"];
        
      
        
        if (_kTableView.tag==2)
        {
            NSString *strid=[[searchResults objectAtIndex:indexPath.row] valueForKey:@"id"];
            if([self.arryData2 containsObject:strid])
            {
                imgarrow.frame=CGRectMake(10,5, 30, 30);
                imgarrow.image=[UIImage imageNamed:@"remember check2.png"];
            } else
                imgarrow.image=[UIImage imageNamed:@"remember Check.png"];
            
            [cell addSubview:imgarrow];
            
            cell.textLabel.frame=CGRectMake(55, 0, cell.frame.size.width-70, 30);
            cell.textLabel.text = [[searchResults objectAtIndex:row] valueForKey:@"name"];
            cell.textLabel.numberOfLines=2;
        }
        else {
            
            NSString *strmessage=[[NSUserDefaults standardUserDefaults]objectForKey:@"Options"];
            
            if ([strmessage isEqualToString:@"filter"])
            {
                 NSString *strmessage2=[[NSUserDefaults standardUserDefaults]objectForKey:@"checking"];
                
                if ([strmessage2 isEqualToString:@"Check"])
                {
                    
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    NSObject * object = [prefs objectForKey:@"indexcheck"];
                    if(object != nil)
                    {
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        NSData *da = [defaults objectForKey:@"indexcheck"];
                        self.arryData= [[NSKeyedUnarchiver unarchiveObjectWithData:da] mutableCopy];
                        
                        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"indexcheck"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                    }
                    else
                    {
                        
                    }
                    
                    
                    if([self.arryData containsObject:indexPath])
                    {
                        imgarrow.frame=CGRectMake(10,5, 30, 30);
                        imgarrow.image=[UIImage imageNamed:@"remember check2.png"];
                    } else
                        imgarrow.image=[UIImage imageNamed:@"remember Check.png"];
                    
                    [cell addSubview:imgarrow];
                    
                    cell.textLabel.frame=CGRectMake(55, 0, cell.frame.size.width-70, 30);
                    cell.textLabel.text = [_kDropDownOption objectAtIndex:row];
                    cell.textLabel.numberOfLines=2;
                }
                else
                {
                    if ([strmessage2 isEqualToString:@"Check1"])
                    {
                        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                        NSObject * object = [prefs objectForKey:@"Makeids"];
                        if(object != nil)
                        {
                           // [self.arryData2 removeAllObjects];
                            self.arryData2=[[[NSUserDefaults standardUserDefaults]objectForKey:@"Makeids"] mutableCopy];
                        }
                        else
                        {
                        
                        }
                    }
                    else if ([strmessage2 isEqualToString:@"Check2"])
                    {
                        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                        NSObject * object = [prefs objectForKey:@"Modelids"];
                        if(object != nil)
                        {
                           // [self.arryData2 removeAllObjects];
                            self.arryData2=[[[NSUserDefaults standardUserDefaults]objectForKey:@"Modelids"] mutableCopy];
                        }
                        else
                        {
                            
                        }
                    }
                        
                    
                    NSString *strid=[NSString stringWithFormat:@"%@",[[_kDropDownOption objectAtIndex:indexPath.row] valueForKey:@"id"]];
                    if([self.arryData2 containsObject:strid])
                    {
                        imgarrow.frame=CGRectMake(10,5, 30, 30);
                        imgarrow.image=[UIImage imageNamed:@"remember check2.png"];
                    } else
                        imgarrow.image=[UIImage imageNamed:@"remember Check.png"];
                    
                    [cell addSubview:imgarrow];
                    
                    cell.textLabel.frame=CGRectMake(55, 0, cell.frame.size.width-70, 30);
                    cell.textLabel.text = [[_kDropDownOption objectAtIndex:row] valueForKey:@"name"];
                    cell.textLabel.numberOfLines=2;
                }
            }
            else
            {
                if([self.arryData containsObject:indexPath])
                {
                    imgarrow.frame=CGRectMake(10,5, 30, 30);
                    imgarrow.image=[UIImage imageNamed:@"remember check2.png"];
                } else
                    imgarrow.image=[UIImage imageNamed:@"remember Check.png"];
                
                [cell addSubview:imgarrow];
                
                cell.textLabel.frame=CGRectMake(55, 0, cell.frame.size.width-70, 30);
                cell.textLabel.text = [_kDropDownOption objectAtIndex:row] ;
                cell.textLabel.numberOfLines=2;
            }
           
        }
    }
    else
    {
        int row = (int)[indexPath row];
        UIImageView *imgarrow=[[UIImageView alloc]init ];
        
        if([self.arryData containsObject:indexPath])
        {
            imgarrow.frame=CGRectMake(230,2, 27, 27);
            imgarrow.image=[UIImage imageNamed:@"check_mark@2x.png"];
        } else
            imgarrow.image=nil;
        
        [cell addSubview:imgarrow];
        cell.textLabel.text = [_kDropDownOption objectAtIndex:row] ;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (isMultipleSelection)
    {
       
        NSString *strmessage=[[NSUserDefaults standardUserDefaults]objectForKey:@"Options"];
        
        if ([strmessage isEqualToString:@"filter"])
        {
            if (_kTableView.tag==2)
            {
                NSString *strid=[[searchResults objectAtIndex:indexPath.row] valueForKey:@"id"];
                
                if([self.arryData2 containsObject:strid]){
                    [self.arryData2 removeObject:strid];
                } else {
                    [self.arryData2 addObject:strid];
                }
                [tableView reloadData];
                [self.delegate DropDownListView3:self Datalist:self.arryData2];
                [self endEditing:YES];
                
//                for (int i=0; i<searchResults.count; i++)
//                {
//                    NSString *str2nd=[[searchResults objectAtIndex:i] valueForKey:@"id"];
//                    if ([strid isEqualToString:str2nd])
//                    {
//                        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
//                        
//                        if([self.arryData containsObject:path]){
//                            [self.arryData removeObject:path];
//                        } else {
//                            [self.arryData addObject:path];
//                        }
//                        [tableView reloadData];
//                        
//                    }
//                }
            }
            else
            {
                
                NSString *strmessage2=[[NSUserDefaults standardUserDefaults]objectForKey:@"checking"];
                
                if ([strmessage2 isEqualToString:@"Check"])
                {
                    if([self.arryData containsObject:indexPath]){
                        [self.arryData removeObject:indexPath];
                    } else {
                        [self.arryData addObject:indexPath];
                    }
                    [tableView reloadData];
                    
                    
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(DropDownListView:Datalist:)]) {
                        NSMutableArray *arryResponceData=[[NSMutableArray alloc]init];
                      //  NSLog(@"%@",self.arryData);
                        NSMutableArray *arrimages=[[NSMutableArray alloc]init];
                        for (int k=0; k<self.arryData.count; k++) {
                            NSIndexPath *path=[self.arryData objectAtIndex:k];
                            [arryResponceData addObject:[_kDropDownOption objectAtIndex:path.row]];
                        //    NSLog(@"pathRow=%ld",(long)path.row);
                            
                            NSMutableArray *arr=[[NSMutableArray alloc] init];
                            [arr addObject:[NSString stringWithFormat:@"%ld",(long)path.row ]];
                            
                            
                            arrimages=[[arrimages arrayByAddingObjectsFromArray:arr] mutableCopy];
                            
                            NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:arrimages,@"key", nil];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"anyname" object:self userInfo:dict];
                            
                        }
                        
                        [self.delegate DropDownListView2:self Datalist:arrimages];
                        [self.delegate DropDownListView:self Datalist:arryResponceData];
                    }

                }
                else
                {
                
                    NSString *strid=[[_kDropDownOption objectAtIndex:indexPath.row] valueForKey:@"id"];
                    if([self.arryData2 containsObject:strid]){
                        [self.arryData2 removeObject:strid];
                    } else {
                        [self.arryData2 addObject:strid];
                    }
                    [tableView reloadData];

                     [self.delegate DropDownListView3:self Datalist:self.arryData2];
                    
                    [self.searchController dismissViewControllerAnimated:YES completion:nil];
                    [self endEditing:YES];

                    
//                    for (int i=0; i<_kDropDownOption.count; i++)
//                    {
//                        NSString *str2nd=[[_kDropDownOption objectAtIndex:i] valueForKey:@"id"];
//                        
//                        if([self.arryData2 containsObject:str2nd]){
//                            [self.arryData2 removeObject:str2nd];
//                        } else {
//                            [self.arryData2 addObject:str2nd];
//                        }
//                        [tableView reloadData];

//                        if ([strid isEqualToString:str2nd])
//                        {
//                            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
//                            
//                            if([self.arryData containsObject:path]){
//                                [self.arryData removeObject:path];
//                            } else {
//                                [self.arryData addObject:path];
//                            }
//                            [tableView reloadData];
//                            
//                        }
                //    }

                }
               
            }

        }
        else
        {
            if([self.arryData containsObject:indexPath]){
                [self.arryData removeObject:indexPath];
            } else {
                [self.arryData addObject:indexPath];
            }
            [tableView reloadData];
        }
        
    }
    else {
    
        if (self.delegate && [self.delegate respondsToSelector:@selector(DropDownListView:didSelectedIndex:)]) {
            [self.delegate DropDownListView:self didSelectedIndex:[indexPath row]];
        }
        // dismiss self
        [self fadeOut];
    }
	
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.searchController dismissViewControllerAnimated:YES completion:nil];
    [self endEditing:YES];
}


#pragma mark - TouchTouchTouch
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // tell the delegate the cancellation
}

#pragma mark - DrawDrawDraw
- (void)drawRect:(CGRect)rect {
    CGRect bgRect = CGRectInset(rect, DROPDOWNVIEW_SCREENINSET, DROPDOWNVIEW_SCREENINSET);
     titleRect = CGRectMake(DROPDOWNVIEW_SCREENINSET + 10, DROPDOWNVIEW_SCREENINSET + 10 + 5,
                                  rect.size.width -  2 * (DROPDOWNVIEW_SCREENINSET + 10), 30);
    CGRect separatorRect = CGRectMake(DROPDOWNVIEW_SCREENINSET, DROPDOWNVIEW_SCREENINSET + DROPDOWNVIEW_HEADER_HEIGHT - 2,
                                      rect.size.width - 2 * DROPDOWNVIEW_SCREENINSET, 2);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
//    NSString *strmessage=[[NSUserDefaults standardUserDefaults]objectForKey:@"Options"];
//    
//    if ([strmessage isEqualToString:@"filter"])
//    {
//         titleRect = CGRectMake(5, DROPDOWNVIEW_SCREENINSET + 10 + 5,
//                                      rect.size.width -  92, 30);
//        
//    }

    
    // Draw the background with shadow
    [[UIColor colorWithRed:R/255 green:G/255 blue:B/255 alpha:A] setFill];
    
    float x = DROPDOWNVIEW_SCREENINSET;
    float y = DROPDOWNVIEW_SCREENINSET;
    float width = bgRect.size.width;
    float height2 = bgRect.size.height;
    CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, x, y + RADIUS);
	CGPathAddArcToPoint(path, NULL, x, y, x + RADIUS, y, RADIUS);
	CGPathAddArcToPoint(path, NULL, x + width, y, x + width, y + RADIUS, RADIUS);
	CGPathAddArcToPoint(path, NULL, x + width, y + height2, x + width - RADIUS, y + height2, RADIUS);
	CGPathAddArcToPoint(path, NULL, x, y + height2, x, y + height2 - RADIUS, RADIUS);
	CGPathCloseSubpath(path);
	CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    CGPathRelease(path);
    
    // Draw the title and the separator with shadow
    CGContextSetShadowWithColor(ctx, CGSizeMake(1, 1), 0.5f, [UIColor blackColor].CGColor);
    [[UIColor colorWithWhite:1 alpha:1.] setFill];
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)) {
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:16.0];
        UIColor *cl=[UIColor whiteColor];
        
        NSDictionary *attributes = @{ NSFontAttributeName: font,NSForegroundColorAttributeName:cl};
        [_kTitleText drawInRect:titleRect withAttributes:attributes];
    }
    else
    {
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:16.0];
        UIColor *cl=[UIColor whiteColor];
        
        NSDictionary *attributes = @{ NSFontAttributeName: font,NSForegroundColorAttributeName:cl};
        [_kTitleText drawInRect:titleRect withAttributes:attributes];
    
    }
     //   [_kTitleText drawInRect:titleRect withFont:[UIFont systemFontOfSize:16.]];
    
    CGContextFillRect(ctx, separatorRect);
}

-(void)SetBackGroundDropDown_R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alph {
    R=r;
    G=g;
    B=b;
    A=alph;
}

@end
