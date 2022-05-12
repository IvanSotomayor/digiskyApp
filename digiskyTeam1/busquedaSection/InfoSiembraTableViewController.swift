//
//  InfoSiembraTableViewController.swift
//  digiskyTeam1
//
//  Created by Carlos Seda on 04/05/22.
//

import UIKit

class InfoSiembraTableViewController: UITableViewController {
    
    @IBOutlet weak var personaACargo: UITextField!
    @IBOutlet weak var cantidadSemillas: UITextField!
    @IBOutlet weak var marca: UITextField!
    @IBOutlet weak var tipoSemilla: UITextField!
    
    var siembra: Siembra?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let siembras = siembra {
            personaACargo.text = siembras.pesonaACargo
            cantidadSemillas.text = siembras.cantidadSemillas
            marca.text = siembras.marca
            tipoSemilla.text = siembras.tipoSemilla
        }
    }
    
    @IBAction func doneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
