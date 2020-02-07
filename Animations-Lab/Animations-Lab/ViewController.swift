//
//  ViewController.swift
//  AnimationsPractice
//
//  Created by Benjamin Stone on 10/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

enum AnimationStyles: String {
    case curveLinear = "curveLinear"
    case curveEaseIn = "curveEaseIn"
    case curveEaseOut = "curveEaseOut"
    case curveEaseInOut = "curveEaseInOut"
}

class ViewController: UIViewController {
    
    lazy var blueSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var animationStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0.1
        stepper.maximumValue = 5.0
        stepper.value = 0.3
        stepper.stepValue = 0.1
        stepper.addTarget(self, action: #selector(stepperButtonPressed(_:)), for: .touchUpInside)
        return stepper
    }()
    
    lazy var moveStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0.0
        stepper.maximumValue = 400.0
        stepper.value = 50.0
        stepper.stepValue = 20.0
        stepper.addTarget(self, action: #selector(moveStepperButtonPressed(_:)), for: .touchUpInside)
        return stepper
    }()
    
    var animationValue: Double = 0.3
    var movementValue: Double = 0.0
    var animationStyles = [AnimationStyles.curveLinear.rawValue, AnimationStyles.curveEaseIn.rawValue, AnimationStyles.curveEaseOut.rawValue, AnimationStyles.curveEaseInOut.rawValue]
    
    lazy var animationPicker: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    lazy var buttonStackView: UIStackView = {
       let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 30
        return buttonStack
    }()
    
    lazy var upButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareUp(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var downButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square down", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareDown(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move square left", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareLeft(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move square right", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareRight(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var blueSquareHeightConstaint: NSLayoutConstraint = {
        blueSquare.heightAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareWidthConstraint: NSLayoutConstraint = {
        blueSquare.widthAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareCenterXConstraint: NSLayoutConstraint = {
        blueSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }()
    
    lazy var blueSquareCenterYConstraint: NSLayoutConstraint = {
        blueSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        animationPicker.delegate = self
        animationPicker.dataSource = self
    }
    
    @IBAction func stepperButtonPressed(_ stepper: UIStepper){
        animationValue = stepper.value
    }
    
    @IBAction func moveStepperButtonPressed(_ stepper: UIStepper){
        movementValue = stepper.value
    }
    
    @IBAction func animateSquareLeft(sender: UIButton) {
        let oldOffet = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffet + CGFloat(movementValue)
        UIView.animate(withDuration: animationValue) {
            self.view.layoutIfNeeded()
        }
        print(animationValue)
    }
    
    @IBAction func animateSquareRight(sender: UIButton) {
        let oldOffet = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffet - CGFloat(movementValue)
        UIView.animate(withDuration: animationValue) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func animateSquareUp(sender: UIButton) {
        let oldOffset = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffset - CGFloat(movementValue)
        UIView.animate(withDuration: animationValue) { [unowned self] in
            self.view.layoutIfNeeded()
        }
                print(movementValue)
    }
    
    @IBAction func animateSquareDown(sender: UIButton) {
        let oldOffet = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffet + CGFloat(movementValue)
        UIView.animate(withDuration: animationValue) { [unowned self] in
            self.view.layoutIfNeeded()
        }
        
        print(movementValue)

    }
    
    private func addSubviews() {
        view.addSubview(blueSquare)
        addStackViewSubviews()
        view.addSubview(buttonStackView)
        view.addSubview(animationStepper)
        view.addSubview(moveStepper)
        view.addSubview(animationPicker)
    }
    
    private func addStackViewSubviews() {
        buttonStackView.addSubview(leftButton)
        buttonStackView.addSubview(rightButton)
        buttonStackView.addSubview(upButton)
        buttonStackView.addSubview(downButton)
    }
    
    private func configureConstraints() {
        constrainAnimationStepper()
        constrainMovementStepper()
        constrainAnimationPicker()
        constrainBlueSquare()
        constrainLeftButton()
        constraintRightButton()
        constrainUpButton()
        constrainDownButton()
        constrainButtonStackView()
    }
    
    private func constrainAnimationStepper() {
        animationStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationStepper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            animationStepper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    
    private func constrainMovementStepper() {
        moveStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moveStepper.topAnchor.constraint(equalTo: animationStepper.topAnchor, constant: 80),
            moveStepper.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func constrainAnimationPicker() {
        animationPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationPicker.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: 80),
            animationPicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            animationPicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func constrainUpButton() {
        upButton.translatesAutoresizingMaskIntoConstraints = false
        upButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        upButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        upButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor).isActive = true
        upButton.bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor).isActive = true
    }
    
    private func constrainDownButton() {
        downButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        downButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        downButton.bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor).isActive = true
    }
    
    private func constrainLeftButton() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        leftButton.bottomAnchor.constraint(equalTo: downButton.topAnchor, constant: -8).isActive = true
    }
    
    private func constraintRightButton() {
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        rightButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor).isActive = true
        rightButton.bottomAnchor.constraint(equalTo: upButton.topAnchor, constant: -8).isActive = true
    }
    
    private func constrainBlueSquare() {
        blueSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blueSquareHeightConstaint,
            blueSquareWidthConstraint,
            blueSquareCenterXConstraint,
            blueSquareCenterYConstraint
        ])
    }
    
    private func constrainButtonStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonStackView.heightAnchor.constraint(equalToConstant: 140),
            buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return animationStyles.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return animationStyles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let oneStyle = animationStyles[row]
        
        switch oneStyle{
        case "curveLinear":
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveLinear], animations: {
                self.blueSquare.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: nil)
        case "curveEaseIn":
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseIn], animations: {
                self.blueSquare.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: nil)
        case "curveEaseOut":
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                self.blueSquare.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: nil)
        case "curveEaseInOut":
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.blueSquare.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            }, completion: nil)
        default:
            return
        }
        
    }
    
    
}
