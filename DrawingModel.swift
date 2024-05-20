import Foundation
import SwiftUI

struct DrawingShape {
    var path: Path

    static func rectangle(startPoint: CGPoint, endPoint: CGPoint) -> DrawingShape {
        let rect = CGRect(origin: startPoint, size: CGSize(width: endPoint.x - startPoint.x, height: endPoint.y - startPoint.y))
        let path = Path(rect)
        return DrawingShape(path: path)
    }

    static func circle(startPoint: CGPoint, endPoint: CGPoint) -> DrawingShape {
        let rect = CGRect(origin: startPoint, size: CGSize(width: endPoint.x - startPoint.x, height: endPoint.y - startPoint.y))
        let path = Path(ellipseIn: rect)
        return DrawingShape(path: path)
    }
}

class DrawingModel: ObservableObject {
    @Published var paths: [DrawingPath] = []
    @Published var currentPath: DrawingPath = DrawingPath(points: [], lineWidth: 2)
    @Published var toolType: ToolType = .pencil
    @Published var isDrawing: Bool = false
    @Published var selectionRect: CGRect?
    var lineWidth: CGFloat = 2
    var selectedPaths: Set<DrawingPath> = []
    private var startPoint: CGPoint?

    func addPoint(_ point: CGPoint) {
        switch toolType {
        case .pencil, .line:
            handlePencilAndLineTool(point)
        case .eraser:
            removePath(at: point)
        case .rectangle, .circle:
            if !isDrawing {
                startDrawing(at: point)
            }
            updateCurrentShape(point)
        case .select:
            if isDrawing {
                selectionRect = CGRect(origin: startPoint!, size: CGSize(width: point.x - startPoint!.x, height: point.y - startPoint!.y))
                selectedPaths = selectPathsInRect(selectionRect!)
            } else {
                startDrawing(at: point)
            }
        }
    }

    private func handlePencilAndLineTool(_ point: CGPoint) {
        switch toolType {
        case .pencil:
            currentPath.points.append(CGPointHashable(point))
        case .line:
            if isDrawing {
                currentPath.points.append(CGPointHashable(point))
            } else {
                currentPath = DrawingPath(points: [CGPointHashable(point)], lineWidth: lineWidth)
                isDrawing = true
            }
        default:
            break
        }
    }

    private func updateCurrentShape(_ point: CGPoint) {
        guard let startPoint = startPoint else { return }
        var shape: DrawingShape?
        switch toolType {
        case .rectangle:
            shape = DrawingShape.rectangle(startPoint: startPoint, endPoint: point)
        case .circle:
            shape = DrawingShape.circle(startPoint: startPoint, endPoint: point)
        default:
            break
        }
        if let shape = shape {
            currentPath = DrawingPath(path: shape.path, lineWidth: lineWidth)
        }
    }

    func startDrawing(at point: CGPoint) {
        startPoint = point
        isDrawing = true
        if toolType == .rectangle || toolType == .circle || toolType == .line {
            currentPath = DrawingPath(points: [], lineWidth: lineWidth)
        }
    }

    func endDrawing(at point: CGPoint) {
        if toolType == .rectangle || toolType == .circle {
            updateCurrentShape(point)
            paths.append(currentPath)
        } else if toolType == .pencil {
            paths.append(currentPath)
            currentPath = DrawingPath(points: [], lineWidth: lineWidth)
        } else if toolType == .line {
            paths.append(currentPath)
            currentPath = DrawingPath(points: [], lineWidth: lineWidth)
        }
        isDrawing = false
        startPoint = nil
    }

    func removePath(at point: CGPoint) {
        for (index, path) in paths.enumerated().reversed() {
            let pathPoints = path.points.map { $0.point }
            let pathBoundingRect = pathPoints.boundingRect
            if pathBoundingRect.contains(point) {
                paths.remove(at: index)
                break
            }
        }
    }

    func selectPathsInRect(_ rect: CGRect) -> Set<DrawingPath> {
        var selectedPaths = Set<DrawingPath>()
        for path in paths {
            let pathPoints = path.points.map { $0.point }
            let pathBoundingRect = pathPoints.boundingRect
            if rect.intersects(pathBoundingRect) {
                selectedPaths.insert(path)
            }
        }
        return selectedPaths
    }
}

extension Array where Element == CGPoint {
    var boundingRect: CGRect {
        var minX = CGFloat.infinity
        var minY = CGFloat.infinity
        var maxX = CGFloat.leastNormalMagnitude
        var maxY = CGFloat.leastNormalMagnitude

        for point in self {
            minX = Swift.min(minX, point.x)
            minY = Swift.min(minY, point.y)
            maxX = Swift.max(maxX, point.x)
            maxY = Swift.max(maxY, point.y)
        }

        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
}
