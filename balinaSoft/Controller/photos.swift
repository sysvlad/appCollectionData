//
//  photos.swift
//  balinaSoft
//
//  Created by Vlad Sys on 12/13/17.
//  Copyright © 2017 Vlad Sys. All rights reserved.
//

import Foundation
import CoreData
import ObjectiveC.runtime

extension UICollectionViewCell {
    
    struct Assoc {
        static var cc = ""
        static var ip = ""
    }
    
    var indexPath: IndexPath? {
        get {
            return objc_getAssociatedObject(self, &Assoc.ip) as? IndexPath
        }
        
        set {
            objc_setAssociatedObject(self, &Assoc.ip, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var longGestureRecognizer: UILongPressGestureRecognizer? {
        
        get {
            return objc_getAssociatedObject(self, &Assoc.cc) as? UILongPressGestureRecognizer
        }
        
        set {
            objc_setAssociatedObject(self, &Assoc.cc, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }
    
}

struct Array {
    let img: UIImage!
    let date: String!
}

class photos : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate {
 
    
    var imageArray = [Image]()
  

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navBtn: UIBarButtonItem!
    @IBOutlet weak var addNewPhoto: UIButton!

    
    var longGesture = UILongPressGestureRecognizer()

    
    override func viewDidLoad() {
        
        
  
        
        let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()
        do{
        let imageArray = try PersistanceService.context.fetch(fetchRequest)
            self.imageArray = imageArray
            self.collectionView.reloadData()
        } catch{
            
        }
        //btn
        navBtn.target = self.revealViewController();
        navBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        addNewPhoto.layer.cornerRadius = 22.5
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    

    
    
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        
        let cell = sender.view as! UICollectionViewCell
        let indexPath = cell.indexPath!
        let image = imageArray[indexPath.row]
        
        
        let alertC = UIAlertController(title: "Delete it?", message: "Want to delete this photo?", preferredStyle: UIAlertControllerStyle.alert)
        let no = UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel) { (alert) in
            
     
        }
        let ok = UIAlertAction(title: "YES", style: UIAlertActionStyle.default) { (alert) in
            
            image.managedObjectContext?.performAndWait({
                image.managedObjectContext?.delete(image)
                try! image.managedObjectContext?.save()
                
            })
            
            self.imageArray = self.imageArray.filter({ $0 !== image })
            self.collectionView!.reloadData()
            
        }
        alertC.addAction(no)
        alertC.addAction(ok)
        
        self.present(alertC, animated: true, completion: nil)
    }

   @IBAction func addBtnTapped(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose Source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("camera not availible")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet,animated: true,completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData = UIImageJPEGRepresentation(image, 1)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
       // self.imageArray.append(Array(img:image, date: result))
        let imagePick = Image(context: PersistanceService.context)
        imagePick.image = imageData as NSData?
        imagePick.date = result
        PersistanceService.saveContext()
        self.imageArray.append(imagePick)
        self.collectionView.reloadData()
       // collectionView.performBatchUpdates({
         //   collectionView.insertItems(at: [NSIndexPath(item: imageArray.count - 1, section: 0) as IndexPath])
        //}, completion: nil)
        picker.dismiss(animated: true, completion: nil)
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let imgArr = imageArray[indexPath.row]
        cell.imgImage.image = UIImage(data: imgArr.image! as Data)
        cell.labelImageName.text = imgArr.date
        
        if cell.longGestureRecognizer == nil {
            let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(photos.longPress(_:)))
            longGesture.minimumPressDuration = 1
            cell.longGestureRecognizer = longGesture
            cell.addGestureRecognizer(longGesture)
        }

        cell.indexPath = indexPath
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let desVC = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let imgArr = imageArray[indexPath.row]
        desVC.image = UIImage(data: imgArr.image! as Data)!
        desVC.name = imgArr.date!
        self.navigationController?.pushViewController(desVC, animated: true)
        
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: 124, height: 124)
    }
   
    
  
    
}
