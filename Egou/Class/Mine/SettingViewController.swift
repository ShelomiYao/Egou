//
//  SettingViewController.swift
//  LoveFreshBeen
//


import UIKit

class SettingViewController: BaseViewController {
    
    private let subViewHeight: CGFloat = 50
    
    private var aboutMeView: UIView!
    private var cleanCacheView: UIView!
    private var cacheNumberLabel: UILabel!
    private var logoutView: UIView!
    private var logoutButton: UIButton!
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        buildaboutMeView()
        buildCleanCacheView()
        buildLogoutView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        print(self)
    }
    
    // MARK: - Build UI
    private func setUpUI() {
        navigationItem.title = "设置"
    }
    
    private func buildaboutMeView() {
        aboutMeView = UIView(frame: CGRectMake(0, 10, ScreenWidth, subViewHeight))
        aboutMeView.backgroundColor = UIColor.whiteColor()
        view.addSubview(aboutMeView!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.aboutMeViewClick))
        aboutMeView.addGestureRecognizer(tap)
        
        let aboutLabel = UILabel(frame: CGRectMake(20, 0, 200, subViewHeight))
        aboutLabel.text = "关于小姚"
        aboutLabel.font = UIFont.systemFontOfSize(16)
        aboutMeView.addSubview(aboutLabel)
        
        let arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
        arrowImageView.frame = CGRectMake(ScreenWidth - 20, (subViewHeight - 10) * 0.5, 5, 10)
        aboutMeView.addSubview(arrowImageView)
    }
    
    private func buildCleanCacheView() {
        cleanCacheView = UIView(frame: CGRectMake(0, subViewHeight + 10, ScreenWidth, subViewHeight))
        cleanCacheView.backgroundColor = UIColor.whiteColor()
        view.addSubview(cleanCacheView!)
        
        let cleanCacheLabel = UILabel(frame: CGRectMake(20, 0, 200, subViewHeight))
        cleanCacheLabel.text = "清理缓存"
        cleanCacheLabel.font = UIFont.systemFontOfSize(16)
        cleanCacheView.addSubview(cleanCacheLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.cleanCacheViewClick))
        cleanCacheView.addGestureRecognizer(tap)
        
        cacheNumberLabel = UILabel(frame: CGRectMake(150, 0, ScreenWidth - 165, subViewHeight))
        cacheNumberLabel.textAlignment = NSTextAlignment.Right
        cacheNumberLabel.textColor = UIColor.colorWithCustom(180, g: 180, b: 180)
        cacheNumberLabel.text = String().stringByAppendingFormat("%.2fM", FileTool.folderSize(LFBCachePath)).cleanDecimalPointZear()
        cleanCacheView.addSubview(cacheNumberLabel)
        
        let lineView = UIView(frame: CGRectMake(10, -0.5, ScreenWidth - 10, 0.5))
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.08
        cleanCacheView.addSubview(lineView)
    }
    
    private func buildLogoutView() {
        logoutView = UIView(frame: CGRectMake(0, CGRectGetMaxY(cleanCacheView.frame) + 20, ScreenHeight, subViewHeight))
        logoutView.backgroundColor = UIColor.whiteColor()
        view.addSubview(logoutView)
        
        logoutButton = UIButton(frame: CGRectMake(0, 0, ScreenWidth, subViewHeight))
        if Util.getCurrentUserInfo().bLogin {
            logoutButton.setTitle("退出当前账号", forState: UIControlState.Normal)
        }else{
            logoutButton.setTitle("登  录", forState: UIControlState.Normal)
        }
        logoutButton.layer.cornerRadius = 10;
        logoutButton.backgroundColor = UIColor.orangeColor()
        logoutButton.setTitleColor(UIColor.colorWithCustom(60, g: 60, b: 60), forState: UIControlState.Normal)
        logoutButton.titleLabel?.font = UIFont.systemFontOfSize(18)
        logoutButton.titleLabel?.textAlignment = NSTextAlignment.Center
        logoutButton.addTarget(self, action: #selector(SettingViewController.logoutViewClick), forControlEvents: UIControlEvents.TouchUpInside)
        logoutView.addSubview(logoutButton)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.logoutViewClick))
        logoutButton.addGestureRecognizer(tap)
    }
    
    // MARK: - Action
    func aboutMeViewClick() {
        let aboutVc = AboltAuthorViewController()
        navigationController?.pushViewController(aboutVc, animated: true)
    }
    
    func cleanCacheViewClick() {
        weak var tmpSelf = self
        ProgressHUDManager.show()
        FileTool.cleanFolder(LFBCachePath) { () -> () in
            tmpSelf!.cacheNumberLabel.text = "0M"
            ProgressHUDManager.dismiss()
        }
    }
    
    func logoutViewClick() {
        if Util.getCurrentUserInfo().bLogin {
            let alert = UIAlertController(title: "确定要退出登录吗？", message: "", preferredStyle: .ActionSheet)
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .Default) { (UIAlertAction) in
            self.logoutButton.setTitle("登  录", forState: UIControlState.Normal)
                Util.getCurrentUserInfo().bLogin = false
            }
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)

        }
        else{
            self.navigationController?.pushViewController(DMLoginViewController(), animated: true)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if Util.getCurrentUserInfo().bLogin {
            logoutButton.setTitle("退出当前账号", forState: UIControlState.Normal)
        }else{
            logoutButton.setTitle("登  录", forState: UIControlState.Normal)
        }
    }
    
}
