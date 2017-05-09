//
//  CLLockMainView.m
//  CoreLock
//
//  Created by ShelomiYao on 15/4/28.
//  Copyright (c) 2015年 ShelomiYao. All rights reserved.
//

#import "CLLockMainView.h"
#import "CoreConst.h"


@interface CLLockMainView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topC;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMarginC;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoViewTopMoveC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelTopMarginC;

@end


@implementation CLLockMainView


-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    if(iphone4x_3_5){
        
        _topC.constant =30;
        
        _bottomMarginC.constant = -30;
        
        _infoViewTopMoveC.constant = -10;
        
        _labelTopMarginC.constant = 10;
    }
}

@end
