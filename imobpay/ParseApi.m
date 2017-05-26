//
//  ParseApi.m
//  PointFunds
//
//  Created by Minkle Garg on 12/03/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "ParseApi.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "AFURLSessionManager.h"
#import "AFURLRequestSerialization.h"
#import "AFURLResponseSerialization.h"
#import "AFNetworkReachabilityManager.h"
@implementation ParseApi

@synthesize delegate;

-(void) callApi:(NSString*)url parameters:(NSDictionary*)parameters type:(NSString *)type currentcontroller:(UIViewController*)current
{
    [SVProgressHUD show];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [SVProgressHUD dismiss];
         NSDictionary *userinfo = responseObject;
         NSLog(@"Success: %@", responseObject);
         current.view.userInteractionEnabled =YES;

         [self passResult:userinfo type:type];
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         current.view.userInteractionEnabled =YES;
         [SVProgressHUD dismiss];
         [self showalert:[NSString stringWithFormat:@"%@",error.localizedDescription] currentcontroller:current];
     }];
}

-(void)passResult:(NSDictionary *)result type:(NSString *)type
{

    [delegate response:result type:type];
}
- (void)failure:(NSError*)error currentcontroller:(UIViewController*)current;
{
    
}
-(void) showalert:(NSString*)reason currentcontroller:(UIViewController*)current
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:reason
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
   //
    //[alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [current presentViewController:alertController animated:YES completion:nil];
}

@end
