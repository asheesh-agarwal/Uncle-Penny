//
//  RegistrationViewController.m
//  Uncle Penny
//
//  Created by Asheesh Agarwal on 10/10/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "RegistrationViewController.h"
#import "Communicator.h"

@interface RegistrationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameFieldText;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountNumberTextField;
@property Communicator *communicator;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)registerButtonPressed:(id)sender {
    BOOL validationStatus = [self validateInput];
    
    if(validationStatus){
        
        NSDictionary *requestData = @{@"firstname":self.nameFieldText.text, @"lastname":self.nameFieldText.text, @"password":self.passwordTextField.text, @"bankname":self.bankNameTextField.text, @"banknumber":self.accountNumberTextField.text, @"username":self.mobileNumberTextField.text};
        
        [self.communicator communicateDataForPOST:requestData ForURL:@"http://<>/registerUser" completion:^(NSDictionary *responseData){
            
            NSLog(@"Reg Response: %@", responseData);
            
            dispatch_async(dispatch_get_main_queue(), ^ {
                [self handleRegistrationResponse:responseData];
                
            });
        }];
    }
}

- (void) handleRegistrationResponse: (NSDictionary *) response {
    if([response count] > 0){
        //[[NSUserDefaults standardUserDefaults] setObject:response forKey:@"UserDetails"];
    }
    
    // TODO
    
    [self performSegueWithIdentifier:@"Dashboard" sender:self];
}

- (BOOL) validateInput {
    
    if(self.nameFieldText.text == NULL || [self.nameFieldText.text length] == 0){
        [self showError:@"Enter your name."];
        
        return false;
        
    } else if ((self.mobileNumberTextField.text == NULL || [self.mobileNumberTextField.text length] == 0)){
        [self showError:@"Enter your mobile number."];
        
        return false;
        
    } else if (self.passwordTextField.text == NULL || [self.passwordTextField.text length] == 0){
        [self showError:@"Enter your password."];
        
        return false;
        
    } else if (self.bankNameTextField.text == NULL || [self.bankNameTextField.text length] == 0){
        [self showError:@"Choose your bank."];
        
        return false;
        
    } else if ((self.accountNumberTextField.text == NULL || [self.accountNumberTextField.text length] == 0)){
        [self showError:@"Enter your bank account number."];
        
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
