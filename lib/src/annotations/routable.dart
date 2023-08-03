final class Routable {
  final String? path;
  final bool navigateToExtension;
  final bool replaceWithExtension;
  final bool rootToExtension;
  final Type? pageBuilder;

  const Routable({
    this.path,
    this.navigateToExtension = true,
    this.replaceWithExtension = true,
    this.rootToExtension = true,
    this.pageBuilder,
  });
}
