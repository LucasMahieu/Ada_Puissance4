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

    function Jouer(E : Etat; C : Coup) return Etat is
        jVide : Natural := 0;
    begin
        -- Si la colonne où l'on veut jouer est pleine
        if (E'last(2) /= Vide) then
            return null;
        end if;
        -- On se place sur la colonne du coup à jouer
        -- et on cherche l'indice de la première case vide.
        while E(C.col, jVide) /= Vide loop
            jVide := jVide + 1;
        end loop;
        E(C.col, jVide) := C.j;

        return E;
    end Jouer;

end Puissance4;
