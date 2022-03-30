//
//  ViewController.swift
//  PanGestureMovingObject
//
//  Created by Nitin Bhatia on 30/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgFile: UIImageView!
    @IBOutlet weak var imgTrash: UIImageView!
    
    var imgFileOrigin : CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgFileOrigin = imgFile.frame.origin
        view.bringSubviewToFront(imgFile)
        setupPanGesture()
    }
    
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        imgFile.isUserInteractionEnabled = true
        imgFile.addGestureRecognizer(panGesture)
    }
    
    // Refactor
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        
        let fileView = sender.view!
        
        switch sender.state {
            
        case .began, .changed:
            moveViewWithPan(view: fileView, sender: sender)
            
        case .ended:
            if fileView.frame.intersects(imgFile.frame) {
                deleteView(view: fileView)
                
            } else {
                returnViewToOrigin(view: fileView)
            }
            
        default:
            break
        }
    }
    
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    
    func returnViewToOrigin(view: UIView) {
        
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin = self.imgFileOrigin
        })
    }
    
    
    func deleteView(view: UIView) {
        
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.0
        },completion: {_ in
            self.imgTrash.image = UIImage(named: "filled_trash")
        })
    }
    
    
}

