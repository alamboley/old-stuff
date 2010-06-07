package lo43.projet.utboheme.hexagone;

import lo43.projet.utboheme.carte.TypeCartes;

public class HexaRessource extends Hexagone {
	
	private Jeton jeton;
	private TypeCartes typeCartes;
	
	public HexaRessource() {
		super();
		this.jeton = null;
		this.typeCartes = null;
		System.out.println("Création d'un hexagone de ressource avec constructeur par défaut");
	}
	
	public HexaRessource(int pindX, int pindY, int psize, boolean pbinome, TypeTerrain ptypeT, TypeCartes ptypeC, Jeton pjeton) {
		super(pindX, pindY, psize, pbinome, ptypeT);
		this.jeton = pjeton;
		this.typeCartes = ptypeC;
		System.out.println("Création d'un hexagone de ressource '" + this.getTypeTerr() + "' avec constructeur par recopie");
	}

	public Jeton getJeton() {
		return this.jeton;
	}

	public HexaRessource setJeton(Jeton pjeton) {
		this.jeton = pjeton;
		return this;
	}
	
	public TypeCartes getTypeCartes() {
		return typeCartes;
	}

	public void setTypeCartes(TypeCartes typeCartes) {
		this.typeCartes = typeCartes;
	}

	public HexaRessource setPosition(int pxHex, int pyHex) {
		this.setXHex(pxHex);
		this.setYHex(pyHex);
		this.InitHexa();
		return this;
	}
	 
	

}
