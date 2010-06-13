package lo43.projet.utboheme.pion;

import lo43.projet.utboheme.jeu.Joueur;

/**
 * Classe representant une UV
 *  - possede un nombre de point de victoire
 *  - possede un attribut pour savoir si double etoile ou non 
 * @author alexandreaugen
 *
 */
public class UV extends Pion {
	
	private int pointVictoire; 
	private boolean doubleEtoile;
	
	/**
	 * Constructeur par defaut
	 */
	public UV() {
		super();
		this.pointVictoire = 0;
		this.doubleEtoile = false;
	}
	
	/**
	 * Constructeur parametre
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
	 * Renvoi le nombre de point de victoire associe
	 * @return
	 * 	- un entier
	 */
	public int getPointVictoire() {
		return pointVictoire;
	}
	
	/**
	 * Test si l'uv est double etoile ou non 
	 * @return
	 */
	public boolean isDoubleEtoile() {
		return doubleEtoile;
	}
	 
	/**
	 * Methode qui change le statut de etoile ou non 
	 */
	public void changeEtoile() {
		this.doubleEtoile = !this.doubleEtoile;
	}

}
