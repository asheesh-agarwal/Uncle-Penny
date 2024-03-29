//
//  ExpandChallengeView.m
//  Uncle Penny
//
//  Created by Praveen Gupta on 10/11/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "ExpandChallengeView.h"
#import "CompeteTableViewController.h"
@interface ExpandChallengeView()
@property (weak, nonatomic) IBOutlet UILabel *challengeID;
@property (weak, nonatomic) IBOutlet UILabel *challengeName;
@property (weak, nonatomic) IBOutlet UILabel *challengeDetails;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *endDate;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIButton *enrollButton;

@end
@implementation ExpandChallengeView
-(void)viewDidLoad{

    self.challengeID.text = [[self.obj.serverResponse objectAtIndex:self.obj.indexOfCell] objectForKey:@"challenge_id"];
    self.challengeName.text = [[self.obj.serverResponse objectAtIndex:self.obj.indexOfCell] objectForKey:@"challenge_name"];
    self.challengeDetails.text = [[self.obj.serverResponse objectAtIndex:self.obj.indexOfCell] objectForKey:@"challenge_details"];
    self.startDate.text = [[self.obj.serverResponse objectAtIndex:self.obj.indexOfCell] objectForKey:@"start_date"];
    self.endDate.text = [[self.obj.serverResponse objectAtIndex:self.obj.indexOfCell] objectForKey:@"end_date"];
    if( self.obj.segSelected==0){
            self.status.text = @"Enrolled";
        self.enrollButton.hidden=YES;
    }
    else
        [self performSegueWithIdentifier:@"Enroll" sender:self];
    
}
@end
