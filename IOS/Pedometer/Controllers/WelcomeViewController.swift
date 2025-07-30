
import UIKit

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSegment()
        nextButton.layer.cornerRadius = 8
    }
    
  
    @IBAction func nextAction(_ sender: Any) {
        if nameField.text != "" {
            userDefaults.set(nameField.text, forKey: "user")
            userDefaults.synchronize()
            let genderIndex = self.genderSegment.selectedSegmentIndex
            if let gender = self.genderSegment.titleForSegment(at: genderIndex){
                if gender == "MALE"{
                    if let getWelcomeControllerInstance = getWelcomeControllerInstance(){
                        self.navigationController?.pushViewController(getWelcomeControllerInstance, animated: true)
                    }
                }else {
                    if let getWelcomeControllerInstance2 = getWelcomeControllerInstance2(){
                        self.navigationController?.pushViewController(getWelcomeControllerInstance2, animated: true)
                    }
                }
            }
        }
    }
    
    func configureSegment() {
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let unSelectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        genderSegment.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        genderSegment.setTitleTextAttributes(unSelectedTextAttributes, for: .normal)
    }
    
    private func getWelcomeControllerInstance() -> WelcomeRepesentatinViewController? {
        if let welcomeRepVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeRepesentatinViewController") as? WelcomeRepesentatinViewController {
            return welcomeRepVC
        }
        return nil
    }
    
    private func getWelcomeControllerInstance2() -> WelcomeRepresentationViewController2? {
        if let welcomeRepVC2 = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeRepresentationViewController2") as? WelcomeRepresentationViewController2 {
            return welcomeRepVC2
        }
        return nil
    }
    
    
}
