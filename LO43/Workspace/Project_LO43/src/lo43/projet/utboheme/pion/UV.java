package lo43.projet.utboheme.pion;

import lo43.projet.utboheme.jeu.Joueur;

public class UV extends Pion {
	
	private int pointVictoire; 
	private boolean doubleEtoile;
	
	public UV() {
		super();
		this.pointVictoire = 0;
		this.doubleEtoile = false;
	}
	
	public UV(Joueur pj, int pptvict, boolean dstar) {
		super(pj);
		this.pointVictoire = pptvict;
		this.doubleEtoile = dstar;
	}

	public int getPointVictoire() {
		return pointVictoire;
	}

	public void setPointVictoire(int pointVictoire) {
		this.pointVictoire = pointVictoire;
	}

	public boolean isDoubleEtoile() {
		return doubleEtoile;
	}

	public void setDoubleEtoile(boolean doubleEtoile) {
		this.doubleEtoile = doubleEtoile;
	}
	 
	public void changeEtoile() {
		this.doubleEtoile = !this.doubleEtoile;
	}

}
