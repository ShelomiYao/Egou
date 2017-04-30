//
//  SearchProductsModel.swift
//  LoveFreshBeen
//






import UIKit

class SearchProducts: NSObject, DictModelProtocol {
    var code: Int = -1
    var msg: String?
    var reqid: String?
    var data: [Goods]?
    
    class func loadSearchData(completion:((data: SearchProducts?, error: NSError?) -> Void)) {
        let path = NSBundle.mainBundle().pathForResource("SalesPromotion", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            
//            print("-------------------------------------------------")
//            let gamescore:BmobObject = BmobObject(className: "SalesPromotion")
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
            let data = modelTool.objectWithDictionary(dict, cls: SearchProducts.self) as? SearchProducts
            completion(data: data, error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(Goods.self)"]
    }
}
