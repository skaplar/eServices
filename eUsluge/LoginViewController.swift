//
//  LoginViewController.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 8/29/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let loggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
        if loggedIn {
            self.performSegue(withIdentifier: "homeSegue", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        login() { success in
            if success {
                self.performSegue(withIdentifier: "homeSegue", sender: self)
            } else {
                let alert = UIAlertController(title: "Not found!", message: "Incorrect credentials!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        /*
        if emailTextField.text == "pera@pera.com" && passwordTextField.text == "pera" {
         performSegue(withIdentifier: "homeSegue", sender: self)
        } else {
            let alert = UIAlertController(title: "Not found!", message: "Incorrect credentials!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }*/
    }
    
    func login(completion: @escaping (Bool) -> Void) {
            let putanja = "http://localhost:3000/users/login"
            let newH: [String: Any] = [
                "username" : emailTextField.text,
                "password" : passwordTextField.text
            ]
            Alamofire.AF.request(putanja, method: .post, parameters: newH,
                              encoding: JSONEncoding.default)
                .responseJSON { response in
                    print("jeste")
                    guard response.error == nil else {
                        // got an error in getting the data, need to handle it
                        print("error")
                        print(response.error!)
                        completion(false)
                        return
                    }
                    
                    // unwrap JSON
                    guard let json = response.value as? [String: Any] else {
                        print("No JSON")
                        // Could not get JSON
                        completion(false)
                        return
                    }
                    
                    // Ovo mozda drugacije da se uradi, uglavnom ako su netacni modaci msg ce biti != nil
                    if json["message"] != nil {
                        completion(false)
                    }
                    
                    print(json)
                    UserDefaults.standard.set(true, forKey: "loggedIn") //Bool
                    UserDefaults.standard.set(json["username"], forKey: "username") //Bool
                    UserDefaults.standard.set(json["password"], forKey: "password")  //Integer
                    UserDefaults.standard.set(json["_id"], forKey: "_id") //setObject
                    UserDefaults.standard.set(json["email"], forKey: "email") //setObject
                    completion(true)
                    
                    /*
                    do {
    //                    "Iz nekog razloga moram da decodujem podatke u model koji imam. Pa onda to tek da kodujem u json i da stavim u user defaults inace ne radi!"
                        let model = try JSONDecoder().decode(ClientFromServer.self, from: response.data!)
                        let encoder = JSONEncoder()
                        if let encoded = try?
                            encoder.encode(model) {
                            completion(true)
                            UserDefaults.standard.set(encoded, forKey: "currentUser")
//                            self.userData.client = model
                        }
                    } catch let jsonErr {
                        print("failed to decode, \(jsonErr)")
                        print(json["message"]!)
                        completion(false)
                    }
 */
            }
        }
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
