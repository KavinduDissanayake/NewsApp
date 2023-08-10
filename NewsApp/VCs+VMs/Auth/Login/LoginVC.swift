//
//  LoginVC.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-09.
//
import SwiftUI
import UIKit
import RxSwift
import RxCocoa

class LoginVC: BaseVC {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hideKeyboardWhenTappedAround()
        bindViewModel()
        setUpUI()
      
    }
   
    func setUpUI(){
        defaultBackBtn()
    
        let startColor = UIColor(red: 1, green: 0.23, blue: 0.27, alpha: 1)
        let endColor = UIColor(red: 1, green: 0.50, blue: 0.53, alpha: 1)
        loginBtn.setGradientBackground(colorOne: startColor, colorTwo: endColor, cornerRadius: 20)
    }
    
    
    
    
    func bindViewModel() {
        // Bind user input to ViewModel
        emailTF.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: disposeBag)
        passwordTF.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        // Bind ViewModel output to the UI
        viewModel.emailError.bind(to: emailErrorLbl.rx.text).disposed(by: disposeBag)
        viewModel.passwordError.bind(to: passwordLbl.rx.text).disposed(by: disposeBag)
        
        viewModel.emailError.map { $0 == nil }.bind(to: emailErrorLbl.rx.isHidden).disposed(by: disposeBag)
        viewModel.passwordError.map { $0 == nil }.bind(to: passwordLbl.rx.isHidden).disposed(by: disposeBag)
        // Handle submit action
        loginBtn.rx.tap
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
struct LoginVC_Previews: PreviewProvider {
    static var previews: some View {
        let loginVC = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
        return UIViewControllerWrapper(viewController: loginVC).ignoresSafeArea()
    }
}
