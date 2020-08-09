//
//  ViewController.swift
//  FinalProject
//
//  Created by MacBookDesarrolloTecno on 8/8/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actionLogin(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "App", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "TabController")
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true, completion: nil)
    }
    
}

