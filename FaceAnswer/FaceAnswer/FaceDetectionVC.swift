//
//  FaceDetectionVC.swift
//  FaceAnswer
//
//  Created by Gozde Kahraman on 3.09.2021.
//

import AVFoundation
import UIKit
import Vision

class FaceDetectionVC: UIViewController {

    @IBOutlet var cameraView: UIView!
    
    var sequenceHandler = VNSequenceRequestHandler()

    let session = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    let dataOutputQueue = DispatchQueue(
      label: "video data queue",
      qos: .userInitiated,
      attributes: [],
      autoreleaseFrequency: .workItem)

    
    var roll: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCaptureSession()
        session.startRunning()
    }

}


// MARK: - Video Processing methods

extension FaceDetectionVC {
  func configureCaptureSession() {
    // Define the capture device we want to use
    guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera,
                                               for: .video,
                                               position: .front) else {
      fatalError("No front video camera available")
    }
    
    // Connect the camera to the capture session input
    do {
      let cameraInput = try AVCaptureDeviceInput(device: camera)
      session.addInput(cameraInput)
    } catch {
      fatalError(error.localizedDescription)
    }
    
    // Create the video data output
    let videoOutput = AVCaptureVideoDataOutput()
    videoOutput.setSampleBufferDelegate(self, queue: dataOutputQueue)
    videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
    
    // Add the video output to the capture session
    session.addOutput(videoOutput)
    
    let videoConnection = videoOutput.connection(with: .video)
    videoConnection?.videoOrientation = .portrait
    
    // Configure the preview layer
    previewLayer = AVCaptureVideoPreviewLayer(session: session)
    previewLayer.videoGravity = .resizeAspectFill
    previewLayer.frame = view.bounds
    cameraView.layer.insertSublayer(previewLayer, at: 0)
  }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate methods

extension FaceDetectionVC: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    // 1
    guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
      return
    }

    // 2
    let detectFaceRequest = VNDetectFaceRectanglesRequest(completionHandler: detectedFace)

    // 3
    do {
      try sequenceHandler.perform(
        [detectFaceRequest],
        on: imageBuffer,
        orientation: .leftMirrored)
    } catch {
      print(error.localizedDescription)
    }
  }
}

extension FaceDetectionVC {

  func detectedFace(request: VNRequest, error: Error?) {
    // 1
    guard
      let results = request.results as? [VNFaceObservation],
      let result = results.first
      else {
        return
    }
    roll = result.roll?.doubleValue ?? 0
    updateView()
   
    print("yaw angle: \(result.yaw?.doubleValue ?? 0)")
    print("roll angle: \(result.roll?.doubleValue ?? 0)")
    print("angle: \(result)")
  }
    
   @objc func updateView(){}
}

