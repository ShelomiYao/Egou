//
//  HeadResources.swift
//  LoveFreshBeen
//


import UIKit

class HeadResources: NSObject, DictModelProtocol {

    var msg: String?
    var reqid: String?
    var data: HeadData?
    
    class func loadHomeHeadData(completion:(data: HeadResources?, error: NSError?) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("FocusButton", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            
//            print("-------------------------------------------------")
//            let gamescore:BmobObject = BmobObject(className: "FocusButton")
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
//            print("------------------------------------------------------")
            
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: HeadResources.self) as? HeadResources
            completion(data: data, error: nil)
        }
    }

    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(HeadData.self)"]
    }
}


class HeadData: NSObject, DictModelProtocol {
    var focus: [Activities]?
    var icons: [Activities]?
    var activities: [Activities]?
    
    static func customClassMapping() -> [String : String]? {
        return ["focus" : "\(Activities.self)", "icons" : "\(Activities.self)", "activities" : "\(Activities.self)"]
    }
}


class Activities: NSObject {
    var id: String?
    var name: String?
    var img: String?
    var topimg: String?
    var jptype: String?
    var trackid: String?
    var mimg: String?
    var customURL: String?
}