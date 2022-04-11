//
//  AstronautListViewController.swift
//  homeProject
//
//  Created by SHAOBAI LI on 26.03.22.
//

import UIKit

class AstronautListViewController: UIViewController {
    
    private var astronautsListViewModel = AstronautListViewModel()

    private let loadingIndicator:  UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.style = .large
        loadingIndicator.backgroundColor = .yellow
        loadingIndicator.startAnimating()
        return loadingIndicator
    }()

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

    private let nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.layer.cornerRadius = 5.0
        nextButton.backgroundColor = .white
        return nextButton
    }()
    
    private let listTableView: UITableView = {
        let listTableView = UITableView()
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.separatorStyle = .none
        listTableView.backgroundColor = .clear
        return listTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1568627059, green: 0.1568627059, blue: 0.1568627059, alpha: 1)
        setupBackground()
        setupViews()
        setupConstraints()
        astronautsListViewModel.astronautsObserver.bind { [weak self] astronautModels in
            self?.listTableView.reloadData()
            self?.astronautsListViewModel.updateChoosenAstronauts()
            self?.nextButton.isHidden = ((self?.astronautsListViewModel.isNext) ?? false)
        }
        astronautsListViewModel.loadList {
            self.loadingIndicator.isHidden = true
        }
        nextButton.addTarget(self, action: #selector(pressNextButton(_ : )), for: .touchUpInside)
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
        self.view.layer.addSublayer(shapeLayer)
        let bottomPattern = UIBezierPath()
        bottomPattern.addArc(
            withCenter: CGPoint(x: view.frame.width - 50, y: view.frame.height + (view.frame.width / 1.4)),
            radius: view.frame.width,
          startAngle: 0,
          endAngle: 2.0 * .pi,
          clockwise: false)
        shapeLayer = CAShapeLayer()
        shapeLayer.path = bottomPattern.cgPath
        shapeLayer.fillColor = #colorLiteral(red: 0.3999999464, green: 0.3999999464, blue: 0.3999999464, alpha: 1)
        self.view.layer.addSublayer(shapeLayer)
    }

    private func setupViews() {
        view.addSubview(loadingIndicator)
        view.addSubview(thingsLabel)
        view.addSubview(appLabel)
        view.addSubview(nextButton)
        view.addSubview(listTableView)
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
        
    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(loadingIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20))
        constraints.append(loadingIndicator.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20))
        constraints.append(thingsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20))
        constraints.append(thingsLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20))
        constraints.append(appLabel.topAnchor.constraint(equalTo: thingsLabel.bottomAnchor, constant: 10))
        constraints.append(appLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20))
        constraints.append(nextButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20))
        constraints.append(nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20))
        constraints.append(nextButton.widthAnchor.constraint(equalToConstant: 120))
        constraints.append(listTableView.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 70))
        constraints.append(listTableView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -70))
        constraints.append(listTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(listTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        NSLayoutConstraint.activate(constraints)
    }

    @objc private func pressNextButton(_ sender: UIButton) {
        let astronautViewController = AstronautViewController()
        astronautViewController.modalPresentationStyle = .fullScreen
        astronautViewController.astronautViewModel = AstronautViewModel(astronauts: astronautsListViewModel.choosenAstronauts)
        present(astronautViewController, animated: true)
    }
}

extension AstronautListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return astronautsListViewModel.astronautsObserver.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        cell.textLabel?.text = astronautsListViewModel.astronautsObserver.value[indexPath.section].astronaut.name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .white
        cell.tintColor = .black

        if astronautsListViewModel.astronautsObserver.value[indexPath.section].isChoosen {
            let accessoryConfiguration = UIImage.SymbolConfiguration(weight: .bold)
            let accessoryimage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: accessoryConfiguration)
            let accessoryView = UIImageView(image: accessoryimage)
            accessoryView.tintColor = .white
            cell.accessoryView = accessoryView
        }
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        cell.backgroundColor = #colorLiteral(red: 0.3999999464, green: 0.3999999464, blue: 0.3999999464, alpha: 1).toColor(#colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), percentage: CGFloat(indexPath.section * 100 / tableView.numberOfSections))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        astronautsListViewModel.astronautsObserver.value[indexPath.section].isChoosen.toggle()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}
