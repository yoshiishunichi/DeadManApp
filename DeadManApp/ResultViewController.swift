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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "完成"
        
        resultImageView.layer.borderColor = UIColor.gray.cgColor
        resultImageView.layer.borderWidth = 1
        
        resultImageView.image = resultImage

    }
}
