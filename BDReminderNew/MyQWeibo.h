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
    //OpenSdkResponse *_OpenSdkResponse;
    
    NSMutableDictionary* _publishParams;
    
    uint16_t _retCode;
}

@property (nonatomic, retain) OpenSdkOauth *_OpenSdkOauth;
@property (nonatomic, retain) OpenSdkRequest *_OpenSdkRequest;

- (id)initForApi:(NSString*)appKey appSecret:(NSString*)appSecret accessToken:(NSString*)accessToken accessSecret:(NSString*)accessSecret openid:(NSString *)openid oauthType:(uint16_t)oauthType;

- (BOOL) revokeAuth;

- (OpenSdkResponse*) getUserInfo;
- (OpenSdkResponse*) getMyFollowingList;
- (OpenSdkResponse*) getOtherUserInfoOfUID: (NSString*) uid;

+ (MyQWeibo*) activeSession;
- (BOOL) isSessionValid;

@end