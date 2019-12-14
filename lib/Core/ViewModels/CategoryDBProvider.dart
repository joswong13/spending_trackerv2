import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/Core/Services/Sqflite/BaseDB.dart';
import 'package:spending_tracker/Core/Services/Sqflite/CategoryDatabaseHelper.dart';

mixin CategoryDBProvider {
  BaseDB<UserCategory> categoryDatabase = CategoryDatabase();

  ///Insert UserCategory to category db, then refresh the current list of _userCategory and map of _userCategoryMap. Then refresh transactions.
  Future<void> insertCategory(String name, String icon, String colorOne, String colorTwo, int position) async {
    UserCategory category = UserCategory();
    category.name = name.toLowerCase();
    category.icon = icon;
    category.colorOne = colorOne;
    category.colorTwo = colorTwo;
    category.position = position;

    await categoryDatabase.insert(category);
  }

  Future<List<Map<String, dynamic>>> getAllCategory() async {
    return await categoryDatabase.getAllInDb();
  }

  Future<bool> categoryExists(String category) async {
    List<Map<String, dynamic>> resp = await categoryDatabase.getWithOneParameter<String>(category);

    if (resp.length > 0) {
      return true;
    }
    return false;
  }

  Future<int> updateUserCategory(
      int id, String name, String colorOne, String colorTwo, String icon, int position) async {
    UserCategory userCategory = UserCategory();
    userCategory.id = id;
    userCategory.name = name;
    userCategory.colorOne = colorOne;
    userCategory.colorTwo = colorTwo;
    userCategory.icon = icon;
    userCategory.position = position;

    int resp = await categoryDatabase.update(userCategory);

    return resp;
  }

//------------DELETE-----------------
  Future<int> deleteCategory(int id) async {
    int resp = await categoryDatabase.deleteById(id);

    return resp;
  }

  /// Given a list of User Categories, iterate through the list and update the database. Then refresh the list of User Categories
  Future<void> batchJobUpdateUserCategory(List<UserCategory> listOfUC) async {
    await categoryDatabase.batchJob(listOfUC);
  }
}
