class Triple {
  Triple(this.left, this.right, {this.indent = false, this.isSatisfied = true});

  final dynamic left;
  final dynamic right;
  final bool indent, isSatisfied;

  @override
  String toString() => 'Pair[$left, $right]';
}
