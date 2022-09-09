//
//  DetailViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 07/08/22.
//

import UIKit

final class DetailViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: DetailViewOutput?

    //MARK: - Views
    
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
}

//MARK: - DetailViewInput

extension DetailViewController: DetailViewInput {
    
}

//MARK: - Private methods

private extension DetailViewController {
    func configureAppearance() {
        navigationController?.configureBackBarItem(image: Icon.backArrow)
        title = presenter?.item.title
        configureTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerCell(DetailImageCell.self)
        tableView.registerCell(DetailTitleCell.self)
        tableView.registerCell(DetailDescriptionCell.self)
    }
}

//MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = presenter?.item
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailImageCell.self)", for: indexPath) as? DetailImageCell else {
                return UITableViewCell()
            }
            cell.configure(imageStringURL: item?.imageUrlString ?? "")
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailTitleCell.self)", for: indexPath) as? DetailTitleCell else {
                return UITableViewCell()
            }
            cell.configure(itemTitle: item?.title, itemDate: item?.dateCreation)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailDescriptionCell.self)", for: indexPath) as? DetailDescriptionCell else {
                return UITableViewCell()
            }
            cell.configure(description: item?.description)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
