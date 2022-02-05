//
//  ViewController+Ext.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 3.02.2022.
//

import UIKit


fileprivate var containerView : UIView!

extension UIViewController {
    
    func presentAlert(message: String, title: String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
    }
    
    // MARK: Skeleton view show and hide
    
    func showSkeleton(uıView: UIView) {
        uıView.isSkeletonable = true
        uıView.showAnimatedSkeleton(usingColor: .carrot, transition: .crossDissolve(0.25))
    }
    
    func hideSkeleton(uıView:UIView){
        uıView.stopSkeletonAnimation()
        view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor       = .systemBackground
        containerView.alpha                 = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
         
        activityIndicator.startAnimating()
    }
    
    func hideLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
}
