cake:
	gnatmake -D build src/main2joueurs.adb
pake:
	gnatmake -D build src/liste_generique.adb


clean:
	rm build/*
