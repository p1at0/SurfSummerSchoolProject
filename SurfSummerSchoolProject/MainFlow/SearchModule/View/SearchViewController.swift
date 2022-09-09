//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 07/08/22.
//

import UIKit

final class SearchViewController: UIViewController, ModuleTransitionable {
    
    //MARK: - Properties
    
    var presenter: SearchViewOutput?
    
    //MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.layer.cornerRadius = 18
        searchBar.searchTextField.clipsToBounds = true
        searchBar.searchTextField.placeholder = "Поиск"
        searchBar.sizeToFit()
        return searchBar
    }()
    
    private lazy var helperView: HelperView = {
        let helperView = HelperView()
        helperView.configureStatus(.writeRequest)
        return helperView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
}

//MARK: - Private method

private extension SearchViewController {
    func configureAppearance() {
        configureNavitionBar()
        configureCollectionView()
        configureSearchBar()
        configureHelperView()
    }
    
    func configureNavitionBar() {
        navigationItem.titleView = searchBar
        navigationController?.configureBackBarItem(image: Icon.backArrow)
    }
    
    func configureCollectionView() {
        collectionView.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(MainItemCell.self)
        collectionView.contentInset = .init(top: Constants.verticalInset,
                                            left: Constants.horizontalInset,
                                            bottom: Constants.verticalInset,
                                            right: Constants.horizontalInset)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing(recognizer:)))
        collectionView.addGestureRecognizer(tapGesture)
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
    }
    
    func configureHelperView() {
        view.addSubview(helperView)
        NSLayoutConstraint.activate([helperView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     helperView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     helperView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                     helperView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250)])
    }
    
    func configureHelperView(_ status: HelperStatus) {
        helperView.configureStatus(status)
    }
    
    @objc func endEditing(recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: collectionView)
        let indexPath = collectionView.indexPathForItem(at: tapLocation)
        guard let indexPath = indexPath else {
            searchBar.endEditing(true)
            return
        }
        presenter?.showDetailViewController(for: indexPath)

    }
    
}

//MARK: - SearchViewInput

extension SearchViewController: SearchViewInput {
    func reload() {
        collectionView.reloadData()
    }
    
    func showHelper(_ status: HelperStatus) {
        configureHelperView(status)
        helperView.isHidden = false
        collectionView.isHidden = true
    }
    
    func showCollection() {
        helperView.isHidden = true
        collectionView.isHidden = false
    }
}

//MARK: - UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.filteredItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCell.self)", for: indexPath) as? MainItemCell else {
            return UICollectionViewCell()
        }
        cell.configure(item: presenter?.getItem(for: indexPath)) { [weak self] isFavorite in
            guard let self = self else {
                return
            }
            self.presenter?.filteredItems[indexPath.item].isFavorite = isFavorite
            self.presenter?.changeFavoriteStatus(for: indexPath, isFavorite: isFavorite)
        }
        return cell
    }
}

//MARK: - UICollectionViewDelagateFlowLayout

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = Constants.itemsPerRow * Constants.horizontalInset + Constants.minimumInteritemSpacing
        let widthPerItem = (collectionView.bounds.width - paddingWidth) / Constants.itemsPerRow
        return .init(width: widthPerItem, height: widthPerItem * Constants.heightToWidthRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minimumLineSpacing
    }
}

//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let presenter = presenter else {
             return
        }
        if searchText.isEmpty {
            presenter.showHelperView(.writeRequest)
        } else {
            presenter.searchPictures(searchText)
            if presenter.resultIsEmpty() {
                presenter.showHelperView(.noResult)
            } else {
                presenter.showCollectionView()
            }
            
        }
    }
}

//MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.endEditing(true)
        return true
    }
}

//MARK: - Private enum

private extension SearchViewController {
    private enum Constants {
        static let itemsPerRow: CGFloat = 2
        static let horizontalInset: CGFloat = 16
        static let verticalInset: CGFloat = 8
        static let minimumLineSpacing: CGFloat = 16
        static let minimumInteritemSpacing: CGFloat = 7
        static let heightToWidthRatio: CGFloat = 1.4642
    }
}
