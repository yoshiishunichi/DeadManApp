//
//  ResultViewController.swift
//  DeadManApp
//
//  Created by 吉井駿一 on 2021/02/28.
//

import UIKit

class ResultViewController: UIViewController{
    
    @IBOutlet weak var resultImageView: UIImageView!
    var resultImage = UIImage(named: "defaultImage")
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "完成"
        
        resultImageView.layer.borderColor = UIColor.gray.cgColor
        resultImageView.layer.borderWidth = 1
        
        resultImageView.image = resultImage
        
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderColor = UIColor.gray.cgColor
        saveButton.layer.borderWidth = 1
        
        shareButton.layer.cornerRadius = 10
        shareButton.layer.borderColor = UIColor.gray.cgColor
        shareButton.layer.borderWidth = 1

    }
}
