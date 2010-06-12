package lo43.projet.utboheme.carte;

import java.util.Random;

/**
 * Classe d'énumération des types de carte lié à la classe GroupeCartes
 * @author alexandreaugen
 *
 */
public enum TypeCartes {
	
	BIERE,
	SOMMEIL,
	CAFE,
	SUPPORT,
	NOURRITURE,
	DEVELOPPEMENT;
	

	/**
	 * Méthode qui permet de tirer un type de cartes aléatoirement dans la liste des énumérations
	 * @return
	 * 	- un type de carte
	 */
	public static TypeCartes random() {
	    int pick = new Random().nextInt(TypeCartes.values().length-1);
	    return TypeCartes.values()[pick];
	}

}
