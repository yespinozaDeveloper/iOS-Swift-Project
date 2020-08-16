//
//  MedicalProtocol.swift
//  FinalProject
//
//  Created by yespinoza on 8/15/20.
//

import Foundation

protocol MedicalProtocol {
    func onSuccess(_ data:[MedicalHistory]) -> Void
    func onError() -> Void
}
