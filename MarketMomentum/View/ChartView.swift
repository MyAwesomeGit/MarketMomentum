
import SwiftUI

struct Point {
    var x: CGFloat
    var y: CGFloat
}

struct ChartView: View {
    var points: [Point]
    
    var body: some View {
        ZStack {
            Color(mainBackgroundColor)
                .edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                Path { path in
                    for i in stride(from: 1, to: points.count, by: 1) {
                        let currentPoint = points[i]
                        let previousPoint = points[i - 1]
                        // Adjust scaling for preview
                        let scaleX = geometry.size.width > 300 ? 1 : 0.5
                        let scaleY = geometry.size.height > 300 ? 1 : 0.5
                        path.move(to: CGPoint(x: previousPoint.x * scaleX, y: previousPoint.y * scaleY))
                        path.addLine(to: CGPoint(x: currentPoint.x * scaleX, y: currentPoint.y * scaleY))
                    }
                }
                .stroke(Color.green, lineWidth: 2)
            }
        }
    }
}


struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(points: [
            Point(x: 10, y: 50),
            Point(x: 30, y: 70),
            Point(x: 60, y: 40),
            Point(x: 90, y: 80),
            Point(x: 120, y: 70),
            Point(x: 150, y: 40),
            Point(x: 180, y: 80),
            Point(x: 210, y: 60),
            Point(x: 240, y: 60)
        ]).frame(height: 200)
    }
}
