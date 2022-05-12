//
//  AddEditRiegoTableViewController.swift
//  digiskyTeam1
//
//  Created by Iván Ortega Sotomayor on 02/05/22.
//

import UIKit
import Firebase

class AddEditRiegoTableViewController: UITableViewController {
   
    @IBOutlet weak var personaACargo: UITextField!
    @IBOutlet weak var tipoAgua: UISegmentedControl!
    @IBOutlet weak var litrosAgua: UITextField!
    
    
    let database = Firestore.firestore()
    
    var riego: Riego?
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil) 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let riegos = riego {
            personaACargo.text = riegos.personaACargo
            litrosAgua.text = "\(riegos.litrosDeAgua)"
            
            if riegos.tipoAgua == "Noria"{
                tipoAgua.selectedSegmentIndex = 0
            } else {
                tipoAgua.selectedSegmentIndex = 1
            }
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
        
        var tipoAguaNombre = ""
               
        if tipoAgua.selectedSegmentIndex == 1 {
            tipoAguaNombre = "Rio"
        }
               
        else if tipoAgua.selectedSegmentIndex == 0{
            tipoAguaNombre = "Noria"
        }
               
        if riego == nil, let personaNombre = personaACargo.text, let litrosAgua = litrosAgua.text {
            
            
            database.collection(registro.riego.collectionName).addDocument(data: [registro.riego.personaACargo: personaNombre,registro.riego.litrosAgua: litrosAgua,registro.riego.tipoAgua: tipoAguaNombre, registro.riego.fecha: dateFormatter.string(from:Date())]) { (error) in
                if let existingError = error{
                    print("No guardado o editado")
                }else{
                    
                    print("Guardado exitosamente!! ª")
                    
                    self.database.collection("irrigation").getDocuments() { [self] (querySnapshot, err) in
                       if let err = err {
                           print("Error getting documents: (err)")
                       } else {
                           for document in querySnapshot!.documents {
                               let datos = document.data()
                              
                               if datos["manager"] as! String == personaNombre && datos["type"] as! String == tipoAguaNombre && datos["date"] as! String == dateFormatter.string(from:Date()) && datos["hectares"] as! String == litrosAgua{
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
        if riego != nil{
            riego = Riego(personaACargo: personaACargo.text ?? "", tipoAgua: tipoAguaNombre, litrosDeAgua: litrosAgua.text ?? "", fechaRiego: riego?.fechaRiego ?? "", documentID: riego?.documentID ?? "")
        }else{
            riego = Riego(personaACargo: personaACargo.text ?? "", tipoAgua: tipoAguaNombre, litrosDeAgua: litrosAgua.text ?? "", fechaRiego: dateFormatter.string(from:Date()), documentID: currentDocumentID)
        }
    }

}
