package lo43.projet.utboheme.carte;

/**
 * Classes repr�sentant groupes de cartes de d�veloppement
 * H�rite de la classe GroupeCartes
 * 	- poss�de les attributs et m�thodes de la classe GroupeCartes
 * 	- poss�de un sous type de carte de d�veloppement 
 * @author alexandreaugen
 *
 */
public class GroupeCartesDev extends GroupeCartes {
	
	private SousTypeCartes sousTypeCartes;
	
	/**
	 * Constructeur par d�faut
	 */
	public GroupeCartesDev() {
		super();
		this.sousTypeCartes = null;
	}
	
	/**
	 * Constructeur param�tr�
	 * @param nb
	 * @param type
	 * @param sstype
	 */
	public GroupeCartesDev(int nb, TypeCartes type, SousTypeCartes sstype) {
		super(nb, type);
		this.sousTypeCartes = sstype;
	}

	/**
	 * Renvoi le sous type de cartes du groupe de cartes de d�vellopement
	 * @return
	 * 	- sousTypeCartes : SousTypesCartes
	 */
	public SousTypeCartes getSousTypeCartes() {
		return sousTypeCartes;
	}

}
