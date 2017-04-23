//
//  SelectedAdressViewController.swift
//  LoveFreshBeen
//






import UIKit

class SelectedAdressViewController: AnimationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        if UserInfo.sharedUserInfo.hasDefaultAdress() {
            let titleView = AdressTitleView(frame: CGRectMake(0, 0, 0, 30))
            titleView.setTitle(UserInfo.sharedUserInfo.defaultAdress()!.address!)
            titleView.frame = CGRectMake(0, 0, titleView.adressWidth, 30)
            navigationItem.titleView = titleView
            
            let tap = UITapGestureRecognizer(target: self, action: "titleViewClick")
            navigationItem.titleView?.addGestureRecognizer(tap)
        }
    }
    
    // MARK: - Build UI
    private func buildNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton("扫一扫", titleColor: UIColor.blackColor(),
            image: UIImage(named: "icon_black_scancode")!, hightLightImage: nil,
            target: self, action: "leftItemClick", type: ItemButtonType.Left)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton("搜 索", titleColor: UIColor.blackColor(),
            image: UIImage(named: "icon_search")!,hightLightImage: nil,
            target: self, action: "rightItemClick", type: ItemButtonType.Right)
        
        let titleView = AdressTitleView(frame: CGRectMake(0, 0, 0, 30))
        titleView.frame = CGRectMake(0, 0, titleView.adressWidth, 30)
        navigationItem.titleView = titleView
        
        let tap = UITapGestureRecognizer(target: self, action: "titleViewClick")
        navigationItem.titleView?.addGestureRecognizer(tap)
    }
    
    // MARK:- Action
    // MARK: 扫一扫和搜索Action
    func leftItemClick() {
        let qrCode = QRCodeViewController()
        navigationController?.pushViewController(qrCode, animated: true)
    }
    
    func rightItemClick() {
        let searchVC = SearchProductViewController()
        navigationController!.pushViewController(searchVC, animated: false)
    }
    
    func titleViewClick() {
        weak var tmpSelf = self
        
        let adressVC = MyAdressViewController { (adress) -> () in
            let titleView = AdressTitleView(frame: CGRectMake(0, 0, 0, 30))
            titleView.setTitle(adress.address!)
            titleView.frame = CGRectMake(0, 0, titleView.adressWidth, 30)
            tmpSelf?.navigationItem.titleView = titleView
            UserInfo.sharedUserInfo.setDefaultAdress(adress)
            
            let tap = UITapGestureRecognizer(target: self, action: "titleViewClick")
            tmpSelf?.navigationItem.titleView?.addGestureRecognizer(tap)
        }
        adressVC.isSelectVC = true
        navigationController?.pushViewController(adressVC, animated: true)
    }
}
