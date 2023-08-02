final class Routable {
  final String? path;
  final bool navigateToExtension;
  final bool replaceWithExtension;
  final bool rootToExtension;

  const Routable({
    this.path,
    this.navigateToExtension = true,
    this.replaceWithExtension = true,
    this.rootToExtension = true,
  });
}
