//
//  LGBase64.h
//
//该Base64转码的文件，来自Github下方的连接
//https://github.com/iPhoto/giffy/blob/48ec0cce614bc0d16c70f066c23fe11dcaecd6ff/ios/Giffy/Giffy/Utilities/Base64.h

#import <Foundation/Foundation.h>

@interface LGBase64 : NSObject

+(NSString*)encodeStrToBase64Str:(NSString*)rawStr;
+(NSString*)decodeBase64ToStr:(NSString*)base64Str;
+(NSString*)base64forData:(NSData*)theData;
+(NSData*)dataForBase64:(NSString*)base64;

@end
