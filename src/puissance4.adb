with Participant, Puissance4;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
use Participant;
use Ada.Text_IO;

package body Puissance4 is

    procedure Initialiser(E : in out Etat) is
        i : Natural := 0;
        j : Natural := 0;
    begin
        -- On vérifie qu'avec ce tableau, il est possible de gagner
        if (Puissance4.Pions_Victoire > Natural'Max(Puissance4.Hauteur, Puissance4.Largeur)) then
            Put_Line("Mauvais choix de tableau : impossible de gagner !");
        else
            -- On boucle sur les range des deux dimensions du tableau
            for i in E'range(1) loop
                for j in E'range(2) loop
                    E(i,j) := Vide;
                end loop;
            end loop;
        end if;
    exception

    end Initialiser;

    function Jouer(E : Etat; C : Coup) return Etat is
        jVide : Natural := 0;
        etatFinal : Etat := E;
    begin
        -- Si la colonne où l'on veut jouer est pleine
        if (E(C.col, E'last(2)) /= Vide) then
            return E;
        end if;
        -- On se place sur la colonne du coup à jouer
        -- et on cherche l'indice de la première case vide.
        while E(C.col, jVide) /= Vide loop
            jVide := jVide + 1;
        end loop;

        etatFinal(C.col, jVide) := C.j;

        return etatFinal;
    end Jouer;

    function Est_Gagnant(E : Etat; J : Joueur) return Boolean is
        pions_aligne : Natural := 0;
        i : Natural := 0;
        jMax : Natural := 0;
        i_check : Natural := 0;
        j_check : Natural := 0;
    begin
        -- On cherche les colonnes où J a peut être mis son pion
        for i in E'range(1) loop
            -- On place jMax sur la dernière ligne du plateau,
            while (E(i, jMax) /= Vide) loop
                jMax := jMax + 1;
            end loop;
            -- On vérifie si le pion en haut de cette colonne est bien de J
            if (E(i, jMax) = J) then
                i_check := i;
                j_check := jMax;
                -- On traite d'abord les cas sur les bords.
                if (i = 0) then
                    -- Si on est sur la première colonne.
                    -- On se déplace vers la diagonale haute
                    while (E(i_check, j_check) = J and j_check <= E'last(2)) loop
                        pions_aligne := pions_aligne + 1;
                        if (pions_aligne >= Puissance4.Pions_Victoire) then
                            return true;
                        end if;
                        i_check := i_check + 1;
                        j_check := j_check + 1;
                    end loop;

                    i_check := i;
                    j_check := jMax;
                    pions_aligne := 0;

                    -- On se déplace vers la droite.
                    while (E(i_check, j_check) = J loop
                        pions_aligne := pions_aligne + 1;
                        if (pions_aligne >= Puissance4.Pions_Victoire) then
                            return true;
                        end if;
                        i_check := i_check + 1;
                    end loop;

                    i_check := i;
                    j_check := jMax;
                    pions_aligne := 0;

                    -- On se déplace vers diagonale basse.
                    while (E(i_check, j_check) = J and j_check >= E'first(2)) = J loop
                        pions_aligne := pions_aligne + 1;
                        if (pions_aligne >= Puissance4.Pions_Victoire) then
                            return true;
                        end if;
                        i_check := i_check + 1;
                        j_check := j_check - 1;
                    end loop;

                    i_check := i;
                    j_check := jMax;
                    pions_aligne := 0;

                    -- On se déplace vers le bas.
                    while (E(i_check, j_check) = J and j_check >= E'first(2)) = J loop
                        pions_aligne := pions_aligne + 1;
                        if (pions_aligne >= Puissance4.Pions_Victoire) then
                            return true;
                        end if;
                        j_check := j_check - 1;
                    end loop;

                    i_check := i;
                    j_check := jMax;
                    pions_aligne := 0;

                elsif (i = E'last(1)) then
                    -- Si on est sur la dernière colonne.

                elsif (jMax = E'last(2)) then
                    -- Si on est sur la dernière ligne.

                else
                -- On regarde dans les 4 directions autour de la case à la recherche de pions alignés.

                end if;



            end if;
        end loop;

        return false;
    end Est_Gagnant;

    function Est_Nul(E : Etat) return Boolean is

    begin
        -- Le match est nulle lorsque toutes les cases sont occupées.
        null;
        return false;
    end Est_Nul;

    procedure Afficher(E : in Etat) is
        i : Natural := 0;
        j : Natural := 0;
    begin
        for j in reverse E'range(2) loop
            for i in E'range(1) loop
                if (E(i,j) = Joueur1) then
                    Put("|O");
                elsif (E(i,j) = Joueur2) then
                    Put("|X");
                else
                    Put("| ");
                end if;
            end loop;
            Put_Line("|");
        end loop;
    end Afficher;

    procedure Affiche_Coup(C : in Coup) is
    begin
        if (C.j = Joueur1) then
            Put_Line("Le joueur 1 a mis son pion sur la colonne" & Integer'Image(C.col));
        elsif (C.j = Joueur2) then
            Put_Line("Le joueur 2 a mis son pion sur la colonne" & Integer'Image(C.col));
        else
            Put_Line("Erreur.");
        end if;
    end Affiche_Coup;

    function Demande_Coup_Joueur1(E : Etat) return Coup is
        col : Natural := 0;
        trafalgar : Coup;
    begin
        Put("Choix Joueur1 : ");
        Get(col);
        if (col > E'last(1) or col < E'first(1)) then
            Put_Line("Insérez votre pion dans une colonne valide !");
            return Demande_Coup_Joueur1(E);
        end if;
        if (E(col, E'last(2)) /= Vide) then
            Put_Line("Cette colonne est pleine.");
            return Demande_Coup_Joueur1(E);
        end if;
        trafalgar.j := Joueur1;
        trafalgar.col := col;

        return trafalgar;
    end Demande_Coup_Joueur1;

    function Demande_Coup_Joueur2(E : Etat) return Coup is
        col : Natural := 0;
        trafalgar : Coup;
    begin
        Put("Choix Joueur2 : ");
        Get(col);
        if (col > E'last(1) or col < E'first(1)) then
            Put_Line("Insérez votre pion dans une colonne valide !");
            return Demande_Coup_Joueur2(E);
        end if;
        if (E(col, E'last(2)) /= Vide) then
            Put_Line("Cette colonne est pleine.");
            return Demande_Coup_Joueur2(E);
        end if;
        trafalgar.j := Joueur2;
        trafalgar.col := col;

        return trafalgar;
    end Demande_Coup_Joueur2;

end Puissance4;
