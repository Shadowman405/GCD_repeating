//
//  SecondViewController.swift
//  GCD_repeating
//
//  Created by Maxim Mitin on 16.01.22.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://kazved.ru/images/uploads/7fe88cb8b79911d85af34a40b8760fe1.jpg")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL,let imageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}

