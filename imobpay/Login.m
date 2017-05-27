//
//  Login.m
//  imobpay
//
//  Created by Minkle Garg on 26/05/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "Login.h"
#import "Constants.h"
#import "ParseApi.h"

@interface Login ()<UserMgrDelegate, UITextFieldDelegate>
@property(nonatomic,weak)IBOutlet UITextField *userField;
@property(nonatomic,weak)IBOutlet UITextField *pwdField;
@end

@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark textfield delegates

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userField)
    {
        [self.pwdField becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return YES;
}

-(IBAction)parseAPI:(id)sender
{
    [self loginfieldValidation];

}

-(void)loginfieldValidation
{
    ParseApi *obj = [[ParseApi alloc]init];
    obj.delegate = self;
    NSString *errorText=nil;
    if (self.userField.text.length>0) {
        if (self.pwdField.text.length>0) {
                [obj callApi:LoginUrl parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userField.text,@"username",self.pwdField.text,@"password", nil] type:@"Login" currentcontroller:self];
        }else
        {
            errorText =@"Please enter password";
            [obj showalert:errorText currentcontroller:self];
        }
    }else
    {
        errorText =@"Please enter email address";
        [obj showalert:errorText currentcontroller:self];
    }
}

-(void)response:(NSDictionary*)responseobject type:(NSString *)type
{
    BOOL status = [[responseobject objectForKey:@"status"] boolValue];
    ParseApi *obj = [[ParseApi alloc]init];
    if (status) {
        [obj showalert:@"You have successfully logged in." currentcontroller:self];
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
