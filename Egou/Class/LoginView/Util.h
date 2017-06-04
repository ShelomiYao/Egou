//
//  Util.h
//  Egou
//
//  Created by Mac on 17/6/4.
//  Copyright © 2017年 ShelomiYao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserEntity.h"

@interface Util : NSObject

//获取当前的用户信息
+(UserEntity * )getCurrentUserInfo;

@end
