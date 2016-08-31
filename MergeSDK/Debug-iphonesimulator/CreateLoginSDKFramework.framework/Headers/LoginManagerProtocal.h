//
//  LoginManagerProtocal.h
//  MyLoginTest
//
//  Created by Mr.LuDashi on 16/8/26.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LoginBlock)(NSString * token);            //登录成功后的回调
typedef void(^LoginFailureBlock)(NSString * errorMessage);  //失败回调
typedef void(^NoAccountLoginBlock)();                   //没有登录过的账号

@protocol LoginManagerProtocal <NSObject>
/**
 *  获取账户管理的单例
 *
 *  @return 返回账户管理的Manager
 */
@optional + (instancetype)shareManager;

/**
 *  设置相应的Block回调
 *
 *  @param loginBlock  登录成功回调
 *  @param logoutBlock 注销成功回调
 *  @param failBlock   失败回调
 */
@optional - (void)setLoginResult: (LoginBlock)loginBlock
                    failureBlock: (LoginFailureBlock) failBlock;

@end
