//
//  NotesTableViewController.swift
//  NotesOnTheGo
//
//  Created by Cristian Sedano Arenas on 14/02/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    var notesArray = [Note]()

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Notes.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       /* if let previousNote = defaults.array(forKey: "NotesArray") as? [Note] {
            self.notesArray = previousNote
        } */
        
        let firstNote = Note()
        firstNote.title = "Ir a por pan"
        notesArray.append(firstNote)
        
        let secondNote = Note()
        secondNote.title = "Comprar Huevos"
        notesArray.append(secondNote)
        
        let thirdNote = Note()
        thirdNote.title = "Leche"
        notesArray.append(thirdNote)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)

        let note = notesArray[indexPath.row]
        
        cell.textLabel?.text = note.title
        
        if note.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryView = .none
        }

        return cell
    }
    
    // MARK: - Methods Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let note = notesArray[indexPath.row]
        note.checked = (note.checked ? false : true)
        
        persistNotes()
        
        tableView.cellForRow(at: indexPath)?.accessoryType = (note.checked ? .checkmark : .none)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK:- Implement new items on the table

    @IBAction func addNewNote(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let controller = UIAlertController(title: "Implement New Note", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Implement Item", style: .default) { (action) in
            
            let note = Note()
            note.title = textField.text!
            self.notesArray.append(note)
            self.tableView.reloadData()
            self.persistNotes()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        controller.addAction(addAction)
        controller.addAction(cancelAction)
        
        controller.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Write your note"
            textField = alertTextField
        }
        
        present(controller, animated: true, completion: nil)
    }
    
    // MARK: - Data Persistence And Manipulation
    
    func persistNotes() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.notesArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error")
        }
    }
}
