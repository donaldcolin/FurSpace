//
//  UploadRequestViewModel.swift
//  FurSpace
//
//  Created by Donald Colin on 02/10/24.
//

import Foundation
import Firebase
import FirebaseAuth

class UploadRequestViewModel: ObservableObject {
    
    @Published  var dateFrom = Date()
    @Published var dateTo = Date()
    @Published  var caption = ""
    
    func uploadRequest(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let reqRef = Firestore.firestore().collection("requests").document()
        let request = Request(id: reqRef.documentID, ownerUID: uid, caption: caption, likes: 0, timestamp: Timestamp(), datefrom: dateFrom, dateTo: dateTo)
        guard let encodedReq = try? Firestore.Encoder().encode(request) else { return }
        try await reqRef.setData(encodedReq)
        
        
    }
}
