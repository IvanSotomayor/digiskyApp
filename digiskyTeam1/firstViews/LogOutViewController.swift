//
//  LogOutViewController.swift
//  digiskyTeam1
//
//  Created by Iván Ortega Sotomayor on 04/05/22.
//

import UIKit
import Firebase

class LogOutViewController: UIViewController {

    @IBOutlet weak var correoUsuario: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        if let user = user {
            let email = user.email
            correoUsuario.text = email
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }

}
