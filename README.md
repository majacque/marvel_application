# Marvel Application
Une application mobile Flutter qui affiche les personnages Marvel et leurs détails à partir de l'API Marvel.

## Getting Started
Ces instructions vous aideront à mettre en place une copie du projet sur votre machine locale à des fins de développement et de test. Consultez la [section de déploiement](#deployment) pour obtenir des notes sur la façon de déployer le projet sur un système en direct.

## Prerequisites
Pour exécuter ce projet, vous aurez besoin de :

* [Flutter SDK](https://docs.flutter.dev/get-started/install)
* [Android Studio ou VS Code](https://docs.flutter.dev/development/tools/android-studio)
* [Clé d'API Marvel](https://developer.marvel.com/)

## Installing

1. Cloner le dépôt
```
git clone https://github.com/majacque/marvel_application.git
```
2. Installer les packages
```
cd marvel_application
flutter pub get
```
3. Créer un fichier api_key.dart dans le dossier [lib](lib), et y ajouter les lignes suivantes, en remplaçant les valeurs par votre clé d'API Marvel :
```
const publicKey = 'YOUR_PUBLIC_KEY';
const privateKey = 'YOUR_PRIVATE_KEY';
```
4. Lancer l'application
```
flutter run
```
## Deployment
Pour déployer l'application, vous pouvez suivre les instructions de Flutter pour [déployer sur iOS](https://docs.flutter.dev/deployment/ios) ou [déployer sur Android](https://docs.flutter.dev/deployment/android).

## Built With
[Flutter](https://flutter.dev/)
[Marvel API](https://developer.marvel.com/)

## Authors
[majacque](https://github.com/majacque)

## License
Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.
