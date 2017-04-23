//
//  ShareManager.swift
//  LoveFreshBeen
//






import UIKit

class ShareManager: NSObject {
    
    static private let blogURLStr = "http://www.jianshu.com/users/5fe7513c7a57/latest_articles"
    static private let authorImage = UIImage(named: "author")
    static private let shareText = "小ESwift全新开源作品,高仿爱鲜蜂,配有blog讲解思路,喜欢的同学star点起来"
    
    class func shareToShareType(shareType: ShareType, vc: UIViewController) {
        
        switch shareType {
            
        case .WeiXinMyFriend:
            UMSocialData.defaultData().extConfig.wechatSessionData.url = blogURLStr
            UMSocialData.defaultData().extConfig.wechatSessionData.title = "小ESwift开源新作"
            
            
            let shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: blogURLStr)
            
            UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatSession], content: shareText, image: authorImage, location: nil, urlResource: shareURL, presentedController: nil) { (response) -> Void in
                if response.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                    showSuccessAlert()
                } else {
                    showErrorAlert()
                }
            }
            
            break
            
        case .WeiXinCircleOfFriends:
            
            UMSocialData.defaultData().extConfig.wechatTimelineData.url = blogURLStr
            UMSocialData.defaultData().extConfig.wechatTimelineData.title = "小ESwift开源新作"
            let shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: blogURLStr)
            UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatTimeline], content: shareText, image: authorImage, location: nil, urlResource: shareURL, presentedController: nil, completion: { (response) -> Void in
                if response.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                    showSuccessAlert()
                } else {
                    showErrorAlert()
                }
            })
            
            break
            
        case .SinaWeiBo:
            
            UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToSina], content: shareText + "   下载地址" + "https://github.com/ZhongTaoTian", image: authorImage, location: nil, urlResource: nil, presentedController: vc, completion: { (response) -> Void in
                if response.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                    showSuccessAlert()
                } else {
                    showErrorAlert()
                }
            })
            break
            
        case .QQZone:
            
            UMSocialData.defaultData().extConfig.qzoneData.url = blogURLStr
            UMSocialData.defaultData().extConfig.qzoneData.title = "小ESwift开源新作"
            let shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: blogURLStr)
            
            UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToQzone], content: shareText, image: authorImage, location: nil, urlResource: shareURL, presentedController: nil, completion: { (response) -> Void in
                if response.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                    showSuccessAlert()
                } else {
                    showErrorAlert()
                }
            })
            
            
            break
        }
    }
    
    class func showSuccessAlert() {
        
        let alert = UIAlertView(title: "成功", message: "分享成功", delegate: nil, cancelButtonTitle: "知道了")
        alert.show()
    }
    
    class func showErrorAlert() {
        
        let alert = UIAlertView(title: "失败", message: "分享失败", delegate: nil, cancelButtonTitle: "知道了")
        alert.show()
        
    }
}
