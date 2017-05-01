//
//  Mine.swift
//  LoveFreshBeen
//


import UIKit

class Mine: NSObject , DictModelProtocol{

    var code: Int = -1
    var msg: String?
    var reqid: String?
    var data: MineData?
    
    class func loadMineData(completion:(data: Mine?, error: NSError?) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("Mine", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
//            
//            print("-------------------------------------------------")
//            let gamescore:BmobObject = BmobObject(className: "Mine")
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
            let data = modelTool.objectWithDictionary(dict, cls: Mine.self) as? Mine
            completion(data: data, error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(MineData.self)"]
    }
}

class MineData: NSObject {
    var has_new: Int = -1
    var has_new_user: Int = -1
    var availble_coupon_num = 0
}