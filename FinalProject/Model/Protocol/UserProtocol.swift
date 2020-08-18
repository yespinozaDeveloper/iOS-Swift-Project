//
//  UserProtocol.swift
//  FinalProject
//
//  Created by yespinoza on 8/15/20.
//

import Foundation

protocol UserProtocol {
    func SaveUser(_ userName:String, email:String, password:String) -> Void
    func onSuccess(_ user:User?) -> Void
    func onError() -> Void
    func onError(_ title:String?, message:String?) -> Void
}

protocol SettingsProtocol {
    func UpdateUser(_ user:User, imageHasChanged:Bool) -> Void
    func onSuccess(_ user:User?) -> Void
    func onError() -> Void
    func onError(_ title:String?, message:String?) -> Void
}

protocol ChangePasswordProtocol{
    func ChangePassword(_ password:String, newPassword:String) -> Void
    func onSuccess(_ user:User?) -> Void
    func onError() -> Void
    func onError(_ title:String?, message:String?) -> Void
}
