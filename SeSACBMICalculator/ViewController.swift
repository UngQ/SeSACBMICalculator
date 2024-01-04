//
//  ViewController.swift
//  SeSACBMICalculator
//
//  Created by ungq on 1/4/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var mainTitleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var randomResultButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    
    //BMI = 몸무게 / 키^2
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designTotalView()
    }

    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func resultButtonClicked(_ sender: UIButton) {
         
        let bmiResult: String = calculatorBMI()
        
        let alert = UIAlertController(title: "BMI 지수결과", message: bmiResult, preferredStyle: .alert)
        let alertCancleButton = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(alertCancleButton)
        present(alert, animated: true)
    }
    
    @IBAction func keyboardDismiss(_ sender: UITextField) {
    }
    
    @IBAction func randomResultButtonClicked(_ sender: UIButton) {
        let randomHeight = Double.random(in: 120...250)
        let randomWeight = Double.random(in: 40...150)
        
        heightTextField.text = String(format: "%.2f", randomHeight)
        weightTextField.text = String(format: "%.2f", randomWeight)
        resultButtonClicked(sender)
    }
    
    func calculatorBMI() -> String {
//        guard let height = heightTextField.text else { return "" }
//        guard let weight = weightTextField.text else { return "" }
//        guard let floatHeight = Float(height) else { return "정확한 키를 입력하시오."}
//        guard let floatWeight = Float(weight) else { return "정확한 몸무게를 입력하시오."}
        
        // 위 처럼 텍스트필드 텍스트를 guard let 옵셔널 언래핑을 한번 더 해주려다가
        // 텍스트필드 텍스트는 nil값을 자동으로 처리해주는 기능이 있어서 오류 발생 확률이 없다 생각하여 강제언래핑으로 변경해보았습니다
        guard let doubleHeight = Double(heightTextField.text!) else { return "정확한 키를 입력하시오."}
        guard let doubleWeight = Double(weightTextField.text!) else { return "정확한 몸무게를 입력하시오."}
        
        let bmiValue = doubleWeight / (doubleHeight / 100 * doubleHeight / 100)
        let stringBMIValue = String(format: "%.2f", bmiValue)

        var bmiResult: String
        
        switch bmiValue {
        case 0..<18.5:
            bmiResult = "저체중"
        case 18.5..<23:
            bmiResult = "정상"
        case 23..<25:
            bmiResult = "과체중"
        case 25..<30:
            bmiResult = "비만"
        case 30...:
            bmiResult = "고도비만"
        default:
            bmiResult = "오류"
        }
        
        switch doubleHeight {
        case 120...250:
            switch doubleWeight {
            case 40...150:
                return "\(bmiResult) (\(stringBMIValue))"
            default:
                return "몸무게를 40이상 150이하로 입력하세요."
            }
        default:
            return "키를 120이상 250이하로 입력하세요."
        }
    }
    
    func designTotalView() {
        
        mainImageView.image = .image
        mainImageView.contentMode = .scaleAspectFill
        
        mainTitleLabel.text = "BMI Calculator"
        mainTitleLabel.font = .boldSystemFont(ofSize: 20)
        
        subTitleLabel.text = "당신의 BMI 지수를\n알려드릴게요."
        subTitleLabel.font = .systemFont(ofSize: 16)
        subTitleLabel.numberOfLines = 2
        
        heightLabel.text = "키가 어떻게 되시나요?"
        heightLabel.font = .systemFont(ofSize: 16)
        
        weightLabel.text = "몸무게는 어떻게 되시나요?"
        weightLabel.font = .systemFont(ofSize: 16)
        
        randomResultButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomResultButton.titleLabel?.font = .systemFont(ofSize: 12)
        randomResultButton.titleLabel?.tintColor = .red
        
        resultButton.setTitle("결과 확인", for: .normal)
        resultButton.titleLabel?.font = .systemFont(ofSize: 20)
        resultButton.tintColor = .white
        resultButton.backgroundColor = .purple
        resultButton.layer.cornerRadius = 10
        
        weightTextField.keyboardType = .numbersAndPunctuation
        heightTextField.keyboardType = .numbersAndPunctuation
    }
}

