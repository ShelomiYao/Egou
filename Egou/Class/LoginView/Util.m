//
//  Util.m
//  Egou
//
//  Created by Mac on 17/6/4.
//  Copyright © 2017年 ShelomiYao. All rights reserved.
//

#import "Util.h"

@implementation Util

//当前登录用户的信息 为单例模式
+(UserEntity * )getCurrentUserInfo
{
    static dispatch_once_t pred;
    static UserEntity *currentUser;
    dispatch_once(&pred, ^{
        currentUser = [[UserEntity alloc] init];
    });
    return currentUser;
}

@end
