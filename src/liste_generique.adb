with Ada.Unchecked_Deallocation;
with Ada.Text_Io; 
use Ada.Text_Io; 

package body Liste_Generique is
	
	type Cellule is record 
		val: Element;
		suiv: Liste;
	end record;

	type Iterateur_Interne is record
		cel: Cellule;
	end record;

	procedure Libere is new Ada.Unchecked_Deallocation(Cellule, Liste);
	procedure Libere_It is new Ada.Unchecked_Deallocation(Iterateur_Interne, Iterateur);

	----------------------------------------------
	----- Affiche le contenu de la Liste
	----------------------------------------------
	procedure Affiche_Liste(L: in Liste) is
		cour: Liste :=L;
	begin
		while cour/=null loop
			Put(cour.val);
			Put(" ");
			cour := cour.suiv;
		end loop;
		New_Line;
	end Affiche_Liste;

	----------------------------------------------
	----- Insere l'element V en tete de liste
	----------------------------------------------
	procedure Insere_Tete(V: in Element; L: in out Liste) is
		tmp : Liste;
	begin
		tmp := new Cellule;
		if L=null then
			tmp.val := V;
			tmp.suiv := null;
		else
			tmp.val := V;
			tmp.suiv := L;
		end if;
		L:=tmp;
	end Insere_Tete;

	----------------------------------------------
	----- Libère la liste 
	----------------------------------------------
	procedure Libere_Liste( L: in out Liste) is
		P:Liste;
	begin
		P:= new Cellule;
		P:=L;
		while P.suiv/=null loop
			P:=P.suiv;
			Libere(L);
			L:=P;
		end loop;
		Libere(P);
		L:=P;
	end Libere_Liste;
	
	----------------------------------------------
	----- Création d'une liste vide
	----------------------------------------------
	function Creer_Liste return Liste is
	begin
		return null;
	end Creer_Liste;

	----------------------------------------------
	----- Création d'un itérateur sur la liste L
	----------------------------------------------
	function Creer_Iterateur(L: Liste) return Iterateur  is
		It : Iterateur;
	begin
		It := new Iterateur_Interne;
		It.cel.val := L.val;
		It.cel.suiv := L.suiv;
		return It; 
	end Creer_Iterateur;


	----------------------------------------------
	----- Libere l'itérateur
	----------------------------------------------
	procedure Libere_Iterateur(It: in out Iterateur) is
	begin
		Libere_It(It);
	end Libere_Iterateur;

	----------------------------------------------
	----- Avance l'iterateur d'une case dans la liste
	----------------------------------------------
	procedure Suivant(It: in out Iterateur) is
	begin
		It.cel.val := It.cel.suiv.val;
		It.cel.suiv := It.cel.suiv.suiv;
	end Suivant;

	----------------------------------------------
	----- Retourne l'élément courant de l'iterateur
	----------------------------------------------
	function Element_Courant(It : Iterateur) return Element  is
	begin
		return It.cel.val;
	end Element_Courant;
	----------------------------------------------
	----- Verifie si il reste un élément à parcourir
	----------------------------------------------
	function A_Suivant (It: Iterateur) return Boolean is
	begin
		if It.cel.suiv=null then
			return false;
		else
			return true;
		end if;
	end A_Suivant;

end Liste_Generique;
