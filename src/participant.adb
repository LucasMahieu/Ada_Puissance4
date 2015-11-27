with Participant;
use Participant;

package body Participant is
	function Adversaire(J : Joueur) return Joueur is
	begin
		if (J = Joueur1) then
			return Joueur2;
		end if;
		if (J = Joueur2) then
			return Joueur1;
		end if;
		return Vide;
	end Adversaire;
end Participant;
