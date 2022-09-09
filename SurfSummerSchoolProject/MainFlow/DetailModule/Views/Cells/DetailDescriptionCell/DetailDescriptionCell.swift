//
//  DetailDescriptionCell.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 08/08/22.
//

import UIKit

final class DetailDescriptionCell: UITableViewCell {

    //MARK: - Views
    
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    //MARK: - Internal methods
    
    func configure(description: String?) {
        descriptionLabel.text = description
    }
}

//MARK: - Private methods

private extension DetailDescriptionCell {
    func configureAppearance() {
        configureDescriptionLabel()
        selectionStyle = .none
    }
    
    func configureDescriptionLabel() {
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .light)
        descriptionLabel.numberOfLines = 0
    }
}
