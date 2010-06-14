package lo43.projet.utboheme.carte;

import java.util.Random;

/**
 * Classe d'enumeration des types de carte lie a la classe GroupeCartes
 */
public enum TypeCartes {

	BIERE, SOMMEIL, CAFE, SUPPORT, NOURRITURE, DEVELOPPEMENT;

	/**
	 * Methode qui permet de tirer un type de cartes aleatoirement dans la liste
	 * des enumerations
	 * 
	 * @return - un type de carte
	 */
	public static TypeCartes random() {
		int pick = new Random().nextInt(TypeCartes.values().length - 1);
		return TypeCartes.values()[pick];
	}

	public String toString() {
		String string;

		if (this == BIERE)
			string = "Biere";
		else if (this == SOMMEIL)
			string = "Sommeil";
		else if (this == CAFE)
			string = "Cafe";
		else if (this == SUPPORT)
			string = "Support";
		else if (this == NOURRITURE)
			string = "Nourriture";
		else if (this == DEVELOPPEMENT)
			string = "Developpement";
		else
			string = null;

		return string;
	}
}
