//
//  ProductCell.swift
//  MyStore
//
//  Created by Igor Lungis on 12/1/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var price: UILabel!
    
    func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {

            let request = URLRequest(url: URL(string: url)!)
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }

                DispatchQueue.main.async {
                    completion(image)
                }
            }
            dataTask.resume()
    
    }
    
}
