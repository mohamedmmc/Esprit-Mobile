//
//  TeacherService.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 22/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation
import Foundation

class TeacherService {
    
    let route = "teacher/"
    
    func getTeachersByPU(id:String, callback: @escaping (Bool,[Teacher]?)->Void){

        let queryItems = [URLQueryItem(name: "pu", value: id)]
        var urlComps = URLComponents(string: baseUrl().url+route+"getByPU")
        urlComps?.queryItems = queryItems
        var request = URLRequest(url: (urlComps?.url)!)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){
            data, response, error in
            DispatchQueue.main.async {
            if error == nil && data != nil{
                if (try? JSONSerialization.jsonObject(with: data!, options:[] ) as? [Any]) != nil{
                        let decoder = JSONDecoder()
                        do {
                            let test = try decoder.decode([Teacher].self, from: data!)
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
    
    func getResponsiblePU(callback: @escaping (Bool,[Teacher]?)->Void){

        
        let urlComps = URLComponents(string: baseUrl().url+route+"responsible/get")
        var request = URLRequest(url: (urlComps?.url)!)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){
            data, response, error in
            DispatchQueue.main.async {
            if error == nil && data != nil{
                if (try? JSONSerialization.jsonObject(with: data!, options:[] ) as? [Any]) != nil{
                        let decoder = JSONDecoder()
                        do {
                            let test = try decoder.decode([Teacher].self, from: data!)
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
