package lo43.projet.utboheme.jeuview;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BorderFactory;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import lo43.projet.utboheme.carte.TypeCartes;
 import lo43.projet.utboheme.jeu.Jeu;
import lo43.projet.utboheme.jeu.Joueur;

/**
 * Classe representant la boite de dialogue d'echange de ressources entre deux joueurs
 * @author alexandreaugen
 *
 */
@SuppressWarnings("serial")
public class EchDial extends JDialog{
	
	private TypeCartes ress1, ress2;
	private String nom;
	private int nb1, nb2;
	private Jeu jeu;

	private JLabel ress1Icon, ress1Label, ress2Icon, ress2Label, nomIcon, nomLabel, nb1Label, nb2Label;
	private JComboBox ress1Combo, ress2Combo, nomCombo;
	private JTextField nb1Text, nb2Text;
	
	/**
	 * Constructeur parametre
	 * @param parent
	 * @param title
	 * @param modal
	 * @param j
	 */
	public EchDial(JFrame parent, String title, boolean modal, Jeu j) {
		super(parent, title, modal);
		this.setSize(500, 400);
		this.setLocationRelativeTo(null);
		this.setResizable(false);
		this.setDefaultCloseOperation(JDialog.EXIT_ON_CLOSE);
		
		this.ress1 = null;
		this.ress2 = null;
		this.nom = null;
		this.nb1 = 0;
		this.nb2 = 0;
		this.jeu = j;
		
		this.initComponent();
	}
	
	/*
	 * Initialisation des composants
	 */
	private void initComponent() {
		
		ress1Icon = new JLabel(new ImageIcon("img/carte-nourriture.png"));
		JPanel panIcon1 = new JPanel();
		panIcon1.setLayout(new BorderLayout());
		panIcon1.add(ress1Icon);
		
		ress2Icon = new JLabel(new ImageIcon("img/carte-nourriture.png"));
		JPanel panIcon2 = new JPanel();
		panIcon2.setLayout(new BorderLayout());
		panIcon2.add(ress2Icon);
		
		nomIcon = new JLabel(new ImageIcon("img/boy_5.png"));
		JPanel panIconNom = new JPanel();
		panIconNom.setLayout(new BorderLayout());
		panIconNom.add(nomIcon);
		
		JPanel ress1Pan = new JPanel();
		ress1Pan.setPreferredSize(new Dimension(200, 60));
		ress1Pan.setBorder(BorderFactory.createTitledBorder("Ressources Joueur Actif"));
		ress1Combo = new JComboBox();
		ress1Combo.addItem(TypeCartes.BIERE);
		ress1Combo.addItem(TypeCartes.SOMMEIL);
		ress1Combo.addItem(TypeCartes.CAFE);
		ress1Combo.addItem(TypeCartes.SUPPORT);
		ress1Combo.addItem(TypeCartes.NOURRITURE);
		ress1Label = new JLabel("Ress : ");
		ress1Pan.add(ress1Label);
		ress1Pan.add(ress1Combo);
		
		JPanel nb1Pan = new JPanel();
		nb1Pan.setPreferredSize(new Dimension(200, 60));
		nb1Text = new JTextField();
		nb1Text.setPreferredSize(new Dimension(100, 25));
		nb1Pan.setBorder(BorderFactory.createTitledBorder("Nombre Ressources : "));
		nb1Label = new JLabel("Nombre : ");
		nb1Pan.add(nb1Label);
		nb1Pan.add(nb1Text);
		
		JPanel nomPan = new JPanel();
		nomPan.setPreferredSize(new Dimension(200, 60));
		nomPan.setBorder(BorderFactory.createTitledBorder("Choix joueur"));
		nomCombo = new JComboBox();
		for(Joueur j : jeu.getParticipants()) {
			if(j != jeu.getJoueurActif()){
				nomCombo.addItem(j.getNom());
			}
		}
		nomLabel = new JLabel("Nom : ");
		nomPan.add(nomLabel);
		nomPan.add(nomCombo);
		
		JPanel ress2Pan = new JPanel();
		ress2Pan.setPreferredSize(new Dimension(200, 60));
		ress2Pan.setBorder(BorderFactory.createTitledBorder("Ressource Autre Joueur"));
		ress2Combo = new JComboBox();
		ress2Combo.addItem(TypeCartes.BIERE);
		ress2Combo.addItem(TypeCartes.SOMMEIL);
		ress2Combo.addItem(TypeCartes.CAFE);
		ress2Combo.addItem(TypeCartes.SUPPORT);
		ress2Combo.addItem(TypeCartes.NOURRITURE);
		ress2Label = new JLabel("Ress : ");
		ress2Pan.add(ress2Label);
		ress2Pan.add(ress2Combo);
		
		JPanel nb2Pan = new JPanel();
		nb2Pan.setPreferredSize(new Dimension(200, 60));
		nb2Text = new JTextField();
		nb2Text.setPreferredSize(new Dimension(100, 25));
		nb2Pan.setBorder(BorderFactory.createTitledBorder("Nombre Ressource : "));
		nb2Label = new JLabel("Nombre : ");
		nb2Pan.add(nb2Label);
		nb2Pan.add(nb2Text);
		
		JPanel content = new JPanel();
		content.setLayout(new GridBagLayout());
		GridBagConstraints gbc = new GridBagConstraints();
		
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.gridx = 0;
		gbc.gridy = 0;
		content.add(panIcon1, gbc);
		
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.gridx = 1;
		gbc.gridy = 0;
		content.add(ress1Pan, gbc);
		
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.gridx = 2;
		gbc.gridy = 0;
		content.add(nb1Pan, gbc);
		
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.gridx = 0;
		gbc.gridy = 1;
		content.add(panIconNom, gbc);
		
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.gridx = 1;
		gbc.gridy = 1;
		content.add(nomPan, gbc);
		
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.gridx = 0;
		gbc.gridy = 2;
		content.add(panIcon2, gbc);
		
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.gridx = 1;
		gbc.gridy = 2;
		content.add(ress2Pan, gbc);
		
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.gridx = 2;
		gbc.gridy = 2;
		content.add(nb2Pan, gbc);
		
		JPanel control = new JPanel();
		JButton okBt = new JButton("OK");
		
		okBt.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				setRess1((TypeCartes)ress1Combo.getSelectedItem());
				setNb1(Integer.parseInt(nb1Text.getText()));
				setNom((String)nomCombo.getSelectedItem());
				setRess2((TypeCartes)ress2Combo.getSelectedItem());
				setNb2(Integer.parseInt(nb2Text.getText()));
				setVisible(false);
			}
		});
		
		JButton cancelBt = new JButton("Annuler");
		cancelBt.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				setVisible(false);
			}
		});
		
		control.add(okBt);
		control.add(cancelBt);
		
		this.getContentPane().add(content, BorderLayout.CENTER);
		this.getContentPane().add(control, BorderLayout.SOUTH);
		
		this.setVisible(true);

 
	}

	/**
	 * Renvoi le type de carte offert
	 * @return
	 * 	- un type de carte
	 */
	public TypeCartes getRess1() {
		return ress1;
	}

	/**
	 * Attribut un type de carte offert 
	 * @param ress1
	 */
	public void setRess1(TypeCartes ress1) {
		this.ress1 = ress1;
	}

	/**
	 * Renvoi le type de carte demande
	 * @return
	 *  - un type de carte
	 */
	public TypeCartes getRess2() {
		return ress2;
	}

	/**
	 * Attribut un type de carte demande
	 * @param ress2
	 */
	public void setRess2(TypeCartes ress2) {
		this.ress2 = ress2;
	}

	/**
	 * Renvoi le nom du joueur
	 * @return
	 * 	- un string
	 */
	public String getNom() {
		return nom;
	}

	/**
	 * Attribut le nom du joueur
	 * @param nom
	 */
	public void setNom(String nom) {
		this.nom = nom;
	}

	/**
	 * Renvoi le nombre de cartes offert
	 * @return
	 *  - un entier
	 */
	public int getNb1() {
		return nb1;
	}

	/**
	 * Attribut le nombre de cartes offert
	 * @param nb1
	 */
	public void setNb1(int nb1) {
		this.nb1 = nb1;
	}

	/**
	 * Renvoi le nombre de cartes demande
	 * @return
	 * 	- un entier
	 */
	public int getNb2() {
		return nb2;
	}

	/**
	 * Attribut le nombre de cartes demande
	 * @param nb2
	 */
	public void setNb2(int nb2) {
		this.nb2 = nb2;
	}
	
}
