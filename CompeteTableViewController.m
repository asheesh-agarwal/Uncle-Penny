//
//  CompeteTableViewController.m
//  Uncle Penny
//
//  Created by Asheesh Agarwal on 10/10/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "CompeteTableViewController.h"
#import "Communicator.h"
#import "ExpandChallengeView.h"

@interface CompeteTableViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property Communicator *communicator;

@end

@implementation CompeteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    if(self.segmentControl.selectedSegmentIndex == 0){
        [self getChallenges: @"http://<>/"];
    } else {
        [self getChallenges: @"http://<>/"];
    }
    self.segSelected= self.segmentControl.selectedSegmentIndex;
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
        [self performSegueWithIdentifier:@"ExpandedView" sender:self];
    }
    
    // TODO
    
    [self performSegueWithIdentifier:@"ExpandedView" sender:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:@"ExpandedView" sender:self];
    
    // Display Alert Message
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"ExpandedView"])
    {
        // Get reference to the destination view controller
        ExpandChallengeView *vc = [segue destinationViewController];
        
        vc.obj = [self.getDummyServerResponse objectAtIndex:0];
        // Pass any objects to the view controller here, like...
    }
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
    self.indexOfCell = indexPath.section;
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"challenge"];
    }
    
    NSDictionary *challenge = [self.serverResponse objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [challenge objectForKey:@"challenge_name"];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (NSArray*) getDummyServerResponse{
    
    
    NSDictionary *challenge = @{@"challenge_id": @"1234", @"challenge_name": @"Microsoft Saver of the Year, 2015", @"challenge_details": @"Increase your savings by 35% to win a Xbox Console", @"start_date": @"9/25/2015", @"end_date": @"10/25/2016" };
    NSDictionary *challenge2 = @{@"challenge_id": @"1234", @"challenge_name": @"Bloomberg Save the Max, 2015", @"challenge_details": @"Compete to save the maximum in a team of 4", @"start_date": @"5/25/2015", @"end_date": @"10/25/2016" };
    NSDictionary *challenge3 = @{@"challenge_id": @"1234", @"challenge_name": @"Capital One, 2015", @"challenge_details": @"Maximum increase in savings", @"start_date": @"4/8/2016", @"end_date": @"10/25/2016" };
    NSDictionary *challenge4 = @{@"challenge_id": @"1234", @"challenge_name": @"BNY Mellon,", @"challenge_details": @"Increase your savings by 50% to win a Xbox Console", @"start_date": @"9/25/2015", @"end_date": @"10/25/2016" };
    NSDictionary *challenge5 = @{@"challenge_id": @"1234", @"challenge_name": @"Microsoft Saver of the Year, 2015", @"challenge_details": @"Increase your savings by 35% to win a Xbox Console", @"start_date": @"9/25/2015", @"end_date": @"10/25/2016" };
    
    NSArray *response = [[NSArray alloc] initWithObjects:challenge, challenge2, challenge3, challenge4, challenge5, nil];
    
    
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
