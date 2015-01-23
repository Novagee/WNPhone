//
//  WNPCarViewController.m
//  SinchCalling
//
//  Created by peng wan on 15-1-21.
//
//

#import "WNPCarViewController.h"
#import <Sinch/Sinch.h>
#import "CallViewController.h"

@interface WNPCarViewController () <SINCallClientDelegate>

@end

@implementation WNPCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (id<SINClient>)client {

    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] client];
}

- (IBAction)call:(id)sender {
    
    if ([self.client isStarted]) {
        id<SINCall> call = [self.client.callClient callUserWithId:@"Novagee"];
        [self performSegueWithIdentifier:@"callView" sender:call];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CallViewController *callViewController = [segue destinationViewController];
    callViewController.call = sender;
    callViewController.call.delegate = callViewController;
}

#pragma mark - SINCallClientDelegate

- (void)client:(id<SINCallClient>)client didReceiveIncomingCall:(id<SINCall>)call {
    [self performSegueWithIdentifier:@"callView" sender:call];
}

- (SINLocalNotification *)client:(id<SINClient>)client localNotificationForIncomingCall:(id<SINCall>)call {
    SINLocalNotification *notification = [[SINLocalNotification alloc] init];
    notification.alertAction = @"Answer";
    notification.alertBody = [NSString stringWithFormat:@"Incoming call from %@", [call remoteUserId]];
    return notification;
}

#pragma mark - RPSlidingMenuViewController

-(NSInteger)numberOfItemsInSlidingMenu{
    // 10 for demo purposes, typically the count of some array
    return 4;
}

- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row{
    
    // alternate for demo.  Simply set the properties of the passed in cell
    
    switch (row) {
            case 1:
            slidingMenuCell.textLabel.text = @"打的";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"CAR1"];
            break;
            
            case 2:
            slidingMenuCell.textLabel.text = @"旅行租车";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"CAR2"];
            break;
            
            case 3:
            slidingMenuCell.textLabel.text = @"购物租车";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"CAR3"];
            break;
            
            case 0:
            slidingMenuCell.textLabel.text = @"";
            slidingMenuCell.detailTextLabel.text = @"小叮当助手致力于解决您在美国生活的衣食住行，咨询和预定一律免费！我们承诺在第一时间解决您的需求。";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"CAR0"];
            break;
        default:
            break;
    }
}

- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row{
    
    [super slidingMenu:slidingMenu didSelectItemAtRow:row];
    
    // when a row is tapped do some action
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Tapped"
                                                    message:[NSString stringWithFormat:@"Row %ld tapped.", (long)row]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

@end
