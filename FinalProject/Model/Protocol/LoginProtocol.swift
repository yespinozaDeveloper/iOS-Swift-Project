//
//  LoginProtocol.swift
//  FinalProject
//
//  Created by yespinoza on 8/15/20.
//

import Foundation

protocol LoginProtocol {
    func onSuccess(_ user:User) -> Void
    func onError() -> Void
}
