//
//  EventTableViewCell.swift
//  EventosViewCode
//
//  Created by Matias Correa Franco de Faria on 07/03/22.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    static let identifier = "EventTableViewCell"
    
    var artImage: UIImageView = {
        let stringImage = "iTunesArtwork.png"
        let image = UIImage(named: stringImage)
        let view = UIImageView(image: image!)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EventTableViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(artImage)
        addSubview(myLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            artImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            artImage.heightAnchor.constraint(equalToConstant: 40),
            artImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            artImage.widthAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            myLabel.leadingAnchor.constraint(equalTo: artImage.trailingAnchor, constant: 10),
            myLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            myLabel.centerYAnchor.constraint(equalTo: artImage.centerYAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
    
    
}


