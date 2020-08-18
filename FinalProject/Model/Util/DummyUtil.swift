//
//  DummyResponseUtil.swift
//  FinalProject
//
//  Created by yespinoza on 8/15/20.
//

import Foundation

class DummyUtil{
    static var IsDummyEnabled:Bool = false
    
    static func getDummyResponse(_ action:String) -> String{
        var response:String
        switch action {
        case NetworkEndpoint.User_Login:
            response =  "{\"code\": \"00\",\"isSuccessful\": true,\"data\": {\"UserName\": \"\(CacheDataUtil.UserCache.UserName)\", \"Email\": \"yespinoza@tecnosys.net\", \"Image\": \"\(ConstantUtil.defaultImage)\"}}"
            break
        case NetworkEndpoint.User_Create:
            response =  "{\"code\": \"00\",\"isSuccessful\": true}"
            break
        case NetworkEndpoint.User_Update:
            response =  "{\"code\": \"00\",\"isSuccessful\": true,\"data\": {\"UserName\": \"\(CacheDataUtil.UserCache.UserName)\", \"Email\": \"\(CacheDataUtil.UserCache.Email)\", \"Image\": \"\(CacheDataUtil.UserCache.Image ?? ConstantUtil.defaultImage)\"}}"
            break
        case NetworkEndpoint.User_ChangePassword:
            response =  "{\"code\": \"00\",\"isSuccessful\": true}"
            break
        case NetworkEndpoint.Medical_GetHistory:
            response = "{\"code\": \"00\",\"isSuccessful\": true,\"data\": ["
            for count in 1...15 {
                let date = Date()
                let dateEdited = Calendar.current.date(byAdding: .month, value: -count, to: date)
                let formatter = DateFormatter()
                formatter.dateFormat = ConstantUtil.HistoryDateFormat
                
                if let dateEdited = dateEdited
                {
                    response += "{ \"Date\":\"\(formatter.string(from: dateEdited))\", \"Detail\":\"\(ConstantUtil.defaultDescription)\"}"
                    if(count < 15){
                        response += ", "
                    }
                }
            }
            response += "]}"
            break
        case NetworkEndpoint.Appointment_GeAll:
            response = "{\"code\": \"00\",\"isSuccessful\": true,\"data\": ["
            for count in 1...5 {
                let date = Date()
                let dateEdited = Calendar.current.date(byAdding: .month, value: count, to: date)
                let formatter = DateFormatter()
                formatter.dateFormat = ConstantUtil.HistoryDateFormat
                
                if let dateEdited = dateEdited
                {
                    response += "{ \"AppointmentDate\":\"\(formatter.string(from: dateEdited))\", \"Place\":\"Alajuela Dental Clinic\", \"Reason\":\"Monthly Control\"}"
                    if(count < 5){
                        response += ", "
                    }
                }
            }
            response += "]}"
            break
        case NetworkEndpoint.Appointment_Create:
            response =  "{\"code\": \"00\",\"isSuccessful\": true}"
            break
        case NetworkEndpoint.Appointment_Update:
            response =  "{\"code\": \"00\",\"isSuccessful\": true}"
            break
        case NetworkEndpoint.Appointment_Delete:
            response =  "{\"code\": \"00\",\"isSuccessful\": true}"
            break
        default:
            response =  ""
        }
        print("###DUMMY RESPONSE### => \(response)")
        return response
    }
}
