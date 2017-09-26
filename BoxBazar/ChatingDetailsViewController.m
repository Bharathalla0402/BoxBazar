//
//  ChatingDetailsViewController.m
//  BoxBazar
//
//  Created by bharat on 19/12/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "ChatingDetailsViewController.h"
#import "Customcell4.h"
#import "DejalActivityView.h"
#import "BoxBazarUrl.pch"
#import "ApiRequest.h"

@interface ChatingDetailsViewController ()<ApiRequestdelegate>
{
     ApiRequest *requested;
    Customcell4 *cell;
    
    UIView *topview;
}
@end

@implementation ChatingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"appear"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;

    
    self.title=@"Chat";
    
    _TextMessage.delegate=self;
    
    arrmessage=[[NSMutableArray alloc]init];
    arrids=[[NSMutableArray alloc]init];
    arrimage=[[NSMutableArray alloc]initWithObjects:@"green.png",@"white.png", nil];
    tripdriverinfo=[[NSMutableArray alloc]init];
    
    self.ChatTable.separatorStyle = UITableViewCellSeparatorStyleNone;
  //  self.ChatTable.backgroundColor=[UIColor lightGrayColor];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Layer 1@2x.png"]];
    [tempImageView setFrame:self.ChatTable.frame];
    self.ChatTable.backgroundView = tempImageView;
    self.ChatTable.rowHeight=UITableViewAutomaticDimension;
    
    self.ChatTable.estimatedRowHeight=85;
    
    
    tripdriverinfo=[[NSUserDefaults standardUserDefaults]objectForKey:@"driverinfo"];
    
    userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"rid"];
    driverid=[NSString stringWithFormat:@"%@",[tripdriverinfo valueForKey:@"user_id"]];
    
    
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 62)];
    topview.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [self.view addSubview:topview];
    topview.hidden=YES;
    
    UIButton *Backbutt=[[UIButton alloc] initWithFrame:CGRectMake(10, topview.frame.size.height/2-3, 20, 20)];
    [Backbutt setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    Backbutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [Backbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Backbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Backbutt addTarget:self action:@selector(BackbuttClickedjf:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt];
    
    UIButton *Backbutt2=[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 55, 55)];
    [Backbutt2 addTarget:self action:@selector(BackbuttClickedjf:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt2.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt2];
    
    
    UILabel *labtitle=[[UILabel alloc]initWithFrame:CGRectMake(topview.frame.size.width/2-120, topview.frame.size.height/2-10, 240, 30)];
    labtitle.text=@"Chat";
    labtitle.font=[UIFont boldSystemFontOfSize:17];
    labtitle.textColor=[UIColor whiteColor];
    labtitle.textAlignment=NSTextAlignmentCenter;
    [topview addSubview:labtitle];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   
                                   initWithTarget:self
                                   
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(method) object:nil];
    [self performSelector:@selector(method) withObject:nil afterDelay:0.1];

}

#pragma mark - Back Clicked

-(IBAction)BackbuttClickedjf:(id)sender
{
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    //   self.searchController.active=false;
}


-(void)method
{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
    {
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&conversation_id=%@",BaseUrl,strtoken,getConversion,english,strCityId,struseridnum,_strConversionId];
        [requested OptionRequest4:nil withUrl:strurl];
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
    {
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&conversation_id=%@",BaseUrl,strtoken,getConversion,arabic,strCityId,struseridnum,_strConversionId];
        [requested OptionRequest4:nil withUrl:strurl];
    }
    else
    {
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&conversation_id=%@",BaseUrl,strtoken,getConversion,english,strCityId,struseridnum,_strConversionId];
        [requested OptionRequest4:nil withUrl:strurl];
    }
    
}


- (IBAction)ButtonClicked:(id)sender
{
    if (_TextMessage.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Enter any Message" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [self.view endEditing:YES];
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            _TextMessage.text=[_TextMessage.text stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
            _TextMessage.text=[_TextMessage.text stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
            NSString *post = [NSString stringWithFormat:@"user_id=%@&conversation_id=%@&message=%@",struseridnum,_strConversionId,_TextMessage.text];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,sendMessage,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];

        }
        else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            _TextMessage.text=[_TextMessage.text stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
            _TextMessage.text=[_TextMessage.text stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
            NSString *post = [NSString stringWithFormat:@"user_id=%@&conversation_id=%@&message=%@",struseridnum,_strConversionId,_TextMessage.text];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,sendMessage,arabic,strCityId];
            [requested sendRequest2:post withUrl:strurl];

        }
        else
        {
            NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
            _TextMessage.text=[_TextMessage.text stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
            _TextMessage.text=[_TextMessage.text stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
            NSString *post = [NSString stringWithFormat:@"user_id=%@&conversation_id=%@&message=%@",struseridnum,_strConversionId,_TextMessage.text];
            NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,sendMessage,english,strCityId];
            [requested sendRequest2:post withUrl:strurl];
        }

    }
}

-(void)responsewithToken2:(NSMutableDictionary *)responseToken
{
    NSLog(@"Registration Response: %@",responseToken);
    
    NSString *strsttus=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"status"]];
    
    if ([strsttus isEqualToString:@"1"])
    {
        _TextMessage.text=@"";
        
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&conversation_id=%@",BaseUrl,strtoken,getConversion,english,strCityId,struseridnum,_strConversionId];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:strurl]];
        [request setHTTPMethod:@"GET"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async (dispatch_get_main_queue(), ^{
                
                if (error)
                {
                    
                } else
                {
                    if(data != nil) {
                        NSError *err;
                        NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                        [self responseOption5:responseJSON];
                        [DejalBezelActivityView removeView];
                    }
                }
            });
        }] resume];
        
        if (arrids.count)
        {
            NSIndexPath *lastIndexPath = [self lastIndexPath];
            
            [_ChatTable scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        
    }
    else
    {
        [requested showMessage:[responseToken valueForKey:@"message"] withTitle:@""];
    }
}


-(void)responseOption4:(NSMutableDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    
    NSString *status = [responseDict valueForKey:@"status"];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(method2) object:nil];
        [self performSelector:@selector(method2) withObject:nil afterDelay:0.1];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        arrmessage=[[[responseDict valueForKey:@"data"]valueForKey:@"messages"]valueForKey:@"message"];
        arrids=[responseDict valueForKey:@"data"];
        
        [_ChatTable reloadData];
        
//        NSIndexPath *lastIndexPath = [self lastIndexPath];
//        
//        [_ChatTable scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
        if (arrids.count)
        {
            NSIndexPath *lastIndexPath = [self lastIndexPath];
            
            [_ChatTable scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
       
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(method2) object:nil];
        [self performSelector:@selector(method2) withObject:nil afterDelay:0.1];
    }
}


-(void)goToBottom
{
    if (arrids.count)
    {
        NSIndexPath *lastIndexPath = [self lastIndexPath];
        
        [_ChatTable scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}


-(NSIndexPath *)lastIndexPath
{
    NSInteger lastSectionIndex = MAX(0, [_ChatTable numberOfSections] - 1);
    NSInteger lastRowIndex = MAX(0, [_ChatTable numberOfRowsInSection:lastSectionIndex] - 1);
    return [NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *label1=[[UILabel alloc] init];
    label1.numberOfLines=0;
    NSArray *arr=[arrids objectAtIndex:indexPath.row];
    label1.text=[arr valueForKey:@"message"];
    CGSize labelSize = [label1.text sizeWithFont:label1.font constrainedToSize:label1.frame.size lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat labelHeight = labelSize.height;
    CGSize descriptionSize = [label1 sizeThatFits:CGSizeMake(250,labelHeight)];
    CGFloat height=descriptionSize.height+40;
   
    
    return height;
    
   //  return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrids.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str=[NSString stringWithFormat:@"%@",[[arrids valueForKey:@"type"]objectAtIndex:indexPath.row]];
    
    if ([str isEqualToString:@"sender"])
    {
        static NSString *CellClassName = @"Customcell4";
        cell = (Customcell4 *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
        
        if (cell == nil)
        {
            cell = [[Customcell4 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Customcell4"
                                                         owner:self options:nil];
            cell = [nib objectAtIndex:0];
            self.ChatTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        UILabel *label1=[[UILabel alloc] init];
        UILabel *label2=[[UILabel alloc]init];
        UIImageView *_bubbleImage=[[UIImageView alloc] init];
        
      
        
        label1.textColor=[UIColor blackColor];
        label1.numberOfLines=0;
        label1.textAlignment=NSTextAlignmentLeft;
        [label1 setAdjustsFontSizeToFitWidth:YES];
        
        label2.textAlignment=NSTextAlignmentRight;
        label2.textColor=[UIColor lightGrayColor];
        label2.font=[UIFont systemFontOfSize:12];
        
        CGSize labelSize = [label1.text sizeWithFont:label1.font constrainedToSize:label1.frame.size lineBreakMode:NSLineBreakByWordWrapping];
        CGFloat labelHeight = labelSize.height;
        
        NSArray *arr=[arrids objectAtIndex:indexPath.row];
        
        _bubbleImage.image = [[self imageNamed:@"bubbleMine"]
                              stretchableImageWithLeftCapWidth:17 topCapHeight:14];
        
        label1.text=[arr valueForKey:@"message"];
        label2.text=[arr valueForKey:@"dateTime"];
        
        
        
        CGSize descriptionSize = [label1 sizeThatFits:CGSizeMake(250,labelHeight)];
        label1.frame = CGRectMake(self.view.frame.size.width-15-descriptionSize.width,10, descriptionSize.width, descriptionSize.height);
        
        _bubbleImage.frame = CGRectMake(self.view.frame.size.width-25-descriptionSize.width,5, descriptionSize.width+25, descriptionSize.height+10);
        label2.frame = CGRectMake(10,_bubbleImage.frame.size.height+_bubbleImage.frame.origin.y-5, self.view.frame.size.width-20, 20);
       
        
        [cell addSubview:_bubbleImage];
        [cell addSubview:label1];
        [cell addSubview:label2];
        
        
        
        //        UILabel *label1=(UILabel *)[cell viewWithTag:1];
        //        UILabel *label2=(UILabel *)[cell viewWithTag:4];
        //        UIView *viewr=(UIView *) [cell viewWithTag:8];
        //
        //
        //        NSArray *arr=[arrids objectAtIndex:indexPath.row];
        //
        //
        //
        //        label1.text=[arr valueForKey:@"message"];
        //        label2.text=[arr valueForKey:@"dateTime"];
        //        [label1 setAdjustsFontSizeToFitWidth:YES];
        //
        //        label2.textColor=[UIColor lightGrayColor];
        //
        //        viewr.backgroundColor=[UIColor colorWithRed:199.0/255.0f green:97.0/255.0f blue:20.0/255.0f alpha:1.0];
        //        viewr.layer.cornerRadius = 5;
        //        viewr.layer.masksToBounds = YES;
        //        [viewr sizeToFit];
        //
        //        cell.labwidth.constant=50;
        
        
    }
    
    else if ([str isEqualToString:@"reciver"])
    {
        static NSString *CellClassName = @"Customcell4";
        
        cell = (Customcell4 *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
        
        if (cell == nil)
        {
            cell = [[Customcell4 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Customcell4"
                                                         owner:self options:nil];
            cell = [nib objectAtIndex:0];
            self.ChatTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        
        UILabel *label1=[[UILabel alloc] init];
        UILabel *label2=[[UILabel alloc]init];
        UIImageView *_bubbleImage=[[UIImageView alloc] init];
        
        
        
        label1.textColor=[UIColor blackColor];
        label1.numberOfLines=0;
        label1.textAlignment=NSTextAlignmentLeft;
        [label1 setAdjustsFontSizeToFitWidth:YES];
        
        label2.textAlignment=NSTextAlignmentLeft;
        label2.textColor=[UIColor lightGrayColor];
        label2.font=[UIFont systemFontOfSize:12];
        
        CGSize labelSize = [label1.text sizeWithFont:label1.font constrainedToSize:label1.frame.size lineBreakMode:NSLineBreakByWordWrapping];
        CGFloat labelHeight = labelSize.height;
        
        NSArray *arr=[arrids objectAtIndex:indexPath.row];
        
        _bubbleImage.image = [[self imageNamed:@"bubbleSomeone"]
                              stretchableImageWithLeftCapWidth:21 topCapHeight:14];
        
        label1.text=[arr valueForKey:@"message"];
        label2.text=[arr valueForKey:@"dateTime"];
        
        
        
        CGSize descriptionSize = [label1 sizeThatFits:CGSizeMake(250,labelHeight)];
        label1.frame = CGRectMake(25,10, descriptionSize.width, descriptionSize.height);
        
        _bubbleImage.frame = CGRectMake(10,5, descriptionSize.width+25, descriptionSize.height+10);
        label2.frame = CGRectMake(12,_bubbleImage.frame.size.height+_bubbleImage.frame.origin.y-5, self.view.frame.size.width-20, 20);
        
        
        [cell addSubview:_bubbleImage];
        [cell addSubview:label1];
        [cell addSubview:label2];

        
        
        
//        UILabel *label1=(UILabel *)[cell viewWithTag:2];
//        UILabel *label2=(UILabel *)[cell viewWithTag:5];
//        UIView *viewr=(UIView *) [cell viewWithTag:9];
//        
//        label2.textColor=[UIColor lightGrayColor];
//        
//        NSArray *arr=[arrids objectAtIndex:indexPath.row];
//        
//        viewr.backgroundColor=[UIColor whiteColor];
//        viewr.layer.cornerRadius = 5;
//        viewr.layer.masksToBounds = YES;
//      
//        
//        label1.text=[arr valueForKey:@"message"];
//        label2.text=[arr valueForKey:@"dateTime"];
        
        
    }
    return cell;
}

-(UIImage *)imageNamed:(NSString *)imageName
{
    return [UIImage imageNamed:imageName
                      inBundle:[NSBundle bundleForClass:[self class]]
 compatibleWithTraitCollection:nil];
}


- (void)dismissKeyboard
{
    [_TextMessage resignFirstResponder];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -250., self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y +250., self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}
-(void)method2
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"English"])
    {
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&conversation_id=%@",BaseUrl,strtoken,getConversion,english,strCityId,struseridnum,_strConversionId];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:strurl]];
        [request setHTTPMethod:@"GET"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async (dispatch_get_main_queue(), ^{
                
                if (error)
                {
                    
                } else
                {
                    if(data != nil) {
                        NSError *err;
                        NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                        [self responseOption5:responseJSON];
                        [DejalBezelActivityView removeView];
                    }
                }
            });
        }] resume];
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"language"] isEqualToString:@"Arabic"])
    {
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&conversation_id=%@",BaseUrl,strtoken,getConversion,arabic,strCityId,struseridnum,_strConversionId];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:strurl]];
        [request setHTTPMethod:@"GET"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async (dispatch_get_main_queue(), ^{
                
                if (error)
                {
                    
                } else
                {
                    if(data != nil) {
                        NSError *err;
                        NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                        [self responseOption5:responseJSON];
                        [DejalBezelActivityView removeView];
                    }
                }
            });
        }] resume];

    }
    else
    {
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@?user_id=%@&conversation_id=%@",BaseUrl,strtoken,getConversion,english,strCityId,struseridnum,_strConversionId];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:strurl]];
        [request setHTTPMethod:@"GET"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async (dispatch_get_main_queue(), ^{
                
                if (error)
                {
                    
                } else
                {
                    if(data != nil) {
                        NSError *err;
                        NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                        [self responseOption5:responseJSON];
                        [DejalBezelActivityView removeView];
                    }
                }
            });
        }] resume];
        

    }

}


-(void)responseOption5:(NSMutableDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    NSString *strsttus=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
    
    if ([strsttus isEqualToString:@"1"])
    {
        arrmessage=[[[responseDict valueForKey:@"data"]valueForKey:@"messages"]valueForKey:@"message"];
        arrids=[responseDict valueForKey:@"data"];
        
        [_ChatTable reloadData];
        
     
        NSString *strvalue=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"appear"]];
        
        if ([strvalue isEqualToString:@"1"])
        {
           // [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(method2) object:nil];
            [self performSelector:@selector(method2) withObject:nil afterDelay:2.0];
        }
    }
    else
    {
       // [requested showMessage:[responseDict valueForKey:@"message"] withTitle:@""];
        
        NSString *strvalue=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"appear"]];
        
        if ([strvalue isEqualToString:@"1"])
        {
           // [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(method2) object:nil];
            [self performSelector:@selector(method2) withObject:nil afterDelay:2.0];
        }
    }
}


-(void)viewWillDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"appear"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(method2) object:nil];
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
