

import Foundation
import UIKit
import Kingfisher

class MainCollectionCell : UICollectionViewCell{
    static let reuseID = "mainCell"

    private lazy var imageView:UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()
    private lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Title"
        
        return titleLabel
    }()
    
    override func awakeFromNib() {
    }
    
      func setupUI(){
        self.contentView.addSubviews(imageView, titleLabel)
        

         self.imageView.snp.makeConstraints{
             $0.width.equalTo(50)
             $0.height.equalTo(50)
             $0.top.equalToSuperview()
             $0.left.equalToSuperview()
         }
         self.titleLabel.snp.makeConstraints{
             $0.top.equalToSuperview()
             $0.bottom.equalToSuperview()
             $0.left.equalTo(imageView.snp.right).offset(8)
             $0.right.equalToSuperview().offset(-10)
            // $0.right.equalTo(titleLabel.snp.right)
         }
    }
    
    func setData(searchResult:SearchResult){
        self.titleLabel.text = searchResult.title
        let url = URL(string: searchResult.images.downsized.url)
        self.imageView.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
    }
}
