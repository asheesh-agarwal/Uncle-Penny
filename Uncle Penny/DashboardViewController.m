//
//  DashboardViewController.m
//  Uncle Penny
//
//  Created by Asheesh Agarwal on 10/10/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "DashboardViewController.h"

@interface DashboardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *avgMonthlyExp;

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.avgMonthlyExp.numberOfLines=3;
    self.avgMonthlyExp.text= @"Average Monthly Expense";
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
