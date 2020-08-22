import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tree_note/models/tree_node.dart';


Future<Database> database() async {
  return openDatabase(
    //Set path to the DB
    join(await getDatabasesPath(), 'tree_note_database.db'),

    //when the database is first created, create a table to store TreeNodes
    onCreate: (db, version) {
      //run the CREATE TABLE statement on the database
      return db.execute(
        """CREATE TABLE nodes(
          id INTEGER PRIMARY KEY,
          parentId INTEGER,
          branch INTEGER,
          name TEXT,
          creationTime TEXT,
          progress INTEGER,
          maxLimit INTEGER,
          note TEXT
        )""",
      );
    },
    //set the version. This executes the onCreate function and provides a path to perform database upgrades and downgrades
    version: 3,
  );
}

Future<void> clearDb() async {
  final Database db = await database();
  await db.execute("DROP TABLE IF EXISTS nodes");
}


Future<void> createDB() async {
  final Database db = await database();
  db.execute(
        """CREATE TABLE nodes(
          id INTEGER PRIMARY KEY,
          parentId INTEGER,
          branch INTEGER,
          name TEXT,
          creationTime TEXT,
          progress INTEGER,
          maxLimit INTEGER,
          note TEXT
        )""",
      );
}


Future<int> insertNode(TreeNode node) async {
  //get a reference to the database.
  final Database db = await database();

  //Insert node into table .
  //ConflictAlgorithm to use in case same node is inserted twice.
  //then just replace the object in DB
  
  int id = await db.insert(
    'nodes',
    node.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  return id;
}

bool isBranch(int i){
  if(i == 1){
    return false;
  } else {
    return true;
  }
}

Future<List<TreeNode>> getAllBranchs() async {
  final Database db = await database();
  //set up db connect then map all the children of the node into TreeNodes
  final List<Map<String, dynamic>> maps = await db.query(
    'nodes',
    where: "branch = 0",
    );

  List<TreeNode> branchesList = List.generate(maps.length, (i) {
    TreeNode childNode =  TreeNode(
       parent: null,
       children: [],
       branch: isBranch(maps[i]['branch']),
       name: maps[i]['name'],
       creationTime: DateTime.parse(maps[i]['creationTime']),
       progress: maps[i]['progress'],
       limit: maps[i]['maxLimit'],
       note: maps[i]['note'],
    );
    childNode.setId(maps[i]['id']);
    childNode.setParentId(maps[i]['parentId']);
    return childNode;
  });
  TreeNode root = new TreeNode(parent: null, children: [], branch: true, name: 'Root', creationTime: DateTime.now(), progress: 0, limit: 0, note:'');
  root.setId(0);
  branchesList.add(root);
  return branchesList;
}

//Function to set children for a node - pseduo code 
  //get Children list {}
  //if childlist is empty(return i)
  //iterate over children list  j = child
    //set j.setParent = I 
    //check if branch before calling setChild(); leafs can not have childs
    // if x = i.addCHild(setChild(j))
    // i.addChild(setChild(j))

Future<TreeNode> setChildren(TreeNode node) async {

  final Database db = await database();
  //set up db connect then map all the children of the node into TreeNodes
  final List<Map<String, dynamic>> maps = await db.query(
    'nodes',
    where: "parentId = ?",
    whereArgs: [node.id],
    );

  List<TreeNode> childList = List.generate(maps.length, (i) {
    TreeNode childNode =  TreeNode(
       parent: node,
       children: [],
       branch: isBranch(maps[i]['branch']),
       name: maps[i]['name'],
       creationTime: DateTime.parse(maps[i]['creationTime']),
       progress: maps[i]['progress'],
       limit: maps[i]['maxLimit'],
       note: maps[i]['note'],
    );
    childNode.setId(maps[i]['id']);
    childNode.setParentId(maps[i]['parentId']);
    return childNode;
  });

  //check if it even has children then also if that child is a branch (notes cant have children)
  //then recursively fill the objects till it comes back and then add it as a child
  if (childList.isNotEmpty) { 
    for (var j = 0; j < childList.length; j++) {
      if (childList[j].branch == true) {
        childList[j] = await setChildren(childList[j]);
      }
      node.addChild(childList[j]);
    }
  }
  return node;
}

Future<void> updateNode(TreeNode node) async {
  // get a reference to the database.
  final db = await database();

  await db.update(
    'nodes',
    node.toMap(),
    //Ensure that the node has a matching ID
    where: "id = ? ",
    //pass the node id as whereArg to prevent SQL injection
    whereArgs: [node.id],
  );
}

Future<void> deleteNode(int id) async {
  //get reference to the database.
  final db = await database();

  //remove node from the Database
  await db.delete(
    'nodes',
    where: "id = ?",
    whereArgs: [id],
  );

}