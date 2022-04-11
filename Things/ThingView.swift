//
//  thingView.swift
//  Things
//
//  Created by SHAOBAI LI on 11/4/2022.
//

import UIKit

class ThingView: UIView {

    private let chosenLabel: UILabel = {
        let chosenLabel = UILabel()
        chosenLabel.translatesAutoresizingMaskIntoConstraints = false
        chosenLabel.text = "Chosen Thing:"
        chosenLabel.font = UIFont.systemFont(ofSize: 15)
        chosenLabel.textColor = .white
        return chosenLabel
    }()


    private let titleLabel: UILabel = {
        let applabel = UILabel()
        applabel.translatesAutoresizingMaskIntoConstraints = false
        applabel.font = UIFont.boldSystemFont(ofSize: 26)
        applabel.text = "???"
        applabel.textColor = .white
        applabel.textAlignment = .center
        return applabel
    }()

    private func setupView() {
        backgroundColor = #colorLiteral(red: 0.3999999464, green: 0.3999999464, blue: 0.3999999464, alpha: 1)
        layer.cornerRadius = 5
        addSubview(chosenLabel)
        addSubview(titleLabel)
        var constraints = [NSLayoutConstraint]()
        constraints.append(titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor))
        constraints.append(titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor))
        constraints.append(titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor))
        constraints.append(chosenLabel.centerXAnchor.constraint(equalTo: centerXAnchor))
        constraints.append(chosenLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5))
        NSLayoutConstraint.activate(constraints)
    }

    func setTitle(title: String) {
        titleLabel.text = title
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
