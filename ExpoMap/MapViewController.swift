//
//  MapViewController.swift
//  ExpoMap
//
//  Created by Yuri Romanov on 15.08.15.
//  Copyright (c) 2015 yurirom. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UIScrollViewDelegate
{
	
	@IBOutlet var scrollView: UIScrollView!
	
	@IBOutlet weak var ContentView: UIView!
	
	@IBOutlet weak var MapImageView: UIImageView!
	
	
	
//	var imageView: UIImageView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		scrollView.contentSize = MapImageView.image!.size

		var tapRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
		tapRecognizer.numberOfTapsRequired = 1
		tapRecognizer.numberOfTouchesRequired = 1
		scrollView.addGestureRecognizer(tapRecognizer)
		var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "handleDoubleTap:")
		doubleTapRecognizer.numberOfTapsRequired = 2
		doubleTapRecognizer.numberOfTouchesRequired = 1
		scrollView.addGestureRecognizer(doubleTapRecognizer)
		
		let pscale = min(self.view.frame.size.width / MapImageView.image!.size.width, self.view.frame.size.height / MapImageView.image!.size.height)
		
		scrollView.minimumZoomScale = pscale
		scrollView.maximumZoomScale = 5.0
		scrollView.zoomScale = 1.0
		
		for i in 0..<pavilions.count
		{
			let W = pavilions[i].W * pscale
			let H = pavilions[i].H * pscale
			pavilions[i].PicV.frame.size = CGSize(width: W, height: H)
			pavilions[i].PicV.backgroundColor = UIColor(red: 1, green: 0.6, blue: 0.2, alpha: 0.5)
			if selectedItem == i
			{
				pavilions[i].PicV.backgroundColor = UIColor(red: 1, green: 0.4, blue: 0.2, alpha: 0.8)
			}
			ContentView.addSubview(pavilions[i].PicV)
		}

		setPavilionsPositions(self.view.frame.size)
		
		// 6
		centerScrollViewContents()
		
	}
	
	override func viewWillTransitionToSize(size: CGSize,
		withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
	{
	//	Если решили повращать девайс - корректируем позиции объектов
		setPavilionsPositions(size)
	}
	
//	override func viewDidLayoutSubviews()
//	{
//		let scrollViewBounds = scrollView.bounds
//		
//		var scrollViewInsets = UIEdgeInsetsZero
////		scrollViewInsets.top = 64
////		scrollViewInsets.bottom = scrollViewBounds.size.height / 20
//		scrollView.contentInset = scrollViewInsets
//		scrollView.userInteractionEnabled = true
//	}
	// MARK: - Делегированные функции
	// MARK: -

	func handleDoubleTap(recognizer: UITapGestureRecognizer)
	{
		scrollView.zoomScale = 1.0
	}
	
	func handleTap(recognizer: UITapGestureRecognizer)
	{
		let p = recognizer.locationInView(ContentView)
		println("gesture: \(p.x)  \(p.y)  \(recognizer.numberOfTapsRequired)")
		for i in 0..<pavilions.count
		{
			dump(pavilions[i].PicV.frame)
			if CGRectContainsPoint(pavilions[i].PicV.frame, p)
			{
				if selectedItem >= 0
				{
					pavilions[i].PicV.backgroundColor = UIColor(red: 1, green: 0.6, blue: 0.2, alpha: 0.5)
				}
				selectedItem == i
				pavilions[i].PicV.backgroundColor = UIColor(red: 1, green: 0.4, blue: 0.2, alpha: 0.8)
				self.navigationItem.title = pavilions[i].Name
			}
		}
	}
//	func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
//		// 1
//		let pointInView = recognizer.locationInView(MapImageView)
//		
//		// 2
//		var newZoomScale = scrollView.zoomScale * 1.5
//		newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
//		
//		// 3
//		let scrollViewSize = scrollView.bounds.size
//		let w = scrollViewSize.width / newZoomScale
//		let h = scrollViewSize.height / newZoomScale
//		let x = pointInView.x - (w / 2.0)
//		let y = pointInView.y - (h / 2.0)
//		
//		let rectToZoomTo = CGRectMake(x, y, w, h);
//		
//		// 4
//		scrollView.zoomToRect(rectToZoomTo, animated: true)
//	}
	
	func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
	{
		return ContentView	//MapImageView
	}
	
	func scrollViewDidZoom(scrollView: UIScrollView)
	{
		centerScrollViewContents()
	}
	
	// MARK: - Прочие функции
	// MARK: -
	
	func setPavilionsPositions(size: CGSize)
	{
		let pscale = min(size.width / MapImageView.image!.size.width, size.height / MapImageView.image!.size.height)
		
		scrollView.minimumZoomScale = pscale
		scrollView.maximumZoomScale = 5.0
//		scrollView.zoomScale = 1.0
		
		let posMapX = (size.width - MapImageView.image!.size.width * pscale) / 2.0
//
		let posMapY = (size.height - MapImageView.image!.size.height * pscale) / 2.0
		println("ContentView.subviews.count: \(ContentView.subviews.count)")
		for i in 0..<pavilions.count
		{
			let X = pavilions[i].X * pscale + posMapX
			let Y = pavilions[i].Y * pscale + posMapY
			pavilions[i].PicV.center = CGPointMake(X, Y)
		}
		
//		for i in 0..<pavilions.count
//		{
//			let X = (pavilions[i].X - pavilions[i].W / 2.0) * pscale + posMapX
//			let Y = (pavilions[i].Y - pavilions[i].H / 2.0) * pscale + posMapY
//			let W = pavilions[i].W * pscale
//			let H = pavilions[i].H * pscale
//			let rect = CGRect(x: 0, y: 0, width: W, height: H)
//			let boxImage = UIImageView(frame: rect)
//			boxImage.backgroundColor = UIColor(red: 1, green: 0.5, blue: 0.4, alpha: 0.4)
//			if selectedItem == i
//			{
//				boxImage.backgroundColor = UIColor(red: 1, green: 0.3, blue: 0.2, alpha: 0.6)
//			}
//			println("boxImage: \(boxImage.frame.origin.x)  \(boxImage.frame.origin.y)  \(boxImage.layer.anchorPoint.x)  \(boxImage.layer.anchorPoint.y)")
//			ContentView.addSubview(boxImage)
//		}
	}
	
	func centerScrollViewContents()
	{
		let boundsSize = scrollView.bounds.size
		var contentsFrame = ContentView.frame
		
		if contentsFrame.size.width < boundsSize.width {
			contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
		} else {
			contentsFrame.origin.x = 0.0
		}
		
		if contentsFrame.size.height < boundsSize.height {
			contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
		} else {
			contentsFrame.origin.y = 0.0
		}
		
		ContentView.frame = contentsFrame
		
	}
}
