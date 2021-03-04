//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Кирилл Тила on 20.02.2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titeLable: UILabel = {
        let label = UILabel()
        label.text = "Всё получится!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
     let precentLable: UILabel = {
        let label = UILabel()
        label.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
     let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.setProgress(HabitsStore.shared.todayProgress, animated: false)
        progressView.tintColor = UIColor(named: "Purple")
        progressView.trackTintColor = .systemGray2
        progressView.layer.masksToBounds = true
        progressView.layer.cornerRadius = 4
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContent()
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContent() {
        contentView.addSubview(bgView)
        bgView.addSubview(titeLable)
        
        bgView.addSubview(precentLable)
        bgView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titeLable.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 10),
            titeLable.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 12),
            
            precentLable.topAnchor.constraint(equalTo: titeLable.topAnchor),
            precentLable.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -12),
            
            progressView.topAnchor.constraint(equalTo: titeLable.bottomAnchor, constant: 10),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            progressView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -12),
            progressView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -15),
            
            
        ])

    }
    
}
