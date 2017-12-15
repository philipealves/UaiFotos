//
//  TakePhotoViewController.swift
//  Uai Fotos
//
//  Created by João Paulo Scopus on 14/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//  Baseado no Artigo https://medium.com/@rizwanm/https-medium-com-rizwanm-swift-camera-part-1-c38b8b773b2
//

import UIKit
import AVFoundation
import Spring
import SwiftMessages

class TakePhotoViewController: UIViewController {

    
    @IBOutlet weak var queijoImageView: SpringImageView!
    @IBOutlet weak var previewPhoto: UIView!
    
    @IBOutlet weak var takePhotoButtom: RoundButton!
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOutput: AVCapturePhotoOutput?
    
    var lastFrameQueijo: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.queijoImageView.alpha = 0
        settingDevice()
     
    }
    func settingDevice(){
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            if let capturedDevice = captureDevice {
                let input = try AVCaptureDeviceInput(device: capturedDevice)
                captureSession = AVCaptureSession()
                captureSession?.addInput(input)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                videoPreviewLayer?.frame = previewPhoto.layer.bounds
                previewPhoto.layer.addSublayer(videoPreviewLayer!)
                captureSession?.startRunning()
                
                // Get an instance of ACCapturePhotoOutput class
                capturePhotoOutput = AVCapturePhotoOutput()
                capturePhotoOutput?.isHighResolutionCaptureEnabled = true
                // Set the output on the capture session
                captureSession?.addOutput(capturePhotoOutput!)
                
            }else{
                SwiftMessages.errorMessage(title: "Iniciar Camera", body: "Ixi, seu celulá num tem aquele trem que tira retratô soh")
            }
        } catch {
            SwiftMessages.errorMessage(title: "Iniciar Camera", body: "Ixi, seu celulá num tem aquele trem que tira retratô soh")
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func takeButtom(_ sender: SpringButton) {
        
        makePhoto()
        applyAnimationButton()
        
        
    }
    func makePhoto(){
        // Make sure capturePhotoOutput is valid
        guard let capturePhotoOutput = self.capturePhotoOutput else { return }
        // Get an instance of AVCapturePhotoSettings class
        let photoSettings = AVCapturePhotoSettings()
        // Set photo settings for our need
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .auto
        // Call capturePhoto method by passing our photo settings and a
        // delegate implementing AVCapturePhotoCaptureDelegate
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    func applyAnimationButton(){
        queijoImageView.animation = "pop"
        queijoImageView.force = 3.0
        queijoImageView.duration = 1.5
        queijoImageView.animate()
        
        queijoImageView.animateToNext {
            self.queijoImageView.animation = "fadeOut"
            self.queijoImageView.duration = 0
            self.queijoImageView.animateTo()
        }
    }
}
extension TakePhotoViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                     previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                 resolvedSettings: AVCaptureResolvedPhotoSettings,
                 bracketSettings: AVCaptureBracketedStillImageSettings?,
                 error: Error?) {
        
        // Make sure we get some photo sample buffer
        guard error == nil,
            let photoSampleBuffer = photoSampleBuffer else {
                print("Error capturing photo: \(String(describing: error))")
                return
        }
        // Convert photo same buffer to a jpeg image data by using // AVCapturePhotoOutput
        guard let imageData =
            AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer) else {
                return
        }
        // Initialise a UIImage with our image data
        let capturedImage = UIImage.init(data: imageData , scale: 1.0)
        if let image = capturedImage {
            // Save our captured image to photos album
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            
            let filterImage = FilterPhotoViewController()
            filterImage.imageTaked = image
            show(filterImage, sender: self)
        }
    }
}



