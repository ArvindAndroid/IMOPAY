//
//  ForgotPasswordViewController.m
//  imobpay
//
//  Created by Arvind Mehta on 27/05/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()
@property (weak, nonatomic) IBOutlet UIView *_containerView;
@property (weak, nonatomic) IBOutlet UIButton *_btsend;

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    viewWithRoundedCornersSize(10, __containerView);
    buttonWithRoundedCornersSize(25, __btsend);
    // Do any additional setup after loading the view.
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


UIView* viewWithRoundedCornersSize(float cornerRadius,UIView * original)
{
    original.layer.borderColor = [UIColor blackColor].CGColor;
    original.layer.borderWidth = 1.5;
    original.layer.cornerRadius =cornerRadius;
    [original setClipsToBounds:YES];
    return original;
    }


UIView* buttonWithRoundedCornersSize(float cornerRadius,UIButton * original)
{
    original.layer.borderColor = [UIColor colorWithRed:202 green:70 blue:199 alpha:1].CGColor;
    original.layer.borderWidth = 1.5;
    original.layer.cornerRadius =cornerRadius;
    [original setClipsToBounds:YES];
    return original;
}
- (IBAction)popbackStack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
