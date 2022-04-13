//
//  OCRService.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 08/04/2022.
//

import Vision

protocol OCRServiceDescriptor {
    func detectText(in imageData: Data, completion: @escaping ([String]) -> Void) -> Void
}

class OCRService: OCRServiceDescriptor {

    func detectText(in imageData: Data, completion: @escaping ([String]) -> Void) {

        // Create a new image-request handler.
        let requestHandler = VNImageRequestHandler(data: imageData)

        // Create a new request to recognize text.
        let request = VNRecognizeTextRequest { request, error in
            let res = self.recognizeTextHandler(request: request, error: error)
            completion(res)
        }
//        request.minimumTextHeight = 18.0
        request.recognitionLevel = .accurate

        do {
            // Perform the text-recognition request.
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
    }

    private func recognizeTextHandler(request: VNRequest, error: Error?) -> [String] {
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            return []
        }

        let recognizedStrings = observations.compactMap { observation in
            // Return the string of the top VNRecognizedText instance.
            return observation.topCandidates(1).first?.string
        }
        return recognizedStrings
    }
}
