//
//  ViewController.swift
//  RxSwiftDemoProject
//
//  Created by Bisma Soomro on 15/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var useNameTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
   // var validUserName = Observable<Bool>()
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let validUserName = useNameTxt.rx.text
            .observe(on: MainScheduler.asyncInstance)
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .map{ [weak self] in self?.isValidUserName(value: $0!)
            }
        validUserName.filter{$0 == true}
            .subscribe(onNext: {
            print($0!)
        }).disposed(by: bag)
        
        let validPassword = passwordTxt.rx.text.observe(on: MainScheduler.asyncInstance)
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .map{ [weak self] in self?.isValidPassword(value: $0!)}
        validPassword.subscribe(onNext: {
            print($0!)
        }).disposed(by: bag)
        
//            useNameTxt.rx.text
//            .observe(on: MainScheduler.asyncInstance)
//            .throttle(.seconds(2), scheduler: MainScheduler.asyncInstance)
//            .map{ [weak self] in self?.isValidUserName(value: $0!)}
//            .filter{$0 == true}
//            .subscribe(onNext: {
//            print($0!)
//        }).disposed(by: bag)
//
//        loginBtn.rx
//        .tap
//        .throttle(.seconds(5), scheduler: MainScheduler.asyncInstance)
//        .bind {
//            print("Login button did tapped")
//        }.disposed(by: bag)
        
    }

    func isValidUserName(value: String) -> Bool{
        return value.count > 4
    }
    
    func isValidPassword(value: String) -> Bool {
        return value.count > 4
    }
}

