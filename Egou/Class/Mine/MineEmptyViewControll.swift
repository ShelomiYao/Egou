//
//  MineEmptyViewControll.swift
//  Egou
//
//  Created by Mac on 17/5/2.
//  Copyright © 2017年 ShelomiYao. All rights reserved.
//

import Foundation

import UIKit

class MineEmptyViewController: BaseViewController {
    
    private let shopImageView         = UIImageView()
    private let emptyLabel            = UILabel()
    private let emptyButton           = UIButton(type: .Custom)
    private let supermarketTableView  = LFBTableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 50), style: .Plain)
    private var isFristLoadData       = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildEmptyUI()
        buildNavigationItem()
    }
    
    // MARK: - Build UI
    private func buildNavigationItem() {
        navigationItem.title = "个人中心"
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(UIImage(named: "v2_goback")!, target: self, action: #selector(MineEmptyViewController.emptyButtonClick))
    }
    
    private func buildEmptyUI() {
        
        
        shopImageView.image = UIImage(named: "v2_my_avatar")
        shopImageView.contentMode = UIViewContentMode.Center
        shopImageView.frame = CGRectMake((view.width - shopImageView.width) * 0.5, view.height * 0.25, shopImageView.width, shopImageView.height)
//        shopImageView.hidden = true
        
        emptyLabel.text = "亲,请先登录"
        emptyLabel.textColor = UIColor.colorWithCustom(100, g: 100, b: 100)
        emptyLabel.textAlignment = NSTextAlignment.Center
        emptyLabel.frame = CGRectMake(0, CGRectGetMaxY(shopImageView.frame) + 55, view.width, 50)
        emptyLabel.font = UIFont.systemFontOfSize(16)
//        emptyLabel.hidden = true
        
        emptyButton.frame = CGRectMake((view.width - 150) * 0.5, CGRectGetMaxY(emptyLabel.frame) + 15, 150, 30)
        emptyButton.setBackgroundImage(UIImage(named: "btn.png"), forState: UIControlState.Normal)
        emptyButton.setTitle("登录", forState: UIControlState.Normal)
        emptyButton.setTitleColor(UIColor.colorWithCustom(100, g: 100, b: 100), forState: UIControlState.Normal)
        emptyButton.addTarget(self, action: #selector(MineEmptyViewController.emptyButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
//        emptyButton.hidden = true
        
        [self.view .addSubview(shopImageView)]
        [self.view .addSubview(emptyButton)]
        [self.view .addSubview(emptyLabel)]


    }
    
    func emptyButtonClick() {
        navigationController?.pushViewController(DMLoginViewController(), animated: true)

    }
    
}