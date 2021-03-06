//
//  AccountDetailsViewController.m
//  BDReminderNew
//
//  Created by qinsoon on 27/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "AccountDetailsViewController.h"
#import "RenrenAccount.h"
#import "DejalActivityView.h"

@interface AccountDetailsViewController ()

@end

@implementation AccountDetailsViewController
@synthesize loginButton;
@synthesize accountIndex;
@synthesize userNameLabel;
@synthesize accountTypeLabel;
@synthesize account;

- (IBAction) userLogin: (id)sender {
    mustOverride();
}

- (IBAction)updateUserInfo:(id)sender {
    mustOverride();
}

- (void) updateAccountTypeAndInfoText: (Account*)account {
    NSMutableString* accountTypeText = [[NSMutableString alloc] init];
    [accountTypeText appendString:[account accountSiteName]];
    [accountTypeText appendString:@" ("];
    [accountTypeText appendString:[account accountStatusText]];
    [accountTypeText appendString:@")"];
    
    self.accountTypeLabel.text = accountTypeText;
}

- (void) updateAccountInfo: (Account*)account {
    self.userNameLabel.text = account.userName;
}

- (void) updateAccountStatus: (Account*) account {
    [self updateAccountTypeAndInfoText:account];
}

- (void) showLoadingOverlayWithText:(NSString*) text {
    [DejalBezelActivityView activityViewForView:self.view withLabel:text];
}

- (void) showLoadingOverlayWithText:(NSString *)text dismissAfterDelay:(NSTimeInterval)delay {
    DejalBezelActivityView* loadingView = (DejalBezelActivityView*)[DejalBezelActivityView activityViewForView:self.view withLabel:text];
    
    [loadingView performSelector:@selector(animateRemove) withObject:nil afterDelay:delay];
}

- (void) updateLoadingOverlayText:(NSString*) text {
    [DejalBezelActivityView removeViewAnimated:NO];
    [self showLoadingOverlayWithText:text];
}

- (void) dismissLoadingOverlay {
    [DejalBezelActivityView removeViewAnimated:NO];
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setLoginButton:nil];
    [self setUserNameLabel:nil];
    [self setAccountTypeLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
