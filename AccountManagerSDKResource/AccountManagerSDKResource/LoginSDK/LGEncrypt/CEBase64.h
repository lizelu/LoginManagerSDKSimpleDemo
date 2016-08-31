//
//  CEBase64.h
//  CEPaySdk
//
//  Created by zzf073 on 15/7/6.
//  Copyright (c) 2015年 zzf073. All rights reserved.
//

//https://github.com/iPhoto/giffy/blob/48ec0cce614bc0d16c70f066c23fe11dcaecd6ff/ios/Giffy/Giffy/Utilities/Base64.h

#import <Foundation/Foundation.h>

@interface CEBase64 : NSObject

+(NSString*)encodeStrToBase64Str:(NSString*)rawStr;
+(NSString*)decodeBase64ToStr:(NSString*)base64Str;
+(NSString*)base64forData:(NSData*)theData;
+(NSData*)dataForBase64:(NSString*)base64;

@end
