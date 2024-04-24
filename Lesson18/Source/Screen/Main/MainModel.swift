//
//  MainModel.swift
//  Lesson18
//
//  Created by user on 18.04.2024.
//

import Foundation

protocol MainModelOutput: AnyObject {
    
    func dataDidLoad(with urls: [String])
    func imageDataDidLoad(for indexPath: IndexPath)
}

protocol MainModelInput {
    
    func loadData()
    func getImageData(for url: String) -> Data?
    func loadData(for urlString: String, at indexPath: IndexPath)
}

class MainModel {
    
    weak var output: MainModelOutput!
    let dataService: DataService
    
    required init(output: MainModelOutput) {
        self.output = output
        self.dataService = DataService()
    }
}

// MARK: - MainModelInput
extension MainModel: MainModelInput {
    
    func loadData() {
        
        let imagesUrl = getUrls()
        output.dataDidLoad(with: imagesUrl)
    }
    
    func getImageData(for url: String) -> Data? {
        return dataService.readData(for: url)
    }
    
    func loadData(for urlString: String, at indexPath: IndexPath) {
       
        guard let url = URL(string: urlString) else { return }
       
        if let data = try? Data(contentsOf: url) {
            
            dataService.write(image: data, for: urlString)
            output.imageDataDidLoad(for: indexPath)
        }
    }
}

// MARK: - Private
private extension MainModel {

    func getUrls() -> [String] {

        return [
            "https://fastly.picsum.photos/id/3/200/200.jpg?hmac=N5yYUNYl5gOUcaMmTtnNNtx839TN2qaNM4SaXhQl65U",
            "https://fastly.picsum.photos/id/219/200/200.jpg?hmac=A55nsncpsnDAEPuZjs3_12i2n8HJNZ5-1SVCIN2fAgc",
            "https://fastly.picsum.photos/id/532/200/200.jpg?hmac=PPwpqfjXOagQmhd_K7H4NXyA4B6svToDi1IbkDW2Eos",
            "https://fastly.picsum.photos/id/78/200/200.jpg?hmac=P2qNtvmWActric-MfeYNdsN7YuChCioX-9CkJMNUYpk",
            "https://fastly.picsum.photos/id/1060/200/200.jpg?hmac=M0E6SK-_reDe8rAPtwDpww5ihTgL6yewgERGc7eX5z8",
            "https://fastly.picsum.photos/id/803/200/200.jpg?hmac=bVMK2xFyXtTrgCuUIozDz-mYxDZuDYFh-C_1LHZDKL4",
            "https://fastly.picsum.photos/id/699/200/200.jpg?hmac=ueGvLUyOnWJ67372C4BTRRWlSCkroP0AtC9mSrj1Cis",
            "https://fastly.picsum.photos/id/372/200/200.jpg?hmac=QFGGlcWGNWBK0oDD1jghIaCvGIFU5iJJcd2VhF5oH6o",
            "https://fastly.picsum.photos/id/253/200/200.jpg?hmac=_dceojr9yz5ZIKoye8I9HOqPCBHfn-jT9aRYdoLx1kQ",
            "https://fastly.picsum.photos/id/39/200/200.jpg?hmac=Q0ovKQ8Rm51WeQ057IqUXwL_1r7V0S8VtWwdZNpXW7E",
            "https://fastly.picsum.photos/id/612/200/200.jpg?hmac=HbIkwJ0QBqhSlGTi3bnF4JFTp9BntF-teQZUQhpqWyM",
            "https://fastly.picsum.photos/id/59/200/200.jpg?hmac=q9DbuoFh1L_NWnGk3AGdzuEOlg5bBW4JmBSgWmQdT74",
            "https://fastly.picsum.photos/id/24/200/200.jpg?hmac=Tw5b43UPAehS5e4JyB0qMQysvfLBmu_GZ_iafWou3m8",
            "https://fastly.picsum.photos/id/505/200/200.jpg?hmac=c295sjTIAZ_9Gj-PENrzAbATNIiWPL1dmhIhWndYnyo",
            "https://fastly.picsum.photos/id/568/200/200.jpg?hmac=WhQYW7EIDNOKVDzKmVpIoRPPwgeIbNL8YOGoTCcCI7o",
            "https://fastly.picsum.photos/id/228/200/200.jpg?hmac=o6k6dSrgAeHp1V6rxIjRR2cwEeu4DUs9Z1-sLxrQ878",
            "https://fastly.picsum.photos/id/299/200/200.jpg?hmac=ZG5bph3-p62DMNC1tvpW85v7Pd_rR1MCI-_elkQlG7M",
            "https://fastly.picsum.photos/id/397/200/200.jpg?hmac=3VBYe8NBAUuvEizTQB0-d8wp2jgqMblJK8vH3h8cslE",
            "https://fastly.picsum.photos/id/134/200/200.jpg?hmac=a3L-JjVSGeG8w3SdNpzxdh8WSC0xHJXgeD6QryCK7pU",
            "https://fastly.picsum.photos/id/661/200/200.jpg?hmac=pTRumV7JHMWLu9tuOU6quaMWqF-oxcymEOAvPNfXG4I",
            "https://fastly.picsum.photos/id/547/200/200.jpg?hmac=04fFD0MMF_hIH8HFysMTH_z8R7CwblctCIrBpdzouJs",
            "https://fastly.picsum.photos/id/557/200/200.jpg?hmac=Y3oVAxcM0NGQ6OBLGhCOaRI9_TBDXdJFB8547MBovxU",
            "https://fastly.picsum.photos/id/120/200/200.jpg?hmac=iqJko6IlBQjHPwKm31fa-KtEGqwtJfXohpfL0Y41EtQ",
            "https://fastly.picsum.photos/id/517/200/200.jpg?hmac=7n69zdD4qSZs14zMRZPUfLGKHFEIR9jTpoSEN1o990E",
            "https://fastly.picsum.photos/id/101/200/200.jpg?hmac=8aiHS9K78DvBexQ7ZROLuLizDR22o8CcjRMUhHbZU6g",
            "https://fastly.picsum.photos/id/817/200/200.jpg?hmac=c7RMfV0IboK5oZwkIxQ9Ofx8Bml5x-j42i9DKdKrTwo",
            "https://fastly.picsum.photos/id/174/200/200.jpg?hmac=drl_DcYoPvaGCAF7hzG6zjvSnt77TUxwZFQz_-FDLuI"
        ]
    }
}
