//
//  MaintenanceViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/12
//

import UIKit

class MaintenanceViewController: AppBaseController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var actionBtnLocation: UIButton!
    @IBOutlet weak var txtReason: UITextView!
    var SelectedAppointment:Appointment?
    var delegate:AppointmentProtocol?
    
    override func viewDidLoad() {
        if let appointment = SelectedAppointment{

            datePicker.date = appointment.getDate()
            txtReason.text = appointment.Reason
            actionBtnLocation.setTitle(appointment.Place, for: .normal)
            if appointment.getDate() < Date.init()
            {
                datePicker.minimumDate = appointment.getDate()
            }else{
                datePicker.minimumDate = Date.init()
            }
        
        }else{
            datePicker.minimumDate = Date.init()
        }
    }
    
    @IBAction func actionBtnSave(_ sender: Any) {
        showLoader()
        //TODO - Call service
        dismissLoader({self.showInfoAlert(ConstantUtil.SuccessAppointmentSave)})
        delegate?.onUpdateSuccess()
        dismiss(animated: true)
    }
    @IBAction func actionBtnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func actionBtnLocation(_ sender: Any) {
        let viewController:LocationSelectionViewController = getViewController("Appointment", identifier: "LocationSelectionViewController")
        viewController.delegate = self
        goTo(viewController)
    }
}

extension MaintenanceViewController : LocationProtocol{
    func onSelect(_ location: String) {
        print("UI => [Select Location] => SUCCESS")
        SelectedAppointment?.Place = location
        actionBtnLocation.setTitle(location, for: .normal)
    }
    
    
}
