package lo43.projet.utboheme.hexagone;

public class HexaRessource extends Hexagone {
	
	private Jeton jeton;
	
	public HexaRessource() {
		super();
		this.jeton = null;
		System.out.println("Création d'un hexagone de ressource avec constructeur par défaut");
	}
	
	public HexaRessource(int pindX, int pindY, int psize, boolean pbinome, TypeTerrain ptypeT, Jeton pjeton) {
		super(pindX, pindY, psize, pbinome, ptypeT);
		this.jeton = pjeton;
		System.out.println("Création d'un hexagone de ressource '" + this.getTypeTerr() + "' avec constructeur par recopie");
	}

	public Jeton getJeton() {
		return this.jeton;
	}

	public HexaRessource setJeton(Jeton pjeton) {
		this.jeton = pjeton;
		return this;
	}
	
	public HexaRessource setPosition(int pxHex, int pyHex) {
		this.setXHex(pxHex);
		this.setYHex(pyHex);
		this.InitHexa();
		return this;
	}
	 
	

}
