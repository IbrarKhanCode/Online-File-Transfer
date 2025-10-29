

class FileItem{
  final String name;
  bool isFavourite;
  bool isShared;

  FileItem({
    required this.name,
    this.isFavourite = false,
    this.isShared = false,
});
}