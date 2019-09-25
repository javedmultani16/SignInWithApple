//
//  ViewController.swift
//  SignInApple
//
//  Created by javedmultani16 on 25/09/2019.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let authorizationButton = ASAuthorizationAppleIDButton()
               authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
               self.view.addSubview(authorizationButton)
    }

    @objc func handleAuthorizationAppleIDButtonPress() {
         let appleIDProvider = ASAuthorizationAppleIDProvider()
         let request = appleIDProvider.createRequest()
         request.requestedScopes = [.fullName, .email]
           
         let authorizationController = ASAuthorizationController(authorizationRequests: [request])
         authorizationController.presentationContextProvider = self
         authorizationController.delegate = self
         authorizationController.performRequests()
       }
}
extension ViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
    
    let id:String = appleIDCredential.user
    let email:String = appleIDCredential.email ?? ""
    let lname:String = appleIDCredential.fullName?.familyName ?? ""
    let fname:String = appleIDCredential.fullName?.givenName ?? ""
    let name:String = fname + lname
    let appleId:String = appleIDCredential.identityToken?.base64EncodedString() ?? ""
    print(appleIDCredential.email)
    let result =  String("ID:\(id),\n Email:\(email),\n  Name:\(name),\n  IdentityToken:\(appleId)")
    print(result)
  }

  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return self.view.window!
  }
}

