package lo43.projet.utboheme.carte;

public class GroupeCartesDev extends GroupeCartes {
	
	private SousTypeCartes sousTypeCartes;
	
	public GroupeCartesDev(int nb, SousTypeCartes type) {
		super(nb, TypeCartes.DEVELOPPEMENT);
		this.sousTypeCartes = type;
	}

	public SousTypeCartes getSousTypeCartes() {
		return sousTypeCartes;
	}

	public void setSousTypeCartes(SousTypeCartes sousTypeCartes) {
		this.sousTypeCartes = sousTypeCartes;
	}

}
