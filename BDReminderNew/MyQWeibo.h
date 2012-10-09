//
//  MyQWeibo.h
//  BDReminderNew
//
//  Created by qinsoon on 9/10/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenSdkOauth.h"
#import "OpenSdkRequest.h"
#import "OpenSdkResponse.h"

@interface MyQWeibo : NSObject {
    OpenSdkRequest *_OpenSdkRequest;
    //OpenSdkResponse *_OpenSdkResponse;
    
    NSMutableDictionary* _publishParams;
}

@property (nonatomic, retain) OpenSdkOauth *_OpenSdkOauth;

- (id)initForApi:(NSString*)appKey appSecret:(NSString*)appSecret accessToken:(NSString*)accessToken accessSecret:(NSString*)accessSecret openid:(NSString *)openid oauthType:(uint16_t)oauthType;

- (OpenSdkResponse*) getUserInfo;

+ (MyQWeibo*) activeSession;
- (BOOL) isSessionValid;

@end
