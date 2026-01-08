//
//  DrawView.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 12/11/25.
//

import UIKit

class DrawView: UIView {
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        drawCircleBezier()
        
    }
    
    private func drawRectangle(_ context: CGContext, rect: CGRect) {
        let rectangle = CGRect(x: 1, y: 1, width: 100, height: 100)
        
        context.setFillColor(UIColor.systemBlue.cgColor)
        context.setLineWidth(1)
        
        context.addRect(rectangle)
        context.drawPath(using: .fillStroke)
    }
    
    private func drawCircle(_ context: CGContext, rect: CGRect) {
        let circle = CGRect(x: 1, y: 1, width: 100, height: 100)
        
        context.setFillColor(UIColor.systemBlue.cgColor)
        context.setLineWidth(1)
        
        context.addEllipse(in: circle)
        context.drawPath(using: .fillStroke)
    }
    
    private func drawTriangle(_ context: CGContext, rect: CGRect) {
        let triangle1 = CGPoint(x: 60, y: 1)
        let triangle2 = CGPoint(x: 110, y: 50)
        let triangle3 = CGPoint(x: 10, y: 50)
        
        context.beginPath()
        context.move(to: triangle1)
        context.addLine(to: triangle2)
        context.addLine(to: triangle3)
        context.closePath()
        
        context.drawPath(using: .fillStroke)
    }
    
    private func drawTriangleBezier() {
        let path = UIBezierPath()
        
        let triangle1 = CGPoint(x: 60, y: 1)
        let triangle2 = CGPoint(x: 110, y: 50)
        let triangle3 = CGPoint(x: 10, y: 50)
        
        path.move(to: triangle1)
        path.addLine(to: triangle2)
        path.addLine(to: triangle3)
        path.close()
        
        UIColor.systemCyan.setFill()
        
        path.fill()
    }
    
    private func drawCircleBezier() {
        let circle = CGRect(x: 1, y: 1, width: 100, height: 100)
        
        let path = UIBezierPath(ovalIn: circle)
        
        UIColor.systemMint.setFill()
        
        path.fill()
    }
    
}
