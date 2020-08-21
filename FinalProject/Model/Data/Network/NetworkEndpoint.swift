//
//  NetworkEndpoints.swift
//  FinalProject
//
//  Created by yespinoza on 8/14/20.
//

import Foundation

struct NetworkEndpoint {
    
    static let rootAPIURL = "http://demostecno.eastus.cloudapp.azure.com:1011/_tmp-iOS-BKN/"

    static let User_Login:String = "User/Login"
    static let User_Create:String = "User/Create"
    static let User_Update:String = "User/Update"
    static let User_ChangePassword:String = "User/ChangePassword"
    static let Medical_GetHistory:String = "Medical/GetHistory"
    static let Appointment_GeAll:String = "Appointment/GeAll"
    static let Appointment_Create:String = "Appointment/Create"
    static let Appointment_Update:String = "Appointment/Update"
    static let Appointment_Delete:String = "Appointment/Delete"
}
