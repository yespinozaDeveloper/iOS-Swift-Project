//
//  AppointmentViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/11.
//

import UIKit

class AppointmentViewController : AppBaseController{
    
    @IBOutlet weak var tableView: UITableView!
    var appointmentList:[Appointment] = []
    var indexRow:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAppointments()        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer)
    {
        actionBtnBack(sender)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBAction func actionBtnLogout(_ sender: Any) {
        logout()
    }
    @IBAction func actionBtnBack(_ sender: Any) {
        self.dismiss(animated: true,completion:nil)
    }
    
    @IBAction func actionBtnAddAppointment(_ sender: Any) {
        let viewController:MaintenanceViewController = getViewController("Appointment", identifier: "MaintenanceViewController")
        viewController.delegate = self
        goToPopup(viewController)
    }
    
    func getAppointments(){
        print("UI => [Fetch Appointments]")
        showLoader()
        AppointmentRepository.getAll(getCurrentUser().UserName, _protocol: self)
    }
    
    func deleteAppointment(_ indexRow:Int){
        self.indexRow = indexRow
        showLoader()
        AppointmentRepository.delete(getCurrentUser().UserName, date: self.appointmentList[indexRow].getDate(), _protocol: self)
    }
}

extension AppointmentViewController: AppointmentProtocol{
    func onUpdateSuccess() {
        getAppointments()
    }
    
    func onSuccess() {
        print("UI => [Delete Appointment] => SUCCESS")
        dismissLoader({
            //self.showInfoAlert(ConstantUtil.SuccessAppointmentDelete)
            self.appointmentList.remove(at: self.indexRow)
            self.indexRow = -1
            self.refresh()
        })
    }
    
    func onSuccess(_ data: [Appointment]) {
        print("UI => [Fetch Appointments] => SUCCESS")
        dismissLoader({
            self.appointmentList = data
            self.refresh()
        })
    }
    
    func onError() {
        print("UI => [Appointment] => Error")
        dismissLoader({self.showDefaultError()})
    }
    
    func onError(_ message:String) {
        print("UI => [Appointment] => Handled Error")
        dismissLoader({self.showInfoAlert(ConstantUtil.ErrorDefaultTitle, message:message)})
    }
}


extension AppointmentViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        appointmentList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.showConfirmAlert(ConstantUtil.DeleteAppointmentTittle, message: ConstantUtil.DeleteAppointmentConfirmationMessage,
                              acceptButton: ConstantUtil.DeleteOption, acceptHandler: {_ in self.deleteAppointment(indexPath.row)})
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AppointmentCell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as! AppointmentCell
        
        let item = appointmentList[indexPath.row]
        cell.lblDate.text = item.AppointmentDate
        cell.lblType.text = item.Reason
        cell.lblPlace.text = item.Place
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Appointment", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "MaintenanceViewController") as! MaintenanceViewController
        
        viewController.SelectedAppointment = appointmentList[indexPath.row]
        dismissLoader({ self.present(viewController, animated: true, completion: nil)})
    }
    
    func refresh(){
        print("REFRESCAR")
        self.tableView.reloadData()
    }
}
