//
//  CLLockLabel.h
//  CoreLock
//
//  Created by ShelomiYao on 15/4/27.
//  Copyright (c) 2015年 ShelomiYao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLLockLabel : UILabel



/*
 *  普通提示信息
 */
-(void)showNormalMsg:(NSString *)msg;



/*
 *  警示信息
 */
-(void)showWarnMsg:(NSString *)msg;


@end
