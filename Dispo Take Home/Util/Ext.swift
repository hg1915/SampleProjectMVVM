

import UIKit

extension UIView {
    
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}


extension UINavigationController {
    func fadeTo(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
}


