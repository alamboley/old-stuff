package lo43.projet.utboheme.carte;

import java.util.Random;

import lo43.projet.utboheme.hexagone.TypeTerrain;

public enum TypeCartes {
	
	BIERE,
	SOMMEIL,
	CAFE,
	SUPPORT,
	NOURRITURE,
	DEVELOPPEMENT;
	

	/**
	 * type de carte aléatoire parmis les cartes de ressource
	 * @return
	 */
	public static TypeCartes random() {
	    int pick = new Random().nextInt(TypeCartes.values().length-1);
	    return TypeCartes.values()[pick];
	}

}
