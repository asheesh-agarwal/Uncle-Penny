//
//  FeedTableViewController.m
//  Uncle Penny
//
//  Created by Asheesh Agarwal on 10/10/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "FeedTableViewController.h"
#import "Communicator.h"

@interface FeedTableViewController ()
@property NSArray *feedServerResponse;
@property Communicator *obj;
@end

@implementation FeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.feedServerResponse = [self getDummyResponse];
    [self getFeed:@"http://<>/"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.feedServerResponse.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

-( NSArray *) getDummyResponse{
    NSDictionary *dummyResponse= @{@"End Point":@"30%", @"RequestParam1":@"param1",@"RequestParam2":@"param2",@"ResponseParam1":@"resp1",@"ResponseParam2":@"resp2"};
    NSArray *send = [[NSArray alloc] initWithObjects:dummyResponse,dummyResponse,dummyResponse,dummyResponse, dummyResponse, dummyResponse,nil];
    return send;
}
     
-(void) getFeed: (NSString*) url{
    NSDictionary *requestData = @{};
    
    [self.obj communicateDataForPOST:requestData ForURL:url completion:^(NSDictionary *responseData){
        
        NSLog(@"Challenge Response Response: %@", responseData);
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self handleFeedResponse:responseData];
            
        });
    }];

}
-(void) handleFeedResponse:(NSDictionary*) responseData{
    if([responseData count] > 0){
        //[[NSUserDefaults standardUserDefaults] setObject:response forKey:@"UserDetails"];
    }
    
    // TODO
    
    [self performSegueWithIdentifier:@"Dashboard" sender:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Feed" ];
    
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Feed"];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 0;
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friends.png"]];
//        cell.accessoryView = imageView;
    }
    NSDictionary *dict = [ self.feedServerResponse objectAtIndex:indexPath.row];
    NSString *str;
    UIImage *img;
    switch(indexPath.section){
        case 0: str=[@"John has pledged " stringByAppendingString:[dict objectForKey:@"End Point"]];
                cell.textLabel.text= [ str stringByAppendingString:@" more savings from 10/11/2015!"];
            cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"you.png"]];
                break;
        case 1: str = [@"Betty has entered the " stringByAppendingString:[dict objectForKey:@"ResponseParam1"]];
                cell.textLabel.text = [str stringByAppendingString:@" challenge with Macy and Peter on 10/8/2015"];
                cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"friends.png"]];
                break;
        case 2:cell.textLabel.text = [@"James has won his challenge by reaching " stringByAppendingString: [dict objectForKey:@"End Point"]];
            cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"compete.png"]];
            break;
        case 3:str = [@"Bertha has pledged " stringByAppendingString:[dict objectForKey:@"End Point"]];
            cell.textLabel.text= [ str stringByAppendingString:@" more savings from 10/11/2015!"];
            cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"you.png"]];
            break;
        case 4: cell.textLabel.text = [@"Dorothy has won her challenge by reaching " stringByAppendingString: [dict objectForKey:@"End Point"]];
            cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"compete.png"]];
            break;
        case 5: str =[@"Taylor has pledged " stringByAppendingString:[dict objectForKey:@"End Point"]];
            cell.textLabel.text= [ str stringByAppendingString:@" more savings from 10/11/2015!"];
            cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"you.png"]];
            break;

    }
    return cell;
}
- (CGFloat)tableView:(UITableView*)tableView
heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 6.0;
    }
    
    return 1.0;
}

- (CGFloat)tableView:(UITableView*)tableView
heightForFooterInSection:(NSInteger)section {
    return 5.0;
}

- (UIView*)tableView:(UITableView*)tableView
viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UIView*)tableView:(UITableView*)tableView
viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}
- (CGFloat)tableView:(UITableView * _Nonnull)tableView
heightForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath{
    return 100.0;
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
