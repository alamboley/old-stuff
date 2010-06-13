package lo43.projet.utboheme.carte;

import java.util.Random;

/**
 * Classe d'enumeration des types de carte lie a la classe GroupeCartes
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
	 * Methode qui permet de tirer un type de cartes aleatoirement dans la liste des enumerations
	 * @return
	 * 	- un type de carte
	 */
	public static TypeCartes random() {
	    int pick = new Random().nextInt(TypeCartes.values().length-1);
	    return TypeCartes.values()[pick];
	}

}
