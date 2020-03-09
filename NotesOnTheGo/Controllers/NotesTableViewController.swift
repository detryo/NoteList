//
//  NotesTableViewController.swift
//  NotesOnTheGo
//
//  Created by Cristian Sedano Arenas on 14/02/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import CoreData

class NotesTableViewController: UITableViewController {
    
    var notesArray = [Note]()

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Notes.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadNotes()
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
        
      // tableView.cellForRow(at: indexPath)?.accessoryType = (note.checked ? .checkmark : .none)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK:- Implement new items on the table

    @IBAction func addNewNote(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let controller = UIAlertController(title: "Implement New Note", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Implement Item", style: .default) { (action) in
            
            let note = Note(context: self.context)
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
    
    // Save Notes
    func persistNotes() {
        
        do {
            try context.save()
            
        } catch {
            print("Save Error")
        }
    }
    
    // Persist Notes
    func loadNotes(from request: NSFetchRequest<Note> = Note.fetchRequest()) {
        
        do {
            notesArray = try context.fetch(request)
        } catch {
            print("Load Error")
        }
        tableView.reloadData()
    }
}

// MARK: - Search Bar Methods

extension NotesTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchText = searchBar.text!
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        
        request.predicate = predicate
        
        let sortDescription = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sortDescription]
        
        
        loadNotes(from: request)
    }
}
