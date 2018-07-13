//
//  BaseViewController.swift
//  Testfy
//
//  Created by Behran Kankul on 10.07.2018.
//  Copyright © 2018 Be Moebil. All rights reserved.
//

import UIKit

class BaseViewController:UIViewController {
    
   fileprivate let loadingView = LoadingView.fromNib()
    
    private var activityCount = 0 {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                UIApplication.shared.isNetworkActivityIndicatorVisible = self.activityCount > 0
            }
        }
    }
    
    private var loadingCount = 0 {
        didSet {
            DispatchQueue.main.async { [unowned self] in
               self.loadingView.isOnFire = self.loadingCount > 0
            }
        }
    }
    
    //UI Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if shouldListenKeyboardNotification() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShownNotif(_:)), name: .UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotif(_:)), name: .UIKeyboardWillHide, object: nil)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Helpers
    internal func shouldListenKeyboardNotification() -> Bool {
        return false
    }
    
    internal func keyboardNotification(willShow:Bool,endFrame:CGRect) {
        
    }
    func hideNavBarBorder() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    // MARK: DeInit
    deinit {
        #if DEBUG
        debugPrint("\(NSStringFromClass(self.classForCoder)) deinitialized")
        #endif
        if shouldListenKeyboardNotification() {
            NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
            NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        }
    }
}

extension BaseViewController {
    
    //MARK: Triggers
    func pushNetworkActivity() {
        activityCount += 1
    }
    
    func popNetworkActivity() {
        if activityCount > 0 { activityCount = 0 }
    }
    func showLoading()
    {
        loadingCount = 1
    }
    func hideLoading()
    {
        loadingCount = 0
    }
    //MARK: Keyboard
    @objc func keyboardWillShownNotif(_ notification:Notification) {
        self.handleKeyboardNotif(notification: notification, willShow: true)
    }
    
    @objc func keyboardWillHideNotif(_ notification:Notification) {
        self.handleKeyboardNotif(notification: notification, willShow: false)
    }
    
    func handleKeyboardNotif(notification:Notification, willShow:Bool) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewKeyframeAnimationOptions = UIViewKeyframeAnimationOptions(rawValue: animationCurveRaw)
            self.keyboardNotification(willShow: willShow, endFrame: endFrame!)
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: animationCurve, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (finished) in })
        }
    }
}
