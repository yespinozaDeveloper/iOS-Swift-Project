//
//  AppointmentProtocol.swift
//  FinalProject
//
//  Created by yespinoza on 8/15/20.
//
protocol AppointmentProtocol {
    func onSuccess(_ data:[Appointment]) -> Void
    func onSuccess() -> Void
    func onUpdateSuccess() -> Void
    func onError() -> Void
}
