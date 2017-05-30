//
//  EachActivityCell.h
//  imobpay
//
//  Created by Minkle Garg on 30/05/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EachActivityCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *activitydate;
@property(nonatomic,weak)IBOutlet UILabel *activityType;
@property(nonatomic,weak)IBOutlet UILabel *activityPrice;
@property(nonatomic,weak)IBOutlet UILabel *activityTime;
@end
