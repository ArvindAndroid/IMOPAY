//
//  SimOrderViewController.m
//  imobpay
//
//  Created by Arvind Mehta on 27/05/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "SimOrderViewController.h"
#import "Constants.h"
#import "ParseApi.h"
@interface SimOrderViewController ()<UITextFieldDelegate, UserMgrDelegate>
@property(nonatomic,weak)IBOutlet UITextField *usernameField;
@property(nonatomic,weak)IBOutlet UITextField *phonenumberField;
@property(nonatomic,weak)IBOutlet UITextField *emailField;
@property(nonatomic,weak)IBOutlet UITextField *addressField;

@end

@implementation SimOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark textfield delegates

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameField)
    {
        [self.emailField becomeFirstResponder];
    }
    if (textField == self.emailField)
    {
        [self.phonenumberField becomeFirstResponder];
    }
    if (textField == self.phonenumberField)
    {
        [self.addressField becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return YES;
}

-(IBAction)parseAPI:(id)sender
{
    [self orderSim];
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)orderSim
{
    ParseApi *obj = [[ParseApi alloc]init];
    obj.delegate = self;
    NSString *errorText=nil;
    if (self.usernameField.text.length>0) {
        if (self.emailField.text.length>0) {
            if ([self validateEmailWithString:self.emailField.text]) {
                if (self.phonenumberField.text.length>0) {
                    if (self.phonenumberField.text.length>9) {
                        if (self.addressField.text.length>0) {
                            [obj callApi:OrderSim parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.usernameField.text,@"name",self.emailField.text,@"email",self.phonenumberField.text,@"phone",self.addressField.text,@"address", nil] type:@"OrderSim" currentcontroller:self];
                        }
                        else
                        {
                            errorText =@"Please enter address";
                            [obj showalert:errorText currentcontroller:self];
                        }
                    }
                    else
                    {
                        errorText =@"Please enter valid phone number";
                        [obj showalert:errorText currentcontroller:self];
                    }
                }else
                {
                    errorText =@"Please enter phone number";
                    [obj showalert:errorText currentcontroller:self];
                }
            }else
            {
                errorText =@"Please enter a valid email address";
                [obj showalert:errorText currentcontroller:self];
            }
        }else
        {
            errorText =@"Please enter email-id";
            [obj showalert:errorText currentcontroller:self];
        }
    }else
    {
        errorText =@"Please enter username";
        [obj showalert:errorText currentcontroller:self];
    }
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
- (IBAction)popbackStack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
