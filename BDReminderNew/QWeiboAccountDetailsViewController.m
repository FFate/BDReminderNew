//
//  QWeiboAccountDetailsViewController.m
//  BDReminderNew
//
//  Created by qinsoon on 8/10/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "QWeiboAccountDetailsViewController.h"
#import "OpenApi.h"
#import "Contact.h"
#import "MyQWeibo.h"
#import "ContactsViewController.h"

#define oauth2TokenKey @"access_token="
#define oauth2OpenidKey @"openid="
#define oauth2OpenkeyKey @"openkey="
#define oauth2ExpireInKey @"expire_in="

@interface QWeiboAccountDetailsViewController ()

@end

@implementation QWeiboAccountDetailsViewController
@synthesize accountStatusLabel;

// override
- (IBAction) userLogin: (id)sender {
    if (![[MyQWeibo activeSession] isSessionValid]) {
        _OpenSdkOauth = [[OpenSdkOauth alloc] initAppKey:[OpenSdkBase getAppKey] appSecret:[OpenSdkBase getAppSecret]];
        [self webViewShow];
        [_OpenSdkOauth doWebViewAuthorize:_webView];
        
        // myLoginSucceed would further take care of login success event
    } else {
        if ([[MyQWeibo activeSession] revokeAuth]) {
            // logged out            
            // update Model
            self.account.identifier = nil;
            self.account.userName = nil;
            
            // update view
            [self updateAccountStatus:self.account];
            [self updateAccountInfo:self.account];
            [self.loginButton setTitle:@"Log in" forState:UIControlStateNormal];
        }
    }
}

// this initMethod will get called by
// [UIStoryboard instantiateViewControllerWithIdentifier]
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    return self;
}

- (void) webViewShow {
    
    CGFloat titleLabelFontSize = 14;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.text = @"微博登录";
    _titleLabel.backgroundColor = [UIColor lightGrayColor];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:titleLabelFontSize];
    _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleBottomMargin;
    _titleLabel.textAlignment = UITextAlignmentCenter;
    
    [self.view addSubview:_titleLabel];
    
    [_titleLabel sizeToFit];
    CGFloat innerWidth = self.view.frame.size.width;
    _titleLabel.frame = CGRectMake(
                                   0,
                                   0,
                                   innerWidth,
                                   _titleLabel.frame.size.height+6);
    
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    _webView = [[UIWebView alloc] initWithFrame:bounds];
    
    _webView.scalesPageToFit = YES;
    _webView.userInteractionEnabled = YES;
    _webView.delegate = self;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_webView];
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL* url = request.URL;
    
    NSLog(@"response url is %@", url);
	NSRange start = [[url absoluteString] rangeOfString:oauth2TokenKey];
    
    //如果找到tokenkey,就获取其他key的value值
	if (start.location != NSNotFound)
	{
        NSString *accessToken = [OpenSdkBase getStringFromUrl:[url absoluteString] needle:oauth2TokenKey];
        NSString *openid = [OpenSdkBase getStringFromUrl:[url absoluteString] needle:oauth2OpenidKey];
        NSString *openkey = [OpenSdkBase getStringFromUrl:[url absoluteString] needle:oauth2OpenkeyKey];
		NSString *expireIn = [OpenSdkBase getStringFromUrl:[url absoluteString] needle:oauth2ExpireInKey];
        
		NSDate *expirationDate =nil;
		if (_OpenSdkOauth.expireIn != nil) {
			int expVal = [_OpenSdkOauth.expireIn intValue];
			if (expVal == 0) {
				expirationDate = [NSDate distantFuture];
			} else {
				expirationDate = [NSDate dateWithTimeIntervalSinceNow:expVal];
			}
		}
        
        NSLog(@"token is %@, openid is %@, expireTime is %@", accessToken, openid, expirationDate);
        
        if ((accessToken == (NSString *) [NSNull null]) || (accessToken.length == 0)
            || (openid == (NSString *) [NSNull null]) || (openkey.length == 0)
            || (openkey == (NSString *) [NSNull null]) || (openid.length == 0)) {
            [_OpenSdkOauth oauthDidFail:InWebView success:YES netNotWork:NO];
        }
        else {
            [_OpenSdkOauth oauthDidSuccess:accessToken accessSecret:nil openid:openid openkey:openkey expireIn:expireIn];
        }
        _webView.delegate = nil;
        [_webView setHidden:YES];
        [_titleLabel setHidden:YES];
        
        [self showLoadingOverlayWithText:@"Getting Account Information..."];
        [NSThread detachNewThreadSelector:@selector(getUserInfoAndContactsInfoInNewThread) toTarget:self withObject:nil];
        
		return NO;
	}
	else
	{
        start = [[url absoluteString] rangeOfString:@"code="];
        if (start.location != NSNotFound) {
            [_OpenSdkOauth refuseOauth:url];
        }
	}
    return YES;
}

- (void) getUserInfoAndContactsInfoInNewThread {
    // create qweibo session
    [[MyQWeibo alloc] initForApi:_OpenSdkOauth.appKey appSecret:_OpenSdkOauth.appSecret accessToken:_OpenSdkOauth.accessToken accessSecret:_OpenSdkOauth.accessSecret openid:_OpenSdkOauth.openid oauthType:_OpenSdkOauth.oauthType];
    
    [self updateAccountStatus:self.account];
    [self.loginButton setTitle:@"Log out" forState:UIControlStateNormal];
    
    // get user info
    //[self showLoadingOverlayWithText:@"Getting Account Information..."];
    OpenSdkResponse* userInfoResponse = [[MyQWeibo activeSession] getUserInfo];
    
    // Going to update account information here
    self.account.userName = [[NSString alloc] initWithString: [userInfoResponse.responseDict objectForKey: @"name"]];
    self.account.identifier = [[NSString alloc] initWithString: [userInfoResponse.responseDict objectForKey: @"openid"]];
    self.userNameLabel.text = self.account.userName;
    
    // get friends list
    //[self updateLoadingOverlayText:@"Getting Contacts..."];
    OpenSdkResponse* followingListResponse = [[MyQWeibo activeSession] getMyFollowingList];
    NSArray* friendArray = [followingListResponse.responseDict objectForKey:@"info"];
    
    NSMutableArray* newContacts = [[NSMutableArray alloc] initWithCapacity:[friendArray count]];
    
    for (NSDictionary* friend in friendArray) {
        OpenSdkResponse* friendInfoResponse = [[MyQWeibo activeSession] getOtherUserInfoOfUID:[friend objectForKey: @"openid" ]];
        if (friendInfoResponse == nil) {
            NSLog(@"getting nil friendInfoResponse, something wrong");
            abort();
        }
        
        NSDictionary* data = friendInfoResponse.responseDict;
        
        NSMutableString* birthday = [[NSMutableString alloc] init];
        [birthday appendFormat:@"%@-%@-%@", [data objectForKey:@"birth_year"],
         [data objectForKey:@"birth_month"], [data objectForKey:@"birth_day"]];
        
        NSMutableString* headUrl = [[data objectForKey:@"head"] mutableCopy];
        [headUrl replaceOccurrencesOfString:@"\\/" withString:@"\\" options:0 range:NSMakeRange(0, [headUrl length])];
        // some hack is needed to properly get head image
        // add /100 to specify head size (100*100)
        [headUrl appendFormat:@"/100"];
        
        NSLog(@"Friend name: %@, BD: %@, head: %@", [data objectForKey:@"nick"], birthday, headUrl);
        
        Contact* contact = [[Contact alloc] initWithUid:[data objectForKey:@"openid"]
                                                   name:[data objectForKey:@"nick"]
                                         birthdayString:birthday
                                                headUrl:headUrl
                                                account:self.account];

        [newContacts addObject:contact];
    }
    
    UINavigationController *nav = (UINavigationController*) [[UIApplication sharedApplication] keyWindow].rootViewController;
    ContactsViewController* contactsViewController = [[nav viewControllers] objectAtIndex:0];
    [contactsViewController mergeContactsAndUpdateView:newContacts];
    
    [self dismissLoadingOverlay];
}

// override
- (void) updateAccountStatus: (Account*) account {
    self.accountStatusLabel.text = [account accountStatusText];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setAccountStatusLabel:nil];
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

@end
