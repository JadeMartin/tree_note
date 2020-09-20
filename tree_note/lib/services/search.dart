
import 'package:tree_note/models/tree_node.dart';

//Recursive function to get the root node
Future<TreeNode> getRoot(TreeNode node) async {
  if (node.id != 0){
    node = await getRoot(node.parent);
  }
  return node;
}


//Recursive function to find the child of the currentNode that is a parent of newParent 
Future<TreeNode> findSubChild(id, newParent) async {
  if (newParent.parent.id != id) {
    newParent = await findSubChild(id, newParent.parent);
  }
  return newParent;
}

//helper function to initiate DFS to find children nodes of a parent
Future<bool> initParentDFS(TreeNode newParent, TreeNode currentNode) async {
  // Code to init parent check to see wether new parent is a child of currentNode
  bool isChild = false;
  Set<TreeNode> visited = await dfs(currentNode, new Set());
  print(newParent.name);
  visited.forEach((element) {print(element.name); isChild = (element.id == newParent.id || isChild) ? true : false;});
  print(isChild);
  return isChild;
}

//helper function to initiate DFS for node swapping
Future<TreeNode> initDFS(int target, TreeNode currentNode) async {
  TreeNode root = await getRoot(currentNode);
  TreeNode targetNode = root;
  Set<TreeNode> visited = await dfs(root, new Set());
  visited.forEach((element) {targetNode = (element.id == target) ? element : targetNode;});
  return targetNode;
}

//Depth first search algorithm implementation 
Future<Set<TreeNode>> dfs(TreeNode node, Set<TreeNode> visited) async {
  visited.add(node);
  node.children.forEach((element) => {dfs(element, visited)});
  return visited;
}