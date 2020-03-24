//
//  ViewController.swift
//  DeepLinking
//
//  Created by Santhosh Kumar on 26/02/20.
//  Copyright © 2020 Santhosh Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - ViewController lifecycle
    
    /** ViewDidLoad */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Deep Linking"
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: Notification.Name("DEEP_LINK_CLICKED"), object: nil)
    }
    
    // MARK: - UIButton Action
    
    @IBAction func btnAction(_ sender: UIButton) {
        let mailURL = URL(string: "message://")! // default apple mail app
        //"googlegmail://" //Gmail
        //"ms-outlook://"
        //"ymail://"
        //"readdle-spark://"
        if UIApplication.shared.canOpenURL(mailURL) {
            UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
         }
    }

    // MARK: - Notification observer
    
    ///Notification Observer
    ///
    /// - parameter notification: `Notification Object`.
    @objc func notificationReceived(_ notification: Notification) {
        goToView(notification.object as! String)
    }
    
    ///Goto particular views
    ///
    /// - parameter urlString: `url string`.
    public func goToView(_ urlString: String) {
        DispatchQueue.main.async {
            let arr: [String] = urlString.components(separatedBy: "=")
            var viewController = UIViewController()
            let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            if arr[0] == "obepower://station?stationid" + "." {
                //Station Page
                viewController = (mainStoryboard.instantiateViewController(withIdentifier: "StationViewController") as? StationViewController)!
            } else if arr[1] == "1:168565" {
                //Booking Page
                viewController = (mainStoryboard.instantiateViewController(identifier: "BookingViewController") as? BookingViewController)!
            }
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

