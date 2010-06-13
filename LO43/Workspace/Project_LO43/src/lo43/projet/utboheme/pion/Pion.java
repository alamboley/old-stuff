package lo43.projet.utboheme.pion;

import lo43.projet.utboheme.jeu.Joueur;

/**
 * Classe representant un pion
 * 	- possede un proprietaire 
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
	 * Constructeur parametre
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
	 * Attribut le parametre au proprietaire
	 * @param proprietaire
	 */
	public void setProprietaire(Joueur proprietaire) {
		this.proprietaire = proprietaire;
	}
	 
	

}
