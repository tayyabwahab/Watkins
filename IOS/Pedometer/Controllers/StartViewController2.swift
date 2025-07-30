//
//  StartViewController2.swift
//  Pedometer
//
//  Created by Behzad Khadim on 15/03/2023.
//

import UIKit
//imported for avaudioplayer
import AVFoundation


class StartViewController2: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var DistanceToTravelLbl: UILabel!
    @IBOutlet weak var litGrayCircle: UIImageView!
    @IBOutlet weak var darkGrayCircle: UIImageView!
    @IBOutlet weak var goldenCircle: UIImageView!
    
    
    //changing twenty meter stepper to 6 and 12 meters stepper
    
    //ten meter is now 6 meters
    //20 meter is now 12 meters
    @IBOutlet weak var twentyMeterStepper: UIButton!
    @IBOutlet weak var tenMeterStepper: UIButton!
    
    
    //audioplayer for using the playSound feature
    var audioPlayer: AVAudioPlayer?

    let stepperConst = 1
    var timeCounter = 0
    var maxCounter = 0
    var timer: Timer?
    
    private let one = "one"
    private let two = "two"
    private let three = "three"
    private let standupWalk = "stand_up_and_walk"

    
    var distanceToCoverInMeter = 3 {
        didSet {
            if distanceToCoverInMeter >= stepperConst {
                SetDistanceLblValue(value: distanceToCoverInMeter)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SVC2")
        tenMeterStepper.layer.cornerRadius = 8
        twentyMeterStepper.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.startButton.setTitle("START", for: .normal)
        distanceToCoverInMeter = 3
        self.maxCounter = 3
    }
    
    @IBAction func StepUpButtonAction(_ sender: Any) {
        distanceToCoverInMeter += stepperConst
    }
    
    @IBAction func StartAction(_ sender: Any) {
        self.view.isUserInteractionEnabled = false
        timer  = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(StartCounter), userInfo: nil, repeats: true)
    }
    
    @IBAction func StepDownButtonAction(_ sender: Any) {
        if distanceToCoverInMeter > stepperConst
        {
            distanceToCoverInMeter -= stepperConst
        }
    }
    
    
    @IBAction func tenMeterStepperAction(_ sender: UIButton) {
        distanceToCoverInMeter += 6
    }
    
    @IBAction func twentyMeterStepperAction(_ sender: UIButton) {
        distanceToCoverInMeter += 12
    }
    
    private func SetDistanceLblValue(value: Int) {
        DistanceToTravelLbl.text = String(format: "%d %@", value, "M")
    }
    
    
    //added if else logic to the StartCounter function along with the playSound component
    
    @objc func StartCounter() {
        
        startButton.setTitle(String(maxCounter), for: .normal)
        if maxCounter == 3 {
            playSound(music: three)
        }else if maxCounter == 2 {
            playSound(music: two)
        } else if maxCounter == 1 {
            playSound(music: one)
            timer?.invalidate()
            timer = nil
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                if let pedometerVC = self.getPedemoterControllerInstance() {
                    pedometerVC.goalDistance = self.distanceToCoverInMeter
                    self.view.isUserInteractionEnabled = true
                    self.navigationController?.pushViewController(pedometerVC, animated: true)
                }
            }
        }
        maxCounter -= 1
    }


    private func getPedemoterControllerInstance() -> PedometerViewController2? {
        if let pedometerVC = self.storyboard?.instantiateViewController(withIdentifier: "PedometerViewController2") as? PedometerViewController2 {
            return pedometerVC
        }
        return nil
    }
    
    //playSound function
    
    private func playSound(music: String) {
        
        do {
            if let fileURL = Bundle.main.path(forResource: music, ofType: ".mp3") {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
                audioPlayer?.play()
            } else {
                print("No file with specified name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        
    }
    
    @IBAction func popViewController(_ sender: Any) {
        // self.navigationController?.popToRootViewController(animated: true)
      
        
        //added this line of code and declared the extension of uinavigationcontroller in UserDefaults+Extension.swift file
        
        self.navigationController?.backToViewController(viewController: WelcomeRepesentatinViewController.self)
    }
}



