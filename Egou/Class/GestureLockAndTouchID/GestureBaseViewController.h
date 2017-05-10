//
//  GestureBaseViewController.h
//  GestureSDK_Demo
//
//  Created by Mac on 17/5/10.
//  Copyright © 2017年 OYXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GestureBaseViewController : UIViewController

{
    CGRect  m_mainContentViewFrame;
}

/**
 *  显示导航栏左侧的按钮
 *
 *  @param aTitle
 *  @param aImage
 *  @param hImage
 */
- (void)showCustomNavigationLeftButtonWithTitle:(NSString *)aTitle
                                          image:(UIImage *)aImage
                                hightlightImage:(UIImage *)hImage;

@end
