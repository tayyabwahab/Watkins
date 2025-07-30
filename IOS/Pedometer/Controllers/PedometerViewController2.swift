//
//  PedometerViewController2.swift
//  Pedometer
//
//  Created by Behzad Khadim on 15/03/2023.
//
import UIKit
import AVFoundation
import CoreMotion
import SwiftLoader
import CoreHaptics

extension UIViewController {
    
  func alert2(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}

class PedometerViewController2: UIViewController {
    
    @IBOutlet weak var optionView: UIView!
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var stepsLbl: UILabel!
    @IBOutlet weak var distanceTravelLbl: UILabel!
    
    @IBOutlet weak var nameLbk: UILabel!
    
    let feedbackGenerator = UINotificationFeedbackGenerator()
    
    var goalDistance = 0
    
    //musicCounter has been changed to 3 to 1
    
    var musicCounter = 1
    
    var completeDistance = 0
    var audioPlayer: AVAudioPlayer?
    
    
    private let pedometer = CMPedometer()
    private var activityManager: CMMotionActivityManager?
    
    private var stepperCountTimer: Timer?
    private var timer = Timer()
    private var motionDetectionTimer: Timer?
    private var soundTimer: Timer?
    
    private var distancetogo = 0.0
    private var timeElapsed: TimeInterval = 0.0
    private var isLoaderAnimating = true
    private let timerInterval = 1.0
    
    private var forwardGif = "forward"
    private var backwardGif = "backward"
    private var sitdownGif = "sitdown"
    private var standupGif = "standup"
    
    private let walk = "walk"
    private let countdownWalk = "countdownWalk"
    private let one = "one"
    private let two = "two"
    private let three = "three"
    private let standupWalk = "stand_up_and_walk"
    private let turnAroundWalk = "turn_around_and_walk_back"
    private let sitDown = "sit_down"
    
    var currentGif = ""
    
    private func vibration(){
        feedbackGenerator.notificationOccurred(.warning)
        print("func has run")
    }
    private var distanceTravel = 0.0 {
        didSet {
            
            distanceTravelLbl.text =  String(format: "%.1f", distanceTravel )
        
            if distanceTravel > 1 && currentGif == forwardGif {
//                currentGif = forwardGif
//                updateGif(gifName: currentGif)
                
            }
            
            //not required
            
//            if distanceTravel >= (Double(completeDistance) * 0.50) &&  distanceTravel < (Double(completeDistance) * 0.90) && currentGif == forwardGif {
//                playSound(music: turnAroundWalk)
//                feedbackGenerator.notificationOccurred(.error)
//                currentGif = backwardGif
//                updateGif(gifName: currentGif)
//
//                do{
//                    sleep(5)
//                }
//            }
            
            //chnages made to the current gif from sitdown to forwardgif inside function
//            if distanceTravel >= (Double(completeDistance) * 0.90) && distanceTravel < Double(completeDistance) && currentGif == forwardGif {
//              //  playSound(music: sitDown)
//                currentGif = forwardGif
//                updateGif(gifName: currentGif)
//            }
            
            //changes made to the current gif from sitdown to forward gif
            if  distanceTravel >= Double(completeDistance) && currentGif == forwardGif {
                currentGif = ""
                activityManager?.stopActivityUpdates()
                activityManager = nil
                DispatchQueue.main.async { [weak self] in
                    self?.showResultsVC()
                    
                }
            }
        }
    }
    
    private var stepCounter = 0.0 {
        didSet {
            if stepCounter == 1 {
                startTimer()
            }
            print(stepCounter)
            DispatchQueue.main.async { [weak self] in
                self?.stepsLbl.text =  String(format: "%.1f", self?.stepCounter ?? 0)
                self?.distanceTravel = (self?.stepCounter ?? 0) * 0.79
                self?.distancetogo =  Double(self?.completeDistance ?? Int(0.0))
            }
        }
    }
    
    private var finalDistance = 0.0 {
        didSet {
            self.finalDistance = Double(self.distancetogo)
        }
    }
    
    private var timeConsumed = "" {
        didSet {
            DispatchQueue.main.async {
                self.timeLbl.text = self.timeConsumed
            }
        }
    }
    
    private var isWalking: Bool = false {
        didSet {
            if isWalking {
                if (motionDetectionTimer != nil) {
                    motionDetectionTimer?.invalidate()
                    motionDetectionTimer = nil
                }
                if self.stepperCountTimer == nil {
                    stepperCountTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self,selector: #selector(startStepperCount) ,userInfo: nil,repeats: true)
                }
            } else {
                if let stepperCountTimer = stepperCountTimer {
                    stepperCountTimer.invalidate()
                }
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PVC2")
        activityManager = CMMotionActivityManager()
        optionView.layer.cornerRadius = 10
        if let name = UserDefaults.standard.string(forKey: "user") {
            nameLbk.text = name
        }
        feedbackGenerator.notificationOccurred(.error)
        
        motionDetectionTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self,selector: #selector(detectMotion) ,userInfo: nil,repeats: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentGif = forwardGif
        updateGif(gifName: currentGif);
        completeDistance = goalDistance
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if musicCounter == 1 {
            //removed the playsound component from here and changed the musicCounter from 3 to 1
            print("Countdown ended.. play any counter sound ")
        }
        musicCounter -= 1
            //changes made to the timeInterval from 1.2 to 0.6
        soundTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self,selector: #selector(play) ,userInfo: nil,repeats: true)
    }
    

    private func newcounter(){
        do {
            sleep(2)
            stepCounter += 1
        }
    }
    
    private func incrementcounter(){
            stepCounter += 1
    }
    
    private func anothercounter(){
        do{
            sleep(1)
            stepCounter += 1
        }
    }
    
    var runCount = 0
    
   
    
    //changes to the pedometer view after the counter
    @objc func play() {
        //removed if else logic from the function
        if musicCounter == 0 {
            playSound(music: walk)
            soundTimer?.invalidate()
            soundTimer = nil
            
            //start the step counter after the gif is in standing mode
           newcounter()
            
            //then added another counter increment with different interval that gets overright with the motion data at the run time.
            

            Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true){ fakestep in
                // self.incrementcounter()
                self.runCount += 1
                self.stepCounter = Double(self.runCount)
                
                if self.runCount == 11 {
//                    self.stepCounter = Double(self.runCount) + self.stepCounter
                    print(self.stepCounter)
                    fakestep.invalidate()
                    
                    if self.stepCounter == 12.0 && self.currentsituation == "stationary"{
                      //alert message to quit the session if no movement
                        self.alert2(message: "Did not read any Movement data, make sure to keep walking! ")
                        self.navigationController?.backToViewController(viewController: StartViewController.self)
                    }
                }
            }
        }
        musicCounter -= 1
    }
    
    @objc func detectMotion() {
        activeMotionDetection()
    }
    
    private func updateGif(gifName: String) {
        let gifImage = UIImage.gifImageWithName(gifName)
        self.gifImageView.image = gifImage
    }
    
    var currentsituation = "walking"
    
    func activeMotionDetection()  {
        
        if CMMotionActivityManager.isActivityAvailable() {
            self.activityManager?.startActivityUpdates(to: .main) { activity in
                guard let activity = activity else { return }
                  
              //  var currentsituation = activity.stationary
                
                DispatchQueue.main.async { [weak self] in
                    if activity.stationary {
                        print("Stationary")
                        self?.currentsituation = "stationary"
            
                        if self?.isWalking == true {
                            self?.isWalking = false
                        }
                    } else if activity.walking {
                        print("Walking")
                        self?.currentsituation = "walking"

                        if (self?.isWalking == false) {
                            self?.isWalking = true
                        }
                    } else if activity.running {
                        print("Running")
                        self?.currentsituation = "running"

                        if (self?.isWalking == false) {
                            self?.isWalking = true
                        }
                    } else if activity.automotive {
                        print("Automotive")
                        self?.currentsituation = "automotive"

                        if (self?.isWalking == false) {
                            self?.isWalking = true
                        }
                    }
                }
            }
        }
    }
    
    func timeIntervalFormat(interval: TimeInterval)-> String {
        var seconds = Int(interval + 0.5) //round up seconds
        let minutes = (seconds / 60) % 60
        seconds = seconds % 60
        return String(format:"%02i:%02i",minutes,seconds)
    }
    
    func startTimer() {
        if timer.isValid { timer.invalidate() }
        timer = Timer.scheduledTimer(timeInterval: timerInterval,target: self,selector: #selector(timerAction(timer:)) ,userInfo: nil,repeats: true)
    }
    
    @objc func startStepperCount() {
        stepCounter += 1;
    }
    
    func stopTimers() {
        timer.invalidate()
        stepperCountTimer!.invalidate()
        stepperCountTimer = nil
    }
    
    @objc func timerAction(timer: Timer) {
        timeElapsed += 1;
        timeConsumed = timeIntervalFormat(interval: timeElapsed)
    }
    
    private func getResultControllerInstance() -> ResultViewController2? {
        if let reultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController2") as? ResultViewController2 {
            return reultVC
        }
        return nil
    }
    
    
    private func showResultsVC() {
        stopTimers()
        DispatchQueue.main.async { [weak self] in
            if let resultVC = self?.getResultControllerInstance() {
                resultVC.steps = String(format: "%.1f", self?.stepCounter ?? 0)
                resultVC.distance = String(format: "%.1f", self?.distancetogo ?? 0)
                resultVC.time = self?.timeConsumed ?? ""
                self?.navigationController?.pushViewController(resultVC, animated: true)
            }
        }
    }
    
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
    
    private func soundwithhaptic(music: String) {
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
    
    private func ConfigureLoader() {
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 150
        config.spinnerLineWidth = 2
        config.spinnerColor = UIColor(red: 22/255.0, green: 27/255.0, blue: 42/255.0, alpha: 1.0)
        config.backgroundColor = UIColor(red: 192/255.0, green: 147/255.0, blue: 49/255.0, alpha: 1.0)
        config.foregroundColor = UIColor.black
        config.foregroundAlpha = 0.6
        config.titleTextFont = UIFont.boldSystemFont(ofSize: 13.0)
        config.titleTextColor =  UIColor(red: 22/255.0, green: 27/255.0, blue: 42/255.0, alpha: 1.0)
        SwiftLoader.setConfig(config)
        SwiftLoader.show(title: "Activating Proximity-Sensor", animated: true)
    }
    
    
    @IBAction func popViewController(_ sender: Any) {
        // self.navigationController?.popToRootViewController(animated: true)
       
        self.navigationController?.backToViewController(viewController: StartViewController2.self)
    }
}

