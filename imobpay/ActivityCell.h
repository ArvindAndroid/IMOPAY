//
//  ActivityCell.h
//  imobpay
//
//  Created by Minkle Garg on 30/05/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel *activityDate;
@property(nonatomic,weak)IBOutlet UILabel *activityDesc;
@property(nonatomic,weak)IBOutlet UILabel *activityTime;
@end
