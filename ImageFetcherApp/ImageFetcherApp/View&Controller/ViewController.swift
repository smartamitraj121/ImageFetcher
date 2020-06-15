//
//  ViewController.swift
//  ImageFetcherApp
//
//  Created by Amit Kumar on 09/06/20.
//  Copyright © 2020 Amit Kumar. All rights reserved.
//

import UIKit
import Network

class ViewController: UIViewController {
    
    var imageFetcherTableView: UITableView!
    var imageFetcherVM: ImageFetcherViewModel?
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        imageFetcherTableView.rowHeight = UITableView.automaticDimension
        imageFetcherTableView.estimatedRowHeight = 120
        setupPullToRefresh()
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self?.imageFetcherTableView.isHidden = false
                }
                self?.getOutputData()
            } else {
                DispatchQueue.main.async {
                    self?.imageFetcherTableView.isHidden = true
                    self?.alert(message: "Internet is not available", title: "Network error")
                }
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    func setupPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        imageFetcherTableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        getOutputData()
    }
    private func setupUI() {
        imageFetcherTableView = UITableView()
        imageFetcherTableView.register(ImageCell.self, forCellReuseIdentifier: "myImgCell")
        imageFetcherTableView.delegate = self
        imageFetcherTableView.dataSource = self
        view.addSubview(imageFetcherTableView)
        imageFetcherTableView?.translatesAutoresizingMaskIntoConstraints = false
        imageFetcherTableView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        imageFetcherTableView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        imageFetcherTableView?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        imageFetcherTableView?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
    
    func getOutputData() {
        let url: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        APIManager.shared.getData(urlString: url) { [weak self] (result) in
            switch result {
            case .success(let imgData):
                self?.imageFetcherVM = ImageFetcherViewModel(model: imgData)
                DispatchQueue.main.async {
                    self?.title = self?.imageFetcherVM?.title
                    self?.imageFetcherTableView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            case .failure(let error):
                print(error)
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageFetcherVM?.imageFetcherData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myImgCell", for: indexPath as IndexPath) as! ImageCell
        cell.titleLbl.text = self.imageFetcherVM?.imageFetcherData[indexPath.row].title
        cell.descriptionLbl.text = self.imageFetcherVM?.imageFetcherData[indexPath.row].description
        if let imgUrl = self.imageFetcherVM?.imageFetcherData[indexPath.row].imageHref {
            cell.canadaImgView.imageFromURL(urlString: imgUrl)
            
        }
        cell.minHeight = 110
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


