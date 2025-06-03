//
//  InternetConnectionService.swift
//  PostsApp
//
//  Created by Milos Pavlovic on 3. 6. 2025..
//

import Network
import Combine

final class InternetConnectionService: ObservableObject {
    
    @Published private(set) var isConnected = true
    
    private let monitor = NWPathMonitor()
    private let queue   = DispatchQueue(label: "NetworkMonitor")
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = (path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }
    
    /// Manual ping (optional). Uses the *current* path, no HTTP round-trip.
    func refresh() {
        isConnected = monitor.currentPath.status == .satisfied
    }
    
    deinit { monitor.cancel() }
}
