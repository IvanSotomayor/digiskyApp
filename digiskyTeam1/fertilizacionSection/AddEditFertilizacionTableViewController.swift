//
//  AddEditFertilizacionTableViewController.swift
//  digiskyTeam1
//
//  Created by Carlos Seda on 04/05/22.
//

import UIKit
import Firebase

class AddEditFertilizacionTableViewController: UITableViewController {
    
    @IBOutlet weak var personaACargo: UITextField!
    @IBOutlet weak var tipoFertilizante: UITextField!
    @IBOutlet weak var cantidadUtilizada: UITextField!
    
    let database = Firestore.firestore()
    
    var fertilizacion : Fertilizacion?
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fertilizaciones = fertilizacion {
            personaACargo.text = fertilizaciones.personaACargo
            tipoFertilizante.text = fertilizaciones.tipoFertilizante
            cantidadUtilizada.text = fertilizaciones.cantidadFertilizante
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var currentDocumentID = ""
        super.prepare(for: segue, sender: sender)
        
        var dateFormatter: DateFormatter = {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                return dateFormatter
        }()
        
        if fertilizacion == nil, let personaNombre = personaACargo.text, let fertilizanteTipo = tipoFertilizante.text, let utilizadaCantidad = cantidadUtilizada.text {
            
            database.collection(registro.fertilizacion.collectionName).addDocument(data: [registro.fertilizacion.personaACargo : personaNombre, registro.fertilizacion.tipoFertilizante: fertilizanteTipo, registro.fertilizacion.cantidadFertilizante : fertilizanteTipo, registro.fertilizacion.fecha: dateFormatter.string(from:Date())]) { (error) in
                
                if let existingError = error {
                    print("ERROR")
                }else{
                    print("GUARDADO EXITOSAMENTE")
                    self.database.collection("fertilization").getDocuments(){
                        [self] (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: (err)")
                        }else{
                            for document in querySnapshot!.documents {
                                let datos = document.data()
                                
                                if datos["manager"] as! String == personaNombre && datos["type"] as! String == fertilizanteTipo && datos["quantity"] as! String == utilizadaCantidad && datos["date"] as! String == dateFormatter.string(from:Date()){
                                    let newDocumentID: String = document.documentID
                                    currentDocumentID = newDocumentID
                                }
                            }
                        }
                    }
                }
            }
        }
        
        guard segue.identifier == "saveUnwind" else { return }
        if fertilizacion != nil {
            fertilizacion = Fertilizacion(personaACargo: personaACargo.text ?? "", tipoFertilizante: tipoFertilizante.text ?? "", cantidadFertilizante: cantidadUtilizada.text ?? "", fechaFertilizacion: dateFormatter.string(from:Date()), documentID: fertilizacion?.documentID ?? "")
        } else{
            fertilizacion = Fertilizacion(personaACargo: personaACargo.text ?? "", tipoFertilizante: tipoFertilizante.text ?? "", cantidadFertilizante: cantidadUtilizada.text ?? "", fechaFertilizacion: dateFormatter.string(from:Date()), documentID: currentDocumentID)
        }
    }

}
