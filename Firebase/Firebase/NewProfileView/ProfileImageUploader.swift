//
//  ProfileImageUploader.swift
//  FirebaseTest
//
//  Created by swft on 5/8/23.
//
import Foundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import UIKit

class ProfileImageUploader {
    
    private let storageRef = Storage.storage().reference()
    private let dbRef = Database.database().reference()
    
    func uploadProfileImage(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(.failure(ProfileImageUploaderError.userNotSignedIn))
            return
        }
        
        let imageRef = storageRef.child("profile_images/\(userId).jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(ProfileImageUploaderError.invalidImageData))
            return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            guard let metadata = metadata else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(ProfileImageUploaderError.unknownError))
                }
                return
            }
            
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(ProfileImageUploaderError.unknownError))
                    }
                    return
                }
                
                let userRef = self.dbRef.child("users/\(userId)")
                userRef.updateChildValues(["profileImageUrl": downloadURL.absoluteString]) { (error, dbRef) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(downloadURL))
                    }
                }
            }
        }
    }
    
    enum ProfileImageUploaderError: Error {
        case userNotSignedIn
        case invalidImageData
        case unknownError
    }
}
