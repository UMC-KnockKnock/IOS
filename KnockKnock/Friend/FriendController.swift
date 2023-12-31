//
//  FriendController.swift
//  KnockKnock
//
//  Created by 티모시 킴 on 2023/07/11.
//

import UIKit
import Tabman
import Pageboy

class FriendController: TabmanViewController {
    
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let topLine: UIView = {
        let topLine = UIView()
        topLine.backgroundColor = #colorLiteral(red: 0.9436392188, green: 0.9436392188, blue: 0.9436392188, alpha: 1)
        return topLine
    }()
    
    let bottomLine: UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = #colorLiteral(red: 0.9436392188, green: 0.9436392188, blue: 0.9436392188, alpha: 1)
        return bottomLine
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        self.navigationController?.navigationBar.topItem?.title = "내 찐친"
        self.view.backgroundColor = .white
        
        // TabmanViewController 설정
        self.dataSource = self
        
        // TabmanBar 설정
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .fit
        bar.backgroundView.style = .custom(view: barView)
        bar.buttons.customize { (button) in
            // 버튼 커스텀
            button.selectedTintColor = #colorLiteral(red: 1, green: 0.1719063818, blue: 0.4505617023, alpha: 1)
            button.tintColor = #colorLiteral(red: 0.787740171, green: 0.787740171, blue: 0.787740171, alpha: 1)
        }
        bar.indicator.tintColor = .clear
        bar.indicator.weight = .custom(value: 1.0)
        addBar(bar, dataSource: self, at: .top)
        
        makeSubView()
        makeConstraint()
        
    }
}

extension FriendController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return 2
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        
        switch index {
        case 0:
            return FriendListVC()
        case 1:
            return GroupVC()
        default:
            return nil
        }
        
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

extension FriendController: TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        if index == 0 {
            return TMBarItem(title: "찐친 목록")
        } else {
            return TMBarItem(title: "내 모임")
        }
    }
}

extension FriendController {
    func makeSubView() {
        barView.addSubview(topLine)
        barView.addSubview(bottomLine)
    }
    
    func makeConstraint() {
        topLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            topLine.topAnchor.constraint(equalTo: barView.topAnchor),
            topLine.leadingAnchor.constraint(equalTo: barView.leadingAnchor),
            topLine.trailingAnchor.constraint(equalTo: barView.trailingAnchor),
            topLine.heightAnchor.constraint(equalToConstant: 1.0),
            bottomLine.bottomAnchor.constraint(equalTo: barView.bottomAnchor),
            bottomLine.leadingAnchor.constraint(equalTo: barView.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: barView.trailingAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1.0),
        ])
    }
}
