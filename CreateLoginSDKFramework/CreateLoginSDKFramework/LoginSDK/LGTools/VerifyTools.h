//
//  VerifyTools.h
//  MyLoginTest
//
//  Created by Mr.LuDashi on 16/8/24.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerifyTools : NSObject
+ (BOOL)verifyUserName:(NSString *)userName;
+ (BOOL)verifyPassword:(NSString *)password;
@end
