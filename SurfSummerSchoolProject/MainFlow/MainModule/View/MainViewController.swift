//
//  MainViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 03/08/22.
//

import UIKit

final class MainViewController: UIViewController, ModuleTransitionable {
    
    //MARK: - Properties
    
    var presenter: MainViewOutput?
    
    //MARK: - Constants
    
    private enum Constants {
        static let itemsPerRow: CGFloat = 2
        static let horizontalInset: CGFloat = 16
        static let verticalInset: CGFloat = 8
        static let minimumLineSpacing: CGFloat = 16
        static let minimumInteritemSpacing: CGFloat = 7
        static let heightToWidthRatio: CGFloat = 1.4642
    }
    
    //MARK: - Views
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    
    private lazy var searchButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: Icon.search,
                                     style: .done,
                                     target: self,
                                     action: #selector(showSearchViewController))
        button.tintColor = .black
        return button
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var warningView: WarningView = {
        let view = WarningView()
        view.alpha = 0
        return view
    }()
    
    private lazy var helperView: HelperView = {
        let view = HelperView()
        view.configureStatus(.failedLoadPosts)
        view.isHidden = true
        return view
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.tintColor = .white
        button.configuration = .none
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.setTitle("Обновить", for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.alpha = 0
        presenter?.loadPosts()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.collectionView.alpha = 1
        }
    }
}

//MARK: - MainViewInput

extension MainViewController: MainViewInput {
    func reload() {
        collectionView.reloadData()
    }
    
    func showWarning(error: String) {
        showWarningView(errorDescription: error)
    }
    
    func showHelperView() {
        helperView.isHidden = false
        updateButton.isHidden = false
    }
    
    func hideHelperView() {
        helperView.isHidden = true
        updateButton.isHidden = true
    }
    
    func startLoadAnimating() {
        spinnerView.startAnimating()
    }
    
    func stopLoadAnimating() {
        spinnerView.stopAnimating()
    }
}

//MARK: - Private methods

private extension MainViewController {
    func configureAppearance() {
        configureWarningViewConstraint()
        configureHelperView()
        configureUpdateButtonConstraint()
        configureCollectionView()
        navigationItem.setRightBarButton(searchButton, animated: true)
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCell(MainItemCell.self)
        collectionView.contentInset = .init(top: Constants.verticalInset,
                                            left: Constants.horizontalInset,
                                            bottom: Constants.verticalInset,
                                            right: Constants.horizontalInset)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.refreshControl = refreshControl
    }
    
    func configureWarningViewConstraint() {
        view.addSubview(warningView)
        NSLayoutConstraint.activate([warningView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     warningView.topAnchor.constraint(equalTo: view.topAnchor),
                                     warningView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     warningView.heightAnchor.constraint(equalToConstant: 93)])
    }
    
    func configureHelperView() {
        view.addSubview(helperView)
        NSLayoutConstraint.activate([helperView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     helperView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     helperView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                     helperView.topAnchor.constraint(equalTo: view.topAnchor, constant: 311)])
    }
    
    func configureUpdateButtonConstraint() {
        view.addSubview(updateButton)
        NSLayoutConstraint.activate([updateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     updateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                     updateButton.topAnchor.constraint(equalTo: helperView.bottomAnchor, constant: 8),
                                     updateButton.heightAnchor.constraint(equalToConstant: 48)])
        
    }
    
    @objc func showSearchViewController() {
        presenter?.showSearchViewController()
    }
    
    @objc func pullToRefresh() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        DispatchQueue.main.async {
            self.collectionView.alpha = 0
            self.refreshPosts()
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            self.collectionView.alpha = 1
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc func refresh() {
        refreshPosts()
    }
    
    func refreshPosts() {
        presenter?.refreshPosts { [weak self] in
            guard let self = self else {
                return
            }
            if self.warningView.alpha == 1 {
                self.hideWarningView()
            }
            self.collectionView.reloadData()
        }
    }
    
    func showWarningView(errorDescription: String? = nil) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) { [weak self] in
            self?.warningView.alpha = 1
        }
        warningView.configure(errorDescription: errorDescription)
        navigationItem.titleView = UIView()
    }
    
    func hideWarningView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) { [weak self] in
            self?.warningView.alpha = 0
        }
        navigationItem.titleView = nil
    }
}

//MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.itemStorage.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCell.self)", for: indexPath) as? MainItemCell else {
            return UICollectionViewCell()
        }

        cell.configure(item: presenter?.getItem(for: indexPath)) { [weak self] isFavorite in
            guard let self = self else {
                return
            }
            self.presenter?.itemStorage.items[indexPath.item].isFavorite = isFavorite
            self.presenter?.changeFavoriteStatus(for: indexPath, isFavorite: isFavorite)
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showDetailViewController(for: indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
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
