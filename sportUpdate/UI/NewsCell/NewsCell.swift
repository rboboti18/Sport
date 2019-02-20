//
//  NewsCell.swift
//  sportUpdate
//
//  Created by rboboti on 20/02/2019.
//  Copyright © 2019 rboboti. All rights reserved.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    fileprivate var presenter : NewsCellPresenter!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension NewsCell {
    
    func configure(with presenter:NewsCellPresenter){
        titleLabel.text       = presenter.title
        descriptionLabel.text = presenter.description
        
        guard
            let urlString = presenter.urlToImage
            else { return }
        
        addImage(with: urlString) 
    }
    
    func addImage(with url:String)
    {
        let urlImage = URL(string: url)
        articleImage.sd_setImage(with: urlImage, completed: nil)
    }
}


//MARK: - Helper Methods
extension NewsCell {
    public static var cellId: String {
        return "NewsCell"
    }
    
    public static var bundle: Bundle {
        return Bundle(for: NewsCell.self)
    }
    
    public static var nib: UINib {
        return UINib(nibName: NewsCell.cellId, bundle: NewsCell.bundle)
    }
    
    public static func register(with tableView: UITableView) {
        tableView.register(NewsCell.nib, forCellReuseIdentifier: NewsCell.cellId)
    }
    
    public static func loadFromNib(owner: Any?) -> NewsCell {
        return bundle.loadNibNamed(NewsCell.cellId, owner: owner, options: nil)?.first as! NewsCell
    }
    
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath, with presenter: NewsCellPresenter) -> NewsCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellId, for: indexPath) as! NewsCell
        cell.configure(with: presenter)
        return cell
    }
}
