//
//  UserEntity.h
//  Egou
//
//  Created by Mac on 17/6/4.
//  Copyright © 2017年 ShelomiYao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject

{
    NSString *userName;   //存储登录用户的用户名
    NSString *password;  //存储登录用户的密码
    BOOL bLogin;       //存储登录状态
}

@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *password;
@property (assign, nonatomic) BOOL bLogin;

@end
