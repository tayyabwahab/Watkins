
import UIKit

class WelcomeRepesentatinViewController: UIViewController {
    @IBOutlet weak var versionSegment: UISegmentedControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var personName: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        versionConfigSegment()
        nextButton.layer.cornerRadius = 8
        if let name = UserDefaults.standard.string(forKey: "user") {
            personName.text = name
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
        
        let versionIndex = self.versionSegment.selectedSegmentIndex
        if let version = self.versionSegment.titleForSegment(at: versionIndex) {
            if version == "10 Meter Walking Test"{
                if let getStartControllerInstance2 = getStartControllerInstance2(){
                    self.navigationController?.pushViewController(getStartControllerInstance2, animated: true)
                }
            }else {
                if let getStartControllerInstance = getStartControllerInstance(){
                    self.navigationController?.pushViewController(getStartControllerInstance, animated: true)
                }
            }
        }
    }
    
    func versionConfigSegment() {
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let unSelectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        versionSegment.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        versionSegment.setTitleTextAttributes(unSelectedTextAttributes, for: .normal)
        
    }
    
    private func getStartControllerInstance2() -> StartViewController2? {
        if let startVC2 = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController2") as? StartViewController2 {
            return startVC2
        }
        return nil
    }
    private func getStartControllerInstance() -> StartViewController? {
        if let startVC = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController {
            return startVC
        }
        return nil
    }
    
    @IBAction func popViewController(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
