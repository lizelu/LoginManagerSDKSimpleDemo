//
//  KeyChainManager.h
//  MyLoginTest
//
//  Created by Mr.LuDashi on 16/8/24.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface KeyChainManager : NSObject
+ (instancetype)shareLoginManager;
- (void)saveAccount: (NSString *) account;
- (void)savePassword: (NSString *) password;
- (NSString *)getAccount;
- (NSString *)getPassword;
- (void)clearAccount;
- (void)clearPassword;
@end
