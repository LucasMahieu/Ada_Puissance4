with Participant, Puissance4;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
use Participant;
use Ada.Text_IO;

package body Puissance4 is

    -- On utilise la package Liste_Coups déclaré dans 
    -- puissance4.ads
    use Liste_Coups;

	----------------------------------------------
	----- Init : 
	----------------------------------------------
    procedure Initialiser(E : in out Etat) is
        i : Natural := 0;
        j : Natural := 0;
    begin
        -- On vérifie qu'avec ce tableau, il est possible de gagner
        if (Puissance4.Pions_Victoire > Natural'Max(Puissance4.Hauteur, Puissance4.Largeur)) then
            Put_Line("Mauvais choix de tableau : impossible de gagner !");
            for i in E'range(1) loop
                for j in E'range(2) loop
                    E(i,j) := Joueur1;
                end loop;
            end loop;
            -- Sinon : produire une exception.
        else
            -- On boucle sur les range des deux dimensions du tableau
            for i in E'range(1) loop
                for j in E'range(2) loop
                    E(i,j) := Vide;
                end loop;
            end loop;
        end if;

    end Initialiser;

	----------------------------------------------
	----- Jouer : 
	----------------------------------------------
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

	----------------------------------------------
	----- Est gagnant : 
	----------------------------------------------
    function Est_Gagnant(E : Etat; J : Joueur) return Boolean is
        pions_aligne : Natural := 0;
        jMax : Natural := E'last(2);
        i_check : Natural := 0;
        j_check : Natural := 0;
    begin
        -- On cherche les colonnes où J a peut être mis son pion
        for i in E'range(1) loop

            -- On remet les valeurs à 0 pour la prochaine itération.
            pions_aligne := 0;
            jMax := E'last(2);

            -- On place jMax sur la dernière ligne du plateau,
            while (E(i, jMax) = Vide) loop
                exit when (jMax = 0);
                jMax := jMax - 1;
            end loop;

            -- On vérifie si le pion en haut de cette colonne est bien de J
            if (E(i, jMax) = J) then

                -- Diagonale y = x
                -- Partie haute
                i_check := i;
                j_check := jMax;

                while (E(i_check, j_check) = J) loop
                    pions_aligne := pions_aligne + 1;
                    if (pions_aligne >= Puissance4.Pions_Victoire) then
                        return true;
                    end if;
                    exit when (i_check = E'last(1) or j_check = E'last(2));
                    i_check := i_check + 1;
                    j_check := j_check + 1;
                end loop;

                -- Partie basse
                i_check := i;
                j_check := jMax;
                -- On décrémente pour ne pas compter la case (i, j) deux fois.
                pions_aligne := pions_aligne - 1;

                while (E(i_check, j_check) = J) loop
                    pions_aligne := pions_aligne + 1;
                    if (pions_aligne >= Puissance4.Pions_Victoire) then
                        return true;
                    end if;
                    exit when (j_check = E'first(2) or i_check = E'first(1));
                    i_check := i_check - 1;
                    j_check := j_check - 1;
                end loop;

                i_check := i;
                j_check := jMax;
                pions_aligne := 0;

                -- Diagonale y = -x
                -- Partie haute

                while (E(i_check, j_check) = J) loop
                    pions_aligne := pions_aligne + 1;
                    if (pions_aligne >= Puissance4.Pions_Victoire) then
                        return true;
                    end if;
                    exit when (j_check = E'last(2) or i_check = E'first(1));
                    i_check := i_check - 1;
                    j_check := j_check + 1;
                end loop;

                -- Partie basse
                i_check := i;
                j_check := jMax;
                pions_aligne := pions_aligne - 1;

                while (E(i_check, j_check) = J) loop
                    pions_aligne := pions_aligne + 1;
                    if (pions_aligne >= Puissance4.Pions_Victoire) then
                        return true;
                    end if;
                    exit when (j_check = E'first(2) or i_check = E'last(1));
                    i_check := i_check + 1;
                    j_check := j_check - 1;
                end loop;

                i_check := i;
                j_check := jMax;
                pions_aligne := 0;

                -- Ligne
                -- Partie droite

                while (E(i_check, j_check) = J) loop
                    pions_aligne := pions_aligne + 1;
                    if (pions_aligne >= Puissance4.Pions_Victoire) then
                        return true;
                    end if;
                    exit when (i_check = E'last(1));
                    i_check := i_check + 1;
                end loop;

                -- Partie gauche
                i_check := i;
                j_check := jMax;
                pions_aligne := pions_aligne - 1;

                while (E(i_check, j_check) = J) loop
                    pions_aligne := pions_aligne + 1;
                    if (pions_aligne >= Puissance4.Pions_Victoire) then
                        return true;
                    end if;
                    exit when (i_check = E'first(1));
                    i_check := i_check - 1;
                end loop;

                i_check := i;
                j_check := jMax;
                pions_aligne := 0;

                -- Colonne

                while (E(i_check, j_check) = J) loop
                    pions_aligne := pions_aligne + 1;
                    if (pions_aligne >= Puissance4.Pions_Victoire) then
                        return true;
                    end if;
                    exit when (j_check = E'first(1));
                    j_check := j_check - 1;
                end loop;
            end if;
        end loop;
        
        -- Si aucune des conditions d'au-dessus n'a été validée.
        return false;
    end Est_Gagnant;

	----------------------------------------------
	----- Est NUl ? : 
	----------------------------------------------
    function Est_Nul(E : Etat) return Boolean is
        count : Natural := 0;
        i : Natural := 0;
    begin
        -- Le match est nulle lorsque toutes les cases sont occupées.
        for i in E'range(1) loop
            if (E(i, E'last(2)) /= Vide) then
                count := count + 1;
            end if;
        end loop;

        -- Si toutes les dernières cases sont occupées,
        -- c'est que le tableau est rempli.
        if (count = E'length(1)) then
            return true;
        end if;

        -- Dans le cas contraire, il reste des coups à jouer !
        return false;
    end Est_Nul;

    procedure Afficher(E : in Etat) is
        i : Natural := 0;
        j : Natural := 0;
    begin
        for j in reverse E'range(2) loop
            for i in E'range(1) loop
                if (E(i,j) = Joueur1) then
                    Put("|X");
                elsif (E(i,j) = Joueur2) then
                    Put("|O");
                else
                    Put("| ");
                end if;
            end loop;
            Put_Line("|");
        end loop;
    end Afficher;

	----------------------------------------------
	----- Affiche coup
	----------------------------------------------
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
        Put("Choix Joueur1 X: ");
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

	----------------------------------------------
	----- Demande coup joueur 2 : 
	----------------------------------------------
    function Demande_Coup_Joueur2(E : Etat) return Coup is
        col : Natural := 0;
        trafalgar : Coup;
    begin
        Put("Choix Joueur2 O: ");
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

    function Coups_Possibles(E : Etat; J : Joueur) return Liste is
        coups : Liste;
        coup_ajout : Coup;
    begin
        -- On crée la liste.
        coups := Creer_Liste;

        -- On parcourt les colonnes
        for i in E'range(1) loop
            -- Si la dernière case de la colonne est vide,
            -- on peut réaliser un coup sur celle-ci.
            -- On l'ajoute alors à la liste.
            if (E(i, E'last(2)) = Vide) then
                coup_ajout.j := J;
                coup_ajout.col := i;
                Insere_Tete(coup_ajout, coups);
            end if;
        end loop;
        return coups;
    end Coups_Possibles;

	----------------------------------------------
	----- Eval
	----------------------------------------------
    function Eval(E : Etat; J : Joueur) return Integer is
        -- Pour compter les pions alignés du joueur.
        pions_aligne_j : Natural := 0;
        -- Nombre de séquences maximales de pions alignés
        compteur_j : Natural := 1;
        -- Pour compter les pions alignés de l'adversaire.
        pions_aligne_a : Natural := 0;
        -- Nombre de séquences maximales de pions alignés
        compteur_a : Natural := 1;
        -- Maximul des pions alignés et complétables pour l'itération en cours.
        pions_alignes_max : Natural := 0;
        -- Pions alignés pour l'itération en cours
        pions_aligne : Integer := 0;
        -- Joueur dont on regarde la séquence
        joueur_actuel : Joueur := J;
        -- Indique si la sequence peut être complétée
        possible : Boolean := false;

        i_check : Natural := 0;
        j_check : Natural := 0;
    begin
        -- On cherche d'abord les cas terminaux.
        if (Est_Nul(E)) then
            -- Si la situation est un status quo, on renvoit 0.
            return 0;
        elsif (Est_Gagnant(E, J)) then
            -- Si J est gagnant, on renvoit Pions_Victoire.
            return Puissance4.Pions_Victoire * E'length(1) * E'length(2);
        elsif (Est_Gagnant(E, Adversaire(J))) then
            -- Si son adversaire est gagnant, on renvoit -Pions_Victoire.
            return -(Puissance4.Pions_Victoire * E'length(1) * E'length(2));
        else
            -- Dans les autre cas, on donne une estimation de l'état pour J

            -- On cherche la séquence maximale pions alignés qu'on peut compléter
            -- cela pour les deux joueurs.
            for i in E'range(1) loop
                for j_it in E'range(2) loop

                    joueur_actuel := E(i,j_it);
                    -- Si la case est vide, toutes les cases au dessus
                    -- seront vides aussi.
                    exit when (joueur_actuel = Vide);
                    pions_alignes_max := 0;
                    possible := false;
                    pions_aligne := 0;


                    -- Diagonale y = x
                    -- Partie haute
                    i_check := i;
                    j_check := j_it;

                    while (E(i_check, j_check) = joueur_actuel) loop
                        pions_aligne := pions_aligne + 1;
                        exit when (i_check = E'last(1) or j_check = E'last(2));
                        i_check := i_check + 1;
                        j_check := j_check + 1;
                        -- Pour compléter la séquence, on regarde si la case
                        -- est Vide.
                        if (E(i_check, j_check) = Vide) then
                            -- On regarde si on peut bien la compléter,
                            -- si la case n'est pas "en l'air".
                            if (j_check = 0 or else E(i_check, j_check - 1) /= Vide) then
                                possible := true;
                            end if;
                        end if;
                    end loop;
                    -- Partie basse
                    i_check := i;
                    j_check := j_it;
                    -- On décrémente pour ne pas compter la case (i, j) deux fois.
                    pions_aligne := pions_aligne - 1;

                    while (E(i_check, j_check) = joueur_actuel) loop
                        pions_aligne := pions_aligne + 1;
                        exit when (j_check = E'first(2) or i_check = E'first(1));
                        i_check := i_check - 1;
                        j_check := j_check - 1;
                        -- Pour compléter la séquence, on regarde si la case
                        -- est Vide.
                        if (E(i_check, j_check) = Vide) then
                            -- On regarde si on peut bien la compléter,
                            -- si la case n'est pas "en l'air".
                            if (j_check = 0 or else E(i_check, j_check - 1) /= Vide) then
                                possible := true;
                            end if;
                        end if;
                    end loop;

                    -- On regarde si ce nouvel alignement possible est le plus grand.
                    if (pions_aligne > pions_alignes_max and possible) then
                        pions_alignes_max := pions_aligne;
                    end if;

                    i_check := i;
                    j_check := j_it;
                    pions_aligne := 0;
                    possible := false;

                    -- Diagonale y = -x
                    -- Partie haute

                    while (E(i_check, j_check) = joueur_actuel) loop
                        pions_aligne := pions_aligne + 1;
                        exit when (j_check = E'last(2) or i_check = E'first(1));
                        i_check := i_check - 1;
                        j_check := j_check + 1;
                        -- Pour compléter la séquence, on regarde si la case
                        -- est Vide.
                        if (E(i_check, j_check) = Vide) then
                            -- On regarde si on peut bien la compléter,
                            -- si la case n'est pas "en l'air".
                            if (j_check = 0 or else E(i_check, j_check - 1) /= Vide) then
                                possible := true;
                            end if;
                        end if;
                    end loop;

                    -- Partie basse
                    i_check := i;
                    j_check := j_it;
                    pions_aligne := pions_aligne - 1;

                    while (E(i_check, j_check) = joueur_actuel) loop
                        pions_aligne := pions_aligne + 1;
                        exit when (j_check = E'first(2) or i_check = E'last(1));
                        i_check := i_check + 1;
                        j_check := j_check - 1;
                        -- Pour compléter la séquence, on regarde si la case
                        -- est Vide.
                        if (E(i_check, j_check) = Vide) then
                            -- On regarde si on peut bien la compléter,
                            -- si la case n'est pas "en l'air".
                            if (j_check = 0 or else E(i_check, j_check - 1) /= Vide) then
                                possible := true;
                            end if;
                        end if;
                    end loop;

                    -- On regarde si ce nouvel alignement est le plus grand.
                    if (pions_aligne > pions_alignes_max and possible) then
                        pions_alignes_max := pions_aligne;
                    end if;

                    i_check := i;
                    j_check := j_it;
                    pions_aligne := 0;
                    possible := false;

                    -- Ligne
                    -- Partie droite

                    while (E(i_check, j_check) = joueur_actuel) loop
                        pions_aligne := pions_aligne + 1;
                        exit when (i_check = E'last(1));
                        i_check := i_check + 1;
                        -- Pour compléter la séquence, on regarde si la case
                        -- est Vide.
                        if (E(i_check, j_check) = Vide) then
                            -- On regarde si on peut bien la compléter,
                            -- si la case n'est pas "en l'air".
                            if (j_check = 0 or else E(i_check, j_check - 1) /= Vide) then
                                possible := true;
                            end if;
                        end if;
                    end loop;

                    -- Partie gauche
                    i_check := i;
                    j_check := j_it;
                    pions_aligne := pions_aligne - 1;

                    while (E(i_check, j_check) = joueur_actuel) loop
                        pions_aligne := pions_aligne + 1;
                        exit when (i_check = E'first(1));
                        i_check := i_check - 1;
                        -- Pour compléter la séquence, on regarde si la case
                        -- est Vide.
                        if (E(i_check, j_check) = Vide) then
                            -- On regarde si on peut bien la compléter,
                            -- si la case n'est pas "en l'air".
                            if (j_check = 0 or else E(i_check, j_check - 1) /= Vide) then
                                possible := true;
                            end if;
                        end if;
                    end loop;

                    -- On regarde si ce nouvel alignement est le plus grand.
                    if (pions_aligne > pions_alignes_max and possible) then
                        pions_alignes_max := pions_aligne;
                    end if;

                    i_check := i;
                    j_check := j_it;
                    pions_aligne := 0;
                    possible := false;

                    -- Colonne
                    -- Vers le haut.

                    while (E(i_check, j_check) = joueur_actuel) loop
                        pions_aligne := pions_aligne + 1;
                        exit when (j_check = E'last(2));
                        j_check := j_check + 1;
                        -- Pour compléter la séquence, on regarde si la case
                        -- est Vide.
                        if (E(i_check, j_check) = Vide) then
                            possible := true;
                        end if;
                    end loop;

                    i_check := i;
                    j_check := j_it;
                    pions_aligne := pions_aligne - 1;
                    -- Vers le bas

                    while (E(i_check, j_check) = joueur_actuel) loop
                        pions_aligne := pions_aligne + 1;
                        exit when (j_check = E'first(2));
                        j_check := j_check - 1;
                    end loop;

                    -- On regarde si ce nouvel alignement est le plus grand.
                    if (pions_aligne > pions_alignes_max and possible) then
                        pions_alignes_max := pions_aligne;
                    end if;

                    -- A ce stade, on a pour cette itération le nombre
                    -- maximal de pions alignés.

                    -- Si on trouve une séquence supérieure ou égale à celle
                    -- déjà enregistrée.
                    if (joueur_actuel = J and pions_alignes_max >= pions_aligne_j) then
                        if (pions_alignes_max = pions_aligne_j) then
                            -- On compte le nombre de fois où on
                            -- a trouvé une telle séquence.
                            compteur_j := compteur_j + 1;
                        else
                            pions_aligne_j := pions_alignes_max;
                            compteur_j := 1;
                        end if;

                    -- Idem pour l'adversaire.
                    elsif (joueur_actuel = Adversaire(J) and pions_alignes_max >= pions_aligne_a) then
                        if (pions_alignes_max = pions_aligne_a) then
                            -- On compte le nombre de fois où on
                            -- a trouvé une telle séquence.
                            compteur_a := compteur_a + 1;
                        else
                            pions_aligne_a := pions_alignes_max;
                            compteur_a := 1;
                        end if;
                    end if;
                end loop;
            end loop;

            -- Après avoir parcouru tout le table, on renvoit
            -- une valeur d'évaluation en fonction du nombre et de
            -- la taille des séquences maximales trouvéés.

--            put_line("pions_aligne_j = " & Integer'Image(pions_aligne_j));
--            put_line("pions_aligne_a = " & Integer'Image(pions_aligne_a));
--            put_line("compteur_j = " & Integer'Image(compteur_j));
--            put_line("compteur_a = " & Integer'Image(compteur_a));

            if (pions_aligne_j > pions_aligne_a) then
                --return pions_aligne_j * compteur_j;
                return pions_aligne_j;
            elsif (pions_aligne_a > pions_aligne_j) then
                return -(pions_aligne_a);
            else
                -- Si les deux joueurs ont des séquences complétables de mêmes tailles,
                -- on regarde leur nombre.
--                if (compteur_j > compteur_a) then
                    -- Cas où l'état actuel est favorable (on renvoit un nombre positif).
--                    return pions_aligne_j * compteur_j;
--                elsif (compteur_a > compteur_j) then
                    -- Cas où l'état actuel est défavorable (nombre négatif).
--                    return -(pions_aligne_a * compteur_a);
--                else
                    -- Cas d'égalité : on renvoit 0.
                    return 0;
--                end if;
            end if;

        end if;
    end Eval;

end Puissance4;
