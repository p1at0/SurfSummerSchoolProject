//
//  ProfileViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 03/08/22.
//

import UIKit

final class ProfileViewController: UIViewController, ModuleTransitionable {
    
    //MARK: - Properties
    
    var presenter: ProfileViewOutput?
    
    //MARK: - Views
    
    @IBOutlet weak private var tableView: UITableView!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    private lazy var spinnerView: SpinnerView = {
        let spinnerView = SpinnerView()
        spinnerView.isHidden = true
        return spinnerView
    }()
    
    private lazy var warningView: WarningView = {
        let view = WarningView()
        view.alpha = 0
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    //MARK: - Actions
    
    @IBAction func tappedLogoutButton(_ sender: Any) {
        presenter?.showAlertController()
    }
}

//MARK: - Private methods

private extension ProfileViewController {
    func configureAppearance() {
        configureTableView()
        configureLogoutButton()
        configureSpinnerView()
        configureWarningViewConstraint()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        tableView.registerCell(HeaderTableViewCell.self)
        tableView.separatorInset = .zero
    }
    
    func configureLogoutButton() {
        logoutButton.backgroundColor = .black
        logoutButton.tintColor = .white
        logoutButton.configuration = .none
        logoutButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        logoutButton.setTitle("Выйти", for: .normal)
    }
    
    func configureSpinnerView() {
        logoutButton.addSubview(spinnerView)
        NSLayoutConstraint.activate([spinnerView.centerXAnchor.constraint(equalTo: logoutButton.centerXAnchor),
                                     spinnerView.centerYAnchor.constraint(equalTo: logoutButton.centerYAnchor),
                                     spinnerView.heightAnchor.constraint(equalToConstant: 24),
                                     spinnerView.widthAnchor.constraint(equalToConstant: 24)])
    }
    
    func configureWarningViewConstraint() {
        view.addSubview(warningView)
        NSLayoutConstraint.activate([warningView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     warningView.topAnchor.constraint(equalTo: view.topAnchor),
                                     warningView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     warningView.heightAnchor.constraint(equalToConstant: 93)])
    }
    
    func statusBarEnterDarkBackground() {
        self.navigationController?.navigationBar.barStyle = .black
    }
}

//MARK: - ProfileViewInput

extension ProfileViewController: ProfileViewInput {

    var isWarningViewHidden: Bool {
        return warningView.alpha == 0 ? true : false
    }
    
    func startLoading() {
        spinnerView.startLoading()
        logoutButton.titleLabel?.isHidden = true
    }
    
    func stopLoading() {
        spinnerView.hideLoading()
        logoutButton.titleLabel?.isHidden = false
    }
    
    func showWarningView(errorDescription: String) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.warningView.alpha = 1
        }
        warningView.configure(errorDescription: errorDescription)
        navigationItem.titleView = UIView()
    }
    
    func hideWarningView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.warningView.alpha = 0
        }
        navigationItem.titleView = nil
    }
    
    func showLoginFlow() {
        (UIApplication.shared.delegate as? AppDelegate)?.runLoginFlow()
    }
}

//MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userInfo = presenter?.getProfile()?.userInfo else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(HeaderTableViewCell.self)", for: indexPath) as? HeaderTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(imageURL: userInfo.avatar, name: "\(userInfo.firstName)\n\(userInfo.lastName)", status: userInfo.about)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
            cell.configure(title: "Город", data: userInfo.city)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
            cell.configure(title: "Телефон", data: PhoneMask().format(with: "+X (XXX) XXX XX XX", phone: userInfo.phone))
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
            cell.configure(title: "Почта", data: userInfo.email)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
