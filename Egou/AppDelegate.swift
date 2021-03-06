import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var adViewController: ADViewController?
    
    // MARK:- public方法
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        NSThread.sleepForTimeInterval(1.0)

        SMSSDK.registerApp("1e50e2985848c", withSecret: "513af83179eecbff2b67281b1b18f865")
        
        setUM()
        
        bLockEgouApp()
        
        setAppSubject()
        
        addNotification()
        
        buildKeyWindow()
        
        return true
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        bLockEgouApp()
    }
    
    
    func bLockEgouApp() {
        let num = NSUserDefaults.standardUserDefaults().objectForKey(KEY_UserDefaults_isGestureLockEnabledOrNotByUser)
        let bGestureLockEnabledOrNotByUser = num?.boolValue
        var isGestureLockEnabledOrNotByUser = true

        print("bGestureLockEnabledOrNotByUser = \(bGestureLockEnabledOrNotByUser)")
        if nil == bGestureLockEnabledOrNotByUser {
            isGestureLockEnabledOrNotByUser = false
        }
        let isHasGestureSavedInNSUserDefaults = GestureTool_Public.isHasGesturePwdStringWhichSavedInNSUserDefaults()
        
        if ((isGestureLockEnabledOrNotByUser) && isHasGestureSavedInNSUserDefaults && Util.getCurrentUserInfo().bLogin) {
            GestureLockScreen.sharedInstance().showGestureWindowByType(GestureLockScreenTypeGesturePwdVerify)
            
            let canVerifyTouchID = TouchIdUnlock.sharedInstance().canVerifyTouchID()
            if canVerifyTouchID {
                TouchIdUnlock.sharedInstance().startVerifyTouchID({
                    GestureLockScreen.sharedInstance().hide()
                })
            }
        }
    }

    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - Public Method
    private func buildKeyWindow() {
        
        window = UIWindow(frame: ScreenBounds)
        window!.makeKeyAndVisible()
        
        let isFristOpen = NSUserDefaults.standardUserDefaults().objectForKey("isFristOpenApp")
        
        if isFristOpen == nil {
            window?.rootViewController = GuideViewController()
            NSUserDefaults.standardUserDefaults().setObject("isFristOpenApp", forKey: "isFristOpenApp")
        } else {
            loadADRootViewController()
        }
    }
    
    func loadADRootViewController() {
        adViewController = ADViewController()
        
        weak var tmpSelf = self
        MainAD.loadADData { (data, error) -> Void in
            if data?.data?.img_name != nil {
                tmpSelf!.adViewController!.imageName = data!.data!.img_name
                tmpSelf!.window?.rootViewController = self.adViewController
            }
        }
    }
    
    func addNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.showMainTabbarControllerSucess(_:)), name: ADImageLoadSecussed, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.showMainTabbarControllerFale), name: ADImageLoadFail, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.shoMainTabBarController), name: GuideViewControllerDidFinish, object: nil)
    }
    
    func setUM() {
        UMSocialData.setAppKey("569f662be0f55a0efa0001cc")
        UMSocialWechatHandler.setWXAppId("wxb81a61739edd3054", appSecret: "c62eba630d950ff107e62fe08391d19d", url: "https://github.com/ShelomiYao")
        UMSocialQQHandler.setQQWithAppId("1105057589", appKey: "Zsc4rA9VaOjexv8z", url: "http://www.jianshu.com/users/5fe7513c7a57/latest_articles")
        UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey("1939108327", redirectURL: "http://sns.whalecloud.com/sina2/callback")
        
        UMSocialConfig.hiddenNotInstallPlatforms([UMShareToWechatSession, UMShareToQzone, UMShareToQQ, UMShareToSina, UMShareToWechatTimeline])
    }
    
    // MARK: - Action
    func showMainTabbarControllerSucess(noti: NSNotification) {
        let adImage = noti.object as! UIImage
        let mainTabBar = MainTabBarController()
        mainTabBar.adImage = adImage
        window?.rootViewController = mainTabBar
    }
    
    func showMainTabbarControllerFale() {
        window!.rootViewController = MainTabBarController()
    }
    
    func shoMainTabBarController() {
        window!.rootViewController = MainTabBarController()
    }
    
    // MARK:- privete Method
    // MARK:主题设置
    private func setAppSubject() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = UIColor.whiteColor()
        tabBarAppearance.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        let navBarnAppearance = UINavigationBar.appearance()
        navBarnAppearance.translucent = false
    }
    
    func loadUserInfo() -> Void {
//        if ([Util getCurrentUserInfo].isLogin == YES)
//        {
//            NSString *userName = [Util getCurrentUserInfo].userName;//已经登录状态,获取登录用户名
//        }
//        else
//        {
//            NSLog(@"未登录状态");
//        }
        if Util.getCurrentUserInfo().bLogin {
            print("已登录")
        }
    }
}


//        UserEntity *currenUser = [Util getCurrentUserInfo];
//        currenUser.bLogin = YES;
//        currenUser.userName = _phoneTextFiled.text;
//        currenUser.password = _passwordTextFiled.text;
//        NSLog(@"currenUser.userName = %@",currenUser.userName);
//        NSLog(@"currenUser.password = %@",currenUser.password);



