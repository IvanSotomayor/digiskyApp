//
//  InfoRiegoTableViewController.swift
//  digiskyTeam1
//
//  Created by Carlos Seda on 04/05/22.
//

import UIKit

class InfoRiegoTableViewController: UITableViewController {
    
    @IBOutlet weak var personaACargo: UITextField!
    @IBOutlet weak var tipoDeAgua: UISegmentedControl!
    @IBOutlet weak var litrosAgua: UITextField!
    @IBOutlet weak var fecha: UILabel!
    
    
    var riego: Riego?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let riegos = riego {
            personaACargo.text = riegos.personaACargo
            litrosAgua.text = "\(riegos.litrosDeAgua)"
            
            if riegos.tipoAgua == "Noria"{
                tipoDeAgua.selectedSegmentIndex = 0
            } else {
                tipoDeAgua.selectedSegmentIndex = 1
            }
            
            fecha.text = riegos.fechaRiego
        }
    }
    
    @IBAction func doneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil) 
    }
    

}
