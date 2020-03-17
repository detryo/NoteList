//
//  ViewController.swift
//  NotesOnTheGo
//
//  Created by Cristian Sedano Arenas on 14/02/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class CategoriesViewController: UICollectionViewController {
    
    var categoriesArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        return cell
    }
    
    // MARK: - Method CollectionView Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ShowNoteList", sender: self)
    }
    
    // MARK: - Create New Categories
    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem) {
        
        
    }
}
