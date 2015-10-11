//
//  CompeteTableViewController.m
//  Uncle Penny
//
//  Created by Asheesh Agarwal on 10/10/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "CompeteTableViewController.h"
#import "Communicator.h"

@interface CompeteTableViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property NSArray *serverResponse;
@property Communicator *communicator;

@end

@implementation CompeteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.segmentControl.selectedSegmentIndex == 0){
        [self getChallenges: @"http://<>/"];
    } else {
        [self getChallenges: @"http://<>/"];
    }
    
    self.serverResponse = [self getDummyServerResponse];
    
    // Get the data from server based on single and group selection
}

- (void) getChallenges: (NSString*) url {
    NSDictionary *requestData = @{};
    
    [self.communicator communicateDataForPOST:requestData ForURL:url completion:^(NSDictionary *responseData){
        
        NSLog(@"Challenge Response Response: %@", responseData);
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self handleChallengeResponse:responseData];
            
        });
    }];
}

- (void) handleChallengeResponse: (NSDictionary *) response {
    if([response count] > 0){
        //[[NSUserDefaults standardUserDefaults] setObject:response forKey:@"UserDetails"];
    }
    
    // TODO
    
    [self performSegueWithIdentifier:@"Dashboard" sender:self];
}

- (IBAction)segmentControlChanged:(id)sender {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Based on number of challenges received from server display the number of rows
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.serverResponse count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"challenge"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"challenge"];
    }
    
    NSDictionary *challenge = [self.serverResponse objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [challenge objectForKey:@"challenge_name"];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    // Configure the cell...
    
    return cell;
}

- (NSArray*) getDummyServerResponse{
    
    
    NSDictionary *challenge = @{@"challenge_id": @"1234", @"challenge_name": @"This is my first challenge", @"challenge_details": @"This is my details", @"start_date": @"start_date", @"end_date": @"" };
    
    NSArray *response = [[NSArray alloc] initWithObjects:challenge, challenge, challenge, challenge, nil];
    
    
    return response;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
