//
//  ImageLoader.swift
//  CafeGo
//
//  Created by Kimminchan on 2016. 10. 31..
//  Copyright © 2016년 SMS. All rights reserved.
//

import Foundation

class ImageLoader {
    
    func settingImg(string:String, imgView:UIImageView) {
        let escapedAddress = string.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
<<<<<<< HEAD
        if let checkedUrl = URL(string: "http://192.168.41.8:3000/images/" + escapedAddress!) {
=======
        if let checkedUrl = URL(string: "http://192.168.44.179:3000/images/" + escapedAddress!) {
>>>>>>> 80119f7132054c7482e1157b24da5ba2e5ab7577
            imgView.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, imgView: imgView)
        }

    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, imgView:UIImageView) {
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { () -> Void in
                imgView.image = UIImage(data: data)
            }
        }
    }
}

var ImageDownLoader = ImageLoader()
