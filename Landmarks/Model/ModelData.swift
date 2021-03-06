//
//  ModelData.swift
//  Landmarks
//
//  Created by Евгений Березенцев on 08.09.2021.
//

import Foundation
import Combine  // Работа с ObservableObject


// Класс для доступа к массиву данных
final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    
    // Работа с Избрынными
    var featured: [Landmark] {
        landmarks.filter { $0.isFeatured}
    }
    
    // Работа с экраном категорий
    var categories: [String: [Landmark]] {
        Dictionary(grouping: landmarks, by: { $0.category.rawValue})
    }
}



// Функция загрузки данных из  JSON
func load<T: Decodable>(_ fileName: String) -> T {
    
    let data: Data
    
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil)
    else {
        fatalError("Couldn't find \(fileName) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(fileName) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(fileName) as \(T.self):\n\(error)")

    }
}
