//
//  LoginVCManager.h
//  MyLoginTest
//
//  Created by Mr.LuDashi on 16/8/26.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginManagerProtocal.h"
#import <UIKit/UIKit.h>

@interface LoginAPI : NSObject<LoginManagerProtocal>
@property (strong, nonatomic) NSString * token;
/**
 *  获取账户管理的单例
 *
 *  @return 返回账户管理的Manager
 */
+ (instancetype)shareManager;

/**
 *  首次登录，获取登录页面
 *
 *  @param loginBlock 登录成功后的Block
 *
 *  @return 返回LoginViewController
 */
- (UIViewController *)getLoginViewController: (LoginBlock)loginBlock;


/**
 *  检查是否有账号登录过
 *
 *  @param loginSuccessBlock 登录成功回调
 *  @param noAccountBlock    无账号登录
 */
- (void)checkHaveLogin: (LoginBlock)loginSuccessBlock
        noAccountBlock: (NoAccountLoginBlock) noAccountBlock;

/**
 *  注销
 */
- (void)logout;

/**
 *  判断是否已注销
 *
 *  @return YES - 已注销， NO - 已登录
 */
- (Boolean)isLogout;
@end


