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
    
    private let alertLoader : UIAlertController = {
        let alert = UIAlertController(title: nil,message: "Please wait...",preferredStyle: .actionSheet)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10,y: 5,width: 50,height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        return alert
    }()
    
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
    
    func presentLoader(){
        if alertLoader.isBeingPresented { return }
        present(alertLoader, animated: true, completion: nil)
    }
    
    func dismissLoader() {
        self.alertLoader.dismiss(animated: true)
    }
}
