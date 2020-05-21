//
//  RecipeData.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/4/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import SwiftUI

struct Recipe: Hashable, Codable, Identifiable {
    var id: UUID
    var name: String    
    var category: Category
    var isFavorite: Bool
    var imageName: String
    
    var steps: [RecipeStep]
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case dessert = "Dessert"
        case entree = "Entree"
        case fastfood = "FastFood"
    }
    
    init(id: UUID, name: String, category: Category) {
        self.id = id
        self.name = name
        self.category = category
        self.isFavorite = false
        self.imageName = "RecipeIcon"
        self.steps = []
    }
    
}

struct RecipeStep: Hashable, Codable, Identifiable {
    var id: UUID
    var title: String
    var items: [RecipeStepItem] = []
    var timeLimit: Int
    var isDone: Bool
    var index: Int
    
    init(id: UUID, title: String, timeLimit: Int, index: Int) {
        self.id = id
        self.title = title
        self.items = []
        self.timeLimit = timeLimit
        self.isDone = false
        self.index = index
    }
}

struct RecipeStepItem: Hashable, Codable {
    var description: String
    
    init(description: String) {
        self.description = description
    }
    
}

extension Recipe {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
    
}

