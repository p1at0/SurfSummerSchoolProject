//
//  HeaderTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 17/08/22.
//

import UIKit

final class HeaderTableViewCell: UITableViewCell {

    //MARK: - Views
    
    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var statusLabel: UILabel!
    
    //MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    //MARK: - Internal methods
    
    func configure(imageURL: String, name: String, status: String) {
        profileImageView.loadImage(from: imageURL)
        nameLabel.text = name
        statusLabel.text = status
    }
    
}

//MARK: - Private methods

private extension HeaderTableViewCell {
    func configureAppearance() {
        separatorInset = .init(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        selectionStyle = .none
        configureProfileImageView()
        configureNameLabel()
        configureStatusLabel()
    }
    
    func configureProfileImageView() {
        profileImageView.layer.cornerRadius = 12
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
    }
    
    func configureNameLabel() {
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
    }
    
    func configureStatusLabel() {
        statusLabel.font = .systemFont(ofSize: 12)
        statusLabel.textColor = .gray
    }
}
