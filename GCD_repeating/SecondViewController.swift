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
        delay(3) {
            self.loginAlert()
        }
    }
    
    fileprivate func delay(_ delay: Int,closure: @escaping () -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "Registred ?", message: "Enter you login and password", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { usernameTxtFld in
            usernameTxtFld.placeholder = "Enter login"
        }
        ac.addTextField { userPassTxtFld in
            userPassTxtFld.placeholder = "Enter password"
            userPassTxtFld.isSecureTextEntry = true
        }
        
        self.present(ac, animated: true, completion: nil)
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

