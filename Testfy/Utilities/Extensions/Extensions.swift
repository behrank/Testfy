//
//  UIView+extensions.swift
//  Near
//
//  Created by Behran Kankul on 3.02.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit
import Foundation

let imageCache = NSCache<NSString, UIImage>()

protocol ParsebleToDictonary {
    func parseToDictionary() -> [String:Any]
}
extension AppDelegate {
    
    class var delegate: AppDelegate? {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return delegate
    }
}
extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    public var presented : UIViewController {
        guard let presentedVC = presentedViewController else { return self }
        return presentedVC
    }
}

protocol ModelType { }
extension UIViewController : ModelType { }
extension ModelType where Self : UIViewController {
    static func fromNib(_ nibName : String = String(describing: Self.self)) -> Self {
        return Self(nibName: nibName, bundle: nil)
    }
    
    static func fromStoryboard(_ type : Storyboard.Identifier) -> Self {
        let storyboard : UIStoryboard = UIStoryboard(name: type.storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: type.rawValue) as! Self
    }
}
extension UIView : ModelType { }
extension ModelType where Self : UIView {
    static func fromNib(_ nibName : String = String(describing: Self.self)) -> Self {
        return Self.create(with: nibName) as! Self
    }
}
@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    open class func create() -> UIView {
        return UIView.create(with: String(describing: self))
    }
    
    open class func create(with nibName:String) -> UIView {
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as! UIView
    }
    
    func layoutIfNeededAnimated(_ duration : TimeInterval = 0.3) {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.y, width: self.w, height: self.h)
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.x, y: value, width: self.w, height: self.h)
        }
    }
    public var w: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.h)
        }
    }
    public var h: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.w, height: value)
        }
    }
    func origin (_ point : CGPoint){
        frame.origin.x = point.x
        frame.origin.y = point.y
    }
    
    class func initFromNib() -> UIView {
        let mainBundle = Bundle.main
        let className  = NSStringFromClass(self).components(separatedBy: ".").last ?? ""
        
        if ( mainBundle.path(forResource: className, ofType: "nib") != nil ) {
            let objects = mainBundle.loadNibNamed(className, owner: self, options: [:])
            
            for object in objects! {
                if let view = object as? UIView {
                    return view
                }
            }
        }
        
        return UIView(frame: CGRect.zero)
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
extension UIImageView {
    func loadImageUsingUrlString(urlString:String) {
        let url = URL(string:urlString)
        
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: url!) { (data, res, error) in
           
            if error != nil {
                debugPrint(error!)
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data:data!)
                imageCache.setObject(imageToCache!,forKey:urlString as NSString)
                
                self.image = imageToCache
            }
            
        }.resume()
    }
}
extension UITableView {
    func moveToTop(){
        self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}

extension UIScrollView {
    var currentPage:Int{
        return Int((self.contentOffset.x+(0.5*self.frame.size.width))/self.frame.width)+1
    }
}
extension UITextView {
    func numberOfLines() -> Int{
        if let fontUnwrapped = self.font{
            return Int(self.contentSize.height / fontUnwrapped.lineHeight)
        }
        return 0
    }
}
class NavigationHelper {
    
    class var rootVC : UIViewController? {
        return AppDelegate.delegate?.window?.rootViewController
    }
    
    class var rootVCForAlert : UIViewController? {
        return rootVC?.presented
    }
}
