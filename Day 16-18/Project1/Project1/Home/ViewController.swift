//
//  ViewController.swift
//  Project1
//
//  Created by Fadhil Hanri on 22/03/21.
//

import UIKit

class ViewController: UITableViewController {

    let fm = FileManager.default
    let identifier = "Picture"
    var pictureList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true

        guard let path = Bundle.main.resourcePath,
              let contents = try? fm.contentsOfDirectory(atPath: path)
        else { return }

        _ = contents.compactMap { if $0.hasPrefix("nssl") { pictureList.append($0) } }
        pictureList = pictureList.sorted()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictureList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            cell.textLabel?.text = "Picture \(indexPath.row + 1) of \(pictureList.count)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
            detailVC.title = identifier
            detailVC.selectedImage = pictureList[indexPath.row]
            detailVC.modalPresentationStyle = .overFullScreen
            detailVC.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

