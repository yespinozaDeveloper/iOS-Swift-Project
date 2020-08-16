//
//  UserProtocol.swift
//  FinalProject
//
//  Created by yespinoza on 8/15/20.
//

import Foundation

protocol UserProtocol {
    func onSuccess(_ user:User?) -> Void
    func onError() -> Void
}
