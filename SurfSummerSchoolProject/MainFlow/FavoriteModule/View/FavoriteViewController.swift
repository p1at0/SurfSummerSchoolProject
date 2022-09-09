//
//  FavoriteViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 09/08/22.
//

import UIKit

final class FavoriteViewController: UIViewController, ModuleTransitionable {
    
    //MARK: - Properties
    
    var presenter: FavoriteViewOutput?
    
    //MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var searchButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: Icon.search,
                                     style: .done,
                                     target: self,
                                     action: #selector(tappedSearchButton))
        button.tintColor = .black
        return button
    }()
    
    private lazy var helperView: HelperView = {
        let helperView = HelperView()
        helperView.configureStatus(.noFavorites)
        return helperView
    }()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchFavoritePictures()
    }

    //MARK: - Actions
    
    @objc private func tappedSearchButton() {
        presenter?.showSearchViewController()
    }
}

//MARK: - Private methods

private extension FavoriteViewController {
    func configureAppearance() {
        navigationItem.setRightBarButton(searchButton, animated: true)
        configureCollectionView()
        configureHelperView()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.contentInset = .init(top: Constants.verticalInset,
                                            left: Constants.horizontalInset,
                                            bottom: Constants.verticalInset,
                                            right: Constants.horizontalInset)
        collectionView.dataSource = self
        collectionView.registerCell(FavoriteCell.self)
    }
    
    func configureHelperView() {
        view.addSubview(helperView)
        NSLayoutConstraint.activate([helperView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     helperView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     helperView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                     helperView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250)])
    }
}

//MARK: - FavoriteViewInput

extension FavoriteViewController: FavoriteViewInput {
    func reload() {
        collectionView.reloadData()
    }
    
    func showHelperView() {
        helperView.isHidden = false
    }
    
    func hideHelperView() {
        helperView.isHidden = true
    }
}

//MARK: - UICollectionViewDataSource

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.favoriteItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FavoriteCell.self)", for: indexPath) as? FavoriteCell else {
            return UICollectionViewCell()
        }
        cell.configure(item: presenter?.favoriteItems[indexPath.item]) { [weak self] in
            guard let self = self else {
                return
            }
            self.presenter?.showAlertController(for: indexPath)
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = view.bounds.width - (2 * Constants.horizontalInset)
        return .init(width: availableWidth, height: availableWidth * Constants.hightToWidthRatio)
    }
}

//MARK: - Private enum

private extension FavoriteViewController {
    private enum Constants {
        static let horizontalInset: CGFloat = 16
        static let verticalInset: CGFloat = 8
        static let hightToWidthRatio: CGFloat = 1.1603
    }
}

