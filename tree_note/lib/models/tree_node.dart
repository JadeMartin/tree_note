class TreeNode {

  //Tree data - unique id for the branch and parents id.
  final TreeNode parent;
  List<TreeNode> children;
  // branch = true, leaf = false.
  final bool branch;

  //Branch data to display for the branch.
  String name;
  DateTime creationTime;
  int progress;
  int limit; 

  //Leaf data
  String note;

  TreeNode({this.parent, this.children, this.branch, this.name, this.creationTime, this.progress, this.limit, this.note});

  //Returns name
  String getData()=> name;

  // Method to append a child into the branch
  addChild(TreeNode child) {
    children.add(child);
  }

  //method to remove a child
  removeChild(TreeNode child){
    children.remove(child);
  }

  //method to get children of a branch
  List<TreeNode> getChildren()=> children;

  // method to return parent node 
  TreeNode getParent()=> parent;

  //method to find if at root
  bool atRoot(){
    if(parent == null) {
      return true;
    } else {
      return false;
    }
  }

  String getTitle(){
    if(atRoot()){
      return 'Tree Notes';
    } else {
      return name;
    }
  }

  update(String newName, int newProgress, int newLimit) {
    name = newName;
    progress = newProgress;
    limit = newLimit;
    creationTime = DateTime.now();
  }

  updateNote(String newNote) {
    note = newNote;
    creationTime = DateTime.now();
  }

  String progressOutput() {
    String output = "";
    if (progress == 0 && limit == 0) {
      output = "$progress / $limit";
    }
    return output;
  }

}