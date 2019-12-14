import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/CommonFunctions.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/TopTextButtonStack.dart';

class ReorganizeCategoryView extends StatefulWidget {
  /// Given a list of user categories, allows user to rearrange the categories to any order.
  @override
  _ReorganizeCategoryViewState createState() => _ReorganizeCategoryViewState();
}

class _ReorganizeCategoryViewState extends State<ReorganizeCategoryView> {
  //Original list that is used to check if the category has moved
  List<UserCategory> _originalListofUserCategory;

  //The cloned list of the UserCategories
  List<UserCategory> cloneList = [];

  //The final list of changed UserCategories
  List<UserCategory> finalList = [];

  @override
  void initState() {
    super.initState();
    List<UserCategory> _originalListofUserCategory = Provider.of<AppProvider>(context, listen: false).userCategoryList;

    _originalListofUserCategory.forEach((uc) {
      //Clone the UC
      UserCategory tempUc = UserCategory();
      tempUc.name = uc.name;
      tempUc.id = uc.id;
      tempUc.colorOne = uc.colorOne;
      tempUc.colorTwo = uc.colorTwo;
      tempUc.position = uc.position;
      tempUc.icon = uc.icon;

      cloneList.add(tempUc);
    });
  }

  void _moveUpList(int index) {
    // Copies the UserCategory to memory for insertion
    UserCategory ucToMove = cloneList[index];

    if (index != 0) {
      cloneList[index].position = index - 1;
      cloneList[index - 1].position = index;
      cloneList.removeAt(index);

      setState(() {
        cloneList.insert(index - 1, ucToMove);
      });
    }
  }

  void _moveDownList(int index) {
    // Copies the UserCategory to memory for insertion
    UserCategory ucToMove = cloneList[index];

    if (index != cloneList.length - 1) {
      cloneList[index].position = index + 1;
      cloneList[index + 1].position = index;
      cloneList.removeAt(index);

      setState(() {
        cloneList.insert(index + 1, ucToMove);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopTextButtonStack(
              title: "Rearrange",
              widget: IconButton(
                icon: const Icon(Icons.save),
                iconSize: 28,
                color: Theme.of(context).primaryColor,
                tooltip: "Save",
                onPressed: () async {
                  for (int i = 0; i < _originalListofUserCategory.length; i++) {
                    bool same = _originalListofUserCategory[i].checkEqual(cloneList[i]);
                    if (!same) {
                      finalList.add(cloneList[i]);
                    }
                  }
                  await appProvider.batchJobUpdateUserCategory(finalList);

                  await appProvider.refreshUserCategoryList();
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cloneList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: index == 0
                        ? IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.grey,
                            ),
                            onPressed: null,
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_up,
                              color: primaryGreen,
                            ),
                            onPressed: () {
                              _moveUpList(index);
                            },
                          ),
                    title: Text(
                      upperCaseFirstLetter(cloneList[index].name),
                      textScaleFactor: 1,
                    ),
                    trailing: index == cloneList.length - 1
                        ? IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                            onPressed: null,
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: primaryGreen,
                            ),
                            onPressed: () {
                              _moveDownList(index);
                            },
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
