enum AppSize {
  small,
  medium,
  large,
}

class AppSizes {
  static double text(AppSize size) {
    switch (size) {
      case AppSize.small:
        return 14;
      case AppSize.medium:
        return 16;
      case AppSize.large:
        return 18;
    }
  }

  static double spacing(AppSize size) {
    switch (size) {
      case AppSize.small:
        return 6;
      case AppSize.medium:
        return 7.5;
      case AppSize.large:
        return 9;
    }
  }
}
