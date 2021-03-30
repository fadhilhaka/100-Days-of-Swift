//
//  ViewController.swift
//  FlagOfNation
//
//  Created by Fadhil Hanri on 30/03/21.
//

import UIKit
import Foundation

class ViewController: UITableViewController {
    
    let identifier = "Flag"
    let nationList = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flag of Nation"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 0.0, right: 8.0)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nationList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            cell.imageView?.image = UIImage(named: nationList[indexPath.row])
            cell.textLabel?.text = "\(nationList[indexPath.row].uppercased())"
            cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let flagVC = FlagViewController()
            flagVC.title = "\(identifier) of \(nationList[indexPath.row].uppercased())"
            flagVC.selectedNation = nationList[indexPath.row]
            flagVC.modalPresentationStyle = .overFullScreen
            flagVC.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(flagVC, animated: true)
    }
    
}

