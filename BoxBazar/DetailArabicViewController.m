//
//  DetailArabicViewController.m
//  BoxBazar
//
//  Created by bharat on 06/03/17.
//  Copyright © 2017 Bharat. All rights reserved.
//

#import "DetailArabicViewController.h"
#import "LCBannerView.h"
#import "UIImageView+WebCache.h"

@interface DetailArabicViewController ()<LCBannerViewDelegate>
{
    UIView *topview,*popview,*footerview,*footerview2;
    NSArray *URLs;
}
@property (nonatomic, weak) LCBannerView *bannerView1;
@end

@implementation DetailArabicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"bana"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview2=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    footerview2.backgroundColor = [UIColor blackColor];
    [popview addSubview:footerview2];
    
    
    UIButton *Backbutt=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-35, 25, 25, 25)];
    [Backbutt setImage:[UIImage imageNamed:@"rightar.png"] forState:UIControlStateNormal];
    Backbutt.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [Backbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Backbutt.titleLabel.font = [UIFont systemFontOfSize:15];
    [Backbutt addTarget:self action:@selector(Backked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt.backgroundColor=[UIColor clearColor];
    [footerview2 addSubview:Backbutt];
    
    UIButton *Backbutt2=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60, 5, 60, 60)];
    [Backbutt2 addTarget:self action:@selector(Backked:) forControlEvents:UIControlEventTouchUpInside];
    Backbutt2.backgroundColor=[UIColor clearColor];
    [footerview2 addSubview:Backbutt2];
    
    
    NSArray *URL=_strUrls;
    
    URLs=_strUrls;
    
    
    if (URL == (id)[NSNull null] || [URL count] == 0)
    {
        UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        image.image=[UIImage imageNamed:@"upload-empty.png"];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [footerview2 addSubview:image];
        
    }
    else
    {
        if (URLs.count==1)
        {
            NSString *strdata=[URLs componentsJoinedByString:@","];
            UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-100)];
            [image sd_setImageWithURL:[NSURL URLWithString:strdata]
                     placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
            image.contentMode = UIViewContentModeScaleAspectFit;
            [footerview2 addSubview:image];
        }
        else
        {
            [footerview2 addSubview:({
                
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
}


-(IBAction)Backked:(id)sender
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"bana"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [footerview removeFromSuperview];
    popview.hidden = YES;
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
