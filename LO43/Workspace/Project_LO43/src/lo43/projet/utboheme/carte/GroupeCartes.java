package lo43.projet.utboheme.carte;

public class GroupeCartes {
	
	private int nombre;
	 
	private TypeCartes typeCartes;
	
	public GroupeCartes() {
		this.nombre = 0;
		this.typeCartes = null;
	}
	
	public GroupeCartes(int pnb, TypeCartes ptypeC) {
		this.nombre = pnb;
		this.typeCartes = ptypeC;
	}
	 
	public int getNombre() {
		return nombre;
	}

	public void setNombre(int nombre) {
		this.nombre = nombre;
	}

	public TypeCartes getTypeCartes() {
		return typeCartes;
	}

	public void setTypeCartes(TypeCartes typeCartes) {
		this.typeCartes = typeCartes;
	}
	
	public void addCartes(int pnb) {
		this.setNombre(this.getNombre() + pnb);
	}
	
	public void remCartes(int pnb) {
		this.setNombre(this.getNombre() - pnb);
	}

}
