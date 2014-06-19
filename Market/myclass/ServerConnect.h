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


//【**********【关注商品】**********】
//[参数]：
//productAttentionVo.product_id(商品id，必填)
//productAttentionVo.merchant_id(商家id,1、淘宝商城 2、京东商城 3、爱康国宾 4、有机生活 5、巴马水,必填)
//authkey(登录时获取的authkey，必填)
//[请求示例]：http://localhost/sys/productManage_addProductAttention?productAttentionVo.product_id=74&productAttentionVo.merchant_id=4&authkey=87
//[本地测试地址]：http://192.168.110.32:80/sys/productManage_addProductAttention?productAttentionVo.product_id=74&productAttentionVo.merchant_id=4&authkey=87
//[响应码]：
//RESULT_CODE（响应码：0-参数获取失败；1-操作成功；2-操作失败；3-传入的authkey无效；）
//RESULT_MSG（响应信息）
//[响应示例]：[{"RESULT_MSG":"操作成功","RESULT_CODE":1}]
+(NSArray *)addProductAttention:(int)product_id merchant_id:(int)merchant_id authkey:(NSString *)authkey;


//【**********【查看当前用户的关注商品信息】**********】
//[参数]：
//authkey(登录时获取的authkey，必填)
//[请求示例]：http://localhost/sys/productManage_queryProductAttention?authkey=87
//[本地测试地址]：http://192.168.110.32:80/sys/productManage_queryProductAttention?authkey=87
//[响应码]：
//RESULT_CODE（响应码：0-参数获取失败；1-您未曾关注过商品；2-操作成功；3-传入的authkey无效；）
//RESULT_MSG（响应信息）
//RESULT_INFO（查询结果）
//[响应示例]：[{"RESULT_MSG":"操作成功","RESULT_CODE":2,
//    "RESULT_INFO":
//    [{"ATTENTION_TIME":"2014-06-16 00:00","ATTENTION_ID":1,"PRODUCT_NAME":"护照","PRODUCT_IMAGEURL":"http://192.168.110.32/sys/productManage_showImg?imgName=8c730eb7feaf454281ab7f01fc054be0.jpg","MERCHANT_LINKURL":"http://www.bmsjb.com","PRODUCT_DESCRIPTION":"物美价廉"},
//     {"ATTENTION_TIME":"2014-06-16 00:00","ATTENTION_ID":4,"PRODUCT_NAME":"护照","PRODUCT_IMAGEURL":"http://192.168.110.32/sys/productManage_showImg?imgName=c1c557e1296f4a2dae2047e7c5a6f81e.jpg","MERCHANT_LINKURL":"http://www.bmsjb.com","PRODUCT_DESCRIPTION":"物美价廉"}]}]
+(NSArray *)queryProductAttention : (NSString *)authkey;


//【**********【根据用户选中的取消关注id，取消关注商品】**********】
//[参数]：
//productAttentionVo.attention_id(关注ID，必填)
//[请求示例]：http://localhost/sys/productManage_deleteProductAttention?productAttentionVo.attention_id=1
//[本地测试地址]：http://192.168.110.32:80/sys/productManage_deleteProductAttention?productAttentionVo.attention_id=1
//[响应码]：
//RESULT_CODE（响应码：0-参数获取失败；1-操作成功；2-操作失败；）
//RESULT_MSG（响应信息）
//[响应示例]：[{"RESULT_MSG":"操作成功","RESULT_CODE":1}]
+(NSArray *)deleteProductAttention :(int)attention_id;


//【**********【自动生成随机账号的】**********】
//http://localhost:8080/service/ehealth_userRegister?autoregister=autoregister&dtype=18
//
//你的登录名 nickname 密码 pwd
//{"success":true,"authkey":"ZWM3MTBkYjIzZGIzNDc0NGFjMWUwZTdjOWEzZWViMmEjMjAxNC0wNi0xOCAxNzowNDozOSMxOCN6%0D%0AaF9DTg%3D%3D","username":"s1403082279464","nickname":"q25LMYw5","pwd":"666666"}
+(NSDictionary *)autoRegister;
@end
