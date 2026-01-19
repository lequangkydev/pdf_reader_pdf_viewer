import 'dart:async';

class SearchState {
  final bool isFocused;
  final String searchText;

  SearchState(this.isFocused, this.searchText);
}

class SearchStream {
  final StreamController<SearchState> _controller = StreamController<SearchState>.broadcast();

  Stream<SearchState> get stream => _controller.stream;

  void update(bool isFocused, String searchText) {
    _controller.add(SearchState(isFocused, searchText));
  }

  void dispose() {
    _controller.close();
  }
}