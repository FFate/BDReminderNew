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

@interface AccountsViewController ()

@end

@implementation AccountsViewController

- (NSString *)accountName:(int) accountTag{
    switch (accountTag){
        case 1: return @"Renren";
        case 2: return @"Facebook";
        //add other account
    }
    return nil;
}

- (UIImage *)iconOfAccount:(int) accountTag{
    switch (accountTag) {
        case 1: return [UIImage imageNamed:@"Renren-icon.png"];
        case 2: return [UIImage imageNamed:@"Facebook－icon.png"];
        //add other account
    }
    return nil;
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.accounts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AccountCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Account *account = [self.accounts objectAtIndex:indexPath.row];
    
    UILabel *accountNameLabel = (UILabel *)[cell viewWithTag:100];
    //accountNameLabel.text = [self accountName:account.accountTag];
    
    if(account.accountTag ==1){
        accountNameLabel.text = @"Renren";
    }else if(account.accountTag == 2){
         accountNameLabel.text = @"Facebook";
    }

    
    
    UIImageView * accountIcon = (UIImageView *)[cell viewWithTag:101];
    //accountIcon.image = [self iconOfAccount:account.accountTag];
    
    if(account.accountTag ==1){
        accountIcon.image = [UIImage imageNamed:@"Renren-icon.png"];
    }else if(account.accountTag == 2){
        accountIcon.image = [UIImage imageNamed:@"Facebook-icon.png"];
    }
    
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
