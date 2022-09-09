//
//  DetailTitleCell.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 08/08/22.
//

import UIKit

final class DetailTitleCell: UITableViewCell {

    //MARK: - Views
    
    @IBOutlet weak private var itemTitleLabel: UILabel!
    @IBOutlet weak private var itemDateLabel: UILabel!
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    //MARK: - Internal methods
    
    func configure(itemTitle: String?, itemDate: String?) {
        itemTitleLabel.text = itemTitle
        itemDateLabel.text = itemDate
    }
}

//MARK: - Private Methods

private extension DetailTitleCell {
    func configureAppearance() {
        configureTitleLabel()
        configureDateLabel()
        selectionStyle = .none
    }
    
    func configureTitleLabel() {
        itemTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    func configureDateLabel() {
        itemDateLabel.font = .systemFont(ofSize: 10, weight: .medium)
        itemDateLabel.textColor = Color.date
    }
}
