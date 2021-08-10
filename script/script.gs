function doGet(request) {
  // Open Google Sheet using ID
  var sheet = SpreadsheetApp.openById(
    "1exf6TgespHpuUMVG5FJyQoQ4CiBWUL2eGKDVnnaQEqI"
  );
  // Get all values in active sheet
  var values = sheet.getActiveSheet().getDataRange().getValues();
  var users = sheet.getSheetByName("User").getDataRange().getValues();
  var questions = sheet.getSheetByName("Question").getDataRange().getValues();

  var data = [];

  for (var i = values.length - 1; i >= 0; i--) {
    // Get each row
    var row = values[i];

    // Create object
    var feedback = {};

    feedback["name"] = row[0];
    feedback["email"] = row[1];
    feedback["mobile_no"] = row[2];
    feedback["feedback"] = row[3];

    // Push each row object in data
    data.push(feedback);
  }

  var userData = [];

  for (var k = users.length - 1; k >= 1; k--) {
    // Get each row
    var row = users[k];

    // Create object
    var feedback = {};

    feedback["id"] = row[0];
    feedback["name"] = row[1];
    feedback["email"] = row[2];
    feedback["mobileNo"] = row[3];
    feedback["comment"] = row[4];

    // Push each row object in data
    userData.push(feedback);
  }

  var questionData = [];

  for (var j = users.length - 1; j >= 1; j--) {
    // Get each row
    var row = questions[j];

    // Create object
    var feedback = {};

    feedback["id"] = row[0];
    feedback["question"] = row[1];

    // Push each row object in data
    questionData.push(feedback);
  }

  var result = {
    data: data,
    userData: userData,
    questionData: questionData,
  };
  // Return result
  return ContentService.createTextOutput(JSON.stringify(result)).setMimeType(
    ContentService.MimeType.JSON
  );
}

function doPost(request) {
  // Open Google Sheet using ID
  var sheet = SpreadsheetApp.openById(
    "1exf6TgespHpuUMVG5FJyQoQ4CiBWUL2eGKDVnnaQEqI"
  );
  var targetSheet = sheet.getSheetByName("Record");

  var result = { status: "SUCCESS" };
  try {
    // Get all Parameters
    var name = request.parameter.name;
    var question = request.parameter.question;
    var answer = request.parameter.answer;

    // Append data on Google Sheet
    var rowData = targetSheet.appendRow([name, question, answer]);
    console.log(rowData);
  } catch (exc) {
    // If error occurs, throw exception
    result = { status: "FAILED", message: exc };
  }

  // Return result
  return ContentService.createTextOutput(JSON.stringify(result)).setMimeType(
    ContentService.MimeType.JSON
  );
}
