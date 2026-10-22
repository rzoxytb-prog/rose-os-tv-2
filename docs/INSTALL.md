# Installer Rosé OS sur la TV

## Android TV / Google TV (le plus simple)
1. Récupère `app-debug.apk` (artefact GitHub Actions « RoseOS-androidtv-apk »).
2. TV et ordinateur sur le même Wi-Fi, **débogage USB / sans fil** activé sur la TV
   (Paramètres > À propos > appuie 7 fois sur « Build » > Options développeur).
3. Sur l'ordinateur (adb installé) :
   ```
   adb connect IP_DE_LA_TV:5555
   adb install app-debug.apk
   ```
   Ou copie l'APK sur une clé USB et ouvre-le depuis un gestionnaire de fichiers sur la TV.
4. Lance « Rosé OS » depuis la liste des applications.
5. Facultatif, en faire l'écran d'accueil :
   `adb shell cmd package set-home-activity com.rose.tvos/.MainActivity`
   (certains modèles refusent : lance alors l'appli à la main).
   Pour revenir en arrière : désinstalle l'appli ou utilise « Revenir à l'OS d'origine ».

## LG webOS
1. Active le mode développeur : installe l'appli « Developer Mode » du LG Content Store, connecte-toi avec un compte LG, active « Dev Mode Status » et « Key Server ».
2. `npm i -g @webos-tools/cli`
3. ```
   ares-setup-device --add macv --info "host=IP_DE_LA_TV,port=9922,username=prisoner"
   ares-novacom --device macv --getkey
   ares-install --device macv dist/com.rose.tvos_1.0.0_all.ipk
   ares-launch --device macv com.rose.tvos
   ```
Le mode développeur expire au bout de quelques heures : relance-le dans l'appli Developer Mode.

## Samsung Tizen
Samsung impose un paquet signé. Avec Tizen Studio : crée un profil de certificat Samsung,
active le **mode développeur** sur la TV (Apps > tape 12345 > IP de ton PC), puis :
```
tizen package -t wgt -s TON_PROFIL -- build/tizen
sdb connect IP_DE_LA_TV
tizen install -n RoseOSTv0.wgt -t NOM_DE_LA_TV
```
(le `.wgt` « unsigned » produit par `build.sh` sert seulement de base.)

## Navigateur
Ouvre `web/index.html` dans un navigateur, ou héberge le dossier `web/` et ouvre l'adresse dans le navigateur de la TV.
