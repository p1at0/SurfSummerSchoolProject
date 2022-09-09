//
//  FavoriteCell.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 09/08/22.
//

import UIKit

final class FavoriteCell: UICollectionViewCell {
    
    //TODO: - Rafactor code
    
    private enum Constants {
        static let heartImage = UIImage(named: "favorite")
        static let filledHeartImage = UIImage(named: "favorite-fill")
    }
    
    //MARK: - Views
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    //MARK: - Events
    
    var completionHandler: (() -> Void)?
    
    //MARK: - Properties
    
    var isFavorite: Bool = true {
        didSet {
            let image = isFavorite ? Constants.filledHeartImage : Constants.heartImage
            favoriteButton.setImage(image, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = ""
        dateLabel.text = ""
        descriptionLabel.text = ""
    }
    
    //MARK: - Internal methods
    
    func configure(item: ItemModel?, completionHandler: @escaping () -> Void) {
        guard let item = item else {
            return
        }
        imageView.loadImage(from: item.imageUrlString)
        titleLabel.text = item.title
        dateLabel.text = item.dateCreation
        descriptionLabel.text = item.description
        isFavorite = true
        self.completionHandler = completionHandler

    }

    //MARK: - Actions
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        completionHandler?()
    }
}

//MARK: - Private methods

private extension FavoriteCell {
    func configureAppearance() {
        configureImageView()
        configureTitleLabel()
        configureDateLabel()
        configureImageView()
        configureDescriptionLabel()
    }
    
    func configureImageView() {
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
    }
    
    func configureTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    func configureDateLabel() {
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = Color.date
    }
    
    func configureDescriptionLabel() {
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .light)
        descriptionLabel.numberOfLines = 1
    }
}
