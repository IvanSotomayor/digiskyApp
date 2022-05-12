//
//  SiembraTableViewController.swift
//  digiskyTeam1
//
//  Created by Iván Ortega Sotomayor on 04/05/22.
//

import UIKit
import Firebase

class SiembraTableViewController: UITableViewController {
    
    @IBOutlet var cultivateList: UITableView! {
        didSet{
            cultivateList.dataSource = self
        }
    }
    
    var siembras = [Siembra] ()
    let databaseRef = Firestore.firestore()
    
    //here database documents are loaded in cultivate table view
        override func viewDidLoad() {
            super.viewDidLoad()
            
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44.0
    
        databaseRef.collection("cultivate").getDocuments() { [self] (querySnapshot, err) in
           if let err = err {
               print("Error getting documents: \(err) ")
           } else {
               for document in querySnapshot!.documents {
                   let datos = document.data()
                   
                       if let manager = datos["manager"] as? String, let cantidadSemillas = datos["quantity"] as? String, let marca = datos["brand"] as? String, let type = datos["type"] as? String, let date = datos["date"]  {
                           let siembra = Siembra(pesonaACargo: manager, cantidadSemillas: cantidadSemillas, marca: marca, tipoSemilla: type, fechaSiembra: date as! String, documentID: document.documentID)
                           self.siembras.append(siembra)
                               let indexPath = IndexPath(row: self.siembras.count - 1, section: 0)
                               self.cultivateList.insertRows(at: [indexPath], with: .automatic)
                   }
               }
           }
       }
   }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return siembras.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "siembraCell", for: indexPath) as! SiembraTableViewCell
        
        let siembra = siembras[indexPath.row]
        cell.update(with: siembra)
        cell.showsReorderControl = true
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
    UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                let post = self.siembras[indexPath.row]
        
                if editingStyle == .delete {
                    siembras.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    databaseRef.collection("cultivate").document(post.documentID).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                        }
                    }
                }
    }
    
    @IBAction func unwindFromAddSiembra(unwindSegue: UIStoryboardSegue) {
        
        let addSiembraTableViewController = unwindSegue.source as! AddEditSiembraTableViewController
        if let siembra = addSiembraTableViewController.siembra {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                siembras[selectedIndexPath.row] = siembra
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                tableView.reloadData()
                databaseRef.collection("cultivate").document(siembra.documentID).setData(["manager" : siembra.pesonaACargo, "quantity" : siembra.cantidadSemillas, "brand" : siembra.marca, "type": siembra.tipoSemilla, "date" : siembra.fechaSiembra])
                
            } else {
                let newIndexPath = IndexPath(row: siembras.count, section: 0)
                siembras.append(siembra)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editSiembra" {
            let indexPath = tableView.indexPathForSelectedRow!
            let siembra = siembras[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let addEditSiembraTableViewController = navController.topViewController as! AddEditSiembraTableViewController
            
            addEditSiembraTableViewController.siembra = siembra
        }
    }
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
        
    }
    
    
    
    
    
}
    
    
    
