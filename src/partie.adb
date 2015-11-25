with Partie;

package body Partie is
    procedure Joue_Partie(E : in out Etat; J : in Joueur) is
        test : Coup;

    begin
        Affiche_Jeu(E);
        test := Coup_Joueur1(E);
        E := Etat_Suivant(E, test);
        Affiche_Jeu(E);
        test := Coup_Joueur1(E);
        E := Etat_Suivant(E, test);
        Affiche_Jeu(E);
        test := Coup_Joueur1(E);
        E := Etat_Suivant(E, test);
        Affiche_Jeu(E);
        test := Coup_Joueur1(E);
        E := Etat_Suivant(E, test);
        Affiche_Jeu(E);
        

    end Joue_Partie;
end Partie;
