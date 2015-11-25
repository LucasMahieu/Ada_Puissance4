with Participant, Puissance4;
use Participant;

package body Puissance4 is
    procedure Initialiser(E : Etat) is
        i : Natural := 0;
        j : Natural := 0;
    begin
        -- On boucle sur les range des deux dimensions du tableau
        for i in E'range(1) loop
            for j in E'range(2) loop
                E(i,j) := Vide;
            end loop;
        end loop;
    end Initialiser;
end Puissance4;
