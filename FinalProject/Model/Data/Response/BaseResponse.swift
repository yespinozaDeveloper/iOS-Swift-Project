//
//  BaseResponse.swift
//  FinalProject
//
//  Created by yespinoza on 8/15/20.
//

import Foundation

struct BaseResponse: Codable{
    var code:String
    var isSuccessful:Bool
    var title:String?
    var description:String?
}
