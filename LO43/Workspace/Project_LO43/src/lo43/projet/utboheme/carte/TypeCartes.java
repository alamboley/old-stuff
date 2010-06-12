package lo43.projet.utboheme.carte;

import java.util.Random;

/**
 * Classe d'�num�ration des types de carte li� � la classe GroupeCartes
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
	 * M�thode qui permet de tirer un type de cartes al�atoirement dans la liste des �num�rations
	 * @return
	 * 	- un type de carte
	 */
	public static TypeCartes random() {
	    int pick = new Random().nextInt(TypeCartes.values().length-1);
	    return TypeCartes.values()[pick];
	}

}
