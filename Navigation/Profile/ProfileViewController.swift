//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ilya on 14.02.2022.
//

import UIKit

struct Post {
    let imageName: String
    let author: String
    let description: String
    let likes: String
    let views: String
}

let post1 = Post(imageName: "ASB", author: "Виталий Красновид", description: "Флорентийскому ассасину Рим очень понравился. Впервые в городе, а его встречает сам папа римский, что-то бормочущий о мировом господстве! Побегали по тайным комнатам, подрались на кулаках, да еще и с богиней встретились — после такого теплого приема грех не заглянуть сюда еще раз.", likes: "280", views: "400")
let post2 = Post(imageName: "ME1", author: "Тимур Хорев", description: "С первых секунд игра кажется смутно знакомой. Возможно, дело в типажах — вот сам герой с внешностью голливудского спасителя мира, вот старый вояка — отец солдатам, вот пилот от бога — носит бейсболку и постоянно язвит, но посмотрите, как он водит «Нормандию» !", likes: "445", views: "503")
let post3 = Post(imageName: "DAO", author: "Андрей Ленский", description: "Скажем прямо: в игровой механике расам уделено мало значения. Четыре плюсика к характеристикам — это смешно, вы за каждый уровень будете получать по +3, а всего этих уровней 20. Вот разве что гномы — которым запрещено быть магами — получают в качестве компенсации 10%-ный шанс отразить вражеские чары. Приятно, но 10% — не та вероятность, на которую стоит полагаться.", likes: "239", views: "245")
let post4 = Post(imageName: "TW1", author: "Михаил Иванов", description: "Банки, склянки, пробирки — казалось бы, скорее удел почтенного профессора (быть может, сумасшедшего), а не храброго воина. Но ведьмак — все же не обычный рубака, да и задачи перед ним стоят не тривиальные; его враги обычному человеку не под силу. Вот и приходится не только уметь, но и знать куда больше, чем можно было бы предположить на первый взгляд. И все эти необходимые знания после острого приступа смерти приходится получать заново нелегким трудом.", likes: "146", views: "304")


final class ProfileViewController: UIViewController {
    
    let postCellID = "postCell"
    let photosCellID = "photosCell"
    
    var posts = [post1, post2, post3, post4]
    
    //var photos = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4")]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    /*
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 8
        return layout
    }()
    
    private lazy var photosCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosTableViewCell.self, forCellWithReuseIdentifier: "PhotosCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        activateConstraints()
        
    }
    
    func setupTableView() {
        self.view.backgroundColor = .white
        navigationItem.title = "Custom Cell"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: postCellID)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: photosCellID)
    }
    
    func activateConstraints() {
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        tableView.reloadData()
    }
    
}

extension ProfileViewController: UITableViewDelegate { }

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let photosCell = tableView.dequeueReusableCell(withIdentifier: photosCellID, for: indexPath)
            return photosCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: postCellID, for: indexPath) as! PostTableViewCell
            let post = posts[indexPath.row - 1]
            cell.post = post
            return cell
        }
    }
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 150
        default:
            tableView.rowHeight = UITableView.automaticDimension
            return tableView.rowHeight
        }
    }
    */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let photosVC = PhotosViewController()
            navigationController?.pushViewController(photosVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count + 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ProfileHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 270
    }
    /*
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    */
}

