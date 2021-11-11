//
//  CalculatorViewController.swift
//  swift-calculator
//
//  Created by Abi  Radzhabova on 5/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var numberOneButton: UIButton!
    @IBOutlet weak var numberTwoButton: UIButton!
    @IBOutlet weak var numberThreeButton: UIButton!
    @IBOutlet weak var numberFourButton: UIButton!
    @IBOutlet weak var numberFiveButton: UIButton!
    @IBOutlet weak var numberSixButton: UIButton!
    @IBOutlet weak var numberSevenButton: UIButton!
    @IBOutlet weak var numberEightButton: UIButton!
    @IBOutlet weak var numberNineButton: UIButton!
    @IBOutlet weak var decimalButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var sumButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var deleteSymbolButton: UIButton!
    @IBOutlet weak var deleteAllButton: UIButton!
    @IBOutlet weak var showOperationsHistoryButton: UIButton!
    @IBOutlet weak var operationsHistoryView: UIView!
    @IBOutlet weak var numpadStackView: UIStackView!
    
    let disposeBag = DisposeBag()
    
    private var operation: Operations = .none
    private var historyData: [String] = []
    private var firstValue: Double?
    private var operationResult: Double?
    private var isEqualButtonTapped: Bool = false
    
    enum Operations: String {
        case sum = "+"
        case subtract = "-"
        case multiply = "*"
        case divide = "/"
        case none = ""
    }
    
    private var inputData = BehaviorRelay<String>(value: "0")
    private var history = BehaviorRelay<String>(value: "")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.title = "PAGE 2"
        showOperationsHistoryButton.frame.size.height = sumButton.frame.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        deleteSymbolButton.rx.tap
            .subscribe(onNext: { _ in
                if self.inputData.value.count > 1 {
                    self.inputData.accept(String(self.inputData.value.dropLast()))
                } else if self.inputData.value.count == 1, self.inputData.value.first != "0" {
                    self.inputData.accept("0")
                }
            })
            .disposed(by: disposeBag)
        
        deleteAllButton.rx.tap
            .subscribe(onNext: { _ in
                self.inputData.accept("0")
                self.operation = .none
                self.operationResult = nil
            })
            .disposed(by: disposeBag)
        
        showOperationsHistoryButton.rx.tap
            .subscribe(onNext: { _ in
                UIView.transition(with: self.view, duration: 0.3, options: .curveEaseIn, animations: {
                        self.operationsHistoryView.isHidden = !self.operationsHistoryView.isHidden
                        self.numpadStackView.isHidden = !self.numpadStackView.isHidden
                    })
            })
            .disposed(by: disposeBag)
        
        numberOneButton.rx.tap
            .subscribe(onNext: { _ in
                self.clearInput()
                
                if self.inputData.value == "0" {
                    self.inputData.accept("1")
                } else {
                    self.inputData.accept(self.inputData.value + "1")
                }
            })
            .disposed(by: disposeBag)
        
        numberTwoButton.rx.tap
            .subscribe(onNext: { _ in
                self.clearInput()
                
                if self.inputData.value == "0" {
                    self.inputData.accept("2")
                } else {
                    self.inputData.accept(self.inputData.value + "2")
                }
            })
            .disposed(by: disposeBag)
        
        numberThreeButton.rx.tap
            .subscribe(onNext: { _ in
                self.clearInput()
                
                if self.inputData.value == "0" {
                    self.inputData.accept("3")
                } else {
                    self.inputData.accept(self.inputData.value + "3")
                }
            })
            .disposed(by: disposeBag)
        
        numberFourButton.rx.tap
            .subscribe(onNext: { _ in
                self.clearInput()
                
                if self.inputData.value == "0" {
                    self.inputData.accept("4")
                } else {
                    self.inputData.accept(self.inputData.value + "4")
                }
            })
            .disposed(by: disposeBag)
        
        numberFiveButton.rx.tap
            .subscribe(onNext: { _ in
                self.clearInput()
                
                if self.inputData.value == "0" {
                    self.inputData.accept("5")
                } else {
                    self.inputData.accept(self.inputData.value + "5")
                }
            })
            .disposed(by: disposeBag)
        
        numberSixButton.rx.tap
            .subscribe(onNext: { _ in
                self.clearInput()
                
                if self.inputData.value == "0" {
                    self.inputData.accept("6")
                } else {
                    self.inputData.accept(self.inputData.value + "6")
                }
            })
            .disposed(by: disposeBag)
        
        numberSevenButton.rx.tap
            .subscribe(onNext: { _ in
                self.clearInput()
                
                if self.inputData.value == "0" {
                    self.inputData.accept("7")
                } else {
                    self.inputData.accept(self.inputData.value + "7")
                }
            })
            .disposed(by: disposeBag)
        
        numberEightButton.rx.tap
            .subscribe(onNext: { _ in
                self.clearInput()
                
                if self.inputData.value == "0" {
                    self.inputData.accept("8")
                } else {
                    self.inputData.accept(self.inputData.value + "8")
                }
            })
            .disposed(by: disposeBag)
        
        numberNineButton.rx.tap
            .subscribe(onNext: { _ in
                self.clearInput()
                
                if self.inputData.value == "0" {
                    self.inputData.accept("9")
                } else {
                    self.inputData.accept(self.inputData.value + "9")
                }
            })
            .disposed(by: disposeBag)
        
        zeroButton.rx.tap
            .subscribe(onNext: { _ in
                self.clearInput()

                if self.inputData.value.first != "0" {
                    self.inputData.accept(self.inputData.value + "0")
                }
            })
            .disposed(by: disposeBag)
        
        decimalButton.rx.tap
            .subscribe(onNext: { _ in
                if !self.inputData.value.contains(".") {
                    self.inputData.accept(self.inputData.value + ".")
                }
            })
            .disposed(by: disposeBag)
        
        inputData.observe(on: MainScheduler.instance)
            .subscribe(onNext: { inputData in
                self.inputLabel.text = inputData
            })
            .disposed(by: disposeBag)
        
        history.observe(on: MainScheduler.instance)
            .subscribe(onNext: { history in
                self.historyLabel.text = history
            })
            .disposed(by: disposeBag)
        
        sumButton.rx.tap
            .subscribe(onNext: { _ in
                if let value = Double(self.inputData.value) {
                    self.firstValue = value
                    self.inputData.accept("0")
                    self.operation = .sum
                }
            })
            .disposed(by: disposeBag)
        
        subtractButton.rx.tap
            .subscribe(onNext: { _ in
                if let value = Double(self.inputData.value) {
                    self.firstValue = value
                    self.inputData.accept("0")
                    self.operation = .subtract
                }
            })
            .disposed(by: disposeBag)
        
        multiplyButton.rx.tap
            .subscribe(onNext: { _ in
                if let value = Double(self.inputData.value) {
                    self.firstValue = value
                    self.inputData.accept("0")
                    self.operation = .multiply
                }
            })
            .disposed(by: disposeBag)
        
        divideButton.rx.tap
            .subscribe(onNext: { _ in
                if let value = Double(self.inputData.value) {
                    self.firstValue = value
                    self.inputData.accept("0")
                    self.operation = .divide
                }
            })
            .disposed(by: disposeBag)
        
        equalButton.rx.tap
            .subscribe(onNext: { _ in
                self.isEqualButtonTapped = true
                
                if let value = Double(self.inputData.value), let first = self.firstValue {
                    let second = value
                    
                    switch self.operation {
                    case .sum:
                        self.operationResult = first + second
                        self.firstValue = self.operationResult
                    case .subtract:
                        self.operationResult = first - second
                        self.firstValue = self.operationResult
                    case .multiply:
                        self.operationResult = first * second
                        self.firstValue = self.operationResult
                    case .divide:
                        if second == 0 {
                            self.presentAlert()
                        } else {
                            self.operationResult = first / second
                            self.firstValue = self.operationResult
                        }
                    case .none:
                        break
                    }
                    
                    if let result = self.operationResult {
                        self.inputData.accept(result.isInteger())
                    }
                    
                    self.setHistoryData(first, second)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func clearInput() {
        if isEqualButtonTapped {
            isEqualButtonTapped = false
            inputData.accept("")
        }
    }
    
    private func setHistoryData(_ first: Double, _ second: Double) {
        
        var result: String = ""
        
        if let res = self.operationResult {
            result = res.isInteger()
        }
        
        if self.history.value.count == 0 {
            self.history.accept("\(first.isInteger()) \(self.operation.rawValue) \(second.isInteger()) \n = \(result) \n")
        } else {
            self.history.accept(self.history.value + "\(first.isInteger()) \(self.operation.rawValue) \(second.isInteger()) \n = \(result) \n")
        }
    }
    
    private func presentAlert() {
        let alert = UIAlertController(title: "Внимание!", message: "Деление на 0 невозможно", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
