//
//  AdressData.swift
//  LoveFreshBeen
//






import UIKit

class AdressData: NSObject, DictModelProtocol {

    var code: Int = -1
    var msg: String?
    var data: [Adress]?
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(Adress.self)"]
    }
    
    class func loadMyAdressData(completion:(data: AdressData?, error: NSError?) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("MyAdress", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            
//            print("-------------------------------------------------")
//            let gamescore:BmobObject = BmobObject(className: "MyAdress")
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
            let data = modelTool.objectWithDictionary(dict, cls: AdressData.self) as? AdressData
            completion(data: data, error: nil)
        }
    }
}


class Adress: NSObject {
    
    var accept_name: String?
    var telphone: String?
    var province_name: String?
    var city_name: String?
    var address: String?
    var lng: String?
    var lat: String?
    var gender: String?
}

