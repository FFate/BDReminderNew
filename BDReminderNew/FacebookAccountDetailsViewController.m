//
//  FacebookAccountDetailsViewController.m
//  BDReminderNew
//
//  Created by Wang Tian on 12-10-2.
//  Copyright (c) 2012年 qinsoon. All rights reserved.
//

#import "FacebookAccountDetailsViewController.h"
#import "MyFacebookLoginDelegate.h"

@interface FacebookAccountDetailsViewController ()

- (IBAction)userLogin:(id)sender;
- (void) updateView;

@end

@implementation FacebookAccountDetailsViewController

@synthesize loginDelegate = _loginDelegate;
@synthesize accountStatusLabel = _accountStatusLabel;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self initDelegatesChecklist];
    return self;
}

- (void) initDelegatesChecklist {
    _loginDelegate = [[MyFacebookLoginDelegate alloc]initWithViewController:self];
}

- (void) updateAccountStatus: (Account*) account {
    self.accountStatusLabel.text = [account accountStatusText];
}

- (void)updateView {
    // get the app delegate, so that we can reference the session property
    if (_loginDelegate.session.isOpen) {
        // valid account UI is shown whenever the session is open
        [self.loginButton setTitle:@"Log out" forState:UIControlStateNormal];
        Account* account = (Account*)[[Account accountList] objectAtIndex:self.accountIndex];
        [self updateAccountStatus:account];

        } else {
        // login-needed account UI is shown whenever the session is closed
        [self.loginButton setTitle:@"Log in" forState:UIControlStateNormal];
        Account* account = (Account*)[[Account accountList] objectAtIndex:self.accountIndex];
        [self updateAccountStatus:account];

    }
}


- (IBAction)userLogin:(id)sender {
    //[self.loginDelegate openSessionWithAllowLoginUI:YES];
    
    if (FBSession.activeSession.isOpen) {
        // if a user logs out explicitly, we delete any cached token information, and next
        // time they run the applicaiton they will be presented with log in UX again; most
        // users will simply close the app or switch away, without logging out; this will
        // cause the implicit cached-token login to occur on next launch of the application
        [FBSession.activeSession closeAndClearTokenInformation];
        
    } else {
        /*if (_loginDelegate.session.state != FBSessionStateCreated) {
            // Create a new, logged out session.
            _loginDelegate.session = [[FBSession alloc] init];
        }
        
        // if the session isn't open, let's open it now and present the login UX to the user
        [_loginDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error) {
            // and here we make sure to update our UX according to the new session state
            [self updateView];
        }];*/
        [_loginDelegate openSessionWithAllowLoginUI:YES];
    }

}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    /*[self updateView];

    if(_loginDelegate.session.isOpen){
        _loginDelegate.session = [[FBSession alloc] init];
    }
    // if we don't have a cached token, a call to open here would cause UX for login to
    // occur; we don't want that to happen unless the user clicks the login button, and so
    // we check here to make sure we have a token before calling open
    if (_loginDelegate.session.state == FBSessionStateCreatedTokenLoaded) {

        // even though we had a cached token, we need to login to make the session usable
        [_loginDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                            FBSessionState status,
                                                            NSError *error) {
            // we recurse here, in order to update buttons and labels
            [self updateView];

        }];
    }*/

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
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
