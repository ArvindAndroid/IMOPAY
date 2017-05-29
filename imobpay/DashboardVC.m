//
//  DashboardVC.m
//  imobpay
//
//  Created by Minkle Garg on 28/05/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "DashboardVC.h"
#import "Constants.h"
#import "ParseApi.h"
#import "ActivityCell.h"
@interface DashboardVC ()<UITableViewDelegate,UITableViewDataSource, UserMgrDelegate>
{
    UIColor *gdColorupper;
    UIColor *gdColormiddle;
    UIColor *gdColorbottom;
    BOOL collapsed;
}
@property(nonatomic,weak)IBOutlet UITableView *activityTableView;
@property(nonatomic,weak)IBOutlet UIView *upperview;
@property(nonatomic,weak)IBOutlet UIView *middleview;
@property(nonatomic,weak)IBOutlet UIView *bottomview;
@property(nonatomic,weak)IBOutlet UILabel *amount;
@property(nonatomic,weak)IBOutlet UIView *userName;
@property(nonatomic,weak)IBOutlet UILabel *toprequest;
@property(nonatomic,retain)NSMutableArray *activities;

@end

@implementation DashboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    collapsed = YES;
    [self.activityTableView registerNib:[UINib nibWithNibName:@"ActivityCell"
                                                   bundle:nil]
             forCellReuseIdentifier:@"ActivityCell"];
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
    ParseApi *obj = [[ParseApi alloc]init];
    obj.delegate = self;
    [obj callApi:GetBalance parameters:[NSDictionary dictionaryWithObjectsAndKeys:@"123456789",@"user_id", nil] type:@"GetBalance" currentcontroller:self];
    // Do any additional setup after loading the view.
}

-(void)response:(NSDictionary*)responseobject type:(NSString *)type
{
    BOOL status = [[responseobject objectForKey:@"status"] boolValue];
    ParseApi *obj = [[ParseApi alloc]init];
    obj.delegate = self;

    if (status) {
        if ([type isEqualToString:@"GetBalance"]) {
            self.amount.text = [NSString stringWithFormat:@"$%@",responseobject[@"data"][@"balance"]];
            [obj callApi:TransHistory parameters:[NSDictionary dictionaryWithObjectsAndKeys:@"123456789",@"user_id",@"week",@"period", nil] type:@"TransHistory" currentcontroller:self];
        }
        else
        {
            self.activities = [[NSMutableArray alloc]init];
            self.activities =responseobject[@"data"];
            [self.activityTableView reloadData];

        }
    }else
    {
        [obj showalert:[responseobject objectForKey:@"msg"] currentcontroller:self];
    }
    NSLog(@"response..%@",responseobject);
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
#pragma mark - Table view data source and Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (!collapsed)
    {
        return [self.activities count];
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,tableView.frame.size.width,50)];
    [self setControllerbackground];
    setgradientView(view, gdColorupper, gdColormiddle, gdColorbottom);
    // view.backgroundColor = [UIColor colorWithRed:58.0/255.0 green:89.0/255.0 blue:153.0/255.0 alpha:1.0];
    //view.backgroundColor = [UIColor clearColor];
    UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(10,view.frame.size.height/2-10,20,20)];
    
    if (collapsed)
    {
        dot.image=[UIImage imageNamed:@"down"];
        
    }
    else
    {
        dot.image=[UIImage imageNamed:@"up"];
    }
    
    [view addSubview:dot];
    
    UILabel *locatioName = [[UILabel alloc]initWithFrame:CGRectMake(35,0,view.frame.size.width -100,50)];
    locatioName.tag=5;
    locatioName.textAlignment = NSTextAlignmentLeft;
    NSString *myString = [NSString stringWithFormat:@"%@",@"Activity"];
    locatioName.text = myString;
    locatioName.font = [UIFont fontWithName:@"Helvetica-Semibold" size:12];
    locatioName.backgroundColor =[UIColor clearColor];
    locatioName.textColor =[UIColor whiteColor];
    [view addSubview:locatioName];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
    button.tag = section;
    button.contentHorizontalAlignment = UIViewContentModeBottomLeft;
    button.backgroundColor= [UIColor clearColor];
    [button addTarget:self action:@selector(filtersButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UILabel *singleline = [[UILabel alloc] initWithFrame:CGRectMake(0, 48, view.frame.size.width, 1)];
    singleline.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:singleline];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // static NSString *CellIdentifier = @"Cell";
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"
                                                      forIndexPath:indexPath];
  //  UITableViewCell *cell = [self.activityTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    cell.activityDate.text = [[self.activities objectAtIndex:indexPath.row]objectForKey:@"date"];
    cell.activityDesc.text = [[self.activities objectAtIndex:indexPath.row]objectForKey:@"description"];
   // cell.activityTime.text = [[self.activities objectAtIndex:indexPath.row]objectForKey:@"time"];

//    cell.textLabel.numberOfLines = 0;
//    cell.textLabel.textColor = [UIColor darkGrayColor];
//    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    return cell;
}

- (void)filtersButtonAction:(UIButton *)sender
{
    if (collapsed)
    {
        collapsed = NO;
    }
    else
    {
        collapsed = YES;
    }
    [self.activityTableView reloadData];
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
