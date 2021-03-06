//
//  ShareManager.swift
//  LoveFreshBeen
//






import UIKit

class ShareManager: NSObject {
    
    static private let blogURLStr = "http://www.jianshu.com/users/5fe7513c7a57/latest_articles"
    static private let authorImage = UIImage(named: "author")
    static private let shareText = "小姚Swift全新开源作品,高仿易购超市,配有blog讲解思路,喜欢的同学star点起来"
    
    class func shareToShareType(shareType: ShareType, vc: UIViewController) {
        
        switch shareType {
            
        case .WeiXinMyFriend:
            UMSocialData.defaultData().extConfig.wechatSessionData.url = blogURLStr
            UMSocialData.defaultData().extConfig.wechatSessionData.title = "小姚Swift开源新作"
            
            
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
            UMSocialData.defaultData().extConfig.wechatTimelineData.title = "小姚Swift开源新作"
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
            
            UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToSina], content: shareText + "   下载地址" + "https://github.com/ShelomiYao", image: authorImage, location: nil, urlResource: nil, presentedController: vc, completion: { (response) -> Void in
                if response.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                    showSuccessAlert()
                } else {
                    showErrorAlert()
                }
            })
            break
            
        case .QQZone:
            
            UMSocialData.defaultData().extConfig.qzoneData.url = blogURLStr
            UMSocialData.defaultData().extConfig.qzoneData.title = "小姚Swift开源新作"
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
        print("分享成功")
    }
    
    class func showErrorAlert() {
        print("分享失败")
    }
}
