//
//  ViewController.swift
//  NotesOnTheGo
//
//  Created by Cristian Sedano Arenas on 14/02/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UICollectionViewController {
    
    var categoriesArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        do {
            try categoriesArray = context.fetch(request)
        } catch {
            print("Error \(error)")
        }
        
        collectionView.reloadData()
    }

    // MARK: - Methods Collection View Data Source
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        let category = categoriesArray[indexPath.row]
        cell.categoryLabel.text = category.title
        cell.categoryImageView.image = UIImage(data: category.image!)
        cell.categoryImageView.contentMode = .scaleAspectFit
        cell.categoryImageView.layer.borderColor = UIColor(hex: category.colorHex!)?.cgColor
        cell.categoryImageView.layer.borderWidth = 5
        cell.categoryImageView.layer.cornerRadius = 10
        cell.categoryImageView.backgroundColor = UIColor(hex: category.colorHex!)
        cell.categoryLabel.textColor = UIColor(hex: category.colorHex!)
        
        return cell
    }
    
    var selectedCategory = -1
    
    // MARK: - Method CollectionView Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedCategory = indexPath.row
        
        performSegue(withIdentifier: "ShowNoteList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowNoteList" {
            
            let destinationVC = segue.destination as! NotesTableViewController
                destinationVC.selectedCategory = categoriesArray[selectedCategory]
            
        }
    }
}
