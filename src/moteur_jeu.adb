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
		Put("Nb Alea : " & Integer'IMAGE(Nombre) );
	end nb_alea;

	----------------------------------------------
	----- Choix du provhain coup fait par l'ordi
	----- E etat actuel
	----- P profondeur de recherche
	----------------------------------------------
	function Choix_Coup(E: Etat) return Coup is
		c : Coup;
		lcp : Liste_Coups.Liste;
		it : Iterateur;
		max : Integer;
		tmp : Integer;
		alea : Integer;
	begin
		lcp := Coups_Possibles(E, JoueurMoteur);
		it := Creer_Iterateur(lcp);
		c := Element_Courant(it);
		max := Eval_Min_Max(E, Moteur_Jeu.P,c,JoueurMoteur);
	Put("Choix coup :" & Integer'IMAGE(max) & "colonne:");
	New_Line;
		while A_Suivant(it) loop
			Suivant(it);
			tmp := Eval_Min_Max(E, Moteur_Jeu.P,Element_Courant(it),JoueurMoteur);
			alea := nb_alea;
			Put("Choix coup :" & Integer'IMAGE(tmp));
			New_Line;
			if tmp > max then 
				max := tmp;
				c := Element_Courant(it);
			elsif tmp = max then
				alea := nb_alea;
				if alea > 5 then
					max := tmp;
					c := Element_Courant(it);
				end if;
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
		alea : Integer;
		E_Suivant : Etat;
	begin
		E_Suivant := Etat_Suivant(E,C);
		-- Si on est sur une feuille
		if p=0 then
		Put("Eval MinMax Feuille :" & Integer'IMAGE(Eval(E_Suivant,J)));
		New_Line;
			return Eval(E_Suivant,J);
			--Pas sur une feuille
		else
			-- Etat terminal
			if Est_Gagnant(E_Suivant, J)=true 
				or Est_Gagnant(E_Suivant,Adversaire(J))=true
				or Est_Nul(E_Suivant)=true then
		Put("Eval MinMax etat Terminale :" & Integer'IMAGE(Eval(E_Suivant,J)));
		New_Line;
				return Eval(E_Suivant, J);
				-- Autres Etats
			else
		Put("Eval MinMax");
		New_Line;
				lcp := Coups_Possibles(E_Suivant,J);
				it := Creer_Iterateur(lcp);
				minMax := Eval_Min_Max(E_Suivant,
										P-1,
										Element_Courant(it),
										Adversaire(J));
				while A_Suivant(it) loop
					Suivant(it);
					tmp:= Eval_Min_Max(	E_Suivant,
										P-1,
										Element_Courant(it),
										Adversaire(J));
					-- Si c'est le Moteur, on prend le MAX
					if J=JoueurMoteur then
						if tmp > minMax then
							minMax := tmp;
						-- en cas d'égalité on prend aléatoirement 
						elsif tmp = minMax then
							alea := nb_alea;
							if alea < 5 then
								minMax := tmp;
							end if;
						end if;
					-- Si c'est l'adversaire on prend le min
					else
						if tmp < minMax then
							minMax := tmp;
						-- En cas d'égalité on prend aléatoirement 
						elsif tmp=minMax then
							alea := nb_alea;
							if alea < 5 then
								minMax := tmp;
							end if;
						end if;
					end if;
				end loop;
				return minMax;
			end if;
		end if;
	end Eval_Min_Max;

end Moteur_jeu;
