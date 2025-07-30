//
//  WelcomeRepresentationViewController2.swift
//  Pedometer
//
//  Created by Behzad Khadim on 25/03/2023.
//

import UIKit

class WelcomeRepresentationViewController2: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var personName: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 8
        if let name = UserDefaults.standard.string(forKey: "user") {
            personName.text = name
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
        
//        let versionIndex = self.versionSegment.selectedSegmentIndex
//        if let version = self.versionSegment.titleForSegment(at: versionIndex) {
//            if version == "10 Meter Walking Test"{
//                if let getStartControllerInstance2 = getStartControllerInstance2(){
//                    self.navigationController?.pushViewController(getStartControllerInstance2, animated: true)
//                }
//            }else {
//                if let getStartControllerInstance = getStartControllerInstance(){
//                    self.navigationController?.pushViewController(getStartControllerInstance, animated: true)
//                }
//            }
//        }
        
        if let getStartControllerInstance3 = getStartControllerInstance3(){
            self.navigationController?.pushViewController(getStartControllerInstance3, animated: true)
        }
    }
  
    
    private func getStartControllerInstance3() -> StartViewController3? {
        if let startVC3 = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController3") as? StartViewController3 {
            return startVC3
        }
        return nil
    }
    
    @IBAction func popViewController(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
