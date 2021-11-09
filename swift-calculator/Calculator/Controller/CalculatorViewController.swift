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
    @IBOutlet weak var dotButton: UIButton!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        showOperationsHistoryButton.frame.size.height = sumButton.frame.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        showOperationsHistoryButton.rx.tap
            .subscribe(onNext: { _ in
                UIView.transition(with: self.view, duration: 0.3, options: .curveEaseIn, animations: {
                        self.operationsHistoryView.isHidden = !self.operationsHistoryView.isHidden
                        self.numpadStackView.isHidden = !self.numpadStackView.isHidden
                    })
            })
            .disposed(by: disposeBag)
    }
}
