with Moteur_Jeu;

package body Moteur_Jeu is

    function Choix_Coup(E : Etat) return Coup is
        detat : Coup;
    begin
        return detat;
    end Choix_Coup;

    function Eval_Min_Max(E : Etat; P : Natural; C : Coup; J : Joueur) return Integer is
    begin
        return 0;
    end Eval_Min_Max;

end Moteur_Jeu;
