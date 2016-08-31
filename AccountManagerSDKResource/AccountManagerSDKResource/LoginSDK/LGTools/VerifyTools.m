//
//  VerifyTools.m
//  MyLoginTest
//
//  Created by Mr.LuDashi on 16/8/24.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import "VerifyTools.h"
#define ExpressionTelNumber @"^(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$"
#define ExpressionPassword @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,15}"

@implementation VerifyTools
#pragma mark 正则匹配用户姓名
+ (BOOL)verifyUserName:(NSString *)userName {
    return [VerifyTools verifyText :userName expression: ExpressionTelNumber];
}

#pragma mark 正则匹配用户密码
+ (BOOL)verifyPassword:(NSString *)password {
    return [VerifyTools verifyText :password expression: ExpressionPassword];
}

/**
 *  公用方法
 *
 *  @param text       要验证的字符串
 *  @param expression 正则
 *
 *  @return 匹配结果
 */
+ (BOOL)verifyText: (NSString *)text expression: (NSString *)expression {
    NSString *pattern = expression;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:text];
    return isMatch;
}

@end
