package lo43.projet.utboheme.carte;

public class GroupeCartesDev extends GroupeCartes {
	
	private SousTypeCartes sousTypeCartes;
	
	public GroupeCartesDev() {
		super();
		this.sousTypeCartes = null;
	}
	
	public GroupeCartesDev(int nb, TypeCartes type, SousTypeCartes sstype) {
		super(nb, type);
		this.sousTypeCartes = sstype;
	}

	public SousTypeCartes getSousTypeCartes() {
		return sousTypeCartes;
	}

	public void setSousTypeCartes(SousTypeCartes sousTypeCartes) {
		this.sousTypeCartes = sousTypeCartes;
	}

}
