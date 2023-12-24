//
//  BaseViewController.swift
//  TMDB-RxSwift
//
//  Created by albooren on 24.12.2023.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    var mainView = UIView()
    private var alertLoader = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func makeLoader(){
        alertLoader = UIAlertController(title: nil,
                                        message: "Please wait...",
                                        preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10,
                                                                     y: 5,
                                                                     width: 50,
                                                                     height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        alertLoader.view.addSubview(loadingIndicator)
        present(alertLoader, animated: true, completion: nil)
    }
    
    func dismissLoader() {
        DispatchQueue.main.async {
            self.alertLoader.dismiss(animated: true)
        }
    }
}
