//
//  ViewController.swift
//  CryptoNest
//
//  Created by yekta on 9.02.2024.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var cryptoVM = CryptoViewModel()
    let disposeBag = DisposeBag()
    var cryptoList = [Crypto]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        setupBindings()
        cryptoVM.requestData()
    }
    
    private func setupBindings(){
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorStr in
                print(errorStr)
            }
            .disposed(by: disposeBag)
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptos in
                self.cryptoList = cryptos
                self.tableView.reloadData()
            }.disposed(by: disposeBag)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptoList[indexPath.row].currency
        content.secondaryText = cryptoList[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
    
}

