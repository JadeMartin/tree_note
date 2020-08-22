
import 'package:tree_note/models/tree_node.dart';

//Recursive function to get the root node
Future<TreeNode> getRoot(TreeNode node) async {
  if (node.id != 0){
    node = await getRoot(node.parent);
  }
  return node;
}

Future<TreeNode> initDFS(int target, TreeNode currentNode) async {
  TreeNode root = await getRoot(currentNode);
  int rootID = root.id;
  print("Root id = $rootID");
  TreeNode parent = await dfs(target, root, []);
  String parentName = parent.name;
  print("Name ?? $parentName");
  return parent;
}

//Depth first search algorithm implementation 
Future<TreeNode> dfs(int targetId, TreeNode node, List<int> visitedIds) async {
  if(node.id == targetId){
    return node;
  }
  String name = node.name;
  int current = node.id;
  print("node name = $name & id = $current - target = $targetId");
  //add node to visited list 
  visitedIds.add(node.id);
  //check if at target node
  List<TreeNode> branches = node.getBranches();
  print("BRANCHS --- $branches");
  if(node.id != targetId){
    if(branches.isEmpty && node.id != 0){
      node = await dfs(targetId, node.parent, visitedIds);
    } else {
    //get node branches then loop over them
    branches.forEach((element) async {
      //check if loop has reached target and then also check if it has already visited node or not
      if(node.id != targetId && !visitedIds.contains(element.id)) {
        node = await dfs(targetId, element, visitedIds);
      }
    });
    }
    print("$name = name >>");
    return node;
  }
}