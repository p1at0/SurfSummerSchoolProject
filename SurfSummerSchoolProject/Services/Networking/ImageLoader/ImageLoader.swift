//
//  ImageLoader.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 09/08/22.
//

import Foundation
import UIKit


struct ImageLoader {
    
    private let session = URLSession(configuration: .default)
    
    func loadImage(from url: URL, _ onLoadWasCompleted: @escaping (_ result: Result<UIImage, Error>) -> Void) {
        
        session.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    onLoadWasCompleted(.success(image))
                }
            }
        }.resume()
    }
}
