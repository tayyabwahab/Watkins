import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var stepLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    let feedbackGenerator = UINotificationFeedbackGenerator()
    
    var distance = ""
    var steps = ""
    var time = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        distanceLbl.text = distance
        stepLbl.text = steps
        timeLbl.text = time
        if let name = UserDefaults.standard.string(forKey: "user") {
            nameLbl.text = name
        }
        feedbackGenerator.notificationOccurred(.error)
    }
    
    @IBAction func popViewController(_ sender: Any) {
        // self.navigationController?.popToRootViewController(animated: true)
        
        self.navigationController?.backToViewController(viewController: StartViewController.self)
    }
}
