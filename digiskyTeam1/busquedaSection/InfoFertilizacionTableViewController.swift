//
//  InfoFertilizacionTableViewController.swift
//  digiskyTeam1
//
//  Created by Carlos Seda on 04/05/22.
//

import UIKit

class InfoFertilizacionTableViewController: UITableViewController {
    
    @IBOutlet weak var personaAcargo: UITextField!
    @IBOutlet weak var tipoFertilizante: UITextField!
    @IBOutlet weak var cantidadUtilizada: UITextField!
    
    var fertilizacion : Fertilizacion?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fertilizaciones = fertilizacion {
            personaAcargo.text = fertilizaciones.personaACargo
            tipoFertilizante.text = fertilizaciones.tipoFertilizante
            cantidadUtilizada.text = fertilizaciones.cantidadFertilizante
        }

    }
    
    @IBAction func buttonDone(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
