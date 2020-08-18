//
//  Appointment.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/10
//


import Foundation
import UIKit
import RealmSwift

class Appointment : Object {
    var User:String
    var AppointmentDate:String
    var Place:String
    var Reason:String?
    
    init(_ user:String, date:String, place:String, reason:String?){
        self.User = user
        self.AppointmentDate = date
        self.Place = place
        self.Reason = reason
    }
    
    required init() {
        self.User = ""
        self.AppointmentDate = ""
        self.Place = ""
        self.Reason = nil
    }
    
    func getDate() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.date(from:AppointmentDate)!
    }
}
