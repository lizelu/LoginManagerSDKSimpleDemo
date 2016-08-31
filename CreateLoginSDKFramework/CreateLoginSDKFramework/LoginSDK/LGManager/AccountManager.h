//
//  UserLoginManager.h
//  MyLoginTest
//
//  Created by Mr.LuDashi on 16/8/24.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginManagerProtocal.h"

@interface AccountManager : NSObject<LoginManagerProtocal>
/**
 *  获取账户管理的单例
 *
 *  @return 返回账户管理的Manager
 */
+ (instancetype)shareManager;

/**
 *  设置相应的Block回调
 *
 *  @param loginBlock  登录成功回调
 *  @param failBlock   失败回调
 */
- (void)setLoginResult: (LoginBlock)loginBlock
          failureBlock: (LoginFailureBlock) failBlock;

/**
 *  传入用户名、密码进行登录
 *
 *  @param userName 用户名
 *  @param password 密码
 */
- (void)loginWithUserName: (NSString *)userName password: (NSString *)password;

/**
 *  检查用户设备是否已经登陆过
 */
- (void)checkHaveLogin: (LoginBlock)loginSuccessBlock noAccountBlock: (NoAccountLoginBlock) noAccountBlock;

/**
 *  注销操作
 */
-(void)loginOut;
@end
