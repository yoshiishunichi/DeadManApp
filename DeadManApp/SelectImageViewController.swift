//
//  SelectImageViewController.swift
//  DeadManApp
//
//  Created by 吉井駿一 on 2021/02/25.
//

import Foundation
import UIKit
import CoreImage

class SelectImageViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var sampleImageView: UIImageView!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var decideButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleImageView.layer.borderWidth = 1
        sampleImageView.layer.borderColor = UIColor.gray.cgColor
        let defaultImage = UIImage(named: "defaultImage")
        sampleImageView.image = defaultImage
        
        selectButton.layer.cornerRadius = 10
        selectButton.layer.borderWidth = 2
        selectButton.layer.borderColor = UIColor.gray.cgColor
        
        decideButton.layer.cornerRadius = 10
        decideButton.layer.borderWidth = 2
        decideButton.layer.borderColor = UIColor.gray.cgColor
        
    }
    
    @IBAction func tapSelectButton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate  = self
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func tapDecideButton(_ sender: Any) {
        
        let resultStoryboard = UIStoryboard(name: "Result", bundle: nil)
        let resultViewController = resultStoryboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        
        navigationController?.pushViewController(resultViewController, animated: true)
        let sampleImage = sampleImageView.image ?? UIImage(named: "defaultImage")
        let monoImage = toMonokuro(colorImage: sampleImage!)
        
        resultViewController.resultImage = monoImage
        
    }
    
    func toMonokuro(colorImage: UIImage) -> UIImage{
        
        let ciImage = CIImage(image: colorImage)
        let filter = CIFilter(name: "CIPhotoEffectMono")!
        filter.setDefaults()
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        return UIImage(ciImage: filter.outputImage!)
        
    }
    
    
    //    imagePickerの処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editImage = info[.editedImage] as? UIImage{
            sampleImageView.image = editImage.withRenderingMode(.alwaysOriginal)
        }else if let originalImage = info[.originalImage] as? UIImage{
            sampleImageView.image = originalImage.withRenderingMode(.alwaysOriginal)
        }
        
        sampleImageView.contentMode = .scaleAspectFit
        sampleImageView.clipsToBounds = true
        
        dismiss(animated: true, completion: nil)
        
    }
}
