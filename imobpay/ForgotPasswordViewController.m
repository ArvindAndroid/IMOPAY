//
//  ForgotPasswordViewController.m
//  imobpay
//
//  Created by Arvind Mehta on 27/05/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "Constants.h"
#import "ParseApi.h"
@interface ForgotPasswordViewController ()<UITextFieldDelegate, UserMgrDelegate>
@property (weak, nonatomic) IBOutlet UIView *_containerView;
@property (weak, nonatomic) IBOutlet UIButton *_btsend;
@property(nonatomic,weak)IBOutlet UITextField *emailField;


@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    viewWithRoundedCornersSize(10, __containerView);
    buttonWithRoundedCornersSize(25, __btsend);
    // Do any additional setup after loading the view.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)parseAPI:(id)sender
{
    ParseApi *obj = [[ParseApi alloc]init];
    obj.delegate = self;
    NSString *errorText=nil;
    if (self.emailField.text.length>0) {
        if ([self validateEmailWithString:self.emailField.text]) {
            [obj callApi:ForgotPassword parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.emailField.text,@"email", nil] type:@"ForgotPassword" currentcontroller:self];
        }
        else
        {
            errorText =@"Please enter a valid email address";
            [obj showalert:errorText currentcontroller:self];
        }
    }else
    {
        errorText =@"Please enter email-id";
        [obj showalert:errorText currentcontroller:self];
    }}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Email Validation
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(void)response:(NSDictionary*)responseobject type:(NSString *)type
{
    BOOL status = [[responseobject objectForKey:@"status"] boolValue];
    ParseApi *obj = [[ParseApi alloc]init];
    if (status) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@",@"You Sim Order request has been sent"] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertController dismissViewControllerAnimated:YES completion:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        });
    }else
    {
        [obj showalert:[responseobject objectForKey:@"msg"] currentcontroller:self];
    }
    
    NSLog(@"response..%@",responseobject);
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
