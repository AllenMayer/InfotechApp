//
//  CustomImageView.swift
//  InfotechApp
//
//  Created by Максим Семений on 18.08.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var task: URLSessionDataTask!
    let spinner = UIActivityIndicatorView(style: .medium)
    
    func loadImage(from string: String) {
        image = nil
        addSpinner()
        
        if let task = task {
            task.cancel()
        }
        
        guard let url = URL(string: string) else { return }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            spinner.removeFromSuperview()
            self.image = imageFromCache
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else { return }
            
            imageCache.setObject(image, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = image
                self.spinner.removeFromSuperview()
            }
        }
        task.resume()
    }
    
    func addSpinner() {
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        spinner.startAnimating()
    }
}
