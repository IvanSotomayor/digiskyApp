//
//  AddEditSiembraTableViewController.swift
//  digiskyTeam1
//
//  Created by Iván Ortega Sotomayor on 04/05/22.
//

import UIKit
import Firebase

class AddEditSiembraTableViewController: UITableViewController {

    @IBOutlet weak var personaACargo: UITextField!
    @IBOutlet weak var cantidadSemillas: UITextField!
    @IBOutlet weak var marcaSemillas: UITextField!
    @IBOutlet weak var tipoSemilla: UITextField!
    
    let database = Firestore.firestore()
    
    var siembra: Siembra?
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check if the pressed cell has values already
        if let siembras = siembra {
            personaACargo.text = siembras.pesonaACargo
            cantidadSemillas.text = siembras.cantidadSemillas
            marcaSemillas.text = siembras.marca
            tipoSemilla.text = siembras.tipoSemilla
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
        
        if siembra == nil, let personaNombre = personaACargo.text, let semillasCantidad = cantidadSemillas.text, let semillasMarca = marcaSemillas.text, let semillasTipo = tipoSemilla.text{
            
            database.collection(registro.siembra.collectionName).addDocument(data: [registro.siembra.personaACargo : personaNombre, registro.siembra.cantidadSemillas: semillasCantidad, registro.siembra.marca : semillasMarca, registro.siembra.tipoSemillas: semillasTipo, registro.siembra.fecha: dateFormatter.string(from:Date())]) { (error) in
                
                if let existingError = error {
                    print("ERROR")
                }else{
                    
                    print("GUARDADO EXITOSAMENTE")
                    self.database.collection("cultivate").getDocuments(){
                        [self] (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: (err)")
                        } else {
                            for document in querySnapshot!.documents {
                                let datos = document.data()
                               
                                if datos["manager"] as! String == personaNombre && datos["quantity"] as! String == semillasCantidad && datos["date"] as! String == dateFormatter.string(from:Date()) && datos["brand"] as! String == semillasMarca && datos["type"] as! String == semillasTipo {
                                    let newDocumentID : String = document.documentID
                                    currentDocumentID = newDocumentID
                                }
                            }
                        }
                    }
                    
                }
            }
            
            
        }
        
        guard segue.identifier == "saveUnwind" else { return }
        if siembra != nil{
            siembra = Siembra(pesonaACargo: personaACargo.text ?? "", cantidadSemillas: cantidadSemillas.text ?? "", marca: marcaSemillas.text ?? "", tipoSemilla: tipoSemilla.text ?? "", fechaSiembra: dateFormatter.string(from:Date()), documentID: siembra?.documentID ?? "")
        }else{
            siembra = Siembra(pesonaACargo: personaACargo.text ?? "", cantidadSemillas: cantidadSemillas.text ?? "", marca: marcaSemillas.text ?? "", tipoSemilla: tipoSemilla.text ?? "", fechaSiembra: dateFormatter.string(from:Date()), documentID: currentDocumentID)
        }
        
        
    }
    
    
    
    
    

    

}
