with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Puissance4;
with Participant;
with Partie;
with Liste_Generique;
with Moteur_Jeu;
with Ada.Numerics.Discrete_Random;

use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Participant;

procedure Main2Joueurs is

-- Pour changer la taille de la grille : changer les 3 peram de cette instanciation
	-- 1er : Largeur 
	-- 2eme: Hauteur 
	-- 3eme: Puissance (nb de pions à aligner pour gagner)
	package MyPuissance4 is new Puissance4(7,6,4);

    -- Moteur de jeu Ordi 1 : Pas très fort : profondeur = 5.
    package MyMoteur2 is new Moteur_Jeu(MyPuissance4.Etat,
                                       MyPuissance4.Coup,
                                       MyPuissance4.Jouer,
                                       MyPuissance4.Est_Gagnant,
                                       MyPuissance4.Est_Nul,
                                       MyPuissance4.Affiche_Coup,
                                       MyPuissance4.Liste_Coups,
                                       MyPuissance4.Coups_Possibles,
                                       MyPuissance4.Eval,
                                       5,
                                       Joueur2);

    -- Moteur de jeu pour ordi 2 : Un vrai bete de course = profondeur = 7
    package MyMoteur1 is new Moteur_Jeu(MyPuissance4.Etat,
                                       MyPuissance4.Coup,
                                       MyPuissance4.Jouer,
                                       MyPuissance4.Est_Gagnant,
                                       MyPuissance4.Est_Nul,
                                       MyPuissance4.Affiche_Coup,
                                       MyPuissance4.Liste_Coups,
                                       MyPuissance4.Coups_Possibles,
                                       MyPuissance4.Eval,
                                       7,
                                       Joueur1);

	package MyPartieHvsH is new Partie(MyPuissance4.Etat,
                                   MyPuissance4.Coup, 
                                   "HUMAIN 1 ",
                                   "HUMAIN 2 ",
                                   MyPuissance4.Jouer,
                                   MyPuissance4.Est_Gagnant,
                                   MyPuissance4.Est_Nul,
                                   MyPuissance4.Afficher,
                                   MyPuissance4.Affiche_Coup,
                                   --MyMoteur1.Choix_Coup,
                                   MyPuissance4.Demande_Coup_Joueur1,
                                   --MyMoteur2.Choix_Coup);
                                   MyPuissance4.Demande_Coup_Joueur2);

	package MyPartieOvsH is new Partie(MyPuissance4.Etat,
                                   MyPuissance4.Coup, 
                                   "HUMAIN ",
                                   "ORDINATEUR ",
                                   MyPuissance4.Jouer,
                                   MyPuissance4.Est_Gagnant,
                                   MyPuissance4.Est_Nul,
                                   MyPuissance4.Afficher,
                                   MyPuissance4.Affiche_Coup,
                                   --MyMoteur1.Choix_Coup,
                                   MyPuissance4.Demande_Coup_Joueur1,
                                   MyMoteur2.Choix_Coup);
                                   --MyPuissance4.Demande_Coup_Joueur2);

	package MyPartieHvsO is new Partie(MyPuissance4.Etat,
                                   MyPuissance4.Coup, 
                                   "ORDINATEUR ",
                                   "HUMAIN ",
                                   MyPuissance4.Jouer,
                                   MyPuissance4.Est_Gagnant,
                                   MyPuissance4.Est_Nul,
                                   MyPuissance4.Afficher,
                                   MyPuissance4.Affiche_Coup,
                                   MyMoteur1.Choix_Coup,
                                   --MyPuissance4.Demande_Coup_Joueur1,
                                   --MyMoteur2.Choix_Coup);
                                   MyPuissance4.Demande_Coup_Joueur2);
	
package MyPartieOvsO is new Partie(MyPuissance4.Etat,
                                   MyPuissance4.Coup, 
                                   "ORDINATEUR 1 ",
                                   "ORDINATEUR 2 ",
                                   MyPuissance4.Jouer,
                                   MyPuissance4.Est_Gagnant,
                                   MyPuissance4.Est_Nul,
                                   MyPuissance4.Afficher,
                                   MyPuissance4.Affiche_Coup,
                                   MyMoteur1.Choix_Coup,
                                   --MyPuissance4.Demande_Coup_Joueur1,
                                   MyMoteur2.Choix_Coup);
                                   --MyPuissance4.Demande_Coup_Joueur2);



	P: MyPuissance4.Etat;

    subtype Inter is Integer range 0..10;
    package Aleatoire is new Ada.Numerics.Discrete_Random(Inter);
    use Aleatoire;
	----------------------------------------------
    ----- Génère un entier aléatoire entre 0 et 10
    ----------------------------------------------
    function nb_alea return Integer is  
        Nombre     : Integer;   
        Generateur : Generator;   
    begin 
        Reset(Generateur); 
        Nombre:=Random(Generateur); 
        return Nombre; 
    end nb_alea;

	----------------------------------------------
	----- Variables utilisées  à l'IHM
	----------------------------------------------
	puissance : Natural := 0;
	h : Natural := 0;
	l : Natural := 0;
	tos : Natural := 2;
	tos_res : Integer :=0;
	wait : Integer := 10;
	sablier : Integer :=100000000;
	boucle : Integer := 45;
	partie : Natural := 10;
begin
	while boucle > 0 loop
		boucle := boucle-1;
		New_Line;
	end loop;
	Put_line("---------- LE SUPER PUISSANCE X ----------");
	Put_Line("C'est partie, on joue au Puissance X");
	New_Line;
	New_Line;
	Put_Line("Quelle type de partie voulez vous lancer ?");
	while (partie/=0 and partie/=1 and partie/=2) loop
		Put_Line("Tapez 0 pour une partie Humain VS Humain");
		Put_Line("Tapez 1 pour une partie Humain VS Ordinateur");
		Put_Line("Tapez 2 pour une partie Ordinateur VS Ordinateur");
		get(partie);
	end loop;

	----------------------------------------------
	----- PARTIE H vs O
	----------------------------------------------
	if (partie=0 or partie=1) then 
		New_Line;
		if partie=1 then 
			Put_Line("Partie Humain VS Ordinateur, qui sera le meilleur ? (Humain accrochez vous,  l'ordi est sur-entrainé !!)");
		else
			Put_Line("Un combat qui affronte deux grands champions, que le meilleur gagne");
		end if;
		New_Line;
		Put_Line("Mais qui va jouer en premier ? Choisissez Pile ou Face pour le tirage au sort:");
		while (tos/=1 and tos/=0) loop
			Put_Line("Tapez 0 pour Pile.");
			Put_Line("Tapez 1 pour Face.");
			get(tos);
		end loop;
		Put_Line("Lancement de la pièce...");
		while wait > 0 loop
			wait := wait -1;
			Put("... ");
			while sablier>0 loop
				sablier := sablier-1;
			end loop;
			sablier := 100000000;
		end loop;
		tos_res := nb_alea;
		-- J à pris pile
		if tos = 0 then
			--Pile est sorti
			if tos_res > 5 then
				Put_Line("Pile !");
				New_Line;
				Put_Line("C'est gagné : Le Joueur 1 commence");	
				Put_Line("Joueur 1 : X"); 
				Put_Line("Joueur 2 : O");

				if partie = 0 then 
					MyPuissance4.Initialiser(P);
					MyPartieHvsH.Joue_Partie(P, Joueur1);
				elsif partie = 1 then
					MyPuissance4.Initialiser(P);
					MyPartieOvsH.Joue_Partie(P, Joueur1);
				end if;
				-- face est sorti
			else 
				Put_Line("Face");
				New_Line;
				Put_Line("C'est perdu : Le Joueur 1 commence");	
				Put_Line("Joueur 1 : X"); 
				Put_Line("Joueur 2 : O");

				if partie = 0 then 
					MyPuissance4.Initialiser(P);
					MyPartieHvsH.Joue_Partie(P, Joueur1);
				elsif partie = 1 then
					MyPuissance4.Initialiser(P);
					MyPartieHvsO.Joue_Partie(P, Joueur1);
				end if;
			end if;
			-- J à pris face
		else 
			--Pile est sorti
			if tos_res > 5 then
				Put("Pile");
				New_Line;
				Put_Line("C'est Perdu : Le Joueur 1 commence");	
				Put_Line("Joueur 1 : X"); 
				Put_Line("Joueur 2 : O");

				if partie = 0 then 
					MyPuissance4.Initialiser(P);
					MyPartieHvsH.Joue_Partie(P, Joueur1);
				elsif partie = 1 then
					MyPuissance4.Initialiser(P);
					MyPartieHvsO.Joue_Partie(P, Joueur1);
				end if;
				-- Face est sorti
			else 
				Put("Face");
				New_Line;
				Put_Line("C'est gagné : Le Joueur 1 commence");	
				Put_Line("Joueur 1 : X"); 
				Put_Line("Joueur 2 : O");

				if partie = 0 then 
					MyPuissance4.Initialiser(P);
					MyPartieHvsH.Joue_Partie(P, Joueur1);
				elsif partie = 1 then
					MyPuissance4.Initialiser(P);
					MyPartieOvsH.Joue_Partie(P, Joueur1);
				end if;
			end if;
		end if;
	elsif partie=2 then
		Put_Line("Partie Ordinateur VS Ordinateur, le quel des deux sera le  meilleur ?");
		Put_Line("Cela va être un grand spectacle !!)");
		New_Line;

		MyPuissance4.Initialiser(P);
		MyPartieOvsO.Joue_Partie(P, Joueur1);




	end if;

end Main2Joueurs;
