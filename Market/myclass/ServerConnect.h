//
//  ServerConnect.h
//  HealthABC
//
//  Created by 夏 伟 on 13-12-4.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface ServerConnect : NSObject

+(NSData *)doSyncRequest:(NSString *)urlString;
+(NSDictionary *)getDictionaryByUrl:(NSString *)url;

+(NSString *)Login:(NSString *)url;

+(NSDictionary *)getUserInfo:(NSString *)url;
+(NSDictionary *)requestCheckCode:(NSString *)url;
+(NSDictionary *)feedBackCheckCode:(NSString *)url;



+(BOOL)uploadUserInfo:(NSString *)url;

+(BOOL)isConnectionAvailable;
+(BOOL)backCheckCode:(NSString *)url;

+(BOOL)resetPassword:(NSString *)url;



//邮箱注册
+(NSString *)registByEmail:(NSString *)email password:(NSString *)password;
//邮箱找回密码时请求验证码
+(NSDictionary *)getCheckCodeByEmail:(NSString *)email;
//邮箱找回密码时发送获得的验证码
+(NSDictionary *)checkCheckCode:(NSString *)email checkcode:(NSString *)checkcode;
//邮箱找回密码时设置新密码
+(NSDictionary *)resetPasswordByEmail:(NSString *)email newpassword:(NSString *)newpassword;

/**
 *获取应用列表 toolType	工具类别：1-安卓， 3-ios
 *           offset		偏移量：从第几条开始查
 */
+(NSDictionary *)getAppList:(int) tooltype offset : (int) offset;


//【**********【根据商品名称和商家id查询商品信息】**********】
//[参数]：
//productVo.product_name（商品名称，选填）
//merchant_id(商家ID，1、淘宝商城 2、京东商城 3、爱康国宾 4、有机生活 5、巴马水，选填)
//[请求示例]：http://localhost/sys/productManage_queryProductListByApp?productVo.product_name=&merchant_id=5
//[本地测试地址]：http://192.168.110.32:80/sys/productManage_queryProductListByApp?productVo.product_name=&merchant_id=5
+(NSArray *)getProductList:(NSString *)productName merchant_id:(int)merchant_id;
@end
