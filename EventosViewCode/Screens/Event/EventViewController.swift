//
//  EventTableViewController.swift
//  EventosViewCode
//
//  Created by Matias Correa Franco de Faria on 07/03/22.
//

import UIKit

class EventViewController: UIViewController {

    var events: [Event]
    let screen: EventView
    let apiClient: EventManager

    init() {
        screen = EventView()
        events = []
        apiClient = EventManager()
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
        setupTableView()
        loadEvents()
    }
     
    func loadEvents() {
        apiClient.loadEvents { result in
            switch result {
            case .success(let events):
                self.events = events
                self.screen.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setupTableView() {
        screen.tableView.dataSource = self
        screen.tableView.delegate = self
        screen.tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.identifier)
    }
    
    
}

extension EventViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        let resultVC = ResultViewController()
        resultVC.screen.firstLabel.text = event.title
        resultVC.screen.secondLabel.text = event.description
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
}

extension EventViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as! EventTableViewCell
        let event = events[indexPath.item]
        cell.myLabel.text = event.title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
