//
//  RiegoTableViewController.swift
//  digiskyTeam1
//
//  Created by Iván Ortega Sotomayor on 02/05/22.
//

import UIKit
import Firebase

class RiegoTableViewController: UITableViewController {
    
    @IBOutlet var arrigationList: UITableView! {
        didSet{
            arrigationList.dataSource = self
        }
    }
    var riegos = [Riego] ()
    let databaseRef = Firestore.firestore()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
         databaseRef.collection("irrigation").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: (err)")
            } else {
                for document in querySnapshot!.documents {
                    let datos = document.data()
                    
                    if let manager = datos["manager"] as? String, let hectares = datos["hectares"] as? String, let date = datos["date"] as? String, let type = datos["type"] as? String {
                        let riego = Riego(personaACargo: manager, tipoAgua: type, litrosDeAgua: hectares, fechaRiego: date, documentID: document.documentID)
                        self.riegos.append(riego)
                            let indexPath = IndexPath(row: self.riegos.count - 1, section: 0)
                            self.arrigationList.insertRows(at: [indexPath], with: .automatic)

                }
                }
            }
        }

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return riegos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "riegoCell", for: indexPath) as! RiegoTableViewCell
        
        let riego = riegos[indexPath.row]
        cell.update(with: riego)
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
                let post = self.riegos[indexPath.row]
        
                if editingStyle == .delete {
                    riegos.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    databaseRef.collection("irrigation").document(post.documentID).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                        }
                    }
                }
    }
    
    @IBAction func unwindFromAddRiego(unwindSegue: UIStoryboardSegue) {
        
        let addRiegoTableViewController = unwindSegue.source as! AddEditRiegoTableViewController
        if let riego = addRiegoTableViewController.riego {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                riegos[selectedIndexPath.row] = riego
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
                databaseRef.collection("irrigation").document(riego.documentID).setData(["manager" : riego.personaACargo, "type" : riego.tipoAgua, "hectares" : riego.litrosDeAgua, "date": riego.fechaRiego])
                
            } else {
                let newIndexPath = IndexPath(row: riegos.count, section: 0)
                riegos.append(riego)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editRiego" {
            let indexPath = tableView.indexPathForSelectedRow!
            let riego = riegos[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let addEditRiegoTableViewController = navController.topViewController as! AddEditRiegoTableViewController
            
            addEditRiegoTableViewController.riego = riego
        }
    }
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
        
    }
    

}
