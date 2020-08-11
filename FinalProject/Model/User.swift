//
//  User.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/10
//


import Foundation
import UIKit

struct User : Codable{
    var UserName:String
    var Email:String
    var Image:String?
    

    func getUImage() -> UIImage?{
        do{
            let dataDecoded:NSData = NSData(base64Encoded: Image!, options: NSData.Base64DecodingOptions(rawValue: 0))!
            return UIImage(data: dataDecoded as Data)!
        }catch{
            return nil
        }
    }
}
