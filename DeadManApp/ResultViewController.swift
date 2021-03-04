//
//  ResultViewController.swift
//  DeadManApp
//
//  Created by 吉井駿一 on 2021/02/28.
//
import UIKit
import GoogleMobileAds

class ResultViewController: UIViewController, GADFullScreenContentDelegate {
    
    let interstitialADTestUnitID = "ca-app-pub-1923099754481403/7586078841"
    var interstitialAd: GADInterstitialAd!
    
    @IBOutlet weak var imageHoldView: UIView!
    @IBOutlet weak var resultImageView: UIImageView!
    var resultImage = UIImage(named: "defaultImage")
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let interstitialAdUnitID  = interstitialADTestUnitID
        GADInterstitialAd.load(withAdUnitID: interstitialAdUnitID, request: GADRequest()) { ad, error in
            
            if error != nil { return }
            self.interstitialAd = ad
            self.interstitialAd.fullScreenContentDelegate = self
            
        }
        
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
    
    // UIViewをUIImageに変換
    func viewToImage(_ view: UIView) -> UIImage{
        
        let rect = view.bounds
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        view.layer.render(in: context)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // pngに変換
        let pngData = image.pngData()!
        let pngImage = UIImage.init(data: pngData)!
        return pngImage
    }
    
    // viewをimageに変換してカメラロールに保存
    func saveImage(_ view: UIView){
        
        let image: UIImage = viewToImage(view)
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(didFinishSavingImage(_:didFinishSavingWithError:contextInfo:)), nil)
        
    }
    
    // 画像の保存結果を取得
    @objc func didFinishSavingImage(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer){
        
        var title = "保存完了"
        var message = "カメラロールに保存しました！"
        
        
        if error != nil{
            title = "エラー"
            message = "カメラロールに保存できませんでした"
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if error != nil{
            alertController.addAction(UIAlertAction(title:"OK", style:.default, handler:nil))
        }
        else{
            alertController.addAction(UIAlertAction(title:"OK", style:.default,
                                                    handler: {(UIAlertAction) in self.showAd()}))
        }

        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func showAd(){
        do {
            
            try self.interstitialAd?.canPresent(fromRootViewController: self)
            self.interstitialAd?.present(fromRootViewController: self)

        } catch {

            print("表示しない")

        }
    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
        
        saveImage(imageHoldView)
        
    }
    
    // UIImageを文面と共にシェア
    func share(_ view: UIView){
        
        let image: UIImage = viewToImage(view)
        let controller = UIActivityViewController(activityItems: [image, "”遺影メーカー”で遺影を作りました。\n#遺影メーカー"], applicationActivities: nil)
        controller.popoverPresentationController?.sourceView = self.view
        controller.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
        
        // 除外するActivityType
        let excludedActivityTypes: Array<UIActivity.ActivityType> = [
            UIActivity.ActivityType.addToReadingList,
            // UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.copyToPasteboard,
            UIActivity.ActivityType.mail,
            UIActivity.ActivityType.message,
            UIActivity.ActivityType.openInIBooks,
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToTencentWeibo,
            // UIActivity.ActivityType.postToTwitter,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.markupAsPDF
        ]
        
        controller.excludedActivityTypes = excludedActivityTypes
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func tapShareButton(_ sender: Any) {
        
        share(imageHoldView)
        
    }
    
}
