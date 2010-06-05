package lo43.projet.utboheme.pion;

import lo43.projet.utboheme.jeu.Joueur;

public class Pion {
	
	private Joueur proprietaire;
	
	public Pion() {
		this.proprietaire = null;
	}
	
	public Pion(Joueur pj) {
		this.proprietaire = pj;
	}

	public Joueur getProprietaire() {
		return proprietaire;
	}

	public void setProprietaire(Joueur proprietaire) {
		this.proprietaire = proprietaire;
	}
	 
	

}
