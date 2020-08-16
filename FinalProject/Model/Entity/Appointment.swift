//
//  Appointment.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/10
//


import Foundation
import UIKit

struct Appointment : Codable{
    var AppointmentDate:String
    var Place:String
    var Reason:String?
    
    func getDate() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.date(from:AppointmentDate)!
    }
}
