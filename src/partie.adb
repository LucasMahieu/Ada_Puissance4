with Partie;
with Ada.Text_IO;
use Ada.Text_IO;

package body Partie is
	procedure Joue_Partie(E : in out Etat; J : in Joueur) is
		detat : Coup;
		j_en_cours : Joueur := J;
	begin
		-- Tant que le match n'est pas nul, on joue.
		while (Est_Nul(E) = false) loop
			Affiche_Jeu(E);
			-- Tour du premier joueur (donné en param)
			if (j_en_cours = Joueur1) then
				-- Le joueur choisit sa colonne
				detat := Coup_Joueur1(E);
				-- On affiche son choix
				Affiche_Coup(detat);
				-- On calcule l'état suivant
				E := Etat_Suivant(E, detat);
				-- Si son coup est gagnant, on quitte la boucle
				if (Est_Gagnant(E, Joueur1)) then
					Put_Line(Partie.Nom_Joueur1 & " a gagné ! Bravo à lui !!!");
					-- On sort de la boucle
					goto exit_loop;
				end if;
				j_en_cours := Joueur2;
			else
				-- Le joueur choisit sa colonne
				detat := Coup_Joueur2(E);
				-- On affiche son choix
				Affiche_Coup(detat);
				-- On calcule l'état suivant
				E := Etat_Suivant(E, detat);
				-- Si son coup est gagnant, on quitte la boucle
				if (Est_Gagnant(E, Joueur2)) then
					Put_Line(Partie.Nom_Joueur2 & " a gagné ... Il a encore triché ...");
					-- On sort de la boucle
					goto exit_loop;
				end if;
				j_en_cours := Joueur1;
			end if;
		end loop;
		-- Si on arrive là, c'est que le match est nul.
		Put_Line("Match nul !!! Vous êtes fiers de vous ?");
		-- Etiquette pour sortir de la boucle en cas de victoire
		<<exit_loop>>
        -- On affiche l'état final.
        Affiche_Jeu(E);

	end Joue_Partie;
end Partie;
