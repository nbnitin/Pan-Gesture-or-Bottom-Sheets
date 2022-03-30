//
//  ViewController.swift
//  BottomSheet
//
//  Created by Nitin Bhatia on 30/03/22.
//

import UIKit

class ViewController: UIViewController,UISheetPresentationControllerDelegate,CustomBottomSheetViewControllerProtocol {

    @IBOutlet weak var backgroundView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func showCustomBottomSheetAction(_ sender: Any) {
        backgroundView.isHidden = false
        let vc = self.storyboard?.instantiateViewController(identifier: "customBottomSheet") as! CustomBottomSheetViewController
        vc.delegate = self
        vc.bottomSheetType = .MEDIUM
        modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: {
            //self.backgroundView.isHidden = true
        })
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

