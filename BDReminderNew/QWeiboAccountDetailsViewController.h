//
//  QWeiboAccountDetailsViewController.h
//  BDReminderNew
//
//  Created by qinsoon on 8/10/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "AccountDetailsViewController.h"
#import "OpenSdkOauth.h"

@interface QWeiboAccountDetailsViewController : AccountDetailsViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView* _webView;
    UILabel *_titleLabel;
    
    OpenSdkOauth *_OpenSdkOauth;
}
@property (weak, nonatomic) IBOutlet UILabel *accountStatusLabel;


@end
