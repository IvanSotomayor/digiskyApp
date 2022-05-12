//
//  LogInViewController.swift
//  digiskyTeam1
//
//  Created by Iván Ortega Sotomayor on 28/04/22.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInWarning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInWarning.text = ""
        emailTextField.text = "sotto02@gmail.com"
        passwordTextField.text = "contraseñaxd"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let existingError = error {
                    self.logInWarning.textColor = UIColor.red
                    self.logInWarning.text = existingError.localizedDescription
                }else{
                    self.performSegue(withIdentifier: "logInToTabBar", sender: self)
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
