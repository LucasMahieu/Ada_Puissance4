package Participant is
   
    type Joueur is (Joueur1, Joueur2, Vide);
   
    -- Retourne l'adversaire du joueur passé en paramètre
    function Adversaire(J : Joueur) return Joueur;
      
end Participant;
