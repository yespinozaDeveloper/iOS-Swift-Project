//
//  CacheDataUtil.swift
//  FinalProject
//
//  Created by yespinoza on 8/15/20.
//

import Foundation

struct CacheDataUtil{
    static var UserCache:User!
    
    static func initUser(_ userName:String?){
        UserCache = User.init(UserName: userName ?? "", Email: "", Image: nil)
    }
}
