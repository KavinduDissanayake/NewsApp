//
//  SignUpVC.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-09.
//
import SwiftUI
import UIKit
import RxSwift
import RxCocoa


class SignUpVC: BaseVC {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nameErrorLbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordErrorLbl: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    
    
    let viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setUpUI()
        bindViewModel()
    }
    
     func setUpUI(){
         defaultBackBtn()
         let startColor = UIColor(red: 1, green: 0.23, blue: 0.27, alpha: 1)
         let endColor = UIColor(red: 1, green: 0.50, blue: 0.53, alpha: 1)
         signUpBtn.setGradientBackground(colorOne: startColor, colorTwo: endColor, cornerRadius: 20)
     }
    
    
    func bindViewModel() {
        // Bind user input to ViewModel
        nameTF.rx.text.orEmpty.bind(to: viewModel.name).disposed(by: disposeBag)
        emailTF.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: disposeBag)
        passwordTF.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        // Bind ViewModel output to the UI
        viewModel.nameError.bind(to: nameErrorLbl.rx.text).disposed(by: disposeBag)
        viewModel.emailError.bind(to: emailErrorLbl.rx.text).disposed(by: disposeBag)
        viewModel.passwordError.bind(to: passwordErrorLbl.rx.text).disposed(by: disposeBag)
        
        
        //Hide ans show
        viewModel.emailError.map { $0 == nil }.bind(to: emailErrorLbl.rx.isHidden).disposed(by: disposeBag)
        viewModel.passwordError.map { $0 == nil }.bind(to: passwordErrorLbl.rx.isHidden).disposed(by: disposeBag)
        
        
        // Handle submit action
        signUpBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.callAPI()
            })
            .disposed(by: disposeBag)
    }
    
    
    
    func callAPI(){
        //chek validation
        if !self.viewModel.validateAllFields() {
            return
        }
        
        //call api and get sueccss
        
    }
}


//MARK: PREVIEW
struct SignUpVC_Previews: PreviewProvider {
    static var previews: some View {
        guard let signUpVc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as? UIViewController else {
            fatalError("Cannot instantiate SampleTabBarController from Main.storyboard")
        }
        return UIViewControllerWrapper(viewController: signUpVc).ignoresSafeArea()
    }
}
