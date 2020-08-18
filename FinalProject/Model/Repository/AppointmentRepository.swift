//
//  AppointmentRepository.swift
//  FinalProject
//
//  Created by yespinoza on 8/15/20.
//

import Foundation

class AppointmentRepository{
    
    static func getAll(_ userName:String, _protocol:AppointmentProtocol){
        do{
            let filter:String = "User == '\(userName)'"
            let appointmentObjectArray:[AppointmentObject] = try RealmSwiftHelper.getInstance().get(filter)
            var appointmentArray:[Appointment] = []
            for item in appointmentObjectArray{
                let appointment:Appointment = Appointment.init(userName, date: item.Date, place: item.Place, reason: item.Reason)
                appointmentArray.append(appointment)
            }
            _protocol.onSuccess(appointmentArray)
        }catch{
            _protocol.onError()
        }
    }
    
    static func save(_ userName:String, date:Date, location:String, reason:String, _protocol:SaveAppointmentProtocol){
        do{
            let filter:String = "User == '\(userName)' AND Date == '\(FormatUtil.dateFormat(date))'"
            let array :[AppointmentObject] = try RealmSwiftHelper.getInstance().get(filter)
            
            if array.count != 0 {
                _protocol.onError(ConstantUtil.DuplicityAppointmentError)
            }
            else{
                let appointment:AppointmentObject = AppointmentObject.init()
                appointment.User = userName
                appointment.Date = FormatUtil.dateFormat(date)
                appointment.Place = location
                appointment.Reason = reason
                RealmSwiftHelper.getInstance().add(appointment)
                _protocol.onSuccess()
            }
        }catch{
            _protocol.onError()
        }
    }
    
    static func update(_ userName:String, oldDate:Date, newDate:Date, location:String, reason:String, _protocol:SaveAppointmentProtocol){
        do{
            var array :[AppointmentObject] = []
            
            if oldDate != newDate {
                let filter:String = "User == '\(userName)' AND Date == '\(FormatUtil.dateFormat(newDate))'"
                array = try RealmSwiftHelper.getInstance().get(filter)
            }
            
            if array.count != 0 {
                _protocol.onError(ConstantUtil.DuplicityAppointmentError)
            }
            else{
                let appointment:AppointmentObject = AppointmentObject.init()
                appointment.User = userName
                appointment.Date = FormatUtil.dateFormat(newDate)
                appointment.Place = location
                appointment.Reason = reason
                let filter:String = "User == '\(userName)' AND Date == '\(FormatUtil.dateFormat(oldDate))'"
                RealmSwiftHelper.getInstance().update(appointment, filter:filter)
                _protocol.onSuccess()
            }
        }catch{
            _protocol.onError()
        }
    }
    
    static func delete(_ userName:String, date:Date, _protocol:AppointmentProtocol){
        do{
            let filter:String = "User == '\(userName)' AND Date == '\(FormatUtil.dateFormat(date))'"
            let array :[AppointmentObject] = try RealmSwiftHelper.getInstance().get(filter)
            
            if array.count == 0 {
                _protocol.onError(ConstantUtil.NotFoundAppointmentError)
            }
            else{
                RealmSwiftHelper.getInstance().delete(array.first!)
                _protocol.onSuccess()
            }
        }catch{
            _protocol.onError()
        }
    }
}
