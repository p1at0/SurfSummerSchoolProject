//
//  DetailTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 08/08/22.
//

import UIKit

final class DetailImageCell: UITableViewCell {

    //MARK: - Views
    
    @IBOutlet weak var itemImageView: UIImageView!

    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    //MARK: - Internal methods
    
    func configure(imageStringURL: String) {
        itemImageView.loadImage(from: imageStringURL)
    }
}

//MARK: - Private Methods

private extension DetailImageCell {
    func configureAppearance() {
        configureImageView()
        selectionStyle = .none
    }
    
    
    func configureImageView() {
        itemImageView.layer.cornerRadius = 12
        itemImageView.contentMode = .scaleAspectFill
    }
}
