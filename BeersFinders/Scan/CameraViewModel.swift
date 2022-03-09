//
//  CameraViewController.swift
//  BeersFinders
//
//  Created by Louis Cauret on 16/02/2022.
//

import SwiftUI
import Vision

class CameraViewModel: ObservableObject {
    private func recognizeText(image: UIImage?){
        guard let cgImage = image?.cgImage else { return }
        
        //Handler
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        //Request
        let request = VNDetectRectanglesRequest { request, error in
            
        }
        //Process request
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}
