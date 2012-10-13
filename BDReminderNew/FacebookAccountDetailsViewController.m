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
@synthesize userName;
@synthesize userImage;

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
    [FBProfilePictureView class];
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
    [self updateView];
}

- (void)getFriendsInfo{
    NSString *query =
    @"SELECT uid, name, pic_square, birthday FROM user WHERE uid IN "
    @"(SELECT uid2 FROM friend WHERE uid1 = me())";
    // Set up the query parameter
    NSDictionary *queryParam =
    [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
    // Make the API request that uses FQL
    [FBRequestConnection startWithGraphPath:@"/fql"
                                 parameters:queryParam
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error) {
                              if (error) {
                                  NSLog(@"Error: %@", [error localizedDescription]);
                              } else {
                                  NSLog(@"Result: %@", result);
                                  
                              }
                          }];
}

- (void)getFriendsInfoOld{
    if (FBSession.activeSession.isOpen){
        FBRequest* friendsRequest = [FBRequest requestForMyFriends];
        [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                      NSDictionary* result,
                                                      NSError *error) {
            NSArray* friends = [result objectForKey:@"data"];
            NSLog(@"Found: %i friends", friends.count);
            for (NSDictionary<FBGraphUser>* friend in friends) {
                NSLog(@"I have a friend named %@ with id %@，birthday:%@", friend.name, friend.id,friend.birthday);
            }
        }];
    }
}

-(void)updateUserInfo{
    if (FBSession.activeSession.isOpen){
        self.userName.hidden = YES;
        self.userImage.hidden = YES;
        
        FBRequest *me = [[FBRequest alloc] initWithSession:FBSession.activeSession
                                                 graphPath:@"me"];
        [me startWithCompletionHandler:^(FBRequestConnection *connection,
                                         // we expect a user as a result, and so are using FBGraphUser protocol
                                         // as our result type; in order to allow us to access first_name and
                                         // birthday with property syntax
                                         NSDictionary<FBGraphUser> *user,
                                         NSError *error) {
            if (error) {
                NSLog(@"Couldn't get info : %@", error.localizedDescription);
                return;
            }
            
            self.userName.text = [NSString stringWithFormat:@"%@",user.name];
            NSLog(@"%@",user.birthday);
            self.userImage.profileID = user.id;
            
            self.userName.hidden = NO;
            self.userImage.hidden = NO;
        }];
    }else{
        self.userName.text = @"No active user";
        self.userImage.hidden = YES;
    }
}


-(void)updateView{
    self.accountStatus.text = [self.account accountStatusText];
    [self updateUserInfo];
    //[self getFriendsInfo];
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

- (void)viewDidUnload {
    [self setUserName:nil];
    [self setUserImage:nil];
    [super viewDidUnload];
}
@end
