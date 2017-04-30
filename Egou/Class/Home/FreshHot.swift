//
//  FreshHot.swift
//  LoveFreshBeen
//


import UIKit

class FreshHot: NSObject, DictModelProtocol {

    var page: Int = -1
    var code: Int = -1
    var msg: String?
    var data: [Goods]?
    
    class func loadFreshHotData(completion:(data: FreshHot?, error: NSError?) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("HotProduct", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            
            
            //            print("-------------------------------------------------")
//            let gamescore:BmobObject = BmobObject(className: "HotProduct")
//            //设置playerName列的值为小黑和age列的值18
//            gamescore.saveAllWithDictionary(dict as [NSObject:AnyObject])
//            gamescore.saveInBackgroundWithResultBlock { [weak gamescore] (isSuccessful, error) in
//                if error != nil{
//                    //发生错误后的动作
//                    print("error is \(error.localizedDescription)")
//                }else{
//                    //创建对象成功，打印对象值
//                    if let game = gamescore {
//                        print("save success \(game)")
//                    }
//                }
//            }
//            print("-------------------------------------------------")
            
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: FreshHot.self) as? FreshHot
            completion(data: data, error: nil)
        }
    }   
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(Goods.self)"]
    }
}

class Goods: NSObject {
    //*************************商品模型默认属性**********************************
    /// 商品ID
    var id: String?
    /// 商品姓名
    var name: String?
    var brand_id: String?
    /// 超市价格
    var market_price: String?
    var cid: String?
    var category_id: String?
    /// 当前价格
    var partner_price: String?
    var brand_name: String?
    var pre_img: String?
    
    var pre_imgs: String?
    /// 参数
    var specifics: String?
    var product_id: String?
    var dealer_id: String?
    /// 当前价格
    var price: String?
    /// 库存
    var number: Int = -1
    /// 买一赠一
    var pm_desc: String?
    var had_pm: Int = -1
    /// urlStr
    var img: String?
    /// 是不是精选 0 : 不是, 1 : 是
    var is_xf: Int = 0
    
    //*************************商品模型辅助属性**********************************
    // 记录用户对商品添加次数
    var userBuyNumber: Int = 0
}