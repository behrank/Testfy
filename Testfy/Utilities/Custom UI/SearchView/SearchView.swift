//
//  SearchView.swift
//  Near
//
//  Created by Behran Kankul on 27.03.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

protocol SearchViewDelegate:class {
    func makeSearchWith(text:String)
    func clearDataContainers()
}

class SearchView:UIView {
    
    var delegate:SearchViewDelegate?
    var isClearBtnHit = false
    var searchTimer: Timer?

    @IBOutlet weak var textField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }
    
    func prepareUI() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidEditingChanged(_:)), for: .editingChanged)
    }
    func hideKeyboardFromUI() {
        textField.resignFirstResponder()
    }
}
extension SearchView:UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        delegate?.clearDataContainers()
        hideKeyboardFromUI()
        searchTimer?.invalidate()
        return true
    }
    @objc func textFieldDidEditingChanged(_ textField: UITextField) {
        
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        searchTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(searchForKeyword(_:)), userInfo: textField.text!, repeats: false)
    }
    
    @objc func searchForKeyword(_ timer: Timer) {
        
        let keyword = timer.userInfo! as! String
        if keyword == "" {
            delegate?.clearDataContainers()
            return
        }
        delegate?.makeSearchWith(text: keyword)
        debugPrint("Searching for keyword \(keyword)")
    }
}
