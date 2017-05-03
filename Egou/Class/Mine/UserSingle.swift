//
//  UserSingle.swift
//  Egou
//
//  Created by Mac on 17/5/1.
//  Copyright © 2017年 ShelomiYao. All rights reserved.
//

import Foundation



class UserSingle  {
    var userName: String?
    var password: String?
    var mobilePhoneNumber: String?
    var mobilePhoneNumberVer: String?

    static let sharedInstance = UserSingle()
    private init() {}
}

let userSingle: UserSingle? = UserSingle .sharedInstance
