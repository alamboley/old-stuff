package lo43.projet.utboheme.pion;

import lo43.projet.utboheme.jeu.Joueur;

/**
 * Classe représentant une UV
 *  - possède un nombre de point de victoire
 *  - possède un attribut pour savoir si double étoilé ou non 
 * @author alexandreaugen
 *
 */
public class UV extends Pion {
	
	private int pointVictoire; 
	private boolean doubleEtoile;
	
	/**
	 * Constructeur par défaut
	 */
	public UV() {
		super();
		this.pointVictoire = 0;
		this.doubleEtoile = false;
	}
	
	/**
	 * Constructeur paramétré
	 * @param pj
	 * @param pptvict
	 * @param dstar
	 */
	public UV(Joueur pj, int pptvict, boolean dstar) {
		super(pj);
		this.pointVictoire = pptvict;
		this.doubleEtoile = dstar;
	}

	/**
	 * Renvoi le nombre de point de victoire associé
	 * @return
	 * 	- un entier
	 */
	public int getPointVictoire() {
		return pointVictoire;
	}
	
	/**
	 * Test si l'uv est double étoilé ou non 
	 * @return
	 */
	public boolean isDoubleEtoile() {
		return doubleEtoile;
	}
	 
	/**
	 * Méthode qui change le statut de etoilé ou non 
	 */
	public void changeEtoile() {
		this.doubleEtoile = !this.doubleEtoile;
	}

}
