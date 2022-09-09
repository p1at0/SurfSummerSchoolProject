//
//  SpinnerView.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 19/08/22.
//

import Foundation
import UIKit


final class SpinnerView: UIView {
    
    //MARK: - Views
    
    private let spinnerImageView: UIImageView = {
        let iv = UIImageView(image: Icon.loader)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configureAppearance()        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Internal methods
    
    func startLoading() {
        rotate360()
        isHidden = false
    }
    
    func hideLoading() {
        isHidden = true
        layer.removeAllAnimations()
    }
}

//MARK: - Private methods

private extension SpinnerView {
    
    func configureAppearance() {
        addSubview(spinnerImageView)
        NSLayoutConstraint.activate([spinnerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     spinnerImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     spinnerImageView.heightAnchor.constraint(equalToConstant: 24),
                                     spinnerImageView.widthAnchor.constraint(equalToConstant: 24)])
    }
    
    func rotate360(duration: CFTimeInterval = 1) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        layer.add(rotateAnimation, forKey: nil)
    }
}
