//
//  ActionLogoutAcceptAlertController.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 19/08/22.
//

import Foundation
import UIKit


final class ActionLogoutAcceptAlertController: UIAlertController {
    
    //MARK: - Properties
    
    private var output: ActionLogoutAcceptModuleOutput!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    //MARK: - Internal methods
    
    func configure(output: ActionLogoutAcceptModuleOutput) {
        self.output = output
    }
}

//MARK: - Private methods

private extension ActionLogoutAcceptAlertController {
    
    func configureAppearance() {
        let cancelAction = UIAlertAction(title: "Нет", style: .default)
        let removeAction = UIAlertAction(title: "Да, точно", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }
            self.output.logout()
        }
        addAction(cancelAction)
        addAction(removeAction)
        preferredAction = removeAction
    }
}
