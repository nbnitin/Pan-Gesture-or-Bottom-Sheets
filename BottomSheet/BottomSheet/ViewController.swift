//
//  ViewController.swift
//  BottomSheet
//
//  Created by Nitin Bhatia on 30/03/22.
//

import UIKit

let DIMMED_VIEW : UIView = UIView()

class ViewController: UIViewController,UISheetPresentationControllerDelegate,CustomBottomSheetViewControllerProtocol {

    @IBOutlet weak var backgroundView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func showCustomBottomSheetAction(_ sender: Any) {
        //backgroundView.isHidden = false
        showBottomSheet(delegate: self)
    }
    
   
    func didDismissed() {
        backgroundView.isHidden = true
    }
    
    @IBAction func presentBottomSheet(_ sender: Any) {
        
        
        
        let bottomSheet = self.storyboard?.instantiateViewController(identifier: "bottomSheet") as! BottomViewController
       // bottomSheet.isModalInPresentation = true //it helps not to close modal on swipe
        
        
        if #available(iOS 15.0, *) {
            if let sheet = bottomSheet.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
                
                sheet.largestUndimmedDetentIdentifier = .large
                //sheet.preferredCornerRadius =
                
                sheet.prefersScrollingExpandsWhenScrolledToEdge = true
                sheet.delegate = self
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
                
                
                //self.sheet.preferredContentSize = CGSize(width: self.view.frame.width, height: 90)
                
            }
        } else {
            // Fallback on earlier versions
        }
        present(bottomSheet, animated: true, completion: nil)
        
    }
    
    @available(iOS 15.0, *)
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        print("I m in",sheetPresentationController.selectedDetentIdentifier)
    }
    

    
}

extension UIViewController {
    
    
    
    func showBottomSheet(delegate:CustomBottomSheetViewControllerProtocol) {
        let vc = self.storyboard?.instantiateViewController(identifier: "customBottomSheet") as! CustomBottomSheetViewController
        vc.delegate = delegate
        vc.bottomSheetType = .MEDIUM
        modalPresentationStyle = .overCurrentContext
        
        
        DIMMED_VIEW.backgroundColor = .black
        DIMMED_VIEW.alpha = 0.6
        DIMMED_VIEW.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(DIMMED_VIEW)
        DIMMED_VIEW.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        DIMMED_VIEW.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        DIMMED_VIEW.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        DIMMED_VIEW.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true

        
        present(vc, animated: true, completion: {
            //self.backgroundView.isHidden = true
        })
    }
    
    func removeDimmedView() {
        //dimmedView.removeFromSuperview()
    }
}

