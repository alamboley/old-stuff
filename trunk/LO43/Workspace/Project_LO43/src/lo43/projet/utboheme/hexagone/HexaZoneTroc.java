package lo43.projet.utboheme.hexagone;

public class HexaZoneTroc extends Hexagone {
	
	private int typeTroc;
	 
	private TypeTerrain typeRessource;
	
	public HexaZoneTroc() {
		super();
		this.typeTroc = 0;
		this.typeRessource = null;
		System.out.println("Création d'une zone de troc avec constructeur par défaut");
	}
	
	public HexaZoneTroc(int pindX, int pindY, int psize, boolean pbinome, TypeTerrain ptypeT, int ptype, TypeTerrain typeR) {
		super(pindX, pindY, psize, pbinome, ptypeT);
		this.typeTroc = ptype;
		this.typeRessource = typeR;
		System.out.println("Création d'une zone de troc '" + this.getTypeTerr() + "' avec constructeur par recopie");
	}

	public int getTypeTroc() {
		return typeTroc;
	}

	public void setTypeTroc(int typeTroc) {
		this.typeTroc = typeTroc;
	}

	public TypeTerrain getTypeRessource() {
		return typeRessource;
	}

	public void setTypeRessource(TypeTerrain typeRessource) {
		this.typeRessource = typeRessource;
	}
	 
	

}
