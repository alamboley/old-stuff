package lo43.projet.utboheme.jeu;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import lo43.projet.utboheme.carte.GroupeCartes;
import lo43.projet.utboheme.carte.GroupeCartesDev;
import lo43.projet.utboheme.carte.SousTypeCartes;
import lo43.projet.utboheme.carte.TypeCartes;
import lo43.projet.utboheme.hexagone.HexaRessource;
import lo43.projet.utboheme.hexagone.HexaZoneTroc;
import lo43.projet.utboheme.hexagone.Hexagone;
import lo43.projet.utboheme.jeuview.JeuFrame;
import lo43.projet.utboheme.pion.Pion;
import lo43.projet.utboheme.pion.UV;

/**
 * Classe representant le jeu
 * 	- possede un attribut tour 
 * 	- possede un attribut pour la valeur du de
 * 	- possede un attribut plateau ou se deroule les actions
 *  - possede une liste de joueurs (participants)
 *  - possede une liste de groupe de cartes (reserve)
 * @author alexandreaugen
 *
 */
public class Jeu {
	
	private int tour;
	private int valeurDes;
	private Plateau plateau;
	private List<Joueur> participants;
	private List<GroupeCartes> reserve;
	private boolean deplacerBinome;
	private boolean carteJoue;
	private boolean DesLances;
	private boolean uvPose;
	private boolean ccPose;
	private int nbUvPose;
	/**
	 * Constructeur par defaut
	 */
	public Jeu(){
		this.tour = 1;
		this.valeurDes = 0;
		this.plateau = null;
		this.participants = null;
		this.reserve = null;
		this.deplacerBinome = false;
		this.carteJoue = false;
		this.DesLances = false;
		this.uvPose = false;
		this.ccPose = false;
		this.nbUvPose = 0;
	}
	
	/**
	 * Constructeur parametre
	 * @param pp
	 */
	public Jeu(Plateau pp) {
		this();
		this.plateau = pp;
		
		this.participants = new ArrayList<Joueur>();
		
		//Creation par defaut des groupes de cartes qui composent la reserve
		this.reserve = new ArrayList<GroupeCartes>();
		this.reserve.add(new GroupeCartes(19, TypeCartes.BIERE));
		this.reserve.add(new GroupeCartes(19, TypeCartes.SOMMEIL));
		this.reserve.add(new GroupeCartes(19, TypeCartes.CAFE));
		this.reserve.add(new GroupeCartes(19, TypeCartes.SUPPORT));
		this.reserve.add(new GroupeCartes(19, TypeCartes.NOURRITURE));
		this.reserve.add(new GroupeCartesDev(2, TypeCartes.DEVELOPPEMENT, SousTypeCartes.CONSTRUCTIONCC));
		this.reserve.add(new GroupeCartesDev(2, TypeCartes.DEVELOPPEMENT, SousTypeCartes.DECOUVERTE));
		this.reserve.add(new GroupeCartesDev(2, TypeCartes.DEVELOPPEMENT, SousTypeCartes.MONOPOLE));
		this.reserve.add(new GroupeCartesDev(5, TypeCartes.DEVELOPPEMENT, SousTypeCartes.POINTVICTOIRE));
		this.reserve.add(new GroupeCartesDev(14, TypeCartes.DEVELOPPEMENT, SousTypeCartes.ANCIEN));
	}
		
	/**
	 * Methode permettant d'incrementer le nombre de tour
	 */
	public void addTours() {
		this.tour += 1;
	}

	/**
	 * Renvoi la valeur du de
	 * @return
	 * 	- un entier
	 */
	public int getValeurDes() {
		return valeurDes;
	}

	/**
	 * Attribut le parametre ˆ la valeur du de
	 * @param pvdes
	 */
	public void setValeurDes(int pvdes) {
		this.valeurDes = pvdes;
	}

	/**
	 * Renvoi le plateau du jeu
	 * @return
	 */
	public Plateau getPlateau() {
		return plateau;
	}

	/**
	 * Renvoi les participant
	 * @return
	 * 	- une liste de joueurs
	 */
	public List<Joueur> getParticipants() {
		return participants;
	}

	/**
	 * Renvoi la reserve 
	 * @return
	 * 	- une liste de groupe de cartes
	 */
	public List<GroupeCartes> getReserve() {
		return reserve;
	}

	/**
	 * Methode permettant d'ajouter un joueur ˆ la liste des participants
	 * @param pj
	 */
	public void setParticipant(Joueur pj) {
		if(participants.size() < 4) {
			participants.add(pj);
		}else{
			System.out.println("Le nombre maximun de participant est atteint : " + participants.size());
		}
	}
	 
	/**
	 * Teste si le binome glandeur est a deplacer
	 * @return
	 * 	- un boolean
	 */
	public boolean isDeplacerBinome() {
		return deplacerBinome;
	}

	/**
	 * Attribut le deplacement du binome glandeur ou non
	 * @param deplacerBinome
	 */
	public void setDeplacerBinome(boolean deplacerBinome) {
		this.deplacerBinome = deplacerBinome;
	}

	/**
	 * Teste si une carte est entrain d'etre joue
	 * @return
	 * 	- un boolean
	 */
	public boolean isCarteJoue() {
		return carteJoue;
	}

	/**
	 * Attribut jouer une carte ou non
	 * @param carteJoue
	 */
	public void setCarteJoue(boolean carteJoue) {
		this.carteJoue = carteJoue;
	}

	/**
	 * Teste si les des ont deja ete lances
	 * @return
	 * 	- un boolean
	 */
	public boolean isDesLances() {
		return DesLances;
	}

	/**
	 * Attribut lancer des ou non
	 * @param desLances
	 */
	public void setDesLances(boolean desLances) {
		DesLances = desLances;
	}

	/**
	 * Teste si une uv a ete pose
	 * @return
	 *  - un boolean
	 */
	public boolean isUvPose() {
		return uvPose;
	}

	/**
	 * Attribut uv pose ou non 
	 * @param uvPose
	 */
	public void setUvPose(boolean uvPose) {
		this.uvPose = uvPose;
	}

	/**
	 * Teste si un controle continu a ete pose
	 * @return
	 *  - un boolean
	 */
	public boolean isCcPose() {
		return ccPose;
	}

	/**
	 * Attribut controle continu pose ou non
	 * @param ccPose
	 */
	public void setCcPose(boolean ccPose) {
		this.ccPose = ccPose;
	}

	/**
	 * Renvoi le nombre d'uv pose
	 * @return
	 * 	- un entier
	 */
	public int getNbUvPose() {
		return nbUvPose;
	}

	/**
	 * Attribut le nombre d'uv pose
	 * @param nbUvPose
	 */
	public void setNbUvPose(int nbUvPose) {
		this.nbUvPose = nbUvPose;
	}

	/**
	 * Methode permettant de renvoyer un groupe de cartes de la reserve selon le type de carte passe en parametre 
	 * @param ptypeC
	 * @return
	 * 	- un groupe de cartes
	 */
	public GroupeCartes getGroupeCarte(TypeCartes ptypeC) {
		GroupeCartes newGroupCart = new GroupeCartes(0, ptypeC);
		for(GroupeCartes gc : reserve) {
			if(gc.getTypeCartes() == ptypeC) {
				newGroupCart = gc;
			}
		}
		return newGroupCart;
	}
	
	/**
	 * Methode permettant de renvoyer la liste de tout les groupes de cartes de type ressource
	 * @return
	 *  - une liste de groupe de cartes de type ressource
	 */
	public List<GroupeCartes> getCartesRess() {
		List<GroupeCartes> lgcRess = new ArrayList<GroupeCartes>();
		for (GroupeCartes g : this.reserve) {
			if(g.getTypeCartes() != TypeCartes.DEVELOPPEMENT) {
				lgcRess.add(g);
			}
		}
		return lgcRess;
	}
	
	/**
	 * Methode permettant de renvoyer la liste de tout les groupes de cartes de type developpement
	 * @return
	 * 	- une liste de groupe de cartes de type developpement
	 */
	public List<GroupeCartes> getCartesDev() {
		List<GroupeCartes> lgcDev = new ArrayList<GroupeCartes>();
		for(GroupeCartes g : this.reserve) {
			if(g.getTypeCartes() == TypeCartes.DEVELOPPEMENT) {
				lgcDev.add(g);
			}
		}
		return lgcDev;
	}
	
	/**
	 * Renvoi le nombre de cartes de developpement
	 * @return
	 * 	- un entier
	 */
	public int nbCartesDev() {
		int res = 0;
		for(GroupeCartes g : this.getCartesDev()) {
			res += g.getNombre();
		}
		return res;
	}
	
	/**
	 * Methode permettant de renvoyer un groupe de cartes de toutes les cartes de developpement
	 * @return
	 * 	- un groupe de cartes de type developpement
	 */
	public GroupeCartes getGroupeCartesDev() {
		return new GroupeCartes(this.nbCartesDev(), TypeCartes.DEVELOPPEMENT);
	}
	
	/**
	 * Methode permettant de renvoyer un groupe de cartes de developpement selon un sous type sstype
	 * @param sstype
	 * @return
	 * 	- un groupe de cartes
	 */
	public GroupeCartes getGroupeCartesDev(SousTypeCartes sstype) {
		GroupeCartes gc = new GroupeCartes();
		for(GroupeCartes g : getCartesDev()) {
			GroupeCartesDev gcd = (GroupeCartesDev) g;
			if(gcd.getSousTypeCartes() == sstype) {
				gc = gcd;
				break;
			}
		}
		return gc;
	}

	/**
	 * Methode permettant d'augmenter un groupe de cartes de la reserve selon le type de carte et le nombre passes en parametre
	 * @param ptypeC
	 * @param pnb
	 */
	public void AugmGroupeCarte(TypeCartes ptypeC, int pnb) {
		this.getGroupeCarte(ptypeC).addCartes(pnb);
	}
	
	/**
	 * Methode permettant de diminuer un groupe de cartes de la reserve selon le type de carte et le nombre passes en parametre
	 * @param ptypeC
	 * @param pnb
	 */
	public void DimGroupeCarte(TypeCartes ptypeC, int pnb) {
		this.getGroupeCarte(ptypeC).remCartes(pnb);
		if(getGroupeCarte(ptypeC).getNombre() < 0) 
			this.getGroupeCarte(ptypeC).setNombre(0);
	}
	
	/**
	 * Methode permettant de diminuer un groupe de cartes de developpement selon le sous type et le nombre passes en parametre
	 * @param sstype
	 * @param pnb
	 */
	public void DimGroupeCarteDev(SousTypeCartes sstype, int pnb) {
		this.getGroupeCartesDev(sstype).remCartes(pnb);
		if(getGroupeCartesDev(sstype).getNombre() < 0)
			this.getGroupeCartesDev(sstype).setNombre(0);
	}
	
	/**
	 * Methode permettant de connaitre le nombre total d'uv pour l'ensemble des participants
	 * @return
	 * 	- un entier
	 */
	public int totalUVParticipants() {
		int res = 0;
		for(Joueur j : participants) {
			res += j.getNbUV();
		}
		return res;
	}
	
	/**
	 * Methode permettant de connaitre le nombre total de cc pour l'ensemble des participants
	 * @return
	 *  - un entien
	 */
	public int totalCCParticipants() {
		int res = 0;
		for (Joueur joueur : participants) {
			res += joueur.getNbCC();
		}
		return res;
	}
	 
	/**
	 * Methode permettant de passer d'un joueur actif ˆ un autre
	 * selon le nombre de tours effectue, le deroulement se fait dans un sens puis dans l'autre
	 */
	public void finirTour() {
		//Phase de fondation : Au tour 3 le joueur actif reste le mm
		if(tour == 3) {
			this.participants.get(this.participants.indexOf(getJoueurActif())).setActif(true);
		//Phase de fondation : Entre le tour 3 et 6, deroulement en sens inverse	
		}else if (tour > 3 && tour < 6) {
			int index = this.participants.indexOf(getJoueurActif());
			
			index--;
			this.getJoueurActif().setActif(false);
			index = (index < 0) ? 2 : index;
			this.participants.get(index).setActif(true);
		//Debut partie : Le dernier joueur reste le joueur actif
		}else if(tour == 6) {
			this.participants.get(this.participants.indexOf(getJoueurActif())).setActif(true);
		// Sinon sens normale (avant tour 3 et apres tour 6)
		}else{
			int index = this.participants.indexOf(getJoueurActif());
			
			index++;
			this.getJoueurActif().setActif(false);
			index = (index >= 3) ? 0 : index;
			this.participants.get(index).setActif(true);
		}
		this.addTours();
	}
	 
	/**
	 * Methode permettant de simuler le lancement de deux des ˆ six faces
	 */
	public void lancerDes() {
		int des1 = 1 + new Random().nextInt(6);
		int des2 = 1 + new Random().nextInt(6);
		this.setValeurDes(des1 + des2);
	}
	
	/**
	 * Methode permettant de renvoyer le joueur actif du jeu
	 * @return
	 * 	- un joueur
	 */
	public Joueur getJoueurActif() {
		Joueur jactif = new Joueur();
		for(Joueur j: this.participants) {
			if (j.isActif()) {
				jactif = j;
				break;
			}
		}
		return jactif;
	}
	
	/**
	 * Methode permettant de diminuer la reserve selon le type de pion passŽ en parametre
	 * @param p
	 */
	public void putRess(Pion p) {
		if(p.getClass() == UV.class) {
			UV uv = (UV) p;
			if(uv.isDoubleEtoile()) {
				this.AugmGroupeCarte(TypeCartes.SUPPORT, 2);
				this.AugmGroupeCarte(TypeCartes.SOMMEIL, 3);
			}else{
				this.AugmGroupeCarte(TypeCartes.BIERE, 1);
				this.AugmGroupeCarte(TypeCartes.NOURRITURE, 1);
				this.AugmGroupeCarte(TypeCartes.SUPPORT, 1);
				this.AugmGroupeCarte(TypeCartes.CAFE, 1);
			}
		}else if(p.getClass() == Pion.class) {
			this.AugmGroupeCarte(TypeCartes.BIERE, 1);
			this.AugmGroupeCarte(TypeCartes.NOURRITURE, 1);
		}
	}
	
	/**
	 * Methode permettant de payer l'achat d'une carte de developpement et de l'affecter au joueur
	 */
	public void payCartesDev() {
		this.AugmGroupeCarte(TypeCartes.SUPPORT, 1);
		this.AugmGroupeCarte(TypeCartes.CAFE, 1);
		this.AugmGroupeCarte(TypeCartes.SOMMEIL, 1);
		GroupeCartesDev gcd = (GroupeCartesDev) getCartesDev().get(new Random().nextInt(getCartesDev().size()));
		getJoueurActif().AugmenterGroupeCarteDev(gcd.getSousTypeCartes(), 1);
		DimGroupeCarteDev(gcd.getSousTypeCartes(), 1);
	}
	
	/**
	 * MŽthode permettant de voler des cartes
	 * Si moitie vrai, moitie des ressources des participants dans la reserve
	 * Si moitie faux, une ressource pour le joueur actif du joueur qui possede une uv sur la nouvelle zone du 
	 * binome glandeur
	 * @param moitie
	 * @return
	 * 	- un boolean
	 */
	public boolean volerCartes(boolean moitie) {
		boolean res = false;
		TypeCartes type = null;
		
		if(moitie) {
			for(Joueur j : participants) {
				if(j.getNbCartesRessTotal() > 7) {
					for(int i=0; i<j.getNbCartesRessTotal()/2; i++) {
						type = j.getGroupeCartes(TypeCartes.random()).getTypeCartes();
						while(j.getGroupeCartes(type).getNombre() <= 0) {
							type = j.getGroupeCartes(TypeCartes.random()).getTypeCartes();
						}
						GroupeCartes gc = j.getGroupeCartes(type);
						gc.remCartes(1);
						AugmGroupeCarte(gc.getTypeCartes(), 1);	
						res = true;
					}
				}			
			}
		}else{
 			Joueur j = plateau.getHexaBinomeG().getSommetUVProprio().get(new Random().nextInt(plateau.getHexaBinomeG().getSommetUVProprio().size()));
 			type = j.getGroupeCartes(TypeCartes.random()).getTypeCartes();
 			if(j.getGroupeCartes(type).getNombre() <= 0) {
 	 			type = j.getGroupeCartes(TypeCartes.random()).getTypeCartes();
 			}
			j.DimGroupeCarte(type, 1);
			getJoueurActif().AugmGroupeCarte(type, 1);
			res = true;
		}
		return res;
	}
	
	/**
	 * MŽthode qui test si le joueur actif a plus de dix points de victoire
	 * @return
	 */
	public boolean gagnerPartie() {
		return (getJoueurActif().getNbPoints() >= 10) ? true : false;
	}
	
	/**
	 * Methode pour attribuer l'ancien le plus vieux
	 * @return
	 * - un boolean
	 */
	public boolean attribuerAncien() {
		boolean res = false;
		if (getJoueurActif().getNbCartesDevJoue(SousTypeCartes.ANCIEN) >= 3) {
			for(Joueur j : participants) {
				if(!j.equals(getJoueurActif()) && j.getNbCartesDevJoue(SousTypeCartes.ANCIEN) < getJoueurActif().getNbCartesDevJoue(SousTypeCartes.ANCIEN)){
					getJoueurActif().setAncien(true);
					getJoueurActif().addNbPoints(2);
					res = true;
				}else{
					j.setAncien(false);
				}
			}
		}else{
			res = false;
		}
		return res;
	} 
	
	/**
	 * Methode pour attribuer le cursus le plus long 
	 * @return
	 * 	- un boolean
	 */
	public boolean attribuerCursus() {
		boolean res = false;
			int nbpion = getJoueurActif().getNbCC() + getJoueurActif().getNbUV() + getJoueurActif().getNbUVStar();
			if(nbpion <= 19) {
				for(Joueur j : participants) {
					if(j.equals(getJoueurActif())){
						getJoueurActif().setCursus(true);
						getJoueurActif().addNbPoints(2);
						res = true;
					}else{
						j.setCursus(false);
					}
				}
			}
		return res;
	} 
	
	/**
	 * Methode pour attribuer une ressource lors du lancement des des
	 * @return
	 * 	- un boolean
	 */
	public boolean attribuerRess() {
		boolean res = false;
		
		for(HexaRessource h : getPlateau().getHexaRessWithUv(getValeurDes())) {
			if(!h.isBinomeG()) {
				for(Joueur jo : h.getSommetUVProprio()) {
					if(getGroupeCarte(h.getTypeCartes()).getNombre() >= 0) {
						DimGroupeCarte(h.getTypeCartes(),1);
						jo.AugmGroupeCarte(h.getTypeCartes(), 1);
						res = true;
					}	
				}
			}
		}
		for(HexaRessource h : getPlateau().getHexaRessWithUvStar(getValeurDes())) {
			if(!h.isBinomeG()) {
				for(Joueur jo : h.getSommetUVStarProprio()) {
					if(getGroupeCarte(h.getTypeCartes()).getNombre() >= 0) {
						DimGroupeCarte(h.getTypeCartes(), 2);
						jo.AugmGroupeCarte(h.getTypeCartes(), 2);
						res = true;
					}	
				}
			}
		}
		return res;
	}
	
	/**
	 * Teste si le joueur actif peux acheter une carte de developpement
	 * @return
	 *  - un boolean
	 */
	public boolean acheterCartesDev() {
		boolean res = false;
		if(getJoueurActif().payCartesDev()) {
			payCartesDev();
			res = true;
		}else{
			res = false;
		}
		return res;
	}
	
	/**
	 * Methode qui permet de faire du troc de ressources entre le joueur actif et la reserve
	 * @param typeOff
	 * @param typeDem
	 * @return
	 * 	- un boolean
	 */
	public boolean trockerCartes(TypeCartes typeOff, TypeCartes typeDem) {
		int nbCartes = 4;
		boolean res = false;
		for(Hexagone h : getPlateau().getHexZoneT()) {
			for(Joueur j : h.getSommetUVProprio()) {
				HexaZoneTroc hexa = (HexaZoneTroc) h;
				if(j == getJoueurActif() && hexa.getTypeCarte() == typeDem && nbCartes > hexa.getTypeTroc()){
					nbCartes = hexa.getTypeTroc();
				}
			}	
		}
		if(getGroupeCarte(typeDem).getNombre() >= 1 && getJoueurActif().getGroupeCartes(typeOff).getNombre() >= nbCartes) {
			getJoueurActif().DimGroupeCarte(typeOff, nbCartes);
			getJoueurActif().AugmGroupeCarte(typeDem, 1);
			DimGroupeCarte(typeDem, 1);
			AugmGroupeCarte(typeOff, nbCartes);
			res = true;
		}
		return res;
	}
	
	/**
	 * Methode qui permet de faire un echange de ressource en deux joueurs
	 * @param typeOff
	 * @param nbOff
	 * @param typeDem
	 * @param nbDem
	 * @param j
	 * @return
	 * 	- un boolean
	 */
	public boolean echangerCartes(TypeCartes typeOff, int nbOff, TypeCartes typeDem, int nbDem, Joueur j){
		boolean res = false;
		if(getJoueurActif().getGroupeCartes(typeOff).getNombre() >= nbOff && j.getGroupeCartes(typeDem).getNombre() >= nbDem){
			getJoueurActif().DimGroupeCarte(typeOff, nbOff);
			j.DimGroupeCarte(typeDem, nbDem);
			getJoueurActif().AugmGroupeCarte(typeDem, nbDem);
			j.AugmGroupeCarte(typeOff, nbOff);
			res = true;
		}
		return res;
	}
	
	/**
	 * Methode qui permet au joueur actif de voler toutes les cartes d'un type au autres joueurs
	 * @param type
	 */
	public void volerAllPart(TypeCartes type) {
		for(Joueur j : participants){
			if(j != getJoueurActif()) {
				getJoueurActif().AugmGroupeCarte(type, j.getGroupeCartes(type).getNombre());
				j.DimGroupeCarte(type, j.getGroupeCartes(type).getNombre());
			}
		}
	}
	
	/**
	 * Methode qui permet de retrouver un joueur selon son nom
	 * @param nom
	 * @return
	 * 	- un joueur
	 */
	public Joueur getJoueur(String nom) {
		Joueur jrech = new Joueur();
		for(Joueur j : participants){
			if(j.getNom() == nom){
				jrech = j;
				break;
			}
		}
		return jrech;
	}
	
	/**
	 * Programme principal
	 * @param args
	 */
	public static void main(String[] args) {
		
		//Creation de la fenetre principale
		new JeuFrame(new Jeu(new Plateau(40))).setVisible(true);
		
	}

}
