import UIKit
import AudioToolbox

class vibrate: UIViewController {
    
    var counter = 0
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func vibratePhone() {
        counter += 1
        switch counter {
        case 1, 2:
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        default:
            timer?.invalidate()
        }
    }
    func vibrate(_ sender: AnyObject) {
        counter = 0
        timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: "vibratePhone", userInfo: nil, repeats: true)
    }
}
