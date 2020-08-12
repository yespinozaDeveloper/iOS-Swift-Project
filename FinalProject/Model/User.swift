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
        return ImageUtil.DecodeBase64Image(imageBase64: self.Image)
    }

    mutating func setUImage(image:UIImage?){
        self.Image = ImageUtil.EncodeBase64Image(image: image)
    }
}
