//
//  ViewController.swift
//  ApiCalls
//
//  Created by Amruta on 05/07/19.
//  Copyright © 2019 Bhargavi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var serverData:Welcome!
//    var idArray=[Int]()
//    var titleArray=[String]()

    @IBOutlet weak var userTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
func apiCall()
{
//    var urlRequest=URLRequest(url: URL(string:"https://gateway.marvel.com:443/v1/public/comics?limit=20&offset=0&apikey=648d15153a4fd0e135f9be961e0100fc")!)
//    urlRequest.httpMethod="GET"
////    let parms=["Content-Type":"application/json; charset=utf-8"]
////    urlRequest.allHTTPHeaderFields=parms
//    URLSession.shared.dataTask(with: urlRequest) { (data, resp, error) in
//        print(data!)
//        do
//        {
//           self.serverData = try JSONDecoder().decode(Welcome.self, from: data!)
//            DispatchQueue.main.async {
//                print(self.serverData)
//                self.userTV.reloadData()
//
//            }
//        }
//        catch{
//            print(error.localizedDescription)
//        }
//
//    }
//    .resume()
    var urlRequest=URLRequest(url: URL(string: "https://gateway.marvel.com:443/v1/public/comics?limit=20&offset=0&apikey=648d15153a4fd0e135f9be961e0100fc")!)
    urlRequest.httpMethod="GET"
    URLSession.shared.dataTask(with: urlRequest) { (data, resp, error) in
        print(data!)
        do{
            var convertedData=try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(convertedData!)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    .resume()
    }

    
    
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serverData?.data.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "abc") as! TableViewCell
        cell.idLabel.text="\(serverData.data.results[indexPath.row].id)"
        cell.titleLabel.text=serverData.data.results[indexPath.row].title
        print("\(serverData.data.results[indexPath.row].id)")
        print(serverData.data.results[indexPath.row].title)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func viewWillAppear(_ animated: Bool) {
       apiCall()
    }
}
