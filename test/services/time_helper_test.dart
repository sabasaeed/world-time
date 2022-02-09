import 'package:flutter_test/flutter_test.dart';
import 'package:time_app/services/time_helper.dart';

main() {
  test('Test greeting text should return Night', () {
    // Arrange

    DateTime current = DateTime(2022, 1, 3, 20); //year, month,dat,hour

// Act
    String timeOfDay = TimeHelper.getTimeOfDay(current);
    //Assert
    expect(timeOfDay, "Night");
  });

  test('Test greeting text should return Morning', () {
    // Arrange

    DateTime current = DateTime(2022, 1, 3, 7); //year, month,dat,hour

// Act
    String timeOfDay = TimeHelper.getTimeOfDay(current);
    //Assert
    expect(timeOfDay, "Morning");
  });

  test('Test isDayTime should return true', () {
    // Arrange

    DateTime current = DateTime(2022, 1, 3, 7); //year, month,dat,hour

// Act
    bool isDay = TimeHelper.isDayTime(current);
    //Assert
    expect(isDay, true);
  });

  test('Test isDayTime should return false', () {
    // Arrange

    DateTime current = DateTime(2022, 1, 3, 22); //year, month,dat,hour

// Act
    bool isDay = TimeHelper.isDayTime(current);
    //Assert
    expect(isDay, false);
  });
}
