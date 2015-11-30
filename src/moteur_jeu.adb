with Participant; use Participant; 
with Liste_Generique;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Moteur_Jeu;

package body Moteur_Jeu is
    use Moteur_Jeu.Liste_Coups;
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
        --Put("Nb Alea : " & Integer'IMAGE(Nombre) );
    end nb_alea;

    ----------------------------------------------
    ----- Choix du prochain coup fait par l'ordi
    ----- E etat actuel
    ----- P profondeur de recherche
    ----------------------------------------------
    function Choix_Coup(E: Etat) return Coup is
        choicoup : Coup;
        lcp : Liste_Coups.Liste;
        it : Iterateur;
        max : Integer;
        tmp : Integer;
        alea : Integer;
    begin
        lcp := Coups_Possibles(E, JoueurMoteur);
        it := Creer_Iterateur(lcp);
        choicoup := Element_Courant(it);
        max := Eval_Min_Max(E, P - 1, choicoup, Adversaire(JoueurMoteur));
        Put_Line("On choisit parmis :");
        Put(Integer'Image(max));
        while A_Suivant(it) loop
            Suivant(it);
            tmp := Eval_Min_Max(E, P - 1, Element_Courant(it), Adversaire(JoueurMoteur));
            Put(Integer'Image(tmp));
            if tmp > max then 
                max := tmp;
                choicoup := Element_Courant(it);
            elsif tmp = max then
                alea := nb_alea;
                if alea > 5 then
                    choicoup := Element_Courant(it);
                end if;
            end if;
        end loop;
        new_line;
        return choicoup;
    end Choix_Coup;

	----------------------------------------------
	----- Evaluer l'coup en fonction de l'etat
	----------------------------------------------
    function Eval_Min_Max(E: Etat; Prof:Natural; C: Coup; J: Joueur) return Integer is

        lcp : Liste_Coups.Liste;
        it : Iterateur;
        minMax : Integer;
        tmp : Integer;
        E_courant : Etat := E;
        prof_courant : Natural := Prof;
    begin
        -- On applique sur l'état courant le coup passé en paramètre.
        E_courant := Etat_Suivant(E, C);
        if Prof = 0 then
            -- Si on est sur une feuille
            return Eval(E_Courant, JoueurMoteur);
        else
            --Pas sur une feuille
            if Est_Gagnant(E_Courant, J) or Est_Nul(E_Courant) or Est_Gagnant(E_Courant, Adversaire(J)) then
                -- Etat terminal
                return Eval(E_Courant, JoueurMoteur);
            else
                -- Autres Etats
                lcp := Coups_Possibles(E_Courant, J);
                it := Creer_Iterateur(lcp);
                minMax := Eval_Min_Max(E_Courant, prof_courant - 1, Element_Courant(it), Adversaire(J));
                while A_Suivant(it) loop
                    Suivant(it);
                    tmp:= Eval_Min_Max(E_Courant, prof_courant - 1, Element_Courant(it), Adversaire(J));
                    if J = JoueurMoteur then
                        -- Si c'est le Moteur, on prend le MAX
                        if tmp > minMax then
                            minMax := tmp;
                        end if;
                    else
                        -- Si c'est l'adversaire on prend le min
                        if tmp < minMax then
                            minMax := tmp;
                        end if;
                    end if;
                end loop;
                return minMax;
            end if;
        end if;
    end Eval_Min_Max;
end Moteur_jeu;
