with Participant;
with Liste_Generique;
use Participant;

generic

    -- Largeur du plateau
    Largeur : Integer;
    -- Hauteur du plateau
    Hauteur : Natural;
    -- Nombre de pions alignés nécessaires à la victoire
    Pions_Victoire : Natural;

package Puissance4 is

    -- Tableau à deux dimensions pour connaître la valeur de chaque case.
    type Etat is array (0..Largeur - 1, 0..Hauteur - 1) of Joueur;
    -- Un coup = 1 joueur et 1 colonne
    type Coup is record
        j : Joueur;
        col : Natural;
    end record;

    -- Initialisation de l'état initial
    procedure Initialiser(E : in out Etat);
    -- Calcule l'etat suivant en appliquant le coup
    function Jouer(E : Etat; C : Coup) return Etat;
    -- Indique si l'etat courant est gagnant pour le joueur J
    function Est_Gagnant(E : Etat; J : Joueur) return Boolean;
    -- Indique si l'etat courant est un status quo (match nul)
    function Est_Nul(E : Etat) return Boolean;
    -- Fonction d'affichage de l'etat courant du jeu
    procedure Afficher(E : Etat);
    -- Affiche a l'ecran le coup passe en parametre
    procedure Affiche_Coup(C : in Coup);
    -- Retourne le prochaine coup joue par le joueur1
    function Demande_Coup_Joueur1(E : Etat) return Coup;
    -- Retourne le prochaine coup joue par le joueur2
    function Demande_Coup_Joueur2(E : Etat) return Coup;
    -- Implantation d'un package de liste de coups
    with package Liste_Coups is new Liste_Generique(Coup, Affiche_Coup); 
    -- Retourne la liste des coups possibles pour J a partir de l'etat
    function Coups_Possibles(E : Etat; J : Joueur) return Liste_Coups.Liste;
    -- Evaluation statique du jeu du point de vue de l'ordinateur
    function Eval(E : Etat) return Integer;

end Puissance4;
