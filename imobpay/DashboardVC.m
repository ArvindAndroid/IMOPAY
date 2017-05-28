//
//  DashboardVC.m
//  imobpay
//
//  Created by Minkle Garg on 28/05/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "DashboardVC.h"

@interface DashboardVC ()
{
    UIColor *gdColorupper;
    UIColor *gdColormiddle;
    UIColor *gdColorbottom;
}
@property(nonatomic,weak)IBOutlet UIView *upperview;
@property(nonatomic,weak)IBOutlet UIView *middleview;
@property(nonatomic,weak)IBOutlet UIView *bottomview;
@property(nonatomic,weak)IBOutlet UILabel *amount;
@property(nonatomic,weak)IBOutlet UIView *userName;
@property(nonatomic,weak)IBOutlet UILabel *toprequest;


@end

@implementation DashboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toprequest.text = @"TOPUP AND REQUEST";
    NSRange range1 = [self.toprequest.text rangeOfString:@"TOPUP"];
    NSRange range2 = [self.toprequest.text rangeOfString:@"AND REQUEST"];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.toprequest.text];
    [string addAttributes:@{
                            NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:13.0],
                            NSForegroundColorAttributeName : [UIColor whiteColor]
                            } range:range1];
    [string addAttributes:@{
                            NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:11.0],
                            NSForegroundColorAttributeName : [UIColor colorWithWhite:1.0 alpha:0.8]
                            } range:range2];
    self.toprequest.attributedText = string;

    for (int i=1; i<4; i++) {
        UIView *btn = [self.bottomview viewWithTag:i];
      //  btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.cornerRadius =btn.bounds.size.width/2;;
        [btn setClipsToBounds:YES];
    }
    
    [self setControllerbackground];
    setgradientView(self.upperview, gdColorupper, gdColormiddle, gdColorbottom);
    [self setsecondControllerbackground];
    setgradientView(self.middleview, gdColorupper, gdColormiddle, gdColorbottom);
    [self setthirdControllerbackground];
    setgradientView(self.bottomview, gdColorupper, gdColormiddle, gdColorbottom);

    // Do any additional setup after loading the view.
}
-(void) setControllerbackground{
    gdColorupper =  [self colorWithHexString:@"#1565C0" alpha:1];
    gdColormiddle = [self colorWithHexString:@"#303F9F" alpha:1];
    gdColorbottom = [self colorWithHexString:@"#1565C0" alpha:1];
    setgradientView(_upperview, gdColorupper, gdColormiddle, gdColorbottom);
}
-(void) setsecondControllerbackground{
    gdColorupper =  [self colorWithHexString:@"#00847D" alpha:1];
    gdColormiddle = [self colorWithHexString:@"#007885" alpha:1];
    gdColorbottom = [self colorWithHexString:@"#007086" alpha:1];
    setgradientView(_middleview, gdColorupper, gdColormiddle, gdColorbottom);
}
-(void) setthirdControllerbackground{
    gdColorupper =  [self colorWithHexString:@"#D6DCDF" alpha:1];
    gdColormiddle = [self colorWithHexString:@"#CCD5D8" alpha:1];
    gdColorbottom = [self colorWithHexString:@"#C9D4D6" alpha:1];
    setgradientView(_bottomview, gdColorupper, gdColormiddle, gdColorbottom);
}
UIView* setgradientView(UIView*  view,UIColor* gdUpper,UIColor* gdMiddle,UIColor *gdBottom)
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = view.bounds;
    gradient.colors = @[(id)gdUpper.CGColor, (id)gdMiddle.CGColor,(id)gdBottom.CGColor];
    
    [view.layer insertSublayer:gradient atIndex:0];
    return view;
}

- (UIColor* )colorWithHexString:(NSString* )str_HEX  alpha:(CGFloat)alpha_range{
    int red = 0;
    int green = 0;
    int blue = 0;
    sscanf([str_HEX UTF8String], "#%02X%02X%02X", &red, &green, &blue);
    return  [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha_range];
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
