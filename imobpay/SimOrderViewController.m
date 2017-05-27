//
//  SimOrderViewController.m
//  imobpay
//
//  Created by Arvind Mehta on 27/05/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "SimOrderViewController.h"

@interface SimOrderViewController ()

@end

@implementation SimOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
