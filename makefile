sync:
	fvm flutter pub get
gen_file:
	fvm flutter pub run build_runner build --delete-conflicting-outputs
gen_lang:
	dart run intl_utils:generate
build_develop:
	fvm flutter build apk --target=lib/main.dart --flavor=develop
fix:
	dart fix --apply 
watch:
	flutter packages pub run image_res:main watch