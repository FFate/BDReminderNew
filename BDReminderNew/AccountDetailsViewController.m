//
//  AccountDetailsViewController.m
//  BDReminderNew
//
//  Created by qinsoon on 27/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "AccountDetailsViewController.h"
#import "RenrenAccount.h"

@interface AccountDetailsViewController ()

@end

@implementation AccountDetailsViewController
@synthesize accountTypeTextField;
@synthesize loginButton;
@synthesize accountIndex;
@synthesize userNameLabel;

//---------------------------BUTTON CLICK EVENT

- (IBAction) userLogin: (id)sender {
    NSLog(@"Button clicked");
    Account* myAccount = (Account *)[[AppDelegate delegate].accountsList objectAtIndex:accountIndex];
    int accountTag = myAccount.accountTag;
    
    if (accountTag == RENREN_ACCOUNT) {
        if (![[Renren sharedRenren] isSessionValid]) {
            // no valid session, log in then
            [[Renren sharedRenren] authorizationWithPermisson:nil andDelegate:self];
        } else {
            [[Renren sharedRenren] logout:self];
        }
    }
    
    else {
        // unrecognised account tag
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unrecognised Account Type"
                                                        message:@"Something wrong happened!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)updateUserInfo:(id)sender {
    Account* myAccount = (Account *)[[AppDelegate delegate].accountsList objectAtIndex:accountIndex];
    int accountTag = myAccount.accountTag;
    
    if (accountTag == RENREN_ACCOUNT) {
        [self requestRenrenAccountInfo];
    }
}

//------------------RENREN
- (void) renrenDidLogin:(Renren *)renren {
    // this account is logged in
    Account* account = (Account*)[[AppDelegate delegate].accountsList objectAtIndex:accountIndex];
    account.accountStatus = ACCOUNT_VALID;
    [self updateAccountTypeAndInfoText:account];
    [self.loginButton setTitle:@"Log out" forState:UIControlStateNormal];
    
    // fetch new info
    [self requestRenrenAccountInfo];
}

- (void) renrenDidLogout:(Renren *)renren {
    // this account is logged out
    Account* account = (Account*)[[AppDelegate delegate].accountsList objectAtIndex:accountIndex];
    account.accountStatus = ACCOUNT_NOT_SET;
    [self updateAccountTypeAndInfoText:account];
    [self.loginButton setTitle:@"Log in" forState:UIControlStateNormal];
}

- (void) renren:(Renren *)renren loginFailWithError:(ROError *)error {
    Account* account = (Account*)[[AppDelegate delegate].accountsList objectAtIndex:accountIndex];
    account.accountStatus = ACCOUNT_AUTHENTICATION_FAILED;
    [self updateAccountTypeAndInfoText:account];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed Login Attempt"
                                                    message:@"Authentication to Renren failed. "
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) requestRenrenAccountInfo{
    // sending request
    ROUserInfoRequestParam* params = [[ROUserInfoRequestParam alloc] init];
    [[Renren sharedRenren] getUsersInfo:params andDelegate:self];
}

- (void)renren: (Renren*)renren requestDidReturnResponse:(ROResponse *)response {
    NSLog(@"requestDidReturn");
    NSArray* returnArray = (NSArray*) response.rootObject;
    ROUserResponseItem* user = (ROUserResponseItem*)[returnArray objectAtIndex:0];
    
//    RenrenAccount* account = (RenrenAccount*)[[AppDelegate delegate].accountsList objectAtIndex:accountIndex];
    
    NSString* name = [[NSString alloc] initWithString:user.name];
    NSLog(@"Returned name is: %@", name);
    Account* myAccount = (Account *)[[AppDelegate delegate].accountsList objectAtIndex:accountIndex];
    myAccount.userName = name;
    self.userNameLabel.text = name;
}

- (void)renren:(Renren *)renren requestFailWithError:(ROError*)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Fail"
                                                    message:@"Something Wrong"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) updateAccountTypeAndInfoText: (Account*)account {
    NSMutableString* accountTypeText = [[NSMutableString alloc] init];
    [accountTypeText appendString:[AccountsViewController accountNameByTag:account.accountTag]];
    [accountTypeText appendString:@" ("];
    [accountTypeText appendString:[AccountsViewController accountStatusText:account.accountStatus]];
    [accountTypeText appendString:@")"];
    
    self.accountTypeTextField.text = accountTypeText;
}

- (void) updateAccountInfo: (Account*)account {
    self.userNameLabel.text = account.userName;
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
    [self setAccountTypeTextField:nil];
    [self setLoginButton:nil];
    [self setUserNameLabel:nil];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
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
