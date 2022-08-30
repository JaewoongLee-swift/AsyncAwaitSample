//
//  ViewController.swift
//  AsyncAwaitSample
//
//  Created by 이재웅 on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func didTapButton(_ sender: UIButton) {
        guard let url = URL(string: "https://reqres.in/api/users?page=2") else { return }
        
        //MARK: async/await를 사용하지 않을 경우
//        requestImageURL(requestURL: url) { [weak self] urlString in
//            guard let self = self else { return }
//            DispatchQueue.global().async {
//                guard let url = URL(string: urlString),
//                      let data = try? Data(contentsOf: url)
//                else { return }
//
//                DispatchQueue.main.async {
//                    self.imageView.image = UIImage(data: data)
//                }
//            }
//        }
        
        //MARK: async/await를 사용할 경우
        Task {
            guard let imageURL = try? await requestImageURL(requestURL: url),
                  let url = URL(string: imageURL),
                  let data = try? Data(contentsOf: url)
            else { return }
            
            imageView.image = UIImage(data: data)
        }
    }
    
    //MARK: async/await를 사용하지 않을 경우
//    func requestImageURL(requestURL: URL, completion: @escaping (String) -> Void) {
//        URLSession.shared.dataTask(with: requestURL) { data, response, _ in
//            guard let data = data,
//                  let httpResponse = response as? HTTPURLResponse,
//                  200..<300 ~= httpResponse.statusCode
//            else { return }
//
//            let decoder = JSONDecoder()
//            if let decoded = try? decoder.decode(SomeModel.self, from: data) {
//                completion(decoded.data.first?.avatar ?? "")
//            } else {
//                print("오류")
//            }
//        }.resume()
//    }
    
    //MARK: async/await를 사용할 경우
    func requestImageURL(requestURL: URL) async throws -> String {
        let (data, _) = try await URLSession.shared.data(from: requestURL)
        let imageURL = try JSONDecoder().decode(SomeModel.self, from: data).data.first?.avatar ?? ""
        
        return imageURL
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

