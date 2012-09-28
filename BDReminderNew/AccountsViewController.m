//
//  AccountsViewController.m
//  BDReminderNew
//
//  Created by Wang Tian on 12-9-16.
//  Copyright (c) 2012年 qinsoon. All rights reserved.
//

#import "AccountsViewController.h"
#import "Account.h"
#import "RenrenAccount.h"
#import "FacebookAccount.h"
#import "AccountCell.h"
#import "AccountDetailsViewController.h"

@interface AccountsViewController ()

@end

@implementation AccountsViewController

+ (NSString *)accountNameByTag:(int) accountTag{
    switch (accountTag){
        case 1: return @"Renren";
        case 2: return @"Facebook";
        //add other account
    }
    return nil;
}

+ (UIImage *)iconOfAccountByTag:(int) accountTag{
    switch (accountTag) {
        case 1: return [UIImage imageNamed:@"Renren-icon.png"];
        case 2: return [UIImage imageNamed:@"Facebook-icon.png"];
        //add other account
    }
    return nil;
}

+ (NSString*)accountStatusText:(int)accountStatus {
    switch (accountStatus) {
        case ACCOUNT_VALID:
            return @"Logged in";
        case ACCOUNT_OUT_OF_DATE:
            return @"Session out of date";
        case ACCOUNT_AUTHENTICATION_FAILED:
            return @"Authentication failed";
        case ACCOUNT_NOT_SET:
            return @"Not set yet";
        default:
            return nil;
    }
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
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.accounts = [appDelegate accountsList];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
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
    return [self.accounts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AccountCell";
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Account *account = [self.accounts objectAtIndex:indexPath.row];
    
    cell.accountNameLabel.text = [AccountsViewController accountNameByTag:account.accountTag];
    cell.accountIcon.image = [AccountsViewController iconOfAccountByTag:account.accountTag];
    cell.accountStatusLabel.text = [AccountsViewController accountStatusText:account.accountStatus];
    
    return cell;
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
    //AccountDetailsViewController *accountDetailsViewController = (AccountDetailsViewController*) self.navigationController.visibleViewController;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    AccountDetailsViewController *accountDetailsViewController = (AccountDetailsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AccountDetailsViewControllerIdentifier"];
    [self.navigationController pushViewController:accountDetailsViewController animated:YES];
    
    Account* account = (Account*)[self.accounts objectAtIndex:indexPath.row];
    
    //-------set information for account details view
    
    // set account tag
    accountDetailsViewController.accountIndex = indexPath.row;
    
    // set account type and status
    [accountDetailsViewController updateAccountTypeAndInfoText:account];
    [accountDetailsViewController updateAccountInfo:account];
    
    // set login button
    NSString* loginText;
    if (account.accountStatus == ACCOUNT_VALID) {
        loginText = @"Log out";
    } else loginText = @"Log in";
    [accountDetailsViewController.loginButton setTitle:loginText forState:UIControlStateNormal];
}

@end
