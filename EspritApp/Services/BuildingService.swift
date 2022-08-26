//
//  BuildingService.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 19/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation

class BuildingService {
    let route = "buildings/"
    func getBuildings( callback: @escaping (Bool,[Building]?)->Void){
       
        guard let url = URL(string: baseUrl().url+route+"get/all") else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){
            data, response, error in
            DispatchQueue.main.async {
            if error == nil && data != nil{
                if (try? JSONSerialization.jsonObject(with: data!, options:[] ) as? [Any]) != nil{
                        let decoder = JSONDecoder()
                        do {
                            let test = try decoder.decode([Building].self, from: data!)
                            if test.count == 0{
                                callback(false,nil)
                            }else{
                                callback(true,test)
                            }
                        } catch  {
                            print(error)
                            callback(false,nil)
                        }
                    }
                    else{
                        callback(false,nil)
                    }
                }
               
            }
        }.resume()
    }
}
