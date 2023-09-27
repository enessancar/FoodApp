//
//  FCImageView.swift
//  FoodApp
//
//  Created by Enes Sancar on 27.09.2023.
//

import UIKit

final class FCImageView: UIImageView {
    
    private var dataTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        contentMode = .scaleToFill
        tintColor = .label
    }
    
    func download(urlString: String, renderingMode: UIImage.RenderingMode) {
        guard let url = URL(string: urlString) else { return }
        image = nil
        
        if let cachedImage = CacheManager.shared.cache.object(forKey: urlString as NSString) {
            self.image = cachedImage.withRenderingMode(.alwaysTemplate)
        }
        
        self.dataTask = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, _, error in
            guard
                let self,
                let data,
                error == nil,
                let image = UIImage(data: data) else {
                return
            }
            
            CacheManager.shared.cache.setObject(image, forKey: urlString as NSString)
            DispatchQueue.main.async {
                self.image = image.withRenderingMode(renderingMode)
            }
        })
        dataTask?.resume()
    }
    
    func cancelDownloading() {
        dataTask?.cancel()
        dataTask = nil
    }
}
