package lo43.projet.utboheme.hexagone;

/**
 * Classe repr�sentant un jeton
 * 	- poss�de un num�ro
 * @author alexandreaugen
 *
 */
public class Jeton {

	private int numero;
	
	/**
	 * Constructeur par d�faut
	 */
	public Jeton() {
		this.numero = 0;
	}
	
	/**
	 * Constructeur param�tr�
	 * @param pnum
	 */
	public Jeton(int pnum) {
		this.numero = pnum;
	}

	/**
	 * Renvoi le num�ro du jeton
	 * @return
	 * 	- un entier
	 */
	public int getNumero() {
		return numero;
	}

}
