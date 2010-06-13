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
import java.lang.reflect.Type;
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
import lo43.projet.utboheme.carte.TypeCartes;
import lo43.projet.utboheme.carteview.GroupeCartesView;
import lo43.projet.utboheme.hexagone.HexaRessource;
import lo43.projet.utboheme.hexagone.TypeTerrain;
import lo43.projet.utboheme.jeu.Jeu;
import lo43.projet.utboheme.jeu.Joueur;

/**
 * Classe qui permet de représenter graphiquement la classe Jeu
 * Hérite de JFrame
 * 	- possède un attribut de type Jeu pour savoir le jeu à représenter
 *  - possède une représentation graphique du plateau associé au jeu
 *  - possède une liste des représentations graphiques des participants
 *  - possède une liste des groupes de cartes qui composent la reserve
 *  - possède un container pour les cartes
 *  - possède un container pour le container des cartes et les boutons
 *  - possède un label pour la valeur du dé
 *  - possède un champ text pour les informations du jeu
 *  - possède différents boutons de commande  
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
	private JButton btBuyCartes;
	
	/**
	 * Constructeur paramétré
	 * @param pj
	 */
	public JeuFrame(Jeu pj) {
		this.j = pj;
		this.plat = new PlateauView(j.getPlateau());
		this.setTitle("Les colons de l'UTboHème");
		this.setSize(j.getPlateau().getWidth() + 550, j.getPlateau().getHeight() + 500);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setBackground(Color.white);
		this.setLocationRelativeTo(null);
		this.setLayout(new BorderLayout());
		
		//création du container de jeu
		containerJeu = new JPanel();
		containerJeu.setLayout(new GridBagLayout());
		//Mise en place du layout de positionnement
		GridBagConstraints gbc = new GridBagConstraints();
		
		//création du container des cartes
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
		
		//création du champ texte pour les infos du jeu
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
		
		//création du label pour les valeurs du dé
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
		
		//Bouton pour lancer le dé
		btDes = new JButton("Lancer Dés");
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
		btOld = new JButton("Ancien le plus vieu");
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
		gbc.gridy = 5;
		containerJeu.add(btFinTour, gbc);
		
		//Bouton de victoire
		btGagner = new JButton("Gagner");
		btGagner.addActionListener(new ActionGagner());
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.ipadx = 20;
		gbc.ipady = 20;
		gbc.gridx = 1;
		gbc.gridy = 5;
		containerJeu.add(btGagner, gbc);
	
		//Bouton acheter carte de dev
		btBuyCartes = new JButton("Acheter cartes");
		btBuyCartes.addActionListener(new ActionBuyCartes());
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.ipadx = 20;
		gbc.ipady = 20;
		gbc.gridx = 1;
		gbc.gridy = 4;
		containerJeu.add(btBuyCartes, gbc);
		
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
	 * Méthode pour initialiser les participants
	 */
	private void attribuerJoueur() {
		
		joueurV = new ArrayList<JoueurView>();
		ImageIcon imgJ1 = new ImageIcon("img/boy_1.png");
		ImageIcon imgJ2 = new ImageIcon("img/girl_1.png");
		ImageIcon imgJ3 = new ImageIcon("img/boy_3.png");
		
		String nom = (String) JOptionPane.showInputDialog(null, "Nom du joueur 1 ?", "Fiche d'inscription", JOptionPane.QUESTION_MESSAGE, imgJ1, null, null);
		j.setParticipant(new Joueur(1, nom, Color.red));
		joueurV.add(new JoueurView(j.getParticipants().get(0), j.getParticipants().get(0).getCouleur(), "img/boy_1.png"));
		
		nom = (String) JOptionPane.showInputDialog(null, "Nom du joueur 2 ?", "Fiche d'inscription", JOptionPane.QUESTION_MESSAGE, imgJ2, null, null);
		j.setParticipant(new Joueur(2, nom, Color.blue));
		joueurV.add(new JoueurView(j.getParticipants().get(1), j.getParticipants().get(1).getCouleur(), "img/girl_1.png"));
		
		nom = (String) JOptionPane.showInputDialog(null, "Nom du joueur 3 ?", "Fiche d'inscription", JOptionPane.QUESTION_MESSAGE, imgJ3, null, null);
		j.setParticipant(new Joueur(3, nom, new Color(0, 204, 0)));
		joueurV.add(new JoueurView(j.getParticipants().get(2), j.getParticipants().get(2).getCouleur(), "img/boy_3.png"));
		
		j.getParticipants().get(new Random().nextInt(3)).setActif(true);
		infosPartie.setText("Bienvenue dans le Jeu les Colons de l'UTBohèMe ! \n C'est à " + j.getJoueurActif().getNom() + " de commencer la phase de fondation !");
	
	}
	
	/**
	 * Méthode pour créer graphiquement les cartes et les stocker dans la liste associée
	 */
	private void creerCartes() {
		for(GroupeCartes gc : j.getCartesRess()) {
			reserveV.add(new GroupeCartesView(gc));
		}
	}
	
	/**
	 * Méthode pour créer graphiquement les cartes de développemeny et les sctocker dans la lste associée
	 */
	private void creerCartesDev() {
		reserveV.add(new GroupeCartesView(j.getGroupeCartesDev()));
	}
	
	/**
	 * Méthode qui renvoi la représentation graphique du joueur actif
	 * @return
	 * 	- un joueurView
	 */
	private JoueurView getViewJoueurActif() {
		JoueurView jView = new JoueurView();
		for(JoueurView jouer : joueurV) {
			if(jouer.getJoueur() == j.getJoueurActif()) {
				jView = jouer;
				break;
			}
		}
		return jView;
	}
	
	/**
	 * Méthode permettant de repeindre l'ensemble des représentation des joueurs
	 */
	private void updateJoueurs() {
		for(JoueurView jv : joueurV) {
			jv.repaint();
		}	
	}
	
	/**
	 * Méthode permettant de repeindre le containerJeu
	 */
	private void updateReserve() {
		this.containerJeu.repaint();
	}
	
	/**
	 * Méthode permettant de désactiver les composant d'un composant
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
	 * Classe qui permet de gérer les événements de la sourie
	 * @author alexandreaugen
	 *
	 */
	private class MapListener implements MouseListener {

		public void mouseClicked(MouseEvent e) {
			// TODO Auto-generated method stub
		}
	

		public void mouseEntered(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		public void mouseExited(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		public void mousePressed(MouseEvent e) {
			if(!containerJeu.isEnabled()) {
				if(plat.fonder(e.getPoint(), getViewJoueurActif())){
					j.finirTour();
					infosPartie.setText("Phase de fondation : \n C'est à " + j.getJoueurActif().getNom() + " de jouer !");
					if(j.totalUVParticipants() <= 9) {
						enabledButton(containerJeu, true);
						infosPartie.setText("Le jeu peux commencer : \n C'est à " + j.getJoueurActif().getNom() + " de jouer !");
					}
				}
			}else{
				if(!plat.ajouter(e.getPoint(), getJ())){
					infosPartie.setText("C'est à " + j.getJoueurActif().getNom() + " de jouer ! \n Vous ne pouvez pas contruire ici !");
				}else{
					infosPartie.setText("C'est à " + j.getJoueurActif().getNom() + " de jouer ! \n Nouvelle construction !");
				}
			}
			updateJoueurs();
			updateReserve();
		}

		public void mouseReleased(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}
	}
	
	/**
	 * Classe qui gére l'évenement sur le bouton du dé
	 * @author alexandreaugen
	 *
	 */
	private class ActionButtonDes implements ActionListener {

		/**
		 * Méthode qui lance le dé
		 * Affiche le résultat
		 * Attribut les ressources aux joueurs
		 */
		public void actionPerformed(ActionEvent e) {
			// TODO Auto-generated method stub
			j.lancerDes();
			valeurDes.setText("" + j.getValeurDes());
			for(HexaRessource h : j.getPlateau().getHexaRessWithUv(j.getValeurDes())) {
				if(!h.isBinomeG()) {
					for(Joueur jo : h.getSommetUVProprio()) {
						if (j.attribuerRess(h.getTypeCartes(), jo)) {
							infosPartie.setText("Les ressources ont été attribuées à chaques participants !");
						}else{
							infosPartie.setText("La reserve en ressource demandée est vide !");
						}
					}
					if(h.getSommetUVProprio().isEmpty()) {
						infosPartie.setText("Aucun participants ne posséde d'uvs sur les terrains numérotés : " + String.valueOf(h.getJeton().getNumero()) + " !");
					}
				}
			}
			if(j.getValeurDes() == 7) {
				infosPartie.setText("Le binome glandeur à été déplacé !!!");
				if(j.deplacerBinome()) {
					infosPartie.setText("Le binome glandeur à été déplacé !!! \n Des ressources ont été volées !!!");
				}
			}
			updateJoueurs();
			updateReserve();
			plat.update();
			btDes.setEnabled(false);
		}
	}
	
	/**
	 * Classe qui gére l'événement sur le bouton du cursus
	 * @author alexandreaugen
	 *
	 */
	private class ActionButtonCursus implements ActionListener {

		/**
		 * Méthode qui attribut le cursus au joueur actif
		 */
		public void actionPerformed(ActionEvent e) {
			if (j.attribuerCursus()) {
				infosPartie.setText(j.getJoueurActif().getNom() + " prend la cartes Cursus le plus long !");
				updateJoueurs();

			}else{
				infosPartie.setText(j.getJoueurActif().getNom() + " ne possède pas le chemin le plus long !");
			}
		}
	}
	
	/**
	 * Classe qui gére l'événenemt sur le bouton d'ancien
	 * @author alexandreaugen
	 *
	 */
	private class ActionButtonOld implements ActionListener {

		/**
		 * Méthode qui attribut l'ancien au joueur actif
		 */
		public void actionPerformed(ActionEvent e) {
			if (j.attribuerAncien()) {
				infosPartie.setText(j.getJoueurActif().getNom() + " prend la cartes Ancien le plus vieu !");
				updateJoueurs();			
			}else{
				infosPartie.setText(j.getJoueurActif().getNom() + " ne possède pas assez de cartes Ancien !");
			}
		}
	}
	
	/**
	 * Classe qui gére l'événement sur le bouton d'echange
	 * @author alexandreaugen
	 *
	 */
	private class ActionExchange implements ActionListener {

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
			JOptionPane jop = new JOptionPane();
			JOptionPane jop2 = new JOptionPane();
			TypeCartes ressOffre = (TypeCartes) JOptionPane.showInputDialog(null, 
													  "Quel type de ressource souhaitez vos échanger ?",
													  "Echanger des ressources avec la réserve",
													  JOptionPane.QUESTION_MESSAGE,
													  new ImageIcon("img/carte-nourriture.png"),
													  ressJoueur,
													  ressJoueur[0]);
			
			TypeCartes ressDem = (TypeCartes) JOptionPane.showInputDialog(null, 
										  "Quel type de ressource désirez vous ?",
										  "Echanger des ressources avec la réserve",
										  JOptionPane.QUESTION_MESSAGE,
										  new ImageIcon("img/carte-nourriture.png"),
										  ressRess,
										  ressRess[0]);
			if(j.echangerCartes(ressOffre, ressDem)) {
				infosPartie.setText("" + getJ().getJoueurActif().getNom() + " a échanger des ressource " + ressOffre + " contre une ressource de " + ressDem);
			}else{
				infosPartie.setText("" + getJ().getJoueurActif().getNom() + " n'a pas pu échanger des ressource " + ressOffre + " contre une ressource de " + ressDem);
			}
			updateJoueurs();
			updateReserve();
		}
		
	}
	
	/**
	 * Classe qui gére l'événement sur le bouton de fin de tour
	 * @author alexandreaugen
	 *
	 */
	private class ActionFinTour	implements ActionListener {

		/**
		 * Méthode qui permet de finir un tour
		 * Affiche les infos de la partie
		 * Met à jour les représentations graphiques des joueurs
		 */
		public void actionPerformed(ActionEvent e) {
			j.finirTour();
			infosPartie.setText("C'est à " + j.getJoueurActif().getNom() + " de jouer !");
			updateJoueurs();
			btDes.setEnabled(true);
		}
		
	}
	
	/**
	 * Classe qui gére l'évenement sur le bouton de victoire
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
				JTextArea fin = new JTextArea("La Partie est terminée ! \n Victoire de " + j.getJoueurActif().getNom() + " ! \n Nombre de points de victoire : " + j.getJoueurActif().getNbPoints());
				fin.setFont(new Font("Comics", Font.BOLD, 15));
				fin.setForeground(Color.red);
				fin.setEditable(false);
				fin.setLineWrap(true);
				fin.setWrapStyleWord(true);
				getContentPane().add(fin, BorderLayout.CENTER);
			}else{
				infosPartie.setText(j.getJoueurActif().getNom() + " n'a pas encore accumulé(e) 10 points de victoire !");
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
				infosPartie.setText(""+ j.getJoueurActif().getNom() + " achète une carte de développement !");
			}else{
				infosPartie.setText(""+ j.getJoueurActif().getNom() + " ne peut pas acheter de carte de développement ! \n Pas assez de ressources disponible !");
			}
			updateJoueurs();
			updateReserve();
		}
	}

	public Jeu getJ() {
		return j;
	}	

}
