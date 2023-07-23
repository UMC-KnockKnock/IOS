//
//  LoginSuccessView.swift
//  KnockKnock
//
//  Created by 다은 on 2023/07/08.
//

import UIKit
class LoginSuccessVC : UIViewController {
    
    var startBtn : UIButton = UIButton()
    
    let checkIMg : UIImageView = {
        let checkImg = UIImageView()
        let config = UIImage.SymbolConfiguration(paletteColors: [#colorLiteral(red: 0.9972829223, green: 0, blue: 0.4537630677, alpha: 1)])
        checkImg.image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: config)
        return checkImg
    }()
    
    let welcomeLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    let signInLabel : UILabel = {
        let label = UILabel()
        label.text = "회원가입 되었습니다."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let readHowtoUseBtn : UIButton = {
        let nextbtn = UIButton()
         var title = AttributedString("앱 사용법 익히기")
         title.font = UIFont.boldSystemFont(ofSize: 20)
         
         var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
         config.cornerStyle = .capsule
         config.attributedTitle = title
        config.baseForegroundColor = #colorLiteral(red: 0.9972829223, green: 0, blue: 0.4537630677, alpha: 1)
        config.background.strokeColor = #colorLiteral(red: 0.9972829223, green: 0, blue: 0.4537630677, alpha: 1)
         nextbtn.configuration = config
         return nextbtn
    }()

    
    
    
    var nickName: String = ""
    var sex: String = ""
    var birthday: String = ""
    var email: String = ""
    var password: String = ""
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigationBar()
        debugingFunction()
        makeSubView()
        makeConstraint()
        makeAddTarget()
        
    }
    
}

extension LoginSuccessVC {
    func makeSubView(){
        view.addSubview(checkIMg)
        view.addSubview(welcomeLabel)
        view.addSubview(signInLabel)
        view.addSubview(readHowtoUseBtn)
        startBtn = setNextBtn(view: self, title: "시작하기")
    }
    
    func makeConstraint(){
        checkIMg.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        readHowtoUseBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkIMg.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            checkIMg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 180),
            checkIMg.widthAnchor.constraint(equalToConstant: 90),
            checkIMg.heightAnchor.constraint(equalToConstant: 90),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: checkIMg.bottomAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            signInLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            signInLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 5),
            signInLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            signInLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            readHowtoUseBtn.bottomAnchor.constraint(equalTo: startBtn.topAnchor, constant: -10),
            readHowtoUseBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            readHowtoUseBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            readHowtoUseBtn.heightAnchor.constraint(equalToConstant: 50)
           
        ])
        
    }
    func makeAddTarget(){
        self.readHowtoUseBtn.addTarget(self, action: #selector(readHowtoUseFunc(_:)), for: .touchUpInside)
        self.startBtn.addTarget(self, action: #selector(startBtnFunc(_:)), for: .touchUpInside)
        
    }
    
    func debugingFunction(){
        // 데이터 가져오기
        if let nickNames = UserDefaults.standard.string(forKey: "nickName"),
           let sex = UserDefaults.standard.string(forKey: "sex"),
           let birthday = UserDefaults.standard.string(forKey: "birthday"),
           let email = UserDefaults.standard.string(forKey: "email"),
           let password = UserDefaults.standard.string(forKey: "password"){
            // 가져온 값 사용
            nickName=nickNames
        } else {
            // 저장된 데이터가 없을 경우 기본값 또는 처리할 로직 설정
            print("No data found.")
        }
        setName()
    }
    
    @objc func setName(){
        welcomeLabel.text = "\(nickName)님 환영합니다!"
        //nickName이 안뜸 흠
    }
    @objc func startBtnFunc(_: UIButton){
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true, completion: nil)
    }
    
    @objc func readHowtoUseFunc(_: UIButton){
        navigationController?.pushViewController(HowtouseVC(), animated: true)
    }
}
