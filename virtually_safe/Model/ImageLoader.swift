//
//  ImageLoader.swift
//  MovieListApp
//
//  Created by David Phan on 4/6/21.
//

import SwiftUI
import UIKit

private let _imgCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {
    @Published var img: UIImage?
    @Published var loading = false
    
    var imgCache = _imgCache
    
    func load(with url: URL) {
        let urlStr = url.absoluteString
        if let imgFromCache = imgCache.object(forKey: urlStr as AnyObject) as? UIImage {
            self.img = imgFromCache
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
        guard let self = self else {return}
        do {
            let data = try Data(contentsOf: url)
            guard let img = UIImage(data: data) else {
                return
            }
        self.imgCache.setObject(img, forKey: urlStr as AnyObject)
            DispatchQueue.main.async{ [weak self] in
                self?.img = img
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
