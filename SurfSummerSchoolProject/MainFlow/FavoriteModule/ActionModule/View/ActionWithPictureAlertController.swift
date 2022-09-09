//
//  ActionWithPictureAlertController.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 15/08/22.
//

import Foundation
import UIKit


final class ActionWithPictureAlertController: UIAlertController {
    
    //MARK: - Properties
    
    private var output: ActionWithPictureModuleOutput!
    private var item: ItemModel!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    //MARK: - Internal methods
    
    func configure(output: ActionWithPictureModuleOutput, item: ItemModel) {
        self.output = output
        self.item = item
    }
}

//MARK: - Private methods

private extension ActionWithPictureAlertController {
    
    func configureAppearance() {
        let cancelAction = UIAlertAction(title: "Нет", style: .default)
        let removeAction = UIAlertAction(title: "Да, точно", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }
            self.output.remove(item: self.item)
        }
        addAction(cancelAction)
        addAction(removeAction)
        preferredAction = removeAction
    }
}
