//
//  CouponData.swift
//  LoveFreshBeen
//






import UIKit

class CouponData: NSObject, DictModelProtocol {

    var code: Int = -1
    var msg: String?
    var reqid: String?
    var data: [Coupon]?
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(Coupon.self)"]
    }
    
    class func loadCouponData(completion:(data: CouponData?, error: NSError?) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("MyCoupon", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            
//            print("-------------------------------------------------")
//            let gamescore:BmobObject = BmobObject(className: "MyCoupon")
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
            let data = modelTool.objectWithDictionary(dict, cls: CouponData.self) as? CouponData
            completion(data: data, error: nil)
        }
    }
    
}

class Coupon: NSObject {
    var id: String?
    var card_pwd: String?
    /// 开始时间
    var start_time: String?
    /// 结束时间
    var end_time: String?
    /// 金额
    var value: String?
    var tid: String?
    /// 是否被使用 0 使用 1 未使用
    var is_userd: String?
    /// 0 可使用 1 不可使用
    var status: Int = -1
    var true_end_time: String?
    /// 标题
    var name: String?
    var point: String?
    var type: String?
    var order_limit_money: String?
    var desc: String?
    var free_freight: String?
    var city: String?
    var ctime: String?
    
    static func customClassMapping() -> [String : String]? {
        return ["desc" : "\(String.self)"]
    }
}

