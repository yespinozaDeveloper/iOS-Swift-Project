//
//  LoginProtocol.swift
//  FinalProject
//
//  Created by yespinoza on 8/15/20.
//

import Foundation

protocol LoginProtocol {
    func login(_ userName:String, password:String) -> Void
    func onSuccess(_ user:User) -> Void
    func onError() -> Void
    func onError(_ title:String?, message:String?) -> Void
}
