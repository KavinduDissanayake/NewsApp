//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-10.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel:BaseVM {
    let email = BehaviorRelay<String?>(value: nil)
    let password = BehaviorRelay<String?>(value: nil)
    
    let emailError = BehaviorRelay<String?>(value: nil)
    let passwordError = BehaviorRelay<String?>(value: nil)
    
    let hasAttemptedToSubmit = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()

    override init() {
        super.init()
        
        email.asObservable()
            .skip(1)  // To skip initial value
            .subscribe(onNext: { [weak self] _ in
                if self?.hasAttemptedToSubmit.value == true {
                    self?.validateFields()
                }
            }).disposed(by: disposeBag)
        
        password.asObservable()
            .skip(1)
            .subscribe(onNext: { [weak self] _ in
                if self?.hasAttemptedToSubmit.value == true {
                    self?.validateFields()
                }
            }).disposed(by: disposeBag)
    }
    
    func validateAllFields() -> Bool {
        self.hasAttemptedToSubmit.accept(true)
        validateFields()
        return emailError.value == nil && passwordError.value == nil
    }

    
    func validateFields() {
        let emailValidity = Validators.isValidEmailValidator(value: email.value ?? "")
        let passwordValidity = Validators.isValidPasswordValidator(value: password.value ?? "")
        emailError.accept(emailValidity ? nil : "Invalid email format")
        passwordError.accept(passwordValidity ? nil : "Password should be at least 7 characters long")
    }

}
