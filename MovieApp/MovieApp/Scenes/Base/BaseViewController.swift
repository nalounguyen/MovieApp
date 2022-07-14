//
//  BaseViewController.swift
//  MovieApp
//
//  Created by Nalou Nguyen on 14/07/2022.
//

import Foundation
import UIKit
import RxSwift

class BaseViewController: UIViewController {
    lazy var tn = "\(type(of: self))".replacingOccurrences(of: "ViewController", with: "")
    var disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        bindingViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        print("\n✏️ ✏️ ✏️ \(type(of: self)) is displayed ")
    }
    
    func setupView() {
        view.layoutIfNeeded()
    }
    
    func bindingViewModel() { }
    
    deinit {
        print("\(type(of: self)) is deinit")
    }
}
