class CategoryDm {
  final String id;
  final String name;
  final List<SubCategory> subCategories;

  CategoryDm({
    required this.id,
    required this.name,
    required this.subCategories,
  });

  // Factory method to create a Category from a Map
  factory CategoryDm.fromMap(String id, Map<dynamic, dynamic> map) {
    var subCategoriesMap = Map<String, String>.from(map['subCategories'] ?? {});
    List<SubCategory> subCategories = subCategoriesMap.entries
        .map((entry) => SubCategory.fromMap(entry.key, entry.value))
        .toList();

    return CategoryDm(
      id: id,
      name: map['name'] ?? '',
      subCategories: subCategories,
    );
  }

  // Method to convert a Category to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'subCategories': {
        for (var subCategory in subCategories)
          subCategory.id: subCategory.name
      },
    };
  }
}




class SubCategory {
  final String id;
  final String name;

  SubCategory({
    required this.id,
    required this.name,
  });

  // Factory method to create a SubCategory from a Map
  factory SubCategory.fromMap(String id, String name) {
    return SubCategory(
      id: id,
      name: name,
    );
  }

  // Method to convert a SubCategory to a Map
  Map<String, String> toMap() {
    return {
      id: name,
    };
  }
}
