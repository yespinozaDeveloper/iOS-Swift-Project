//
//  LocationSelectionViewController.swift
//  FinalProject
//
//  Created by yespinoza on 8/15/20.
//

import UIKit

class LocationSelectionViewController: AppBaseController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var delegate:LocationProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer)
    {
        actionBtnBack(sender)
    }
    
    @IBAction func actionBtnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension LocationSelectionViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ConstantUtil.LocationList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as UITableViewCell
        cell.textLabel?.textColor = UIColor.darkGray
        cell.tintColor = UIColor.darkGray
        cell.textLabel?.text = ConstantUtil.LocationList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelect(ConstantUtil.LocationList[indexPath.row])
        self.dismiss(animated: true)
    }
    
    
}
