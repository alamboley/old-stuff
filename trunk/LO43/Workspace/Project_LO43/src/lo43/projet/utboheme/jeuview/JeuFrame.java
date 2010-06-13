package lo43.projet.utboheme.jeuview;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextArea;

import lo43.projet.utboheme.carte.GroupeCartes;
import lo43.projet.utboheme.carte.GroupeCartesDev;
import lo43.projet.utboheme.carte.SousTypeCartes;
import lo43.projet.utboheme.carte.TypeCartes;
import lo43.projet.utboheme.carteview.GroupeCartesView;
import lo43.projet.utboheme.hexagone.HexaRessource;
import lo43.projet.utboheme.jeu.Jeu;
import lo43.projet.utboheme.jeu.Joueur;

/**
 *Classe qui permet de representer graphiquement la classe Jeu
 * Herite de JFrame
 * 	- possede un attribut de type Jeu pour savoir le jeu a representer
 *  - possede une representation graphique du plateau associe au jeu
 *  - possede une liste des representations graphiques des participants
 *  - possede une liste des groupes de cartes qui composent la reserve
 *  - possede un container pour les cartes
 *  - possede un container pour le container des cartes et les boutons
 *  - possede un label pour la valeur du de
 *  - possede un champ text pour les informations du jeu
 *  - possede differents boutons de commande 
 * @author alexandreaugen
 *
 */
@SuppressWarnings("serial")
public class JeuFrame extends JFrame {
	
	private Jeu j;
	private JPanel map;
	private PlateauView plat;
	private List<JoueurView> joueurV;
	private List<GroupeCartesView> reserveV;
	private JPanel containerCartes;
	private JPanel containerJeu;
	private JLabel valeurDes;
	private JTextArea infosPartie;
	private JButton btDes;
	private JButton btCursus;
	private JButton btOld;
	private JButton btExchange;
	private JButton btFinTour;
	private JButton btGagner;
	private JButton btBuyCarte;
	private JButton btPlayCarte;
	private JButton btDoTroc;
	
	/**
	 * Constructeur parametre
	 * @param pj
	 */
	public JeuFrame(Jeu pj) {
		this.j = pj;
		this.plat = new PlateauView(j.getPlateau());
		this.setTitle("Les colons de l'UTboHeme");
		this.setSize(j.getPlateau().getWidth() + 550, j.getPlateau().getHeight() + 500);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setBackground(Color.white);
		this.setLocationRelativeTo(null);
		this.setLayout(new BorderLayout());
		
		//creation du container de jeu
		containerJeu = new JPanel();
		containerJeu.setLayout(new GridBagLayout());
		//Mise en place du layout de positionnement
		GridBagConstraints gbc = new GridBagConstraints();
		
		//creation du container des cartes
		containerCartes = new JPanel();
		containerCartes.setLayout(new GridBagLayout());
		
		reserveV = new ArrayList<GroupeCartesView>();
		creerCartes();
		creerCartesDev();
		
		//Positionnement dans le layout
		gbc.fill = GridBagConstraints.BOTH;
		gbc.weighty = 1.0;
		gbc.weightx = 1.0;
		gbc.gridx = 0;
		gbc.gridy = 0;
		containerCartes.add(reserveV.get(0), gbc);
		
		gbc.fill = GridBagConstraints.BOTH;
		gbc.weighty = 1.0;
		gbc.weightx = 1.0;
		gbc.gridx = 1;
		gbc.gridy = 0;
		containerCartes.add(reserveV.get(1), gbc);
		
		gbc.fill = GridBagConstraints.BOTH;
		gbc.weighty = 1.0;
		gbc.weightx = 1.0;
		gbc.gridx = 2;
		gbc.gridy = 0;
		containerCartes.add(reserveV.get(2), gbc);
		
		gbc.fill = GridBagConstraints.BOTH;
		gbc.weighty = 1.0;
		gbc.weightx = 1.0;
		gbc.gridx = 0;
		gbc.gridy = 1;
		containerCartes.add(reserveV.get(3), gbc);
		
		gbc.fill = GridBagConstraints.BOTH;
		gbc.weighty = 1.0;
		gbc.weightx = 1.0;
		gbc.gridx = 1;
		gbc.gridy = 1;
		containerCartes.add(reserveV.get(4), gbc);
		
		gbc.fill = GridBagConstraints.BOTH;
		gbc.weighty = 1.0;
		gbc.weightx = 1.0;
		gbc.gridx = 2;
		gbc.gridy = 1;
		containerCartes.add(reserveV.get(5), gbc);
		
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.weighty = 1.0;
		gbc.gridx = 0;
		gbc.gridy = 1;
		gbc.gridwidth = 2;
		containerJeu.add(containerCartes, gbc);
		
		//creation du champ texte pour les infos du jeu
		infosPartie = new JTextArea();
		infosPartie.setFont(new Font("Comics", Font.ITALIC, 13));
		infosPartie.setForeground(Color.blue);
		infosPartie.setEditable(false);
		infosPartie.setLineWrap(true);
		infosPartie.setWrapStyleWord(true);
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.weighty = 0.5;
		gbc.gridx = 0;
		gbc.gridy = 0;
		gbc.gridwidth = 2;
		containerJeu.add(infosPartie, gbc);
		
		//creation du label pour les valeurs du de
		valeurDes = new JLabel("0");
		valeurDes.setFont(new Font("Comics", Font.BOLD, 16));
		valeurDes.setForeground(Color.blue);
		valeurDes.setHorizontalAlignment(JLabel.CENTER);
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.weighty = 0.5;
		gbc.gridx = 0;
		gbc.gridy = 2;
		gbc.gridwidth = 1;
		containerJeu.add(valeurDes, gbc);
		
		//Bouton pour lancer le de
		btDes = new JButton("Lancer Des");
		btDes.addActionListener(new ActionButtonDes());
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.weighty = 0.5;
		gbc.ipadx = 20;
		gbc.ipady = 20;
		gbc.gridx = 0;
		gbc.gridy = 3;
		containerJeu.add(btDes, gbc);
		
		//Bouton pour le cursus le plus long
		btCursus = new JButton("Cursus plus long");
		btCursus.addActionListener(new ActionButtonCursus());
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.ipadx = 20;
		gbc.ipady = 20;
		gbc.gridx = 1;
		gbc.gridy = 2;
		containerJeu.add(btCursus, gbc);
	
		//Bouton pour ancien le plus vieu
		btOld = new JButton("Ancien le plus vieux");
		btOld.addActionListener(new ActionButtonOld());
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.ipadx = 20;
		gbc.ipady = 20;
		gbc.gridx = 1;
		gbc.gridy = 3;
		containerJeu.add(btOld, gbc);
		
		//Bouton pour echanger des ressources avec la reserve
		btExchange = new JButton("Echanger");
		btExchange.addActionListener(new ActionExchange());
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.ipadx = 20;
		gbc.ipady = 20;
		gbc.gridx = 0;
		gbc.gridy = 4;
		containerJeu.add(btExchange, gbc);
		
		//Bouton de fin de tour
		btFinTour = new JButton("Fin Tour");
		btFinTour.addActionListener(new ActionFinTour());
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.ipadx = 20;
		gbc.ipady = 20;
		gbc.gridx = 0;
		gbc.gridy = 6;
		containerJeu.add(btFinTour, gbc);
		
		//Bouton de victoire
		btGagner = new JButton("Gagner");
		btGagner.addActionListener(new ActionGagner());
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.ipadx = 20;
		gbc.ipady = 20;
		gbc.gridx = 1;
		gbc.gridy = 6;
		containerJeu.add(btGagner, gbc);
	
		//Bouton acheter carte de dev
		btBuyCarte = new JButton("Acheter carte");
		btBuyCarte.addActionListener(new ActionBuyCartes());
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.ipadx = 20;
		gbc.ipady = 20;
		gbc.gridx = 1;
		gbc.gridy = 4;
		containerJeu.add(btBuyCarte, gbc);
		
		//Bouton joueur carte de dev
		btPlayCarte = new JButton("Jouer carte");
		btPlayCarte.addActionListener(new ActionPlayCarte());
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.ipadx = 20;
		gbc.ipady = 20;
		gbc.gridx = 1;
		gbc.gridy = 5;
		containerJeu.add(btPlayCarte, gbc);
		
		//Bouton faire troc
		btDoTroc = new JButton("Faire Troc");
		btDoTroc.addActionListener(new ActionDoTroc());
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.ipadx = 20;
		gbc.ipady = 20;
		gbc.gridx = 0;
		gbc.gridy = 5;
		containerJeu.add(btDoTroc, gbc);
		
		containerJeu.setEnabled(false);
		
		map = new JPanel();
		plat.addMouseListener(new MapListener());
		map.add(plat);
		
		attribuerJoueur();
		enabledButton(containerJeu, false);
		
		this.getContentPane().add(joueurV.get(2), BorderLayout.NORTH);
		this.getContentPane().add(joueurV.get(1), BorderLayout.WEST);
		this.getContentPane().add(joueurV.get(0), BorderLayout.SOUTH);
		this.getContentPane().add(containerJeu, BorderLayout.EAST);
		this.getContentPane().add(map, BorderLayout.CENTER);

		
	}
	
	/**
	 * Methode pour initialiser les participants
	 */
	private void attribuerJoueur() {
		
		joueurV = new ArrayList<JoueurView>();
		ImageIcon imgJ1 = new ImageIcon("img/boy_1.png");
		ImageIcon imgJ2 = new ImageIcon("img/girl_1.png");
		ImageIcon imgJ3 = new ImageIcon("img/boy_3.png");
		
		String nom1 = new String("Joueur 1");
		String nom2 = new String("Joueur 2");
		String nom3 = new String("Joueur 3");
		String nom = new String();
		
		nom = (String) JOptionPane.showInputDialog(null, "Nom du joueur 1 ?", "Fiche d'inscription", JOptionPane.QUESTION_MESSAGE, imgJ1, null, null);
		if(nom == null) {
			nom = nom1;
		}
		j.setParticipant(new Joueur(1, nom, Color.red));
		joueurV.add(new JoueurView(j.getParticipants().get(0), j.getParticipants().get(0).getCouleur(), "img/boy_1.png"));
		
		nom = (String) JOptionPane.showInputDialog(null, "Nom du joueur 2 ?", "Fiche d'inscription", JOptionPane.QUESTION_MESSAGE, imgJ2, null, null);
		if(nom == null) {
			nom = nom2;
		}
		j.setParticipant(new Joueur(2, nom, Color.blue));
		joueurV.add(new JoueurView(j.getParticipants().get(1), j.getParticipants().get(1).getCouleur(), "img/girl_1.png"));
		
		nom = (String) JOptionPane.showInputDialog(null, "Nom du joueur 3 ?", "Fiche d'inscription", JOptionPane.QUESTION_MESSAGE, imgJ3, null, null);
		if(nom == null) {
			nom = nom3;
		}
		j.setParticipant(new Joueur(3, nom, new Color(0, 204, 0)));
		joueurV.add(new JoueurView(j.getParticipants().get(2), j.getParticipants().get(2).getCouleur(), "img/boy_3.png"));
		
		j.getParticipants().get(new Random().nextInt(3)).setActif(true);
		infosPartie.setText("Bienvenue dans le Jeu les Colons de l'UTBoheMe ! \n C'est a " + j.getJoueurActif().getNom() + " de commencer la phase de fondation !");
	
	}
	
	/**
	 * Methode pour creer graphiquement les cartes et les stocker dans la liste associee
	 */
	private void creerCartes() {
		for(GroupeCartes gc : j.getCartesRess()) {
			reserveV.add(new GroupeCartesView(gc));
		}
	}
	
	/**
	 * Methode pour creer graphiquement les cartes de developpemeny et les sctocker dans la lste associee
	 */
	private void creerCartesDev() {
		reserveV.add(new GroupeCartesView(j.getGroupeCartesDev()));
	}
	
	/**
	 * Méthode permettant de repeindre l'ensemble des representation des joueurs
	 */
	private void updateJoueurs() {
		for(JoueurView jv : joueurV) {
			jv.repaint();
		}	
	}
	
	/**
	 * Methode permettant de repeindre le containerJeu
	 */
	private void updateReserve() {
		this.containerJeu.repaint();
	}
	
	/**
	 * Methode permettant de desactiver les composant d'un composant
	 * @param jc
	 * @param b
	 */
	private void enabledButton(JComponent jc, boolean b) {
		jc.setEnabled(b);
		for(Component c : jc.getComponents()) {
			if(c instanceof JButton) {
				enabledButton((JButton)c, b);
			}
		}
	}
	
	/**
	 * Classe qui permet de gerer les evenements de la sourie
	 * @author alexandreaugen
	 *
	 */
	private class MapListener implements MouseListener {

		public void mousePressed(MouseEvent e) {
			if(!j.isDeplacerBinome()) {
				if(!containerJeu.isEnabled()) {
					if(!j.isCarteJoue()) {
						if(plat.fonder(e.getPoint(), j)){
							j.finirTour();
							infosPartie.setText("Phase de fondation : \n C'est à " + j.getJoueurActif().getNom() + " de jouer !");
							if(j.totalUVParticipants() <= 9) {
								enabledButton(containerJeu, true);
								infosPartie.setText("Le jeu peux commencer : \n C'est à " + j.getJoueurActif().getNom() + " de jouer !");
							}
						}
					}else{
						plat.fonder(e.getPoint(), j);
						j.setNbCursusPose(j.getNbCursusPose()-1);
						if(j.getNbCursusPose() <= 0) {
							j.setCarteJoue(false);
							enabledButton(containerJeu, true);
							infosPartie.setText("La construction des controles continus gratuit est finie !");
						}
					}
				}else{
					if(!plat.ajouter(e.getPoint(), getJ())){
						infosPartie.setText("C'est à " + j.getJoueurActif().getNom() + " de jouer ! \n Vous ne pouvez pas contruire ici !");
					}else{
						infosPartie.setText("C'est à " + j.getJoueurActif().getNom() + " de jouer ! \n Nouvelle construction !");
					}
				}
			}else{
				if(plat.attribuerBinome(e.getPoint())){
					infosPartie.setText("Le binome glandeur à été déplacé par " + j.getJoueurActif().getNom() + " !");
					if(j.isCarteJoue()) {
						j.volerCartes(false);
						j.setCarteJoue(false);
						infosPartie.setText("" + j.getJoueurActif().getNom() + " recoit une carte de ressource !");
					}
					enabledButton(containerJeu, true);
					j.setDeplacerBinome(false);
				}else{
					infosPartie.setText("Le binome glandeur ne peut pas être placé ici !");
				}
			}
			updateJoueurs();
			updateReserve();
		}
		
		public void mouseClicked(MouseEvent e) {
			// TODO Auto-generated method stub
		}
	

		public void mouseEntered(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		public void mouseExited(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		public void mouseReleased(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

	}
	
	/**
	 * Classe qui gere l'evenement sur le bouton du de
	 * @author alexandreaugen
	 *
	 */
	private class ActionButtonDes implements ActionListener {

		/**
		 * Methode qui lance le de
		 * Affiche le resultat
		 * Attribut les ressources aux joueurs
		 */
		public void actionPerformed(ActionEvent e) {
			// TODO Auto-generated method stub
			j.lancerDes();
			valeurDes.setText("" + j.getValeurDes());
			if(j.getValeurDes() != 7) {
				for(HexaRessource h : j.getPlateau().getHexaRessWithUv(j.getValeurDes())) {
					if(!h.isBinomeG()) {
						for(Joueur jo : h.getSommetUVProprio()) {
							if (j.attribuerRess(h.getTypeCartes(), jo)) {
								infosPartie.setText("Les ressources ont ete attribuees à chaques participants !");
							}else{
								infosPartie.setText("La reserve en ressource demandée est vide !");
							}
						}
						if(h.getSommetUVProprio().isEmpty()) {
							infosPartie.setText("Aucun participants ne possede d'uvs sur les terrains numerotes : " + String.valueOf(h.getJeton().getNumero()) + " !");
						}
					}
				}
			}else{
				infosPartie.setText("La moitie des ressources de chaque participants a ete volee ! \n Le binome glandeur doit etre deplace sur un nouvel Hexagone!!!");
				j.volerCartes(true);
				j.setDeplacerBinome(true);
				enabledButton(containerJeu, false);
			}
			updateJoueurs();
			updateReserve();
			plat.update();
			btDes.setEnabled(false);
		}
	}
	
	/**
	 * Classe qui gere l'evenement sur le bouton du cursus
	 * @author alexandreaugen
	 *
	 */
	private class ActionButtonCursus implements ActionListener {

		/**
		 * Methode qui attribut le cursus au joueur actif
		 */
		public void actionPerformed(ActionEvent e) {
			if (j.attribuerCursus()) {
				infosPartie.setText(j.getJoueurActif().getNom() + " prend la cartes Cursus le plus long !");
				updateJoueurs();

			}else{
				infosPartie.setText(j.getJoueurActif().getNom() + " ne possede pas le chemin le plus long !");
			}
		}
	}
	
	/**
	 * Classe qui gere l'evenenemt sur le bouton d'ancien
	 * @author alexandreaugen
	 *
	 */
	private class ActionButtonOld implements ActionListener {

		/**
		 * Methode qui attribut l'ancien au joueur actif
		 */
		public void actionPerformed(ActionEvent e) {
			if (j.attribuerAncien()) {
				infosPartie.setText(j.getJoueurActif().getNom() + " prend la cartes Ancien le plus vieux !");
				updateJoueurs();			
			}else{
				infosPartie.setText(j.getJoueurActif().getNom() + " ne possede pas assez de cartes Ancien !");
			}
		}
	}
	
	/**
	 * Classe qui gere l'evenement sur le bouton d'echange
	 * @author alexandreaugen
	 *
	 */
	private class ActionDoTroc implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			// TODO Auto-generated method stub
			TypeCartes[] ressJoueur = new TypeCartes[getJ().getJoueurActif().getGroupeCartesRess().size()];
			int i = 0;
			for(GroupeCartes gc : getJ().getJoueurActif().getGroupeCartesRess()){
				if(gc.getNombre() > 0){
					ressJoueur[i] = gc.getTypeCartes();
					i++;
				}
			}
			TypeCartes[] ressRess = new TypeCartes[getJ().getCartesRess().size()];
			i = 0;
			for(GroupeCartes gc : getJ().getCartesRess()){
				if(gc.getNombre() > 0){
					ressRess[i] = gc.getTypeCartes();
					i++;
				}
			}
			TypeCartes ressOff = (TypeCartes) JOptionPane.showInputDialog(null, 
													  "Quel type de ressource souhaitez vos echanger ?",
													  "Echanger des ressources avec la reserve",
													  JOptionPane.QUESTION_MESSAGE,
													  new ImageIcon("img/carte-nourriture.png"),
													  ressJoueur,
													  ressJoueur[0]);
			
			TypeCartes ressDem = (TypeCartes) JOptionPane.showInputDialog(null, 
										  "Quel type de ressource desirez vous ?",
										  "Echanger des ressources avec la reserve",
										  JOptionPane.QUESTION_MESSAGE,
										  new ImageIcon("img/carte-nourriture.png"),
										  ressRess,
										  ressRess[0]);
			if(ressDem == null || ressOff == null){
				infosPartie.setText("" + getJ().getJoueurActif().getNom() + " n'a pas pu echanger de ressources !");
			}else if(j.trockerCartes(ressOff, ressDem)) {
				infosPartie.setText("" + getJ().getJoueurActif().getNom() + " a echanger des ressource " + ressOff + " contre une ressource de " + ressDem);
			}else{
				infosPartie.setText("" + getJ().getJoueurActif().getNom() + " n'a pas pu echanger des ressource " + ressOff + " contre une ressource de " + ressDem);
			}
			updateJoueurs();
			updateReserve();
		}
		
	}
	
	/**
	 * Classe qui gere l'evenement sur le bouton de fin de tour
	 * @author alexandreaugen
	 *
	 */
	private class ActionFinTour	implements ActionListener {

		/**
		 * Methode qui permet de finir un tour
		 * Affiche les infos de la partie
		 * Met a jour les representations graphiques des joueurs
		 */
		public void actionPerformed(ActionEvent e) {
			j.finirTour();
			infosPartie.setText("C'est a " + j.getJoueurActif().getNom() + " de jouer !");
			updateJoueurs();
			btDes.setEnabled(true);
		}
		
	}
	
	/**
	 * Classe qui gere l'evenement sur le bouton de victoire
	 * @author alexandreaugen
	 *
	 */
	private class ActionGagner implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			// TODO Auto-generated method stub
			if(j.gagnerPartie()){
				infosPartie.setText(j.getJoueurActif().getNom() + " a accumulé(e) 10 points de victoire et gagne la partie !");
				map.setVisible(false);
				enabledButton(containerJeu, false);
				joueurV.get(0).setEnabled(false);
				JTextArea fin = new JTextArea("La Partie est terminee ! \n Victoire de " + j.getJoueurActif().getNom() + " ! \n Nombre de points de victoire : " + j.getJoueurActif().getNbPoints());
				fin.setFont(new Font("Comics", Font.BOLD, 15));
				fin.setForeground(Color.red);
				fin.setEditable(false);
				fin.setLineWrap(true);
				fin.setWrapStyleWord(true);
				getContentPane().add(fin, BorderLayout.CENTER);
			}else{
				infosPartie.setText(j.getJoueurActif().getNom() + " n'a pas encore accumule(e) 10 points de victoire !");
			}
			
		}
	}
	
	/**
	 * Classe qui gére l'évenement sur le bouton d'achat de cartes
	 * @author alexandreaugen
	 *
	 */
	private class ActionBuyCartes implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			// TODO Auto-generated method stub
			if(j.acheterCartesDev()) {
				infosPartie.setText(j.getJoueurActif().getNom() + " achete une carte de developpement !");
			}else{
				infosPartie.setText(j.getJoueurActif().getNom() + " ne peut pas acheter de carte de developpement ! \n Pas assez de ressources disponible !");
			}
			reserveV.get(5).getgCartes().remCartes(1);
			updateJoueurs();
			updateReserve();
		}
	}
	
	/**
	 * Classe qui gere l'evenement sur le bouton pour jouer une carte de dev
	 * @author alexandreaugen
	 *
	 */
	private class ActionPlayCarte implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			SousTypeCartes[] cartesDev = new SousTypeCartes[getJ().getJoueurActif().getGroupeCartesDev().size()];
			int i = 0;
			for(GroupeCartes gc : getJ().getJoueurActif().getGroupeCartesDev()){
				GroupeCartesDev gcd = (GroupeCartesDev) gc;
				if(gcd.getNombre() > 0){
					cartesDev[i] = gcd.getSousTypeCartes();
					i++;
				}
			}
			
			SousTypeCartes sstype = (SousTypeCartes) JOptionPane.showInputDialog(null, 
													  "Quel cartes de développement souhaitez vous jouer ?",
													  "Jouer une carte de développement",
													  JOptionPane.QUESTION_MESSAGE,
													  new ImageIcon("img/carte-monopole.png"),
													  cartesDev,
													  cartesDev[0]);
			
			if(sstype == null){
				infosPartie.setText("" + getJ().getJoueurActif().getNom() + " n'a pas pu jouer de cartes de développement !");
			}else if(sstype == SousTypeCartes.ANCIEN){
				infosPartie.setText("" + getJ().getJoueurActif().getNom() + " a jouer une carte de développemet :  " + sstype + " ! \n Le binome glandeur doit être déplacé sur un nouvel Hexagone!!!");
				j.setCarteJoue(true);
				j.setDeplacerBinome(true);
				enabledButton(containerJeu, false);
			}else if(sstype == SousTypeCartes.CONSTRUCTIONCC){
				infosPartie.setText("" + getJ().getJoueurActif().getNom() + " a jouer une carte de développemet :  " + sstype + " ! \n Vous pouvez construire deux uvs!!!");
				j.setCarteJoue(true);
				j.setNbCursusPose(2);
				enabledButton(containerJeu, false);
			}else if(sstype == SousTypeCartes.DECOUVERTE){
				TypeCartes[] ressRess = new TypeCartes[getJ().getCartesRess().size()];
				i = 0;
				for(GroupeCartes gc : getJ().getCartesRess()){
					if(gc.getNombre() > 0){
						ressRess[i] = gc.getTypeCartes();
						i++;
					}
				}
				TypeCartes ress= (TypeCartes) JOptionPane.showInputDialog(null, 
						  "Quel type de ressource désirez vous ?",
						  "Prendre des ressources dans la réserve",
						  JOptionPane.QUESTION_MESSAGE,
						  new ImageIcon("img/carte-nourriture.png"),
						  ressRess,
						  ressRess[0]);
				if(ress == null) {
					infosPartie.setText("" + getJ().getJoueurActif().getNom() + " n'a pas pu jouer de cartes de développement !");
				}else{
					j.getGroupeCarte(ress).remCartes(2);
					j.getJoueurActif().getGroupeCartes(ress).addCartes(2);
					infosPartie.setText("" + getJ().getJoueurActif().getNom() + " a jouer une carte de développemet :  " + sstype + " \n Deux cartes de type " + ress + " sont prises dans la réserve !");
				}
			}else if(sstype == SousTypeCartes.MONOPOLE) {
				TypeCartes[] ressRess = new TypeCartes[getJ().getCartesRess().size()];
				i = 0;
				for(GroupeCartes gc : getJ().getCartesRess()){
					if(gc.getNombre() > 0){
						ressRess[i] = gc.getTypeCartes();
						i++;
					}
				}
				TypeCartes ress= (TypeCartes) JOptionPane.showInputDialog(null, 
						  "Quel type de ressource désirez vous ?",
						  "Prendre des ressources à chaque participants",
						  JOptionPane.QUESTION_MESSAGE,
						  new ImageIcon("img/carte-nourriture.png"),
						  ressRess,
						  ressRess[0]);
				if(ress == null) {
					infosPartie.setText("" + getJ().getJoueurActif().getNom() + " n'a pas pu jouer de cartes de développement !");
				}else{
					j.volerAllPart(ress);
					infosPartie.setText("" + getJ().getJoueurActif().getNom() + " a jouer une carte de développemet :  " + sstype + " \n Toutes les cartes de type " + ress + " sont volées aux participants !");
				}
			}else if(sstype == SousTypeCartes.POINTVICTOIRE){
				j.getJoueurActif().addNbPoints(2);
				infosPartie.setText("" + getJ().getJoueurActif().getNom() + " a jouer une carte de développemet :  " + sstype + " \n Ajout de deux points de victoire !");
			}
			
			j.getJoueurActif().jouerCarteDev(sstype);
			updateJoueurs();
			updateReserve();
		}
	}
	
	/**
	 * Classe qui gere l'evenement sur le bouton pour faire du troc
	 * @author alexandreaugen
	 *
	 */
	private class ActionExchange implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			// TODO Auto-generated method stub
		}
	}

	public Jeu getJ() {
		return j;
	}

}
