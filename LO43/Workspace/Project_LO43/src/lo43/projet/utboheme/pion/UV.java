package lo43.projet.utboheme.pion;

import lo43.projet.utboheme.jeu.Joueur;

/**
 * Classe repr�sentant une UV
 *  - poss�de un nombre de point de victoire
 *  - poss�de un attribut pour savoir si double �toil� ou non 
 * @author alexandreaugen
 *
 */
public class UV extends Pion {
	
	private int pointVictoire; 
	private boolean doubleEtoile;
	
	/**
	 * Constructeur par d�faut
	 */
	public UV() {
		super();
		this.pointVictoire = 0;
		this.doubleEtoile = false;
	}
	
	/**
	 * Constructeur param�tr�
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
	 * Renvoi le nombre de point de victoire associ�
	 * @return
	 * 	- un entier
	 */
	public int getPointVictoire() {
		return pointVictoire;
	}
	
	/**
	 * Test si l'uv est double �toil� ou non 
	 * @return
	 */
	public boolean isDoubleEtoile() {
		return doubleEtoile;
	}
	 
	/**
	 * M�thode qui change le statut de etoil� ou non 
	 */
	public void changeEtoile() {
		this.doubleEtoile = !this.doubleEtoile;
	}

}
