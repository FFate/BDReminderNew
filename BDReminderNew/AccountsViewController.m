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
#import "QWeiboAccount.h"
#import "AccountCell.h"
#import "AccountDetailsViewController.h"
#import "RenrenAccountDetailsViewController.h"
#import "FacebookAccountDetailsViewController.h"
#import "QWeiboAccountDetailsViewController.h"
#import "DejalActivityView.h"

@interface AccountsViewController ()

@end

@implementation AccountsViewController

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
    
    self.accounts = [Account accountList];

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
    
    cell.accountNameLabel.text = [account accountSiteName];
    cell.accountIcon.image = [account accountIcon];
    cell.accountStatusLabel.text = [account accountStatusText];
    
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
    Account* account = (Account*)[self.accounts objectAtIndex:indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    if ([account class ] == [RenrenAccount class]) {
        RenrenAccountDetailsViewController *accountDetailsViewController = (RenrenAccountDetailsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RenrenAccountDetailsViewControllerIdentifier"];
        [self.navigationController pushViewController:accountDetailsViewController animated:YES];
        
        //-------set information for account details view
        
        // set account tag
        accountDetailsViewController.accountIndex = indexPath.row;
        
        // set account type and status
        [accountDetailsViewController updateAccountStatus:account];
        [accountDetailsViewController updateAccountInfo:account];
        
        // set login button
        NSString* loginText;
        if ([account isSessionValid]) {
            loginText = @"Log out";
        } else loginText = @"Log in";
        [accountDetailsViewController.loginButton setTitle:loginText forState:UIControlStateNormal];
        
        accountDetailsViewController.account = account;
    }else if([account class] == [FacebookAccount class]){
        FacebookAccountDetailsViewController *accountDetailsViewController =
        (FacebookAccountDetailsViewController*)[storyboard instantiateViewControllerWithIdentifier:@"FacebookAccountDetailsViewControllerIdentifier"];
        [self.navigationController pushViewController:accountDetailsViewController animated:YES];
        
        accountDetailsViewController.accountIndex = indexPath.row;
        
        // set account type and status
        [accountDetailsViewController updateAccountStatus:account];
        
        /*NSString* loginText;
        if ([account isSessionValid]) {
            loginText = @"Log out";
        } else loginText = @"Log in";
        [accountDetailsViewController.loginButton setTitle:loginText forState:UIControlStateNormal];*/
        
        accountDetailsViewController.account = account;
    }else if ([account class] == [QWeiboAccount class]) {
        QWeiboAccountDetailsViewController *accountDetailsViewController =
        (QWeiboAccountDetailsViewController*)[storyboard instantiateViewControllerWithIdentifier:@"QWeiboAccountDetailsViewControllerIdentifier"];
        [self.navigationController pushViewController:accountDetailsViewController animated:YES];
        
        accountDetailsViewController.accountIndex = indexPath.row;
        
        // set login button
        NSString* loginText;
        if ([account isSessionValid]) {
            loginText = @"Log out";
        } else loginText = @"Log in";
        [accountDetailsViewController.loginButton setTitle:loginText forState:UIControlStateNormal];
        
        accountDetailsViewController.account = account;
    }
    else {
        // generic accountDetailsView
        AccountDetailsViewController* accountDetailsViewController =
        (AccountDetailsViewController*)[storyboard instantiateViewControllerWithIdentifier:@"AccountDetailsViewControllerIdentifier"];
        [self.navigationController pushViewController:accountDetailsViewController animated:YES];
        
        [accountDetailsViewController updateAccountTypeAndInfoText:account];
    }
}

@end
