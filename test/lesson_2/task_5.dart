import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fight_club/fight_club_images.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_test/flutter_test.dart';

///
/// 5. Добавить аватарки (3 балл)
///
/// Добавить аватарки для нас и для нашего врага. В ассеты, в pubspec.yaml и
/// на главный экран
///
/// - Скачать аватарки из ресурсов этого занятия
/// - Добавить аватарки в папку assets/images
/// - Создать файл в папке lib: fight_club_images.dart
/// - В файле создать Utility Class FightClubImages
/// - В этом файле сделать две переменные: youAvatar, enemyAvatar с путями до картинок
/// - Прописать ассеты с картинками в файле pubspec.yaml
/// - Добавить аватарку youAvatar вместо красного квадрата
/// - Добавить аватарку enemyAvatar вместо синего квадрата
///

void runTestLesson2Task5() {
  testWidgets('module5', (WidgetTester tester) async {
    final String youAvatarPath = "assets/images/you-avatar.png";
    final String enemyAvatarPath = "assets/images/enemy-avatar.png";

    final yourData = await rootBundle.load(youAvatarPath);
    final yourBuffer = yourData.buffer;
    final yourBytes = yourBuffer.asUint8List(yourData.offsetInBytes, yourData.lengthInBytes);
    final yourMd5checksum = md5.convert(yourBytes);
    expect(yourMd5checksum.toString(), "b740ac516bd8fb9950654185ce9241c4");

    final enemiesData = await rootBundle.load(enemyAvatarPath);
    final enemiesBuffer = enemiesData.buffer;
    final enemiesBytes =
        enemiesBuffer.asUint8List(enemiesData.offsetInBytes, enemiesData.lengthInBytes);
    final enemiesMd5checksum = md5.convert(enemiesBytes);
    expect(enemiesMd5checksum.toString(), "98855f71fa4fd927e3789adebcddaf73");

    expect(FightClubImages.youAvatar, youAvatarPath);
    expect(FightClubImages.enemyAvatar, enemyAvatarPath);

    await tester.pumpWidget(MyApp());

    final youImageFinder = assetImageByPathFinder(youAvatarPath);
    expect(youImageFinder, findsOneWidget);
    final Image youImage = tester.widget(youImageFinder);
    expect(youImage.image, isInstanceOf<AssetImage>());
    expect((youImage.image as AssetImage).assetName, youAvatarPath);

    final enemyImageFinder = assetImageByPathFinder(enemyAvatarPath);
    expect(enemyImageFinder, findsOneWidget);
    final Image enemyImage = tester.widget(enemyImageFinder);
    expect(enemyImage.image, isInstanceOf<AssetImage>());
    expect((enemyImage.image as AssetImage).assetName, enemyAvatarPath);
  });
}

Finder assetImageByPathFinder(final String path) {
  return find.byWidgetPredicate((widget) {
    if (widget is! Image) {
      return false;
    }
    final provider = widget.image;
    if (provider is ExactAssetImage) {
      return provider.assetName == path;
    } else if (provider is AssetImage) {
      return provider.assetName == path;
    }
    return false;
  });
}