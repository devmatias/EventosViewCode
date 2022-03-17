//
//  ResultViewController.swift
//  EventosViewCode
//
//  Created by Matias Correa Franco de Faria on 08/03/22.
//

import UIKit

class ResultViewController: UIViewController {

    static let identifier = "ResultViewController"
    
    let event: Event? = nil
    
    let screen: ResultView
    
    init() {
        screen = ResultView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    



}
