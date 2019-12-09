//
//  ViewController.swift
//  kijkdoos
//
//  Created by Collin Hemeltjen on 09/12/2019.
//  Copyright © 2019 Collin Hemeltjen. All rights reserved.
//

import UIKit
import RealityKit

class ViewController: UIViewController {

		let boxWalls: [(size: (	height: Float,
								width: Float,
								depth: Float),
						position: (	x: Float,
									y: Float,
									z: Float))] =
		[(size: (height: 0.40,
				 width: 0.25,
				 depth: 0.01),
		  position: (x: 0,
					 y: -0.20,
					 z:0.14)),
		 (size: (height: 0.40,
				width: 0.01,
				depth: 0.27),
		  position: (x: 0.11,
					y: -0.20,
					z: 0)),
		 (size: (height: 0.40,
				width: 0.21,
				depth: 0.01),
		 position: (x: 0,
					y: -0.21,
					z: -0.14)),
		 (size: (height: 0.40,
				width: 0.01,
				depth: 0.27),
		  position: (x: -0.11,
					y: -0.20,
					z: 0))
	]
    @IBOutlet var arView: ARView!
	let boxAnchor = try! Kijkdoos.loadScene()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
		generateOcculsionEntity()

	}

	func generateOcculsionEntity(){
		for boxWall  in boxWalls {
			let planeSize = boxWall.size
			let planeMesh = MeshResource.generateBox(width: planeSize.width,
													 height: planeSize.height,
													 depth: planeSize.depth)

			let material = OcclusionMaterial()

			let occlusionPlane = ModelEntity(mesh: planeMesh, materials: [material])

			let planePosition = boxWall.position
			occlusionPlane.position.x = planePosition.x
			occlusionPlane.position.y = planePosition.y
			occlusionPlane.position.z = planePosition.z

			arView.scene.anchors.first?.addChild(occlusionPlane)
		}
	}
}
