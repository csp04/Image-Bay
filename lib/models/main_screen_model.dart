import 'package:flutter/cupertino.dart';
import 'package:pixabay_picker/model/pixabay_media.dart';
import 'package:pixabay_picker/pixabay_picker.dart';

class MainScreenModel with ChangeNotifier {
  PixabayPicker _picker = PixabayPicker(
      apiKey: '19007881-cef67cf7daf6ef17622baa858', language: "en");

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;

    notifyListeners();
  }

  List<String> get categories => Category.categories;

  int _selectedCategoryIndex;
  int get selectedCategoryIndex => _selectedCategoryIndex;

  set selectedCategoryIndex(int value) {
    if (_selectedCategoryIndex == value) return;

    _selectedCategoryIndex = value;

    var category = categories[value];

    loadImages(category);

    notifyListeners();
  }

  Map<String, CategoryImageHandler> _categoryImages = {};

  CategoryImageHandler get currentCategoryImage =>
      _categoryImages[categories[selectedCategoryIndex]];

  Future<void> loadImages(String category) async {
    loading = true;

    var handler = _categoryImages[category] ??= CategoryImageHandler(category);
    try {
      var res = await _picker.api.requestImages(
          category: category,
          resultsPerPage: 100,
          page: ++handler.nextPageNumber);

      handler.images.addAll(res.hits.cast<PixabayImage>());
    } catch (Exception) {}

    loading = false;
  }

  // category
  // -> page index
  // -> images

}

class CategoryImageHandler {
  final String category;

  int _nextPageNumber = 0;

  CategoryImageHandler(this.category);

  int get nextPageNumber => _nextPageNumber;

  set nextPageNumber(int pageNumber) {
    _nextPageNumber = pageNumber;
  }

  List<PixabayImage> _images = <PixabayImage>[];

  List<PixabayImage> get images => _images;

  set images(List<PixabayImage> images) {
    _images = images;
  }
}
