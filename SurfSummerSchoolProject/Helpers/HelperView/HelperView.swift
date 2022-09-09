//
//  HelperView.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 17/08/22.
//

import Foundation
import UIKit


final class HelperView: UIView {
    
    //MARK: - Views
    
    private lazy var emojiImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .gray
        return iv
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 2
        return label
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Internal methods
    
    func configureStatus(_ status: HelperStatus) {
        descriptionLabel.text = status.title
        emojiImageView.image = status.icon
    }
    
}

//MARK: - Private methods

private extension HelperView {
    func configure() {
        addSubview(emojiImageView)
        addSubview(descriptionLabel)
        configureEmojiImageView()
        configureDescriptionLabel()
        
    }
    
    func configureEmojiImageView() {
        NSLayoutConstraint.activate([emojiImageView.widthAnchor.constraint(equalToConstant: 32),
                                     emojiImageView.heightAnchor.constraint(equalToConstant: 32),
                                     emojiImageView.topAnchor.constraint(equalTo: topAnchor),
                                     emojiImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     emojiImageView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -14)])
    }
    
    func configureDescriptionLabel() {
        NSLayoutConstraint.activate([descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
