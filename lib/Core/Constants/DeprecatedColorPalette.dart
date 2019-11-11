//-------------------------------V2-----------------------------------------------------
// Map<String, Color> materialColorMap = {};
// List<Map<String, dynamic>> materialColorsList = [];

// void initColorPalette() {
//   for (int i = 100; i <= 900; i = i + 100) {
//     materialColorMap["pink" + i.toString()] = Colors.pink[i];
//   }

//   for (int i = 100; i <= 900; i = i + 100) {
//     materialColorMap["red" + i.toString()] = Colors.red[i];
//   }

//   for (int i = 100; i <= 900; i = i + 100) {
//     materialColorMap["orange" + i.toString()] = Colors.orange[i];
//   }

//   for (int i = 100; i <= 900; i = i + 100) {
//     materialColorMap["yellow" + i.toString()] = Colors.yellow[i];
//   }

//   for (int i = 100; i <= 900; i = i + 100) {
//     materialColorMap["green" + i.toString()] = Colors.green[i];
//   }

//   for (int i = 100; i <= 900; i = i + 100) {
//     materialColorMap["teal" + i.toString()] = Colors.teal[i];
//   }

//   for (int i = 100; i <= 900; i = i + 100) {
//     materialColorMap["cyan" + i.toString()] = Colors.cyan[i];
//   }

//   for (int i = 100; i <= 900; i = i + 100) {
//     materialColorMap["blue" + i.toString()] = Colors.blue[i];
//   }

//   for (int i = 100; i <= 900; i = i + 100) {
//     materialColorMap["blueGrey" + i.toString()] = Colors.blueGrey[i];
//   }

//   for (int i = 100; i <= 900; i = i + 100) {
//     materialColorMap["purple" + i.toString()] = Colors.purple[i];
//   }

//   materialColorMap.forEach((key, value) {
//     materialColorsList.add({"name": key, "color": value});
//   });
// }

//-------------------------------V1-----------------------------------------------------
// //Green--------------------------------------------------
// const Color greenLightGreenishBlue = Color.fromRGBO(85, 239, 196, 1.0);

// const Color greenMintLeaf = Color.fromRGBO(0, 184, 148, 1);

// const Color greenLime = Color.fromRGBO(97, 255, 97, 1);

// //Teal--------------------------------------------------
// const Color tealFadedPoster = Color.fromRGBO(129, 236, 236, 1.0);

// const Color tealRobinsEgg = Color.fromRGBO(0, 206, 201, 1.0);

// const Color tealLessThanRobinsEgg = Color.fromRGBO(0, 198, 189, 1);

// //Blue--------------------------------------------------
// const Color blueGreenDarnerTail = Color.fromRGBO(116, 185, 255, 1.0);

// const Color blueElectron = Color.fromRGBO(116, 185, 255, 1.0);

// const Color blueLivid = Color.fromRGBO(106, 137, 204, 1.0);

// const Color blueAzraq = Color.fromRGBO(74, 105, 189, 1.0);

// const Color blueGuang = Color.fromRGBO(30, 55, 153, 1.0);

// const Color blueDarkSapphire = Color.fromRGBO(12, 36, 97, 1.0);

// const Color bluePowder = Color.fromRGBO(118, 137, 243, 1.0);

// const Color blueDarkTeal = Color.fromRGBO(43, 104, 133, 1.0);

// const Color blueDarkDarkBlue = Color.fromRGBO(34, 45, 66, 1);

// //Purple--------------------------------------------------
// const Color purpleShyMoment = Color.fromRGBO(162, 155, 254, 1.0);

// const Color purpleExodusFruit = Color.fromRGBO(108, 92, 231, 1);

// //Yellow--------------------------------------------------
// const Color yellowSourLemon = Color.fromRGBO(255, 234, 167, 1.0);

// const Color yellowBrightYarrow = Color.fromRGBO(253, 203, 110, 1.0);

// //Orange--------------------------------------------------
// const Color orangeFirstDate = Color.fromRGBO(250, 177, 160, 1.0);

// const Color orangeville = Color.fromRGBO(225, 112, 85, 1.0);

// //Red--------------------------------------------------
// const Color redPinkGlamor = Color.fromRGBO(255, 118, 117, 1.0);

// const Color redChiGong = Color.fromRGBO(214, 48, 49, 1.0);

// //Pink--------------------------------------------------
// const Color pinkPico = Color.fromRGBO(253, 121, 168, 1.0);

// const Color pinkPrunusAvium = Color.fromRGBO(232, 67, 147, 1.0);

// //Grey--------------------------------------------------
// const Color greyCityLights = Color.fromRGBO(223, 230, 233, 1.0);

// const Color greyAmericanRiver = Color.fromRGBO(99, 110, 114, 1.0);

// const Color greyDraculaOrchid = Color.fromRGBO(45, 52, 54, 1.0);

// const Color greyVeryDarkBlue = Color.fromRGBO(58, 66, 86, 1.0);

// const Color greySlightlyDarkBlue = Color.fromRGBO(64, 75, 96, .9);

// //BlueGrey--------------------------------------------------

// const Color blueGreySpray = Color.fromRGBO(130, 204, 221, 1.0);

// const Color blueGreyDupain = Color.fromRGBO(96, 163, 188, 1.0);

// const Color blueGreyGoodSamaritan = Color.fromRGBO(60, 99, 130, 1.0);

// const Color blueGreyForestBlues = Color.fromRGBO(10, 61, 98, 1.0);

// Map<String, Color> colorsMap = {
//   "blueGreySpray": blueGreySpray,
//   "blueGreyDupain": blueGreyDupain,
//   "blueGreyGoodSamaritan": blueGreyGoodSamaritan,
//   "greyVeryDarkBlue": greyVeryDarkBlue,
//   "blueGreyForestBlues": blueGreyForestBlues,
//   "blueGreenDarnerTail": blueGreenDarnerTail,
//   "blueElectron": blueElectron,
//   "blueLivid": blueLivid,
//   "purpleShyMoment": purpleShyMoment,
//   "purpleExodusFruit": purpleExodusFruit,
//   "blueAzraq": blueAzraq,
//   "blueDarkSapphire": blueDarkSapphire,
//   "blueGuang": blueGuang,
//   "bluePowder": bluePowder,
//   "blueDarkDarkBlue": blueDarkDarkBlue,
//   "blueDarkTeal": blueDarkTeal,
//   "greenLightGreenishBlue": greenLightGreenishBlue,
//   "greenMintLeaf": greenMintLeaf,
//   "greenLime": greenLime,
//   "tealFadedPoster": tealFadedPoster,
//   "tealRobinsEgg": tealRobinsEgg,
//   "tealLessThanRobinsEgg": tealLessThanRobinsEgg,
//   "yellowBrightYarrow": yellowBrightYarrow,
//   "yellowSourLemon": yellowSourLemon,
//   "redChiGong": redChiGong,
//   "redPinkGlamor": redPinkGlamor,
//   "orangeville": orangeville,
//   "orangeFirstDate": orangeFirstDate,
//   "pinkPico": pinkPico,
//   "pinkPrunusAvium": pinkPrunusAvium,
// };

// List<Map<String, dynamic>> getColorsMapAsList() {
//   List<Map<String, dynamic>> colorsMapAsList = [];
//   colorsMap.forEach((key, value) {
//     colorsMapAsList.add({"name": key, "color": value});
//   });

//   return colorsMapAsList;
// }
