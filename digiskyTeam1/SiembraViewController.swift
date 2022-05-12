//
//  SiembraViewController.swift
//  digiskyTeam1
//
//  Created by Iván Ortega Sotomayor on 29/04/22.
//

import UIKit
import Firebase

class SiembraViewController: UIViewController {
    
    let database = Firestore.firestore()
    
    @IBOutlet weak var personaTextField: UITextField!
    @IBOutlet weak var tipoAguaUsada: UISegmentedControl!
    @IBOutlet weak var litrosAguaUsados: UITextField!
    @IBOutlet weak var warning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warning.text = ""
        // Do any additional setup after loading the view.
    }
    
    @IBAction func agregarButtonPressed(_ sender: UIButton) {
        
        var tipoAguaNombre = ""
        
        if tipoAguaUsada.selectedSegmentIndex == 0 {
            tipoAguaNombre = "Agua de Rio"
        }
        
        else if tipoAguaUsada.selectedSegmentIndex == 1{
            tipoAguaNombre = "Agua de Noria"
        }
        
        if let personaNombre = personaTextField.text, let litrosAgua = litrosAguaUsados.text{
            
            database.collection(registro.riego.collectionName).addDocument(data: [registro.riego.personaACargo: personaNombre,registro.riego.litrosAgua: litrosAgua,registro.riego.tipoAgua: tipoAguaNombre]) { (error) in
                if let existingError = error{
                    self.warning.textColor = UIColor.red
                    self.warning.text = existingError.localizedDescription
                }else{
                    self.warning.textColor = UIColor.green
                    self.warning.text = "Guardado exitosamente"
                    print("Guardado exitosamente!!")
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
