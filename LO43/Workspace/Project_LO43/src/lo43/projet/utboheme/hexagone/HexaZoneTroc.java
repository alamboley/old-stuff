package lo43.projet.utboheme.hexagone;

import lo43.projet.utboheme.carte.TypeCartes;

public class HexaZoneTroc extends Hexagone {
	
	private int typeTroc;
	private TypeCartes typeC;
	
	public HexaZoneTroc() {
		super();
		this.typeTroc = 0;
		this.typeC = null;
		System.out.println("Création d'une zone de troc avec constructeur par défaut");
	}
	
	public HexaZoneTroc(int pindX, int pindY, int psize, boolean pbinome, TypeTerrain ptypeT, int ptype, TypeCartes ptypeC) {
		super(pindX, pindY, psize, pbinome, ptypeT);
		this.typeTroc = ptype;
		this.typeC = ptypeC;
		System.out.println("Création d'une zone de troc '" + this.getTypeTerr() + "' avec constructeur par recopie");
	}

	public int getTypeTroc() {
		return typeTroc;
	}

	public void setTypeTroc(int typeTroc) {
		this.typeTroc = typeTroc;
	}

	public TypeCartes getTypeCarte() {
		return typeC;
	}

	public void setTypeCarte(TypeCartes ptypeC) {
		this.typeC = ptypeC;
	}
	 
	

}
