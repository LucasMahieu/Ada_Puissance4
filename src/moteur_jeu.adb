with Participant; use Participant; 
with Liste_Generique;
with Ada.Text_IO;
use Ada.Text_IO;

with Moteur_Jeu;

package body Moteur_Jeu is
	use Moteur_Jeu.Liste_Coups;

	----------------------------------------------
	----- Choix du provhain coup fait par l'ordi
	----- E etat actuel
	----- P profondeur de recherche
	----------------------------------------------
	function Choix_Coup(E: Etat) return coup is
		c : coup;
		lcp : Liste_Coups.Liste;
		it : Iterateur;
		max : Integer;
		tmp : Integer;
	begin
		lcp := Coups_Possibles(E, JoueurMoteur);
		it := Creer_Iterateur(lcp);
		c := Element_Courant(it);
		max := Eval_Min_Max(E, Moteur_Jeu.P,c,JoueurMoteur);
		while A_Suivant(it) loop
		Suivant(it);
			tmp := Eval_Min_Max(E, Moteur_Jeu.P,Element_Courant(it),JoueurMoteur);
			if tmp > max then 
				max := tmp;
				c := Element_Courant(it);
			end if;
		end loop;
		return c;
	end Choix_Coup;

	----------------------------------------------
	----- Evaluer l'coup en fonction de l'etat
	----------------------------------------------
	function Eval_Min_Max(E: Etat; P:Natural; 
		C: Coup; J: Joueur) return Integer is
		lcp : Liste_Coups.Liste;
		it : Iterateur;
		minMax : Integer;
		tmp : Integer;
	begin
		-- Si on est sur une feuille
		if p=0 then
			return Eval(E,J);
		--Pas sur une feuille
		else
			-- Etat terminal
			if Est_Gagnant(E, J)=true 
			or Est_Gagnant(E,Adversaire(J))=true
			or Est_Nul(E)=true then
				return Eval(E, J);
			-- Autres Etats
			else
				lcp := Coups_Possibles(E,J);
				it := Creer_Iterateur(lcp);
				minMax := Eval_Min_Max(	E,
										P-1,
										Element_Courant(it),
										Adversaire(J));
				while A_Suivant(it) loop
					Suivant(it);
						tmp:= Eval_Min_Max(	E,
											P-1,
											Element_Courant(it),
											Adversaire(J));
					if J = JoueurMoteur then
						if tmp > minMax then
							minMax := tmp;
						end if;
					else
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
