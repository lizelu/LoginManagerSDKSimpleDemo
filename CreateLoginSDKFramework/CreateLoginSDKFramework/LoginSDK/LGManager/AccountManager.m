//
//  UserLoginManager.m
//  MyLoginTest
//
//  Created by Mr.LuDashi on 16/8/24.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import "AccountManager.h"
#import "VerifyTools.h"
#import "KeyChainManager.h"
#import "AESCrypt.h"
#define KEY_PASWORD @"qwertyuiopsdfghjk" //正常的key也是需要处理的
@interface AccountManager()
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) LoginBlock loginSuccessBlock;
@property (nonatomic, strong) LoginFailureBlock loginFailureBlock;
@property (nonatomic, strong) NoAccountLoginBlock noAccountLoginBlock;
@end

@implementation AccountManager

+ (instancetype)shareManager {
    static AccountManager * accountManagerObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        accountManagerObject = [[self alloc] init];
    });
    return accountManagerObject;
}

- (void)setLoginResult: (LoginBlock)loginBlock
          failureBlock: (LoginFailureBlock) failBlock {
    self.loginSuccessBlock = loginBlock;
    self.loginFailureBlock = failBlock;
}

- (void)checkHaveLogin: (LoginBlock)loginSuccessBlock noAccountBlock: (NoAccountLoginBlock) noAccountBlock {
    self.loginSuccessBlock = loginSuccessBlock;
    self.noAccountLoginBlock = noAccountBlock;
    [self getKeyChain];
}

- (void)loginWithUserName: (NSString *)userName
                 password: (NSString *)password {
    if ([self verifyUserName:userName] && [self verifyPassword:password]) {
        [self reqLogin];
    }
}

-(void)loginOut {
    [self reqLogout];
}

-(Boolean)verifyUserName: (NSString *)userName {
    if (![VerifyTools verifyUserName:userName]) {
        if (self.loginFailureBlock != nil) {
            self.loginFailureBlock(@"用户名格式不正确");
        }
        return NO;
    }
    self.userName = userName;
    return YES;
}

-(Boolean)verifyPassword: (NSString *)password {
    if (![VerifyTools verifyPassword:password]) {
        if (self.loginFailureBlock != nil) {
            self.loginFailureBlock(@"用户密码格式不正确");
        }
        return NO;
    }
    self.password = password;
    return YES;
}

- (void)reqLogin {
    if (self.loginSuccessBlock != nil) {
        self.loginSuccessBlock(self.userName);
        [self saveKeyChain];
    }
}

- (void)reqLogout {
//    if (self.logoutSuccessBlock != nil) {
//        self.logoutSuccessBlock(0);
//    }
}

- (void)saveKeyChain {
    [[KeyChainManager shareLoginManager] saveAccount:[self encrypt:_userName]];
    [[KeyChainManager shareLoginManager] savePassword:[self encrypt:_password]];
}

- (void)getKeyChain {
    NSString * username = [self dencrypt:[[KeyChainManager shareLoginManager] getAccount]];
    NSString * password = [self dencrypt:[[KeyChainManager shareLoginManager] getPassword]];
    NSLog(@"%@, %@", username, password);
    
    if ((username != nil && password != nil) &&
        (![username isEqualToString:@""] && ![password isEqualToString:@""])) {
        _userName = username;
        _password = password;
        [self reqLogin];
    } else {
        if (_noAccountLoginBlock) {
            _noAccountLoginBlock();
        }
    }
}

- (NSString *)encrypt: (NSString *)text {
    //return text;
    return [AESCrypt encrypt:text password:KEY_PASWORD];
}

- (NSString *)dencrypt: (NSString *)text {
    //return text;
    return [AESCrypt decrypt:text password:KEY_PASWORD];
}


@end
