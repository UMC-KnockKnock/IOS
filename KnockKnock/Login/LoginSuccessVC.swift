//
//  LoginSuccessView.swift
//  KnockKnock
//
//  Created by 다은 on 2023/07/08.
//

import UIKit
class LoginSuccessVC : UIViewController {
    
    let checkIMg : UIImageView = {
       let checkImg = UIImageView()
        let config = UIImage.SymbolConfiguration(paletteColors: [#colorLiteral(red: 0.9972829223, green: 0, blue: 0.4537630677, alpha: 1)])
        checkImg.image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: config)
        return checkImg
    }()
    
    let firstLabel : UILabel = {
       let label = UILabel()
        label.text = "환영합니다!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    let secondLabel : UILabel = {
       let label = UILabel()
        label.text = "회원가입 되었습니다."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let startBtn : UIButton = {
       let startbtn = UIButton()
        startbtn.backgroundColor = #colorLiteral(red: 0.9972829223, green: 0, blue: 0.4537630677, alpha: 1)
        startbtn.setTitle("시작하기", for: .normal)
        startbtn.tintColor = .white
        startbtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        startbtn.layer.cornerRadius = 25
        return startbtn
    }()
    
    
    func makeSubView(){
        view.addSubview(checkIMg)
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        view.addSubview(startBtn)
    }
    
    func makeConstraint(){
        checkIMg.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
    secondLabel.translatesAutoresizingMaskIntoConstraints = false
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkIMg.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            checkIMg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 180),
            checkIMg.widthAnchor.constraint(equalToConstant: 90),
            checkIMg.heightAnchor.constraint(equalToConstant: 90),
            firstLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            firstLabel.topAnchor.constraint(equalTo: checkIMg.bottomAnchor, constant: 20),
            firstLabel.widthAnchor.constraint(equalToConstant: 40),
            firstLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            firstLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            secondLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 5),
            secondLabel.widthAnchor.constraint(equalToConstant: 40),
            secondLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            secondLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            startBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            startBtn.heightAnchor.constraint(equalToConstant: 50),
            startBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            startBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
        
    }
    
    func makeAddTarget(){
        self.startBtn.addTarget(self, action: #selector(nextView(_:)), for: .touchUpInside)
    }
    
    @objc func nextView(_: UIButton){
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
       self.present(tabBarController, animated: true, completion: nil)
        
        //시작 버튼 누르면 tabbarcontroller로 이동
        //방식 수정 필요
     
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigationBar()
        makeSubView()
        makeConstraint()
        makeAddTarget()
        
    }
}