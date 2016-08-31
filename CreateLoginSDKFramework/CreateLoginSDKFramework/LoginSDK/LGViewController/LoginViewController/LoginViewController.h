//
//  ViewController.h
//  MyLoginTest
//
//  Created by Mr.LuDashi on 16/8/24.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginManagerProtocal.h"

@interface LoginViewController : UIViewController
/**
 *  设置相应的Block回调
 *
 *  @param loginBlock  登录成功回调
 */
- (void)setLoginResult: (LoginBlock)loginBlock;
@end

