package lo43.projet.utboheme.carte;

/**
 * Classes representant groupes de cartes de developpement
 * Herite de la classe GroupeCartes
 * 	- possede les attributs et methodes de la classe GroupeCartes
 * 	- possede un sous type de carte de developpement 
 * @author alexandreaugen
 *
 */
public class GroupeCartesDev extends GroupeCartes {
	
	private SousTypeCartes sousTypeCartes;
	
	/**
	 * Constructeur par defaut
	 */
	public GroupeCartesDev() {
		super();
		this.sousTypeCartes = null;
	}
	
	/**
	 * Constructeur parametre
	 */
	public GroupeCartesDev(int nb, TypeCartes type, SousTypeCartes sstype) {
		super(nb, type);
		this.sousTypeCartes = sstype;
	}

	/**
	 * Renvoie le sous type de cartes du groupe de cartes de devellopement
	 * @return
	 * 	- sousTypeCartes : SousTypesCartes
	 */
	public SousTypeCartes getSousTypeCartes() {
		return sousTypeCartes;
	}

}
