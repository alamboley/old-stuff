package  
{
	/**
	 * ...
	 * @author 3wg
	 */
	public class GameVars
	{
		public static var SpeechNightMare:Array = new Array(
		"Je ne pourrai pas aller plus loin.",
		"Je n'ai pas le choix, je dois y aller.",
		"Je veux rentrer chez moi",
		"Que cet endroit est lugubre ",
		"Que vais-je découvrir dans la grotte de l'ours ?"
		);
		
		public static var SpeechHopital:Array = new Array(
		"Ah ! Ce n'était qu'un cauchemar...",
		"Zut la porte est fermée.",
		"Ce cauchemar me hante...",
		"Oh mon doudou... Je devrais le prendre !");
		
		public static var SpeechDots:Array = new Array(
		"1180",
		"1470",
		"780",
		"623");		
		
		public function GameVars() 
		{
			
		}
		
		public static var level1:Array = new Array();
		public static var level2:Array = new Array();
		public static var level3:Array = new Array();
		public static var level4:Array = new Array();
		
		public static var GameScale:Number = 1;
		public static var UpScale:Number = 1;
		
		public static var Props:Array = new Array();
		public static var levelItems:Array = new Array();
		
		public static var LevelWidth:int = new int(0);
		
		public static var level1Fini:Boolean = false;
		
	}

}