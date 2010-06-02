package lo43.projet.utboheme.hexagone;

import lo43.projet.utboheme.pion.Pion;

public class Arete {
	
	private Pion controleC;
	private Sommet sDebut;
	private Sommet sFin;
	
	public Arete() {
		this.sDebut = null;
		this.sFin = null;
		this.controleC = null;
	}
	 	
	public Arete(Sommet psdebut, Sommet psfin){
		this.sDebut = psdebut;
		this.sFin = psfin;
		System.out.println("Création d'une aréte a la position debut: " + this.getsDebut() + " et fin: " + this.getsDebut());
	}
	
	public Pion getControleC() {
		return controleC;
	}

	public void setControleC(Pion pcontrolec) {
		this.controleC = pcontrolec;
	}

	public Sommet getsDebut() {
		return sDebut;
	}

	public void setsDebut(Sommet psdebut) {
		this.sDebut = psdebut;
	}

	public Sommet getsFin() {
		return sFin;
	}

	public void setsFin(Sommet psfin) {
		this.sFin = psfin;
	}
	
	public boolean hasCC() {
		if (controleC != null)
			return true;
		else {
			return false;
		}
	}

}
