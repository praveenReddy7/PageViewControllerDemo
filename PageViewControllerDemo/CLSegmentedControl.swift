//
//  CLSegmentedControl.swift
//  CLSegmentedControl
//
//  Created by praveen on 6/20/19.

import UIKit
let themeColor = UIColor(red: 0/255, green: 183/255, blue: 156/255, alpha: 1)

protocol ISegmentDelegate {
    func didSelectSegmentedControl(_ segmentedControl: CLSegmentedControl, at indexPath: IndexPath)
}

class CLSegmentedControl: UICollectionView {
    let title: [String]
    var selectedIndex = IndexPath(item: 0, section: 0)
    var segmentDelegate: ISegmentDelegate?
    
    init(title: [String]) {
        self.title = title
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        self.backgroundColor = .white
        self.delegate = self
        self.dataSource = self
        self.register(CLSegmentedControlCell.self, forCellWithReuseIdentifier: CLSegmentedControlCell.identifier)
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = themeColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectedTabBarChanged(to indexPath: IndexPath) {
        if let previousCell = self.cellForItem(at: indexPath) as? CLSegmentedControlCell {
            previousCell.setSelectedState(false)
        }
        
        guard let cell = self.cellForItem(at: indexPath) as? CLSegmentedControlCell else { return }
        self.selectedIndex = indexPath
        cell.setSelectedState(true)
        self.reloadData()
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension CLSegmentedControl: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath != selectedIndex else { return }
        segmentDelegate?.didSelectSegmentedControl(self, at: indexPath)
        self.selectedTabBarChanged(to: indexPath)
    }
}

extension CLSegmentedControl: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return title.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CLSegmentedControlCell.identifier, for: indexPath) as! CLSegmentedControlCell
        cell.titleLabel.text = title[indexPath.row].capitalized
        if self.selectedIndex == indexPath {
            cell.setSelectedState(true)
        } else {
            cell.setSelectedState(false)
        }
        return cell
    }
    
    
}

extension CLSegmentedControl: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class CLSegmentedControlCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let highlighter = UIView()
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = UIColor(red: 176/255, green: 235/255, blue: 226/255, alpha: 1)
        self.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        
        
        highlighter.translatesAutoresizingMaskIntoConstraints = false
        highlighter.backgroundColor = themeColor
        self.addSubview(highlighter)
        
        highlighter.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        highlighter.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        highlighter.heightAnchor.constraint(equalToConstant: 4.0).isActive = true
        highlighter.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    func setSelectedState(_ isSelected: Bool) {
        DispatchQueue.main.async {
            if isSelected {
                self.highlighter.backgroundColor = .orange
                self.titleLabel.textColor = .white
            } else {
                self.highlighter.backgroundColor = themeColor
                self.titleLabel.textColor = UIColor(red: 176/255, green: 235/255, blue: 226/255, alpha: 1)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.textColor = UIColor(red: 176/255, green: 235/255, blue: 226/255, alpha: 1)
        self.highlighter.backgroundColor = themeColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

