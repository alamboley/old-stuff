package lo43.projet.utboheme.hexagone;

/**
 * Classe représentant un jeton
 * 	- possède un numéro
 * @author alexandreaugen
 *
 */
public class Jeton {

	private int numero;
	
	/**
	 * Constructeur par défaut
	 */
	public Jeton() {
		this.numero = 0;
	}
	
	/**
	 * Constructeur paramétré
	 * @param pnum
	 */
	public Jeton(int pnum) {
		this.numero = pnum;
	}

	/**
	 * Renvoi le numéro du jeton
	 * @return
	 * 	- un entier
	 */
	public int getNumero() {
		return numero;
	}

}
