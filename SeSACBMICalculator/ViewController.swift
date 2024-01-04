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
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var randomResultButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    
    //integer을 사용하였더니, 소수를 저장하지 못하는 케이스 발생 확인되어,
    //string으로 구현
    var savedNickname = UserDefaults.standard.string(forKey: "nickname")
    var savedHeight = UserDefaults.standard.string(forKey: "height")
    var savedWeight = UserDefaults.standard.string(forKey: "weight")
    
    
    // enum 활용하고 싶은데 활용방법을 잘 모르겠어서, 수업 들어본 후 수정해보려함
    //    enum Status: String {
    //        case 저체중 = "저체중"
    //        case 정상 = "정상"
    //        case 과체중 = "과체중"
    //        case 비만 = "비만"
    //        case 고도비만 = "고도비만"
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputSavedTextFieldDate()
        updatedSubTitleLable(nicknameText: savedNickname)
        designTotalView()
        
    }
    
    @IBAction func editingTextField(_ sender: UITextField) {
        trimmingTextField(textfield: sender)
        updatedSubTitleLable(nicknameText: nicknameTextField.text)
    }

    
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func resultButtonClicked(_ sender: UIButton) {
        
        resultAlert()

        UserDefaults.standard.set(nicknameTextField.text, forKey: "nickname")
        UserDefaults.standard.set(heightTextField.text, forKey: "height")
        UserDefaults.standard.set(weightTextField.text, forKey: "weight")
    }
    
    @IBAction func keyboardDismiss(_ sender: UITextField) {
    }
    
    
    @IBAction func randomResultButtonClicked(_ sender: UIButton) {
        inputRandomValues()
        updatedSubTitleLable(nicknameText: nicknameTextField.text)
    }
    
    @IBAction func resetButtonClicked(_ sender: UIButton) {

        nicknameTextField.text = nil
        heightTextField.text = nil
        weightTextField.text = nil
        
        UserDefaults.standard.set("", forKey: "nickname")
        UserDefaults.standard.set("0", forKey: "height")
        UserDefaults.standard.set("0", forKey: "weight")

        updatedSubTitleLable(nicknameText: nicknameTextField.text)
        resetAlert()
    }
    
    func inputRandomValues() {
        let randomHeight = Double.random(in: 120...250)
        let randomWeight = Double.random(in: 40...150)
        nicknameTextField.text = "Random"
        heightTextField.text = String(format: "%.2f", randomHeight)
        weightTextField.text = String(format: "%.2f", randomWeight)
    }
    
    func calculatorBMI() -> String {
        
        //viewdidload에서 inputSavedTextFieldDate() 통하여
        //초기 nil값들을 잡아줌
        if nicknameTextField.text == "" {
            return "닉네임을 입력하시오."
        }
        // 텍스트필드 텍스트는 nil값을 자동으로 처리해주는 기능이 있어서 오류 발생 확률이 없다 생각하여 강제언래핑으로 변경해보았습니다
        guard let doubleHeight = Double(heightTextField.text!) else {
            return "정확한 키를 입력하시오."
        }
        guard doubleHeight >= 120 && doubleHeight <= 250 else {
            return "키를 120이상 250이하로 입력하세요."
        }
        
        guard let doubleWeight = Double(weightTextField.text!) else {
            return "정확한 몸무게를 입력하시오."
        }
        
        guard doubleWeight >= 40 && doubleWeight <= 150 else {
            return "몸무게를 40이상 150이하로 입력하세요."
        }
        
        let bmiValue = doubleWeight / (doubleHeight / 100 * doubleHeight / 100)
        let stringBMIValue = String(format: "%.2f", bmiValue)

        return stringBMIValue
    }
    
    func judgeBMI(stringBMIValue: String) -> String {
    
        let result = Double(stringBMIValue) ?? 0
        switch result {
        case 1..<18.5:
            return "저체중"
        case 18.5..<23:
            return "정상"
        case 23..<25:
            return "과체중"
        case 25..<30:
            return "비만"
        case 30...:
            return "고도비만"
        default:
            return ""
        }
    }
    
    func designTotalView() {
        
        mainImageView.image = .image
        mainImageView.contentMode = .scaleAspectFill
        
        mainTitleLabel.text = "BMI Calculator"
        mainTitleLabel.font = .boldSystemFont(ofSize: 20)
        
        subTitleLabel.font = .systemFont(ofSize: 16)
        subTitleLabel.numberOfLines = 2
        
        nicknameLabel.text = "닉네임이 어떻게 되시나요?"
        nicknameLabel.font = .systemFont(ofSize: 14)
        
        heightLabel.text = "키가 어떻게 되시나요?"
        heightLabel.font = .systemFont(ofSize: 14)
        
        weightLabel.text = "몸무게는 어떻게 되시나요?"
        weightLabel.font = .systemFont(ofSize: 14)
        
        randomResultButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomResultButton.titleLabel?.font = .systemFont(ofSize: 12)
        randomResultButton.titleLabel?.tintColor = .red
        
        resultButton.setTitle("결과 확인", for: .normal)
        resultButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        resultButton.tintColor = .white
        resultButton.backgroundColor = .purple
        resultButton.layer.cornerRadius = 10
        
        resetButton.setTitle("데이터 리셋", for: .normal)
        resetButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        resetButton.tintColor = .black
        resetButton.backgroundColor = .lightGray
        resetButton.layer.cornerRadius = 10
        
        weightTextField.keyboardType = .numbersAndPunctuation
        heightTextField.keyboardType = .numbersAndPunctuation
    }
    
    func inputSavedTextFieldDate() {
        if let savedNickname {
            nicknameTextField.text = savedNickname
        } else {
            nicknameTextField.text = ""
        }
        
        if Double(savedHeight ?? "0") == 0 {
            heightTextField.text = ""
        } else {
            heightTextField.text = savedHeight
        }
        if Double(savedWeight ?? "0") == 0 {
            weightTextField.text = ""
        } else {
            weightTextField.text = savedWeight
        }
    }
    
    func updatedSubTitleLable(nicknameText: String?) {
        if nicknameText == "" {
            subTitleLabel.text = "당신의 BMI 지수를\n알려드릴게요."
        } else {
            subTitleLabel.text = "\(nicknameText ?? "당신")의 BMI 지수를\n알려드릴게요."
        }
    }
    
    func resultAlert() {
        let bmiResult: String = calculatorBMI()
        let judgeBMI = judgeBMI(stringBMIValue: bmiResult)
        let alert = UIAlertController(title: "BMI 지수결과", message: "\(judgeBMI) \(bmiResult)", preferredStyle: .alert)
        let alertCancleButton = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(alertCancleButton)
        present(alert, animated: true)
    }
    
    func resetAlert() {
        let alert = UIAlertController(title: "데이터 리셋 완료", message: .none, preferredStyle: .alert)
        let alertCancleButton = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(alertCancleButton)
        present(alert, animated: true)
    }
    
    func trimmingTextField(textfield: UITextField) {
        textfield.text = textfield.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
}
