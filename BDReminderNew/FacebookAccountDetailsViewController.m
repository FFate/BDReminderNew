//
//  FacebookAccountDetailsViewController.m
//  BDReminderNew
//
//  Created by Wang Tian on 12-10-12.
//  Copyright (c) 2012年 qinsoon. All rights reserved.
//

#import "FacebookAccountDetailsViewController.h"

@interface FacebookAccountDetailsViewController ()

@end

@implementation FacebookAccountDetailsViewController

@synthesize loginDelegate = _loginDelegate;

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
    
    if (!FBSession.activeSession.isOpen) {
        // create a fresh session object
        FBSession.activeSession = [[FBSession alloc] init];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [FBSession.activeSession openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                // we recurse here, in order to update buttons and labels
            }];
        }
    }

    return self;
}

// any new Delegates should be added here
- (void) initDelegatesChecklist {
    self.loginDelegate = [[MyFacebookLoginDelegate alloc]initWithViewController:self];
    
}

// override
- (void)userLogin{
    [self.loginDelegate openSession];
}

-(void)logoutButtonWasPressed:(id)sender{
    [self.loginDelegate closeSession];
}

-(void)updateView{
    self.accountStatus.text = [self.account accountStatusText];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
