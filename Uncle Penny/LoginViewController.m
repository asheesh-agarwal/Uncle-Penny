//
//  LoginViewController.m
//  Uncle Penny
//
//  Created by Asheesh Agarwal on 10/10/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "LoginViewController.h"
#import "Communicator.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property Communicator *communicator;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    // Do any additional setup after loading the view.
}

- (IBAction)loginButtonpressed:(id)sender {
    BOOL validationStatus = [self validateInput];
    
    if(validationStatus){
        [self loginUser];
    }
    
}

- (void) loginUser {
    NSDictionary *requestData = @{@"username":self.mobileNumberTextField.text, @"password":self.passwordTextField.text};
    
    [self.communicator communicateDataForPOST:requestData ForURL:@"http:/<>/loginUser" completion:^(NSDictionary *responseData){
        
        NSLog(@"Login Response: %@", responseData);
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self handleLoginResponse:responseData];
            
        });
    }];
}

- (void) handleLoginResponse: (NSDictionary *) response {
    if([response count] > 0){
        //[[NSUserDefaults standardUserDefaults] setObject:response forKey:@"UserDetails"];
    }
    
    // TODO
    
    [self performSegueWithIdentifier:@"Dashboard" sender:self];
}

- (BOOL) validateInput {
    
    if(self.mobileNumberTextField.text == NULL || [self.mobileNumberTextField.text length] == 0){
        [self showError:@"Enter your mobile number."];
        
        return false;
        
    } else if ((self.passwordTextField.text == NULL || [self.passwordTextField.text length] == 0)){
        [self showError:@"Enter your password."];
        
        return false;
        
    }
    
    return true;
}

- (void)showError:(NSString*)errorMsg {
    NSString *msgTitle = @"Error Message";
    
    UIAlertController *error = [UIAlertController alertControllerWithTitle:msgTitle message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    
    [error addAction:okAction];
    [self presentViewController:error animated:YES completion:nil];
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
