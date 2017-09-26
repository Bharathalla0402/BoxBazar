//
//  CarDescriptionViewController.m
//  BoxBazar
//
//  Created by bharat on 02/09/16.
//  Copyright © 2016 Bharat. All rights reserved.
//

#import "CarDescriptionViewController.h"
#import "ApiRequest.h"
#import "LCBannerView.h"
#import "UIImageView+WebCache.h"

#import "DejalActivityView.h"
#import "LoginandRegisterViewController.h"
#import "BoxBazarUrl.pch"
#import "ChatingDetailsViewController.h"
#import "DetailsViewController.h"

@interface CarDescriptionViewController ()<ApiRequestdelegate,LCBannerViewDelegate>
{
    ApiRequest *requested;
    UIView *topview,*popview,*footerview;
    
    UIScrollView *categoryScrollView;
    
    UILabel *titlelab;
    int x;
    
    NSArray *URLs;
    
    NSString *UserId;
    NSString *postUserId;
    NSString *postId;
    NSString *posturl;
    UIButton *favbutt;
    int a;
    UIButton *buttla;
    
    BOOL fav;
    UIImageView *imaged;
    NSString *jsonStr1;
}

@property (nonatomic, weak) LCBannerView *bannerView1;
@property (nonatomic, weak) LCBannerView *bannerView2;
@end

@implementation CarDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"bana"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    self.view.backgroundColor=[UIColor colorWithRed:255.0/255.0f green:255.0/255.0f blue:255.0/255.0f alpha:1.0];
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    
    [self customView];
    
    NSString *strval=[NSString stringWithFormat:@"%@",[_strDataArray valueForKey:@"favorite"]];
    
    if ([strval isEqualToString:@"0"])
    {
        fav=NO;
    }
    else
    {
        fav=YES;
    }
}



-(void)customView
{
    topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    topview.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [self.view addSubview:topview];
    
    UIButton *Backbutt=[[UIButton alloc] initWithFrame:CGRectMake(10, topview.frame.size.height/2-5, 25, 25)];
    [Backbutt setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    Backbutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [Backbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Backbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Backbutt addTarget:self action:@selector(BackbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt];
    
    UIButton *Backbutt2=[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
    [Backbutt2 addTarget:self action:@selector(BackbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt2.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt2];
    
    UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(topview.frame.size.width/2-120, topview.frame.size.height/2-15, 240, 40)];
    lbltitle.text=_strtitle;
    lbltitle.textColor=[UIColor whiteColor];
    lbltitle.textAlignment=NSTextAlignmentCenter;
    lbltitle.font=[UIFont boldSystemFontOfSize:16];
    lbltitle.numberOfLines=2;
    [topview addSubview:lbltitle];
    
    UIImageView *imaged2=[[UIImageView alloc] initWithFrame:CGRectMake(topview.frame.size.width-34, topview.frame.size.height/2-5, 24, 24)];
    imaged2.image=[UIImage imageNamed:@"menu-2.png"];
    [topview addSubview:imaged2];
    
    UIButton *Backbutt3=[[UIButton alloc] initWithFrame:CGRectMake(topview.frame.size.width-50, 5, 50, 50)];
    [Backbutt3 addTarget:self action:@selector(SharebuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt3.backgroundColor=[UIColor clearColor];
    [topview addSubview:Backbutt3];


    
    categoryScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height)];
  
    [self.view addSubview:categoryScrollView];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.contentSize = CGSizeMake(0, 300);
    [categoryScrollView addSubview:scrollView];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"b2" forKey:@"banar"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
  //  NSArray *URLs=[[_strDataArray valueForKey:@"pic"] valueForKey:@"url"];
    
    
    NSArray *URL=_strUrls;
    
    URLs=_strUrls;

    if (URL == (id)[NSNull null] || [URL count] == 0)
    {
        UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300.0f)];
        image.image=[UIImage imageNamed:@"upload-empty.png"];
        image.contentMode = UIViewContentModeScaleAspectFill;
        [scrollView addSubview:image];
        
//        [scrollView addSubview:({
//            
//            LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(self.view.frame.size.width/2-150, 10, 300, 180.0f)
//                                                                delegate:self
//                                                               imageURLs:URLs
//                                                    placeholderImageName:@"upload-empty.png"
//                                                            timeInterval:300.0f
//                                           currentPageIndicatorTintColor:[UIColor whiteColor]
//                                                  pageIndicatorTintColor:[UIColor whiteColor]];
//            self.bannerView1 = bannerView;
//        })];

    }
    else
    {
      //  URLs=_strUrls;
        
        NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:_strUrls];
        URLs = [orderedSet array];
        
        if (URLs.count==1)
        {
//            NSString *strdata=[URLs componentsJoinedByString:@","];
//            UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300.0f)];
//            [image sd_setImageWithURL:[NSURL URLWithString:strdata]
//                     placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
//            image.contentMode = UIViewContentModeScaleAspectFill;
//            [scrollView addSubview:image];
//            
//            UIButton *buttonclick=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300.0f)];
//            buttonclick.backgroundColor=[UIColor clearColor];
//            [buttonclick addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
//            [scrollView addSubview:buttonclick];
            
            
            [scrollView addSubview:({
                
                LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300.0f)
                                                                    delegate:self
                                                                   imageURLs:URLs
                                                        placeholderImageName:@"upload-empty.png"
                                                                timeInterval:60.0f
                                               currentPageIndicatorTintColor:[UIColor clearColor]
                                                      pageIndicatorTintColor:[UIColor clearColor]];
                
                
                bannerView.didClickedImageIndexBlock = ^(LCBannerView *bannerView, NSInteger index) {
                    
                    NSLog(@"Block: Clicked image in %p at index: %d", bannerView, (int)index);
                    
                    DetailsViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
                    detail.strUrls=URLs;
                    [self.navigationController pushViewController:detail animated:YES];
                    
                    //  [self presentationView];
                };
                self.bannerView1 = bannerView;
            })];

        }
        else
        {
        
            [scrollView addSubview:({
                
                LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300.0f)
                                                                    delegate:self
                                                                   imageURLs:URLs
                                                        placeholderImageName:@"upload-empty.png"
                                                                timeInterval:60.0f
                                               currentPageIndicatorTintColor:[UIColor redColor]
                                                      pageIndicatorTintColor:[UIColor whiteColor]];
                
                
                bannerView.didClickedImageIndexBlock = ^(LCBannerView *bannerView, NSInteger index) {
                    
                    NSLog(@"Block: Clicked image in %p at index: %d", bannerView, (int)index);
                    
                    DetailsViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
                    detail.strUrls=URLs;
                    [self.navigationController pushViewController:detail animated:YES];
                    
                    //  [self presentationView];
                };
                self.bannerView1 = bannerView;
            })];

        }
        
    }
    
    
    UIImageView *imagebig=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-46, 256, 36, 36)];
    imagebig.image=[UIImage imageNamed:@"ic_aspect_ratio_white_3x.png"];
    imagebig.contentMode = UIViewContentModeScaleAspectFill;
    [scrollView addSubview:imagebig];
    
    
    
    UIView *titleview=[[UIView alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 50)];
    titleview.backgroundColor=[UIColor colorWithRed:248.0/255.0f green:248.0/255.0f blue:248.0/255.0f alpha:1.0];
    [categoryScrollView addSubview:titleview];
    
    titlelab=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.view.frame.size.width-39, 40)];
    titlelab.text=_strtitle;
    titlelab.numberOfLines=2;
    titlelab.font=[UIFont boldSystemFontOfSize:15];
    [titleview addSubview:titlelab];
    
    
    favbutt=[[UIButton alloc] initWithFrame:CGRectMake(titleview.frame.size.width-34, 13, 24, 24)];
    NSString *strid=[NSString stringWithFormat:@"%@",[_strDataArray valueForKey:@"favorite"]];
    
    if ([strid isEqualToString:@"1"])
    {
        [favbutt setImage:[UIImage imageNamed:@"hearts.png"] forState:UIControlStateNormal];
        [favbutt addTarget:self action:@selector(favoritelistClickedb1:) forControlEvents:UIControlEventTouchUpInside];
        a=1;
    }
    else
    {
        [favbutt setImage:[UIImage imageNamed:@"favorite-2.png"] forState:UIControlStateNormal];
        [favbutt addTarget:self action:@selector(favoritelistClickedb2:) forControlEvents:UIControlEventTouchUpInside];
        a=1;
    }
    favbutt.hidden=YES;
    [titleview addSubview:favbutt];
    
    UIView *Descriptionview=[[UIView alloc]initWithFrame:CGRectMake(0, titleview.frame.size.height+titleview.frame.origin.y+5, self.view.frame.size.width, 40)];
    Descriptionview.backgroundColor=[UIColor colorWithRed:248.0/255.0f green:248.0/255.0f blue:248.0/255.0f alpha:1.0];
    [categoryScrollView addSubview:Descriptionview];
    
    UILabel *Descriptionlab=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.view.frame.size.width-20, 30)];
    Descriptionlab.text=@"Description";
    Descriptionlab.backgroundColor=[UIColor colorWithRed:248.0/255.0f green:248.0/255.0f blue:248.0/255.0f alpha:1.0];
    [Descriptionview addSubview:Descriptionlab];
    
//    UITextView *desview=[[UITextView alloc]initWithFrame:CGRectMake(5, Descriptionview.frame.size.height+Descriptionview.frame.origin.y+3, self.view.frame.size.width-10, 100)];
//    desview.text=[_strDataArray valueForKey:@"description"];
//    desview.textAlignment=NSTextAlignmentNatural;
//    desview.layer.borderColor=[[UIColor lightGrayColor]CGColor];
//    desview.layer.borderWidth=1.0;
//    desview.font = [UIFont systemFontOfSize:15];
//    desview.backgroundColor=[UIColor clearColor];
//    [categoryScrollView addSubview:desview];
    
    UIWebView *desview=[[UIWebView alloc]initWithFrame:CGRectMake(5, Descriptionview.frame.size.height+Descriptionview.frame.origin.y+3, self.view.frame.size.width-10, 100)];
    NSString *urlString=[[NSString alloc]init];
    urlString = [_strDataArray valueForKey:@"description"];
    NSString *htmlString = [NSString stringWithFormat:@"<span style=\"font-family: %@; font-size: %i\">%@</span>",
                            @"Helvetica Neue",
                            14,
                            urlString];
    
    [desview loadHTMLString:htmlString baseURL:nil];
    desview.backgroundColor=[UIColor clearColor];
    [categoryScrollView addSubview:desview];
    
    UILabel *Adlab1=[[UILabel alloc]initWithFrame:CGRectMake(0, desview.frame.size.height+desview.frame.origin.y+5, self.view.frame.size.width, 30)];
    Adlab1.backgroundColor=[UIColor colorWithRed:248.0/255.0f green:248.0/255.0f blue:248.0/255.0f alpha:1.0];
    [categoryScrollView addSubview:Adlab1];
    
    UILabel *Adlab=[[UILabel alloc]initWithFrame:CGRectMake(10, desview.frame.size.height+desview.frame.origin.y+5, self.view.frame.size.width-20, 30)];
    Adlab.text=@"Ad Details";
    Adlab.backgroundColor=[UIColor colorWithRed:248.0/255.0f green:248.0/255.0f blue:248.0/255.0f alpha:1.0];
    [categoryScrollView addSubview:Adlab];
    
    NSMutableDictionary *dataarray=[[_strDataArray valueForKey:@"detail"] mutableCopy];
    [dataarray removeObjectForKey:@"id"];
    [dataarray removeObjectForKey:@"locality"];
    
    NSUInteger keyCount = [dataarray  count];
    NSLog(@"%lu", (unsigned long)keyCount);
    
    NSArray *arrkeys=[dataarray allKeys];
    NSArray *arrVlues=[dataarray allValues];
    
    
    UIView *detailview=[[UIView alloc] initWithFrame:CGRectMake(0, Adlab.frame.size.height+Adlab.frame.origin.y, self.view.frame.size.width, keyCount*42-5+6)];
    x=0;
    for (int i=0; i<dataarray.count; i++)
    {
        UILabel *labname=[[UILabel alloc] initWithFrame:CGRectMake(10, x+5, 120, 35)];
        NSString *strkey=[arrkeys objectAtIndex:i];
        if (strkey == (id)[NSNull null] || strkey.length == 0 )
        {
            
        }
        else
        {
           strkey=[NSString stringWithFormat:@"%@%@",[[strkey substringToIndex:1] uppercaseString],[strkey substringFromIndex:1] ];
        }
        labname.text=strkey;
        labname.font=[UIFont systemFontOfSize:13];
        labname.numberOfLines=2;
        labname.textColor=[UIColor lightGrayColor];
        labname.textAlignment=NSTextAlignmentLeft;
        [detailview addSubview:labname];
        
        UILabel *labvalue=[[UILabel alloc] initWithFrame:CGRectMake(labname.frame.size.width+labname.frame.origin.x+10, x+6, detailview.frame.size.width-150, 35)];
        labvalue.text=[NSString stringWithFormat:@"%@",[arrVlues objectAtIndex:i]];
        labvalue.font=[UIFont systemFontOfSize:13];
        labvalue.numberOfLines=2;
        labvalue.textAlignment=NSTextAlignmentLeft;
        [detailview addSubview:labvalue];
        x+=40;
    }
    
    [categoryScrollView addSubview:detailview];
    
    
    UILabel *locationlab=[[UILabel alloc]initWithFrame:CGRectMake(0, detailview.frame.size.height+detailview.frame.origin.y+5, self.view.frame.size.width, 30)];
    locationlab.backgroundColor=[UIColor colorWithRed:248.0/255.0f green:248.0/255.0f blue:248.0/255.0f alpha:1.0];
    [categoryScrollView addSubview:locationlab];
    
    UILabel *locationlab1=[[UILabel alloc]initWithFrame:CGRectMake(10, detailview.frame.size.height+detailview.frame.origin.y+5, self.view.frame.size.width-20, 30)];
    locationlab1.text=@"Location";
    locationlab1.backgroundColor=[UIColor colorWithRed:248.0/255.0f green:248.0/255.0f blue:248.0/255.0f alpha:1.0];
    [categoryScrollView addSubview:locationlab1];
    
//    MKMapView *mapview=[[MKMapView alloc] initWithFrame:CGRectMake(2, locationlab1.frame.size.height+locationlab1.frame.origin.y+2, self.view.frame.size.width-4, 200)];
//    mapview.hidden=YES;
//    [categoryScrollView addSubview:mapview];
    
   
    
    NSString *strlat=[[_strDataArray valueForKey:@"location"] valueForKey:@"latitude"];
    NSString *strlong=[[_strDataArray valueForKey:@"location"] valueForKey:@"longitude"];
    latitude=[strlat floatValue];
    longitude=[strlong floatValue];
    NSString *currentLatLong = [NSString stringWithFormat:@"%f,%f",latitude,longitude];
    
    [self getAddressFromLatLong:currentLatLong];
    
    
    UILabel *address=[[UILabel alloc]initWithFrame:CGRectMake(10, locationlab1.frame.size.height+locationlab1.frame.origin.y+5, 80, 35)];
    address.text=@"Address :";
    address.font=[UIFont boldSystemFontOfSize:14];
    address.numberOfLines=2;
   // address.hidden=YES;
    address.textAlignment=NSTextAlignmentLeft;
    [categoryScrollView addSubview:address];
    
    UILabel *addressname=[[UILabel alloc]initWithFrame:CGRectMake(address.frame.size.width+address.frame.origin.x+10,locationlab1.frame.size.height+locationlab1.frame.origin.y+5, self.view.frame.size.width-110, 35)];
    addressname.text=[NSString stringWithFormat:@"%@",jsonStr1];
    addressname.font=[UIFont systemFontOfSize:13];
    addressname.numberOfLines=2;
  //  addressname.hidden=YES;
    addressname.textAlignment=NSTextAlignmentLeft;
    [categoryScrollView addSubview:addressname];
    
    
    mapview=[[GMSMapView alloc] initWithFrame:CGRectMake(2, address.frame.size.height+address.frame.origin.y+2, self.view.frame.size.width-4, 200)];
    mapview.delegate=self;
    marker = [[GMSMarker alloc] init];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                                longitude:longitude
                                                                     zoom:14];
    mapview.camera=camera;
    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
    marker.title=jsonStr1;
    marker.map = mapview;
    [categoryScrollView addSubview:mapview];
    
    
    UILabel *sellarDetaillab=[[UILabel alloc]initWithFrame:CGRectMake(0, mapview.frame.size.height+mapview.frame.origin.y+5, self.view.frame.size.width, 30)];
    sellarDetaillab.backgroundColor=[UIColor whiteColor];
    [categoryScrollView addSubview:sellarDetaillab];
    
    UILabel *sellarDetaillab1=[[UILabel alloc]initWithFrame:CGRectMake(10, mapview.frame.size.height+mapview.frame.origin.y+5, self.view.frame.size.width-20, 30)];
    sellarDetaillab1.text=@"Seller Detail";
    sellarDetaillab1.backgroundColor=[UIColor whiteColor];
    [categoryScrollView addSubview:sellarDetaillab1];
    
    UIView *detailsview=[[UIView alloc]initWithFrame:CGRectMake(0, sellarDetaillab1.frame.size.height+sellarDetaillab1.frame.origin.y, self.view.frame.size.width, 105)];
    detailsview.backgroundColor=[UIColor colorWithRed:248.0/255.0f green:248.0/255.0f blue:248.0/255.0f alpha:1.0];
    [categoryScrollView addSubview:detailsview];
    
    
    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(10, detailsview.frame.size.height/2-40, 80, 80)];
  
    [image sd_setImageWithURL:[NSURL URLWithString:[[_strDataArray valueForKey:@"user"] valueForKey:@"profil_pic"]]
             placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
    image.layer.cornerRadius = image.frame.size.height /2;
    image.layer.masksToBounds = YES;
    image.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
   // image.backgroundColor=[UIColor colorWithRed:255.0/255.0f green:174.0/255.0f blue:185.0/255.0f alpha:1.0];
    image.contentMode = UIViewContentModeScaleAspectFill;
//    UIImage *imag = [self makeRoundedImage:[imaget image]
//                                     radius: 5.0f];
   
//    image.clipsToBounds = YES;
//    image.layer.cornerRadius  = 5.0f;
//    image.layer.masksToBounds  = YES;
    
    [detailsview addSubview:image];
    
    UILabel *labname=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+10, detailsview.frame.size.height/2-32, detailsview.frame.size.width-110, 25)];
    labname.text=[[_strDataArray valueForKey:@"user"] valueForKey:@"name"];
    labname.font=[UIFont systemFontOfSize:13];
    [detailsview addSubview:labname];
    
    UILabel *labemail=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+10, detailsview.frame.size.height/2-10, detailsview.frame.size.width-110, 25)];
    labemail.text=[[_strDataArray valueForKey:@"user"] valueForKey:@"email"];
    labemail.font=[UIFont systemFontOfSize:13];
    [detailsview addSubview:labemail];
    
    UILabel *labContact=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+10, detailsview.frame.size.height/2+12, detailsview.frame.size.width-110, 25)];
    labContact.text=[[_strDataArray valueForKey:@"user"] valueForKey:@"contact"];
    labContact.font=[UIFont systemFontOfSize:13];
    [detailsview addSubview:labContact];
    
    postUserId=[[_strDataArray valueForKey:@"user"] valueForKey:@"user_id"];
    postId=[_strDataArray valueForKey:@"id"];
    posturl=[_strDataArray valueForKey:@"url_parameter"];
    UserId=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
    
  //  NSLog(@"Post UserId: %@",postUserId);
  //   NSLog(@"Post Id: %@",postId);
  //   NSLog(@"URL Parameter: %@",posturl);
   // NSLog(@"UserId: %@",UserId);
    
    
    categoryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 300+745+(keyCount*45)-(keyCount));
    
    UIButton *callbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width/2-1, 40)];
    callbutton.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [callbutton setTitle:@"Call" forState:UIControlStateNormal];
    callbutton.titleLabel.font = [UIFont systemFontOfSize:20];
    callbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [callbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [callbutton addTarget:self action:@selector(CallButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:callbutton];
    
    
    UILabel *lblmiddle=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-1, self.view.frame.size.height-40, 2, 40)];
    lblmiddle.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:lblmiddle];
    
    
    UIButton *chatbutton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+1, self.view.frame.size.height-40, self.view.frame.size.width/2-1, 40)];
    chatbutton.backgroundColor=[UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    [chatbutton setTitle:@"Chat" forState:UIControlStateNormal];
    chatbutton.titleLabel.font = [UIFont systemFontOfSize:20];
    chatbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [chatbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [chatbutton addTarget:self action:@selector(ChatButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chatbutton];
    
    
    NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
    
    if ([struseridnum isEqualToString:postUserId])
    {
        callbutton.hidden=YES;
        chatbutton.hidden=YES;
        lblmiddle.hidden=YES;
    }
    else
    {
        callbutton.hidden=NO;
        chatbutton.hidden=NO;
        lblmiddle.hidden=NO;
    }

}




-(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius;
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

#pragma mark-Get address from latlng

-(NSString*)getAddressFromLatLong : (NSString *)latLng
{
    NSString *esc_addr =  [latLng stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@&sensor=true", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    NSMutableDictionary *data = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding]options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *dataArray = (NSMutableArray *)[data valueForKey:@"results" ];
    if (dataArray.count == 0)
    {
        NSString *message =@"No Address Found";
        UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
        [toast show];
        int duration = 1; // in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [toast dismissWithClickedButtonIndex:0 animated:YES];
        });
        
        
    }
    else
    {
        for (id firstTime in dataArray) {
            jsonStr1 = [firstTime valueForKey:@"formatted_address"];
            NSLog(@"%@",jsonStr1);
            return jsonStr1;
        }
    }
    return nil;
}


#pragma mark - Sort By Date Clicked

-(IBAction)CallButtClicked:(id)sender
{
    NSString *phone_number = [[[[_strDataArray valueForKey:@"user"] valueForKey:@"contact"] componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phone_number]]];
}


-(IBAction)ChatButtClicked:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject * object = [prefs objectForKey:@"userid"];
    if(object != nil)
    {
         NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *post = [NSString stringWithFormat:@"user_id=%@&post_id=%@&post_user_id=%@&post_url=%@",struseridnum,postId,postUserId,posturl];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,setConversation,english,strCityId];
       [requested sendRequest2:post withUrl:strurl];
    }
    else
    {
        LoginandRegisterViewController *lr=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginandRegisterViewController"];
        [self.navigationController pushViewController:lr animated:YES];
    }

}

-(void)responsewithToken2:(NSMutableDictionary *)responseToken
{
    NSLog(@"Registration Response: %@",responseToken);
    
    NSString *strsttus=[NSString stringWithFormat:@"%@",[responseToken valueForKey:@"status"]];
    
    if ([strsttus isEqualToString:@"1"])
    {
        ChatingDetailsViewController *chat=[self.storyboard instantiateViewControllerWithIdentifier:@"ChatingDetailsViewController"];
        chat.strConversionId=[[responseToken valueForKey:@"data"] valueForKey:@"conversation_id"];
        chat.strPostUserId=postUserId;
        [self.navigationController pushViewController:chat animated:YES];
    }
    else
    {
        [requested showMessage:[responseToken valueForKey:@"message"] withTitle:@""];
    }
}



-(void)favoritelistClickedb1:(UIButton *)sender
{
    if (a==1)
    {
        [favbutt setImage:[UIImage imageNamed:@"favorite-2.png"] forState:UIControlStateNormal];
        
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *post = [NSString stringWithFormat:@"post_id=%@&post_type=%@&user_id=%@",postId,_strurlparameter,struseridnum];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,removeFavorites,arabic,strCityId];
        [requested sendRequest3:post withUrl:strurl];
        a=2;
    }
    else
    {
        [favbutt setImage:[UIImage imageNamed:@"hearts.png"] forState:UIControlStateNormal];
        
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *post = [NSString stringWithFormat:@"post_id=%@&post_type=%@&user_id=%@",postId,_strurlparameter,struseridnum];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,addFavorites,arabic,strCityId];
        [requested sendRequest3:post withUrl:strurl];
        
        a=1;
    }
}


-(void)favoritelistClickedb2:(UIButton *)sender
{
    if (a==1)
    {
        [favbutt setImage:[UIImage imageNamed:@"hearts.png"] forState:UIControlStateNormal];
        
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *post = [NSString stringWithFormat:@"post_id=%@&post_type=%@&user_id=%@",postId,_strurlparameter,struseridnum];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,addFavorites,arabic,strCityId];
        [requested sendRequest3:post withUrl:strurl];
        
        a=2;
    }
    else
    {
        [favbutt setImage:[UIImage imageNamed:@"favorite-2.png"] forState:UIControlStateNormal];
        
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *post = [NSString stringWithFormat:@"post_id=%@&post_type=%@&user_id=%@",postId,_strurlparameter,struseridnum];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,removeFavorites,arabic,strCityId];
        [requested sendRequest3:post withUrl:strurl];
        a=1;
    }
}

-(void)responsewithToken3:(NSMutableDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
}




#pragma mark - Sort By Date Clicked

-(IBAction)SharebuttClicked:(id)sender
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-84, 300, 168)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, footerview.frame.size.width-50, 40)];
    lab.text=@"Options";
    lab.textColor=[UIColor blackColor];
    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentLeft+10;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UIButton *butt11=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60, 0, 50, 40)];
    [butt11 setTitle:@"Cancel" forState:UIControlStateNormal];
    butt11.titleLabel.font = [UIFont systemFontOfSize:15];
    butt11.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [butt11 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt11 addTarget:self action:@selector(Cancelc:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt11];
    
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(1, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width-2, 1)];
    labeunder.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:labeunder];
    
    buttla=[[UIButton alloc]initWithFrame:CGRectMake(15,labeunder.frame.origin.y+5,footerview.frame.size.width-30,40)];
    if (fav==NO)
    {
        [buttla setTitle:@"Add Favorite" forState:UIControlStateNormal];
    }
    else
    {
        [buttla setTitle:@"Remove Favorite" forState:UIControlStateNormal];
    }
    buttla.titleLabel.font = [UIFont systemFontOfSize:15];
    buttla.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [buttla setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttla addTarget:self action:@selector(AddFavclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:buttla];
    
    imaged=[[UIImageView alloc] initWithFrame:CGRectMake(footerview.frame.size.width-40, labeunder.frame.origin.y+12, 25, 25)];
    if (fav==NO)
    {
        imaged.image=[UIImage imageNamed:@"favorite-2.png"];
    }
    else
    {
        imaged.image=[UIImage imageNamed:@"hearts.png"];
    }
    [footerview addSubview:imaged];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(15, buttla.frame.origin.y+buttla.frame.size.height+2, footerview.frame.size.width-30, 40)];
    [butt1 setTitle:@"Share" forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont systemFontOfSize:15];
    butt1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [butt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt1 addTarget:self action:@selector(Shareclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt1];
    
    UIButton *butt2=[[UIButton alloc]initWithFrame:CGRectMake(15, butt1.frame.origin.y+butt1.frame.size.height+2, footerview.frame.size.width-30, 40)];
    [butt2 setTitle:@"Report Spam" forState:UIControlStateNormal];
    butt2.titleLabel.font = [UIFont systemFontOfSize:15];
    butt2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [butt2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt2 addTarget:self action:@selector(Spamclicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:butt2];
}





#pragma mark - Sort By Date Clicked

-(IBAction)Cancelc:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}


-(IBAction)AddFavclicked:(id)sender
{
    if (fav==NO)
    {
        imaged.image=[UIImage imageNamed:@"hearts.png"];
        
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *post = [NSString stringWithFormat:@"post_id=%@&post_type=%@&user_id=%@",postId,_strurlparameter,struseridnum];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,addFavorites,english,strCityId];
        [requested sendRequest4:post withUrl:strurl];
        
        fav=YES;
        [footerview removeFromSuperview];
        popview.hidden = YES;
    }
    else
    {
        imaged.image=[UIImage imageNamed:@"favorite-2.png"];
        
        NSString *struseridnum=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]];
        NSString *post = [NSString stringWithFormat:@"post_id=%@&post_type=%@&user_id=%@",postId,_strurlparameter,struseridnum];
        NSString *strtoken=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSString *strCityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"CityId"];
        NSString *strurl=[NSString stringWithFormat:@"%@%@/%@/%@/%@",BaseUrl,strtoken,removeFavorites,english,strCityId];
        [requested sendRequest4:post withUrl:strurl];
        
        fav=NO;
        [footerview removeFromSuperview];
        popview.hidden = YES;
    }
}

-(void)responsewithToken4:(NSMutableDictionary *)responseDict
{
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                    message:[responseDict valueForKey:@"message"]
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
    [toast show];
    int duration = 1; // in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [toast dismissWithClickedButtonIndex:0 animated:YES];
    });
    
}


-(IBAction)Shareclicked:(id)sender
{
    [requested showMessage:@"We will Update Soon" withTitle:@"Share"];
    
    [footerview removeFromSuperview];
    popview.hidden = YES;
    
    
//    NSArray* sharedObjects=[NSArray arrayWithObjects:@"sharecontent",  nil];
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:sharedObjects applicationActivities:nil];
//    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo];
//    [self presentViewController:activityVC animated:TRUE completion:nil];
}

-(IBAction)Spamclicked:(id)sender
{
    [requested showMessage:@"We will Update Soon" withTitle:@"Spam"];
    
    [footerview removeFromSuperview];
    popview.hidden = YES;
}


#pragma mark - PopView Clicked Clicked

-(void)presentationView
{
    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"bana"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    footerview.backgroundColor = [UIColor blackColor];
    [popview addSubview:footerview];
    
    
    UIButton *Backbutt=[[UIButton alloc] initWithFrame:CGRectMake(10, 25, 25, 25)];
    [Backbutt setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    Backbutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [Backbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Backbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Backbutt addTarget:self action:@selector(Backked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt.backgroundColor=[UIColor clearColor];
    [footerview addSubview:Backbutt];
    
    UIButton *Backbutt2=[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
    [Backbutt2 addTarget:self action:@selector(Backked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt2.backgroundColor=[UIColor clearColor];
    [footerview addSubview:Backbutt2];
    
    
    if (URLs.count==1)
    {
        NSString *strdata=[URLs componentsJoinedByString:@","];
        UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300.0f)];
        [image sd_setImageWithURL:[NSURL URLWithString:strdata]
                 placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
        image.contentMode = UIViewContentModeScaleAspectFill;
        [footerview addSubview:image];
        
        UIButton *buttonclick=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300.0f)];
        buttonclick.backgroundColor=[UIColor clearColor];
        [buttonclick addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [footerview addSubview:buttonclick];
    }
    else
    {
        [footerview addSubview:({
            
            LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-100)
                                                                delegate:self
                                                               imageURLs:URLs
                                                    placeholderImageName:@"upload-empty.png"
                                                            timeInterval:60.0f
                                           currentPageIndicatorTintColor:[UIColor redColor]
                                                  pageIndicatorTintColor:[UIColor whiteColor]];
            
            
            self.bannerView1 = bannerView;
            
        })];
    }
}


-(IBAction)Backked:(id)sender
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"bana"];
    [[NSUserDefaults standardUserDefaults]synchronize];
 
    [footerview removeFromSuperview];
    popview.hidden = YES;
}


-(IBAction)buttonTapped:(id)sender
{
    DetailsViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    detail.strUrls=URLs;
    [self.navigationController pushViewController:detail animated:YES];
}



#pragma mark - Back Clicked

-(IBAction)BackbuttClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - view life cycles

-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
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
