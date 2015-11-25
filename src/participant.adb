with Participant;
use Participant;

package body Participant is
function Adversaire(J : Joueur) return Joueur is
begin
    if (J = Joueur1) then
        return Joueur2;
    end if;
    if (j = Joueur2) then
        return Joueur1;
    end if;
    if (J = Vide) then
        return Vide;
    end if;
end Adversaire;
end Participant;
