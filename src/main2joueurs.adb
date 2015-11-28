with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Puissance4;
with Participant;
with Partie;
with Liste_Generique;
with Moteur_Jeu;

use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Participant;

procedure Main2Joueurs is

	package MyPuissance4 is new Puissance4(6,5,4);

    package MyMoteur is new Moteur_Jeu(MyPuissance4.Etat,
                                       MyPuissance4.Coup,
                                       MyPuissance4.Jouer,
                                       MyPuissance4.Est_Gagnant,
                                       MyPuissance4.Est_Nul,
                                       MyPuissance4.Affiche_Coup,
                                       MyPuissance4.Liste_Coups,
                                       MyPuissance4.Coups_Possibles,
                                       MyPuissance4.Eval,
                                       3,
                                       Joueur2);

	package MyPartie is new Partie(MyPuissance4.Etat,
                                   MyPuissance4.Coup, 
                                   "Sarah Connor",
                                   "TERMINATOR",
                                   MyPuissance4.Jouer,
                                   MyPuissance4.Est_Gagnant,
                                   MyPuissance4.Est_Nul,
                                   MyPuissance4.Afficher,
                                   MyPuissance4.Affiche_Coup,
                                   MyPuissance4.Demande_Coup_Joueur1,
                                   MyMoteur.Choix_Coup);

	use MyPartie;

	P: MyPuissance4.Etat;

begin
	Put_Line("Puissance 4");
	Put_Line("");
	Put_Line("Joueur 1 : X"); 
	Put_Line("Joueur 2 : O");

	MyPuissance4.Initialiser(P);

	Joue_Partie(P, Joueur2);
end Main2Joueurs;
