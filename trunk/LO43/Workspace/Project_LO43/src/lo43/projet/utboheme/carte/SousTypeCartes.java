package lo43.projet.utboheme.carte;

/**
 * Classe d'enumeration des sous types de cartes lies a la classe GroupeCartesDev
 */
public enum SousTypeCartes {

	ANCIEN, CONSTRUCTIONCC, DECOUVERTE, MONOPOLE, POINTVICTOIRE;

	public String toString() {
		String string;

		if (this == ANCIEN)
			string = "Ancien";
		else if (this == CONSTRUCTIONCC)
			string = "Construction CC";
		else if (this == DECOUVERTE)
			string = "Decouverte";
		else if (this == MONOPOLE)
			string = "Monopole";
		else if (this == POINTVICTOIRE)
			string = "Point victoire";
		else
			string = null;

		return string;
	}
}
