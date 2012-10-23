//
//  MyQWeibo.m
//  BDReminderNew
//
//  Created by qinsoon on 9/10/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "MyQWeibo.h"

#define NSDEFAULT_APP_KEY       @"qweibo_app_key"
#define NSDEFAULT_APP_SECRET    @"qweibo_app_secret"
#define NSDEFAULT_ACCESS_TOKEN  @"qweibo_access_token"
#define NSDEFAULT_ACCESS_SECRET @"qweibo_access_secret"
#define NSDEFAULT_OPEN_ID       @"qweibo_open_id"
#define NSDEFAULT_OAUTH_TYPE    @"qweibo_oauth_type"

#define FORMAT_JSON             @"json"

#pragma -
#pragma mark base define

#define ApiBaseUrl @"http://open.t.qq.com/api/"
#define ApiBaseUrl_For_oauth2 @"https://open.t.qq.com/api/"

#define AppFrom @"ios-sdk1.2"

#define UserInfoSuffix @"user/info"
#define RevokeAuthSuffix @"auth/revoke_auth"
#define FollowingListSuffix @"friends/idollist_name"
#define OtherUserInfoSuffix @"user/other_info"

/*
 * http请求方式
 */
#define GetMethod @"GET"
#define PostMethod @"POST"

@implementation MyQWeibo

@synthesize _OpenSdkOauth;
@synthesize _OpenSdkRequest;

- (id)initForApi:(NSString*)appKey appSecret:(NSString*)appSecret accessToken:(NSString*)accessToken accessSecret:(NSString*)accessSecret openid:(NSString *)openid oauthType:(uint16_t)oauthType{
	if ([super init])
	{
        _OpenSdkRequest = [[OpenSdkRequest alloc] init];
        _OpenSdkOauth = [[OpenSdkOauth alloc] init];
        
        _OpenSdkOauth.appKey = [appKey copy];
		_OpenSdkOauth.appSecret = [appSecret copy];
        _OpenSdkOauth.accessToken = [accessToken copy];
        _OpenSdkOauth.accessSecret = [accessSecret copy];
        _OpenSdkOauth.openid = [openid copy];
        _OpenSdkOauth.oauthType = oauthType;
        
        [self saveSessionToNSDefaults];
	}
	return self;
}

- (BOOL) revokeAuth {
    NSString *requestUrl = [self getApiBaseUrl:RevokeAuthSuffix];
    
    _publishParams = [NSMutableDictionary dictionary];
    
    [_publishParams setObject:FORMAT_JSON forKey:@"format"];
    [self addPublicParams];
    
    NSString *resultStr = [_OpenSdkRequest sendApiRequest:requestUrl httpMethod:GetMethod oauth:_OpenSdkOauth params:_publishParams files:nil oauthType:_OpenSdkOauth.oauthType retCode:&_retCode];
    
    OpenSdkResponse *response = [[OpenSdkResponse alloc] init];
    [response parseData:resultStr];
    NSLog(@"Logged out");
    [self deleteSessionFromNSDefaults];
    active = nil;
    return YES;
}

- (void) saveSessionToNSDefaults {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_OpenSdkOauth.appKey        forKey:NSDEFAULT_APP_KEY];
    [defaults setObject:_OpenSdkOauth.appSecret     forKey:NSDEFAULT_APP_SECRET];
    [defaults setObject:_OpenSdkOauth.accessToken   forKey:NSDEFAULT_ACCESS_TOKEN];
    [defaults setObject:_OpenSdkOauth.accessSecret  forKey:NSDEFAULT_ACCESS_SECRET];
    [defaults setObject:_OpenSdkOauth.openid        forKey:NSDEFAULT_OPEN_ID];
    [defaults setInteger:_OpenSdkOauth.oauthType    forKey:NSDEFAULT_OAUTH_TYPE];
    
    [defaults synchronize];
}

- (void) deleteSessionFromNSDefaults {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:NSDEFAULT_APP_KEY];
    [defaults removeObjectForKey:NSDEFAULT_APP_SECRET];
    [defaults removeObjectForKey:NSDEFAULT_ACCESS_TOKEN];
    [defaults removeObjectForKey:NSDEFAULT_ACCESS_SECRET];
    [defaults removeObjectForKey:NSDEFAULT_OPEN_ID];
    [defaults removeObjectForKey:NSDEFAULT_OAUTH_TYPE];
    
    [defaults synchronize];
}

+ (OpenSdkOauth*) restoreOpenSdkOauthFromNSDefaults {
    OpenSdkOauth* restore = [[OpenSdkOauth alloc] init];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    restore.appKey          = [defaults objectForKey:NSDEFAULT_APP_KEY];
    restore.appSecret       = [defaults objectForKey:NSDEFAULT_APP_SECRET];
    restore.accessToken     = [defaults objectForKey:NSDEFAULT_ACCESS_TOKEN];
    restore.accessSecret    = [defaults objectForKey:NSDEFAULT_ACCESS_SECRET];
    restore.openid          = [defaults objectForKey:NSDEFAULT_OPEN_ID];
    restore.oauthType       = [defaults integerForKey:NSDEFAULT_OAUTH_TYPE];
    
    return restore;
}

static MyQWeibo* active = nil;

+ (MyQWeibo*) activeSession {
    if (active == nil) {
        active = [[MyQWeibo alloc] init];
        [active isSessionValid];
        active._OpenSdkRequest = [[OpenSdkRequest alloc] init];
    }
    
    return active;
}

- (BOOL) isSessionValid {
    _OpenSdkOauth = [MyQWeibo restoreOpenSdkOauthFromNSDefaults];
    
    BOOL valid = ( self._OpenSdkOauth.appKey != nil
                  && ![self._OpenSdkOauth.appKey isEqual:@""]
                  
                  && self._OpenSdkOauth.appSecret != nil
                  && ![self._OpenSdkOauth.appSecret isEqual:@""]
                  
                  && self._OpenSdkOauth.accessToken != nil
                  && ![self._OpenSdkOauth.accessToken isEqual:@""]
                  
                  //&& self._OpenSdkOauth.accessSecret != nil
                  //&& ![self._OpenSdkOauth.accessSecret isEqual:@""]
                  
                  && self._OpenSdkOauth.openid != nil
                  && ![self._OpenSdkOauth.openid isEqual:@""]);
    
    return valid;
}

- (OpenSdkResponse*) getUserInfo{
    NSString *requestUrl = [self getApiBaseUrl:UserInfoSuffix];
    
    _publishParams = [NSMutableDictionary dictionary];
    
    [_publishParams setObject:FORMAT_JSON forKey:@"format"];
    [self addPublicParams];
    
    NSString *resultStr = [_OpenSdkRequest sendApiRequest:requestUrl httpMethod:GetMethod oauth:_OpenSdkOauth params:_publishParams files:nil oauthType:_OpenSdkOauth.oauthType retCode:&_retCode];
    
    if (resultStr == nil) {
        NSLog(@"没有授权或授权失败");
        //[OpenSdkBase showMessageBox:@"没有授权或授权失败"];
        return nil;
    }
    
    if (_retCode == resSuccessed) {
        OpenSdkResponse *_OpenSdkResponse = [[OpenSdkResponse alloc] init];
        NSInteger ret = [_OpenSdkResponse parseData:resultStr];  //解析json数据
        if (ret == 2) {
            
            if (_OpenSdkResponse.ret == 3 && _OpenSdkResponse.errcode == 1) {
                //[OpenSdkBase showMessageBox:resultStr];
                //[OpenSdkBase showMessageBox:@"用户授权已失效，需要重新授权"];
                NSLog(@"Invalid session when get result");
            }
        }
        
        return _OpenSdkResponse;
        //[OpenSdkBase showMessageBox:resultStr];
    }
    else {
        // [OpenSdkBase showMessageBox:@"调用user/info接口失败"];
        NSLog(@"Fail to call user/info");
        return nil;
    }
}

- (OpenSdkResponse*) getMyFollowingList {
    NSString* requestUrl = [self getApiBaseUrl:FollowingListSuffix];
    
    _publishParams = [NSMutableDictionary dictionary];
    
    [_publishParams setObject:FORMAT_JSON forKey:@"format"];
    [_publishParams setObject:@"200" forKey:@"reqnum"];
    [_publishParams setObject:@"0" forKey:@"startindex"];
    [self addPublicParams];
    
    NSString *resultStr = [_OpenSdkRequest sendApiRequest:requestUrl httpMethod:GetMethod oauth:_OpenSdkOauth params:_publishParams files:nil oauthType:_OpenSdkOauth.oauthType retCode:&_retCode];
    
    if (resultStr == nil ) {
        NSLog(@"Failed to send request, result string is nil");
        return nil;
    }
    
    if (_retCode == resSuccessed) {
        OpenSdkResponse *response = [[OpenSdkResponse alloc] init];
        [response parseData:resultStr];
        if (response.ret == 0) {
            NSLog(@"Got following list");
            return response;
        } else {
            NSLog(@"Returned error message");
            return nil;
        }
    }
    
    return nil;
}

- (OpenSdkResponse*) getOtherUserInfoOfUID: (NSString*) uid {
    NSString *requestUrl = [self getApiBaseUrl:OtherUserInfoSuffix];
    
    _publishParams = [NSMutableDictionary dictionary];
    [_publishParams setObject:FORMAT_JSON forKey:@"format"];
    [_publishParams setObject:uid forKey:@"fopenid"];
    [self addPublicParams];
    
    NSString *resultStr = [_OpenSdkRequest sendApiRequest:requestUrl httpMethod:GetMethod oauth:_OpenSdkOauth params:_publishParams files:nil oauthType:_OpenSdkOauth.oauthType retCode:&_retCode];
    
    if (resultStr == nil) {
        NSLog(@"failed to send getOtherUserInfo request");
        return NO;
    }
    
    if (_retCode == resSuccessed) {
        OpenSdkResponse *response = [[OpenSdkResponse alloc] init];
        [response parseData:resultStr];
        if (response.ret == 0) {
            return response;
        }
    }
    
    return nil;
}

/*
 * 根据ApiBaseUrl和接口名称获取接口访问路径
 */
- (NSString *) getApiBaseUrl:(NSString *)suffix {
    
    NSString *retStringUrl = nil;
    if (_OpenSdkOauth.oauthType == InAuth1) {
        retStringUrl = ApiBaseUrl;
    }
    else
    {
        retStringUrl = ApiBaseUrl_For_oauth2;
    }
    
    return [retStringUrl stringByAppendingString:suffix];
}

/*
 * 接口请求的公共参数，必须携带
 */
- (void) addPublicParams{
    [_publishParams setObject:AppFrom forKey:@"appfrom"];
    NSString *SeqId = [NSString stringWithFormat:@"%u", arc4random() % 9999999 + 123456];
    [_publishParams setObject:SeqId forKey:@"seqid"];
    [_publishParams setObject:[OpenSdkBase getClientIp] forKey:@"clientip"];
}

@end
