
import 'package:tree_note/models/tree_node.dart';

//Recursive function to get the root node
Future<TreeNode> getRoot(TreeNode node) async {
  if (node.id != 0){
    node = await getRoot(node.parent);
  }
  return node;
}

Future<bool> initParentDFS(TreeNode newParent, TreeNode currentNode) async {
  // Code to init parent check to see wether new parent is a child of currentNode
  bool isChild = false;
  Set<TreeNode> visited = await dfs(currentNode, new Set());
  visited.forEach((element) {isChild = (element.id == newParent.id) ? true : false;});
  print("Visisted nodes = $visited");
  print(" is child = $isChild");
  return isChild;
}

Future<TreeNode> initDFS(int target, TreeNode currentNode) async {
  TreeNode root = await getRoot(currentNode);
  TreeNode targetNode = root;
  Set<TreeNode> visited = await dfs(root, new Set());
  visited.forEach((element) {targetNode = (element.id == target) ? element : targetNode;});
  String tar = targetNode.name;
  print("targetname = $tar");
  return targetNode;
}

//Depth first search algorithm implementation 
Future<Set<TreeNode>> dfs(TreeNode node, Set<TreeNode> visited) async {
  visited.add(node);
  node.children.forEach((element) => {dfs(element, visited)});
  return visited;
}