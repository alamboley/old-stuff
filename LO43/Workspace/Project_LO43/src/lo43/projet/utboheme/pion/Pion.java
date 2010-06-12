package lo43.projet.utboheme.pion;

import lo43.projet.utboheme.jeu.Joueur;

/**
 * Classe repr�sentant un pion
 * 	- poss�de un proprietaire 
 * @author alexandreaugen
 *
 */
public class Pion {
	
	private Joueur proprietaire;
	
	/**
	 * Constructeur par defaut
	 */
	public Pion() {
		this.proprietaire = null;
	}
	
	/**
	 * Constructeur param�tr�
	 * @param pj
	 */
	public Pion(Joueur pj) {
		this.proprietaire = pj;
	}

	/**
	 * Renvoi le proprietaire
	 * @return
	 * 	- un joueur
	 */
	public Joueur getProprietaire() {
		return proprietaire;
	}

	/**
	 * Attribut le param�tre au proprietaire
	 * @param proprietaire
	 */
	public void setProprietaire(Joueur proprietaire) {
		this.proprietaire = proprietaire;
	}
	 
	

}
