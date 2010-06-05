package lo43.projet.utboheme.jeu;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import lo43.projet.utboheme.carte.GroupeCartes;
import lo43.projet.utboheme.carte.GroupeCartesDev;
import lo43.projet.utboheme.carte.SousTypeCartes;
import lo43.projet.utboheme.carte.TypeCartes;
import lo43.projet.utboheme.jeuview.JeuFrame;

public class Jeu {
	
	private int tour;
	private int valeurDes;
	private Plateau plateau;
	private List<Joueur> participants;
	private List<GroupeCartes> reserve;
	private Joueur joueurActif;
	
	public Jeu(){
		this.setTour(0);
		this.setValeurDes(0);
		this.setPlateau(null);
		this.setParticipants(null);
		this.setReserve(null);
		this.setJoueurActif(null);
	}
	
	public Jeu(Plateau pp) {
		this.setTour(0);
		this.setValeurDes(0);
		this.setPlateau(pp);
		this.setJoueurActif(null);
		
		this.participants = new ArrayList<Joueur>();
		this.participants.add(new Joueur());
		this.participants.add(new Joueur());
		this.participants.add(new Joueur());
		
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
	
	public int getTour() {
		return tour;
	}

	public void setTour(int ptour) {
		this.tour = ptour;
	}

	public int getValeurDes() {
		return valeurDes;
	}

	public void setValeurDes(int pvdes) {
		this.valeurDes = pvdes;
	}

	public Plateau getPlateau() {
		return plateau;
	}

	public void setPlateau(Plateau pp) {
		this.plateau = pp;
	}

	public List<Joueur> getParticipants() {
		return participants;
	}

	public void setParticipants(List<Joueur>plp) {
		this.participants = plp;
	}

	public List<GroupeCartes> getReserve() {
		return reserve;
	}

	public void setReserve(List<GroupeCartes> plr) {
		this.reserve = plr;
	}

	public Joueur getJoueurActif() {
		return joueurActif;
	}

	public void setJoueurActif(Joueur pja) {
		this.joueurActif = pja;
	}
	 
	public void setParticipant(Joueur pj) {
		if(participants.size() < 4) {
			participants.add(pj);
		}else{
			System.out.println("Le nombre maximun de participant est atteind : " + participants.size());
		}
	}
	 
	public GroupeCartes getGroupeCarte(TypeCartes ptypeC) {
		for(GroupeCartes gc : reserve) {
			if(gc.getTypeCartes() == ptypeC) {
				return gc;
			}
		}
		return null;
	}
	
	public void setGroupeCarte(TypeCartes ptypeC, int pnb) {
		this.getGroupeCarte(ptypeC).addCartes(pnb);
	}
	
	public GroupeCartes getGroupeCarte(TypeCartes ptypeC, int pnb) {
		int nb;
		if(this.getGroupeCarte(ptypeC).getNombre() > 0) {
			if(this.getGroupeCarte(ptypeC).getNombre() >= pnb) {
				nb = pnb;
			}else{
				nb = this.getGroupeCarte(ptypeC).getNombre();
			}
			return new GroupeCartes(nb, ptypeC);
		}
		System.out.println("La reserve de cartes " + ptypeC + " est vide" );
		return null;
	}
	 
	public void finirTour() {
		// si on a pas atteint le dernier joueur on passe au suivant, sinon on revient au premier
		if (tour < participants.size())
			joueurActif = participants.get(++tour);
		else {
			tour = 0;
			joueurActif = participants.get(tour);
		}
	}
	 
	public void phaseFondation() {
	 
	}
	 
	public void lancerDes() {
		int des1 = 1 + new Random().nextInt(6);
		int des2 = 1 + new Random().nextInt(6);
		this.setValeurDes(des1 + des2);
	}

	public boolean distribuerRess(){
		
		return false;
	}
	
	public boolean hasCursusPlusLong(Joueur pj) {
		return false;
	}
	 
	public boolean hasAncientPlusVieu(Joueur pj) {
		return false;
	}


	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO appeler le constructeur correctement avec les bons parametres (cartes)
		
		new JeuFrame(new Jeu(new Plateau(45))).setVisible(true);

	}

}
