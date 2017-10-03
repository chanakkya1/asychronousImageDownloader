//
//  ImageViewController.swift
//  MoviesCollection
//
//  Created by chanakkya mati on 9/28/17.
//  Copyright © 2017 chanakya. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//      let album =  Album(collectionName: "Hiee", imageUrl: "https://i.ytimg.com/vi/lfVPPF0yI-8/maxresdefault.jpg", id: "lfVPPF0yI-8")
//       let operation = NetworkOperation(albumsStore: AlbumsStore(), album: album) { (image) in
//            self.imageView.image = image
//            print("Image Set")
//        }
//        
//        operation.completionBlock = {
//            print("operation completed")
//        }
//        let album2 =  Album(collectionName: "Hiee", imageUrl: "http://images4.fanpop.com/image/photos/21000000/SunSet-SunRise-sunsets-and-sunrises-21056738-1600-1200.jpg", id: "lfVPPF0yI-8ijk")
//        let operation1 = NetworkOperation(albumsStore: AlbumsStore(), album: album2) { (image) in
//            self.imageView2.image = image
//            print("Image Set for image 2")
//        }
//        operation1.completionBlock = {
//            print("operation1 completed")
//        }
//        
//        operation.completionBlock = {
//            print("operation completed")
//        }
//        
//       // operation1.addDependency(operation)
//        OperationQueue().addOperations([operation1,operation], waitUntilFinished: false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
