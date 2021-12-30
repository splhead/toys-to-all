//
//  ViewController.swift
//  toysToAll
//
//  Created by Splhead on 23/12/21.
//

import UIKit
import Firebase

class ToyViewController: UIViewController {

    let collection = "Toys"

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var segmentedControlState: UISegmentedControl!
    @IBOutlet weak var textFieldDonorName: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    @IBOutlet weak var textViewAddress: UITextView!
    @IBOutlet weak var buttonSave: UIButton!
    
    var toy: Toy?
    lazy var firestore: Firestore = {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        
        let firestore = Firestore.firestore()
        firestore.settings = settings
        
        return firestore
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let toy = toy {
            title = "Edição"
            textFieldName.text = toy.name
            segmentedControlState.selectedSegmentIndex = toy.state
            textFieldDonorName.text = toy.donorName
            textFieldPhone.text = toy.phone
            textViewAddress.text = toy.address
        }
    }

    @IBAction func save(_ sender: UIButton) {
        guard let name = textFieldName.text, let donorName = textFieldDonorName.text, let phone = textFieldPhone.text, let address = textViewAddress.text else {
            print("error")
            return
            
        }
        
        let data: [String: Any] = [
            "name": name,
            "state": segmentedControlState.selectedSegmentIndex,
            "donorName": donorName,
            "phone": phone,
            "address": address
        ]
        
        
        if let toy = toy {
            firestore.collection(self.collection).document(toy.id).updateData(data)
            goBack()
        } else {
            print("no toy")
            print(data)
            var ref: DocumentReference? = nil
            ref = firestore.collection(self.collection).addDocument(data: data) { error in
                if let error = error {
                    print("Erro ao salvar \(error)")
                } else {
                    print("Brinquedo salvo \(ref!.documentID)")
                }
            }
            goBack()
        }
        
        
        
        
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

