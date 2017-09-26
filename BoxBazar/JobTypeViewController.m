//
//  JobTypeViewController.m
//  BoxBazar
//
//  Created by bharat on 24/08/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "JobTypeViewController.h"
#import "JobFilterViewController.h"
#import "JobFilterArabicViewController.h"

@interface JobTypeViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation JobTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _CustomSearchbar.barTintColor=[UIColor clearColor];
    _CustomSearchbar.searchBarStyle = UISearchBarStyleMinimal;
    
     self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    _topview.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    
    arrlistofjobs=[[NSMutableArray alloc]initWithObjects:@"Full Time Jobs",@"Work From Home",@"Part Time Jobs",@"Placement-Recruitment Agencies",@"Most Popular",@"Freelancers",@"Non-profit NGO's",@"Other Jobs",@"Internships",@"Work Abroad", nil];
}


- (IBAction)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SearchbuttClicked:(id)sender
{

}



#pragma mark - TableView Delegate Methods



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrlistofjobs.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UILabel *lblname=(UILabel*)[cell viewWithTag:1];
    
    lblname.text =[arrlistofjobs objectAtIndex:indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strCategeory =[arrlistofjobs objectAtIndex:indexPath.row];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
    {
        JobFilterViewController *filter=[self.storyboard instantiateViewControllerWithIdentifier:@"JobFilterViewController"];
        filter.strtitle=strCategeory;
        filter.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:filter animated:YES];
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
    {
        JobFilterArabicViewController *filter=[self.storyboard instantiateViewControllerWithIdentifier:@"JobFilterArabicViewController"];
        filter.strtitle=strCategeory;
        filter.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:filter animated:YES];
    }
    else
    {
        JobFilterViewController *filter=[self.storyboard instantiateViewControllerWithIdentifier:@"JobFilterViewController"];
        filter.strtitle=strCategeory;
        filter.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:filter animated:YES];
    }
}




#pragma mark - Searchbar Delegate Methods


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
