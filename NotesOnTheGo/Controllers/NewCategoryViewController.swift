//
//  NewCategoryViewController.swift
//  NotesOnTheGo
//
//  Created by Cristian Sedano Arenas on 23/03/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class NewCategoryViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet var colorSliders: [UISlider]!
    @IBOutlet var colorLabels: [UILabel]!
    
    @IBOutlet weak var hexLabel: UILabel!
    
    let colorKeys = ["R", "G", "B", "A"]
    let imagePicker = UIImagePickerController()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)

        repaintBackbround()
        imagePicker.delegate = self
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        colorLabels[sender.tag].text = "\(colorKeys[sender.tag]): \(lroundf(sender.value*255.0))"
        repaintBackbround()
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        let category = Category(context: context)
        category.title = textField.text
        category.colorHex = UIColor(hex: hexLabel.text!)?.toHex
        category.image = imageView.image?.pngData()
        
        do {
            try context.save()
        } catch {
            print("Category error")
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        
       dismiss(animated: true, completion: nil)
    }
    
    @objc func imageViewTapped() {
        
        let controller = UIAlertController(title: "Select Image", message: "", preferredStyle: .actionSheet)
        
        controller.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert) in
            self.presentImagePicker(with: .camera)
        }))
        
        controller.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: { (action) in
            self.presentImagePicker()
        }))
        
        controller.addAction(UIAlertAction(title: "Film roll", style: .default, handler: { (action) in
            self.presentImagePicker(with: .photoLibrary)
        }))
        
        self.present(controller, animated: true, completion: nil)
    }
    
    func presentImagePicker(with sourceType: UIImagePickerController.SourceType = .savedPhotosAlbum) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
        
    }
    //
    func repaintBackbround() {
        
        let backColor = UIColor(red: CGFloat(colorSliders[0].value), green: CGFloat(colorSliders[1].value), blue: CGFloat(colorSliders[2].value), alpha: CGFloat(colorSliders[3].value))
        
        self.view.backgroundColor = backColor
        self.hexLabel.text = backColor.toHex
    }
}

extension NewCategoryViewController: UITextFieldDelegate {
    //
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

extension NewCategoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
}
