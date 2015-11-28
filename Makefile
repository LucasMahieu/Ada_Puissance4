cake:
	gnatmake -D build src/main2joueurs.adb
pake:
	gnatmake -D build src/testListe.adb


clean:
	rm build/*
