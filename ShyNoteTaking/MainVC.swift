//
//  ViewController.swift
//  ShyNoteTaking
//
//  Created by Andi on 2016-12-22.
//  Copyright © 2016 andiroot. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var imageCaptured: UIImageView!
    @IBOutlet weak var entryNote: UITextField!
    
    @IBOutlet weak var qty: UITextField!
    @IBOutlet weak var note: UITextField!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var nItem: NoteData? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if nItem != nil{
            entryNote.text = nItem?.note
            //note.text = nItem?.note
            //qty.text = nItem?.qty
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func cancelTapped(_ sender: Any) {
         dismissVC()
    }
    
    @IBAction func addImagesFromCamera(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.imageCaptured.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if nItem == nil{
            newItem()
        }else{
            editItem()
        }
        dismissVC()
    }
    func dismissVC(){
        navigationController?.popViewController(animated: true)
    }
    func newItem(){
        let context = self.context
        let ent = NSEntityDescription.entity(forEntityName: "NoteData", in: context)
        let nItem = NoteData(entity: ent!, insertInto: context)
        nItem.note = entryNote.text
      //  nItem.note = note.text
      //  nItem.qty  = qty.text
        do {
            try context.save()
            
        } catch  {
            
        }
        
        
        
    }
    func editItem(){
        nItem?.note = entryNote.text
        //nItem?.note = note.text
        //nItem?.qty  = qty.text
        do {
            try context.save()
            
        } catch  {
            
        }
        
    }
    
    
    
}

