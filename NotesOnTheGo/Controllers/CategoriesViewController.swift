//
//  ViewController.swift
//  NotesOnTheGo
//
//  Created by Cristian Sedano Arenas on 14/02/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class CategoriesViewController: UICollectionViewController {
    
    let categoriesArray = ["Compras", "Tareas De La Casa", "Ocio"]

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
        
        cell.categoryLabel.text = categoriesArray[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ShowNoteList", sender: self)
    }
}

