//
//  Appointment.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/17
//


import Foundation
import RealmSwift

class AppointmentObject : Object {
    @objc dynamic var User:String
    @objc dynamic var Date:String
    @objc dynamic var Place:String
    @objc dynamic var Reason:String?
    
    required init() {
        self.User = ""
        self.Date = ""
        self.Place = ""
        self.Reason = nil
    }
}
