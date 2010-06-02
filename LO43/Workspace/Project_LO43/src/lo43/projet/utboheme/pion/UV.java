package lo43.projet.utboheme.pion;

public class UV extends Pion {
	
	private int pointVictoire;
	 
	private boolean doubleEtoile;

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
