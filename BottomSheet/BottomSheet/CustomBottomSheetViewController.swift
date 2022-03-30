//
//  CustomBottomSheetViewController.swift
//  BottomSheet
//
//  Created by Nitin Bhatia on 30/03/22.
//

import UIKit

let DISMISSABLE_HEIGHT : CGFloat = 200
let CORNER_RADIUS : CGFloat = 20
let TOP_MARGIN : CGFloat = 70

enum BOTTOM_SHEET_TYPE {
    case MEDIUM
    case LARGE
}

protocol CustomBottomSheetViewControllerProtocol {
    func didDismissed()
}

class CustomBottomSheetViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    
    var delegate : CustomBottomSheetViewControllerProtocol?
    var bottomSheetType : BOTTOM_SHEET_TYPE = .LARGE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(pan)
        containerView.layer.cornerRadius = CORNER_RADIUS
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.4, options: .curveEaseIn, animations: {
            self.containerViewHeightConstraint.constant = self.view.frame.height / 2
            
        }, completion: nil)
        
        
    }
    
    @objc func handlePan(_ sender:UIPanGestureRecognizer) {
        let view = sender.view!
        let translation = sender.translation(in: view)
        
        if bottomSheetType == .MEDIUM {
            if translation.y < 0 {
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
                    self.containerViewHeightConstraint.constant += 2
                    self.view.layoutIfNeeded()
                }, completion: {_ in
                    self.containerViewHeightConstraint.constant -= 2
                })
                return
            }
        }
        switch sender.state {
        case .began, .changed:
            
            if translation.y < 0 {
                //going up
                if containerViewHeightConstraint.constant >= self.view.frame.height - TOP_MARGIN {
                    return
                }
            }
            //coming down
            containerViewHeightConstraint.constant = containerViewHeightConstraint.constant - translation.y
            self.view.layoutIfNeeded()
            sender.setTranslation(CGPoint.zero, in: view)
        case .ended,.cancelled:
            if containerViewHeightConstraint.constant < DISMISSABLE_HEIGHT {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.4, options: .curveEaseIn, animations: {
                    self.containerViewHeightConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }, completion: {_ in
                    self.delegate?.didDismissed()
                    self.dismiss(animated: false)
                })
            }
        default:
            break
        }
    }
    
}
