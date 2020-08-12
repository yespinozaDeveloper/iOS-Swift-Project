//
//  ImageUtil.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/11
//

import Foundation
import UIKit

class ImageUtil{
    
    static func DecodeBase64Image(imageBase64:String?) -> UIImage?{
        do{
            if let imageBase64 = imageBase64, let dataDecoded:NSData = NSData(base64Encoded: imageBase64, options: NSData.Base64DecodingOptions(rawValue: 0)){
                return UIImage(data: dataDecoded as Data)!
            }else{
                return nil
            }
        }catch{
            return nil
        }
    }

    static func EncodeBase64Image(image:UIImage?) -> String?{
        do{
            let imageResized = self.resizeImage(image: image!, targetSize: CGSize(width: 150, height: 150))
            let imageData: Data? = imageResized.jpegData(compressionQuality: 0.0001)
            let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
            return imageStr.replacingOccurrences(of: "\r\n", with: "", options: .literal, range: nil)
        }catch{
            return nil
        }
    }
    
     static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
