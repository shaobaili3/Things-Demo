//
//  AstronautViewController.swift
//  homeProject
//
//  Created by SHAOBAI LI on 29.03.22.
//

import UIKit

class AstronautViewController: UIViewController  {

    var astronautViewModel: AstronautViewModel!
    var randomAstronaut: Int!

    private let thingsLabel: UILabel = {
        let thingsLabel = UILabel()
        thingsLabel.translatesAutoresizingMaskIntoConstraints = false
        thingsLabel.text = "THINGS"
        thingsLabel.font = UIFont.boldSystemFont(ofSize: 30)
        thingsLabel.textColor = .white
        return thingsLabel
    }()

    private let appLabel: UILabel = {
        let applabel = UILabel()
        applabel.translatesAutoresizingMaskIntoConstraints = false
        applabel.text = "The App"
        applabel.font = UIFont.boldSystemFont(ofSize: 18)
        applabel.textColor = .white
        return applabel
    }()

    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.layer.cornerRadius = 5.0
        backButton.backgroundColor = .white
        return backButton
    }()

    private let listTableView: UITableView = {
        let listTableView = UITableView()
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.separatorStyle = .none
        listTableView.backgroundColor = .clear
        return listTableView
    }()

    private let displayView: ThingView = {
        let displayView = ThingView()
        displayView.translatesAutoresizingMaskIntoConstraints = false
        return displayView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1568627059, green: 0.1568627059, blue: 0.1568627059, alpha: 1)
        setupBackground()
        setupViews()
        setupConstraints()
        randomAstronaut = astronautViewModel.getRandomAstronaut()
    }

    private func setupBackground() {
        let topPattern = UIBezierPath()
        topPattern.addArc(
            withCenter: CGPoint(x: 70, y: -(view.frame.width / 1.6)),
            radius: view.frame.width,
          startAngle: 0,
          endAngle: 2.0 * .pi,
          clockwise: false)
        var shapeLayer = CAShapeLayer()
        shapeLayer.path = topPattern.cgPath
        shapeLayer.fillColor = #colorLiteral(red: 0.3999999464, green: 0.3999999464, blue: 0.3999999464, alpha: 1)
        view.layer.addSublayer(shapeLayer)
        let bottomPattern = UIBezierPath()
        bottomPattern.addArc(
            withCenter: CGPoint(x: 50, y: view.frame.height + (view.frame.width / 1.4)),
            radius: view.frame.width,
          startAngle: 0,
          endAngle: 2.0 * .pi,
          clockwise: false)
        shapeLayer = CAShapeLayer()
        shapeLayer.path = bottomPattern.cgPath
        shapeLayer.fillColor = #colorLiteral(red: 0.3999999464, green: 0.3999999464, blue: 0.3999999464, alpha: 1)
        view.layer.addSublayer(shapeLayer)
    }

    private func setupViews() {
        view.addSubview(thingsLabel)
        view.addSubview(appLabel)
        view.addSubview(backButton)
        view.addSubview(listTableView)
        view.addSubview(displayView)

        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        backButton.addTarget(self, action: #selector(back(_ : )), for: .touchUpInside)
    }

    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()

        constraints.append(thingsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20))
        constraints.append(thingsLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20))

        constraints.append(appLabel.topAnchor.constraint(equalTo: thingsLabel.bottomAnchor, constant: 10))
        constraints.append(appLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20))

        constraints.append(backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20))
        constraints.append(backButton.widthAnchor.constraint(equalToConstant: 120))

        constraints.append(listTableView.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 70))
        constraints.append(listTableView.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -20))
        constraints.append(listTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25))
        constraints.append(listTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -5))

        constraints.append(displayView.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 70))
        constraints.append(displayView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 5))
        constraints.append(displayView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        constraints.append(displayView.heightAnchor.constraint(equalTo: displayView.widthAnchor))
        NSLayoutConstraint.activate(constraints)
    }

    @objc private func back(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension AstronautViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return astronautViewModel.astronauts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        cell.textLabel?.text = astronautViewModel.astronauts[indexPath.section].name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .white
        cell.tintColor = .black
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        cell.backgroundColor = #colorLiteral(red: 0.3999999464, green: 0.3999999464, blue: 0.3999999464, alpha: 1).toColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), percentage: CGFloat(indexPath.section * 100 / tableView.numberOfSections))
        cell.isUserInteractionEnabled = false
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let duration = indexPath.section==randomAstronaut ? 6 : Double.random(in: 0..<5)
        UIView.animate(withDuration: duration, delay: 0) {
            cell.alpha = 1
        } completion: { _ in
            if indexPath.section == self.randomAstronaut{
                    self.displayView.setTitle(title: self.astronautViewModel.astronauts[self.randomAstronaut].name)
            }
        }

    }
}
