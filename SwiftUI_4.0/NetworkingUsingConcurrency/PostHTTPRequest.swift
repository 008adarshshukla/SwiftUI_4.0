//
//  PostHTTPSRequest.swift
//  SwiftUI4.0
//
//  Created by Adarsh Shukla on 23/01/23.
//

import SwiftUI

struct PostHTTPSRequest: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PostHTTPSRequest_Previews: PreviewProvider {
    static var previews: some View {
        PostHTTPSRequest()
    }
}

/*
 let session = URLSession.shared
         let url = "http://...."
         let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
         request.httpMethod = "POST"
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         var params :[String: Any]?
         params = ["Some_ID" : "111", "REQUEST" : "SOME_API_NAME "]
         do{
             request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
             let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                 if let response = response {
                     let nsHTTPResponse = response as! HTTPURLResponse
                     let statusCode = nsHTTPResponse.statusCode
                     print ("status code = \(statusCode)")
                 }
                 if let error = error {
                     print ("\(error)")
                 }
                 if let data = data {
                     do{
                         let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                         print ("data = \(jsonResponse)")
                     }catch _ {
                         print ("OOps not good JSON formatted response")
                     }
                 }
             })
             task.resume()
         }catch _ {
             print ("Oops something happened buddy")
         }
 */
