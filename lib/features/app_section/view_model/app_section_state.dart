class AppSectionState {
  const AppSectionState({this.currentIndex = 0});

  final int currentIndex;

  AppSectionState copyWith({int? currentIndex}) {
    return AppSectionState(currentIndex: currentIndex ?? this.currentIndex);
  }
}
