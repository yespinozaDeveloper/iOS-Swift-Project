//
//  BaseResponse.swift
//  FinalProject
//
//  Created by yespinoza on 8/14/20.
//

import Foundation

struct BaseDataResponse <T:Codable> : Codable{
    var code:String
    var isSuccessful:Bool
    var title:String?
    var description:String?
    var data:T?
}
