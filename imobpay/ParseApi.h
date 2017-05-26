//
//  ParseApi.h
//  PointFunds
//
//  Created by Minkle Garg on 12/03/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@protocol UserMgrDelegate;

@interface ParseApi : NSObject
@property(strong,nonatomic)id<UserMgrDelegate> delegate;

-(void) callApi:(NSString*)url parameters:(NSDictionary*)parameters type:(NSString *)type currentcontroller:(UIViewController*)current;
-(void) showalert:(NSString*)reason currentcontroller:(UIViewController*)current;
-(void) passResult:(NSDictionary*)result type:(NSString *)type;
- (void)failure:(NSError*)error currentcontroller:(UIViewController*)current;

@end

@protocol UserMgrDelegate <NSObject>
- (void)response:(NSDictionary*)responseobject type:(NSString *)type;

@end
