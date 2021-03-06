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
        print("data = \(data)")
//        if data != nil {
        if false{
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            
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

