//
//  ViewController.swift
//  CameraCapture
//
//  Created by Matt Hayes on 2/16/18.
//  Copyright © 2018 uShip. All rights reserved.
//
import Foundation
import AVFoundation
import UIKit

class ViewController : UIViewController {
    let captureSession = AVCaptureSession()
    let photoOutput = AVCapturePhotoOutput()
    let cameraPreview = UIView(frame: .zero)
    let progressIndicator = ProgressIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVideoPreview()
        
        do {
            try setupCaptureSession()
        } catch {
            let errorMessage = String(describing:error)
            print("[--ERROR--]: \(#file):\(#function):\(#line): " + errorMessage)
            alert(title: "Error", message: errorMessage)
        }
    }
    
    private func setupCaptureSession() throws {
        let deviceDiscovery = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.back)
        let devices = deviceDiscovery.devices
        
        guard let captureDevice = devices.first else {
            let errorMessage = "No camera available"
            print("[--ERROR--]: \(#file):\(#function):\(#line): " + errorMessage)
            alert(title: "Error", message: errorMessage)
            return
        }
        
        let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
        captureSession.addInput(captureDeviceInput)
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        captureSession.startRunning()
        
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        }
    }
    
    private func setupVideoPreview() {
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.bounds = view.bounds
        previewLayer.position = CGPoint(x:view.bounds.midX, y:view.bounds.midY)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        cameraPreview.layer.addSublayer(previewLayer)
        cameraPreview.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(capturePhoto)))
        
        cameraPreview.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cameraPreview)
        
        let viewsDict = ["cameraPreview":cameraPreview]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[cameraPreview]-0-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[cameraPreview]-0-|", options: [], metrics: nil, views: viewsDict))
        
    }
    
    @objc func capturePhoto(_ sender: UITapGestureRecognizer) {
        progressIndicator.add(toView: view)
        let photoOutputSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])
        photoOutput.capturePhoto(with: photoOutputSettings, delegate: self)
    }
    
    func saveToPhotosAlbum(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(photoWasSavedToAlbum), nil)
    }
    
    @objc func photoWasSavedToAlbum(_ image: UIImage, _ error: Error?, _ context: Any?) {
        alert(message: "Photo saved to device photo album")
    }
    
    func alert(title: String?=nil, message:String?=nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated:true)
    }
    
}

extension ViewController : AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard  let photoData = photo.fileDataRepresentation() else {
            let errorMessage = "Photo capture did not provide output data"
            print("[--ERROR--]: \(#file):\(#function):\(#line): " + errorMessage)
            alert(title: "Error", message: errorMessage)
            return
        }
        
        guard let image = UIImage(data: photoData) else {
            let errorMessage = "could not create image to save"
            print("[--ERROR--]: \(#file):\(#function):\(#line): " + errorMessage)
            alert(title: "Error", message: errorMessage)
            return
        }
        
        saveToPhotosAlbum(image)
        
        progressIndicator.hide()
    }
    
}




