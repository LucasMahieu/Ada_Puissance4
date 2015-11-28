with Ada.Unchecked_Deallocation;
with Ada.Text_Io; 
use Ada.Text_Io; 

with Liste_Generique;

procedure testListe is

	type Coups is (Bon, Mauvais, Droit, Gauche, Nul);

	type Coup is record 
		Nom : Coups;
	end record;

	procedure Affiche_Coup (C : Coup) is
	begin
		Put("( " & Coups'Image(C.Nom) & " )");
	end Affiche_Coup;
	

	package Liste_Coup is new Liste_Generique( Coup,
											Affiche_Coup);
	use Liste_Coup;
		
	c1 :constant Coup := (Nom=>Bon); 
	c2 :constant Coup := (Nom=>Mauvais);
	c3 :constant Coup := (Nom=>Droit);
	c4 :constant Coup := (Nom=>Gauche);
	c5 :constant Coup := (Nom=>Nul);
	c6 :constant Coup := (Nom=>Bon);
	LesCoups : Liste := Creer_Liste;

begin

	Insere_Tete(c1, LesCoups);
	Affiche_Liste(LesCoups);
	Insere_Tete(c2, LesCoups);
	Affiche_Liste(LesCoups);
	Insere_Tete(c3, LesCoups);
	Affiche_Liste(LesCoups);
	Insere_Tete(c4, LesCoups);
	Affiche_Liste(LesCoups);
	Insere_Tete(c5, LesCoups);
	Affiche_Liste(LesCoups);
	Insere_Tete(c6, LesCoups);
	Affiche_Liste(LesCoups);
	Insere_Tete(c1, LesCoups);
	Affiche_Liste(LesCoups);

end testListe;
