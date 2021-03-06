//
//  Signup.m
//  imobpay
//
//  Created by Minkle Garg on 26/05/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "Signup.h"
#import "Constants.h"
#import "ParseApi.h"
@interface Signup ()<UITextFieldDelegate, UserMgrDelegate>
@property(nonatomic,weak)IBOutlet UITextField *usernameField;
@property(nonatomic,weak)IBOutlet UITextField *passwordField;
@property(nonatomic,weak)IBOutlet UITextField *confirmpasswordField;
@property(nonatomic,weak)IBOutlet UITextField *icciField;
@property(nonatomic,weak)IBOutlet UITextField *phonenumberField;
@property(nonatomic,weak)IBOutlet UITextField *emailField;
@property(nonatomic,weak)IBOutlet UITextField *addressField;
@end

@implementation Signup

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
        [self.passwordField becomeFirstResponder];
    }
    if (textField == self.passwordField)
    {
        [self.confirmpasswordField becomeFirstResponder];
    }
    if (textField == self.confirmpasswordField)
    {
        [self.phonenumberField becomeFirstResponder];
    }
    if (textField == self.phonenumberField)
    {
        [self.icciField becomeFirstResponder];
    }
    if (textField == self.icciField)
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
    [self registerfieldValidation];
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)registerfieldValidation
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
                            if (self.icciField.text.length>0) {
                                if (self.passwordField.text.length>0) {
                                    if (self.confirmpasswordField.text.length>0) {
                                        if ([self.confirmpasswordField.text isEqualToString:self.passwordField.text]) {
                                             [obj callApi:RegisterUrl parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.usernameField.text,@"name",self.emailField.text,@"password",self.phonenumberField.text,@"iccid",self.addressField.text,@"phone_number",self.icciField.text,@"email",self.passwordField.text,@"address", nil] type:@"Register" currentcontroller:self];
                                        }
                                        else
                                        {
                                            errorText =@"Please enter the same password";
                                            [obj showalert:errorText currentcontroller:self];
                                        }
                                    }
                                    else
                                    {
                                        errorText =@"Please enter confirm password";
                                        [obj showalert:errorText currentcontroller:self];
                                    }
                                }else
                                {
                                    errorText =@"Please enter password";
                                    [obj showalert:errorText currentcontroller:self];
                                }
                                
                            }else
                            {
                                errorText =@"Please enter iccid";
                                [obj showalert:errorText currentcontroller:self];
                            }
                        }else
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
        [obj showalert:@"You have successfully registered" currentcontroller:self];
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

@end
