//
//  WarningView.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 20/08/22.
//

import Foundation
import UIKit


final class WarningView: UIView {
    
    //MARK: - Views
    
    private let errorDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Логин или пароль введены неверно"
        return label
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
    
    func configure(errorDescription: String?) {
        errorDescriptionLabel.text = errorDescription
    }
}

//MARK: - Private methods

private extension WarningView {
    func configureAppearance() {
        configureView()
        configureErrorDescriptionLabel()
    }
    
    func configureView() {
        backgroundColor = Color.warningViewRed
    }
    
    func configureErrorDescriptionLabel() {
        addSubview(errorDescriptionLabel)
        NSLayoutConstraint.activate([errorDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     errorDescriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 57)])
    }
}
