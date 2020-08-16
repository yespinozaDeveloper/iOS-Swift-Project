//
//  FormatUtil.swift
//  FinalProject
//
//  Created by yespinoza on 8/15/20.
//

import Foundation

struct FormatUtil{
    static func dateFormat(_ date:Date) -> String{
        return dateFormat(date, format:"yyyy/MM/dd")
    }
    static func dateFormat(_ date:Date, format:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
