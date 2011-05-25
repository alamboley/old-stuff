/** * Tutoriel "Les jeux à base de tuiles * "http://ressources.mediabox.fr/tutoriaux/flashplatform/jeux/jeux_a_base_de_tuiles" *  * Classe "Heros" * */package kinessia.pacman.objects {	import kinessia.network.NetworkEvent;	import kinessia.network.PhoneInput;	import kinessia.pacman.Objet;	import kinessia.pacman.TypesObjets;	import flash.events.Event;	import flash.events.KeyboardEvent;	import flash.events.TimerEvent;	import flash.ui.Keyboard;	import flash.utils.Timer;		/**	 * On définit la classe Heros héritière de la classe Objet.	 */	public class Heros extends Objet	{		/**		 * Direction actuelle (code de la dernière touche directionelle enfoncée)		 */		private var _direction:uint;				private var _phoneInput:PhoneInput;				public function Heros ( )		{			/**			 * On définit le type via une des constantes de la classe TypeObjets			 * on choisit "JOUEUR" puisqu'il sagira ici du heros.			 */			type = TypesObjets.JOUEUR;						this.graphics.clear();			this.graphics.beginFill(0xFF0000);			this.graphics.drawCircle(12.5, 12.5, 15);			this.graphics.endFill();						_phoneInput = new PhoneInput();			_phoneInput.initialize();						/**			 * On attends que le héros soit ajouté a la carte.			 */			addEventListener ( Event.ADDED_TO_STAGE, addedToStage );		}				public function addedToStage ( $e:Event ):void		{			removeEventListener ( Event.ADDED_TO_STAGE, addedToStage );						/**			 * On écoute l'évènement keyDown pour pouvoir agir quand le joueur appuie sur une fleche.			 */			stage.addEventListener ( KeyboardEvent.KEY_DOWN, keyDownHandler );			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);						addEventListener ( Event.ENTER_FRAME, deplacement );		}				public function keyDownHandler ( $e:KeyboardEvent ):void		{			switch ( $e.keyCode )			{				case Keyboard.LEFT :				case Keyboard.RIGHT :				case Keyboard.UP :				case Keyboard.DOWN :					/**					 * C'est une touche directionnelle, donc on change la propriété "direction".					 */					_direction = $e.keyCode;					break;				default :					/**					 * Si c'est une autre touche, on ne fait rien.					 */					break;			}		}				private function keyUpHandler($e:KeyboardEvent):void {						switch ( $e.keyCode )			{				case Keyboard.LEFT :				case Keyboard.RIGHT :				case Keyboard.UP :				case Keyboard.DOWN :					_direction = 0;					break;				default :					break;			}		}				public function deplacement ( $e:Event ):void		{			/**			 * On fait varier les coordonnées du héros en fonction de la direction actuelle.			 */			switch ( _direction )			{				case Keyboard.LEFT :					if ( carte.objet( positionX - 1, positionY) is EndLevel)						_endLevel();					if ( carte.sol ( positionX - 1, positionY ) is Sol || carte.objet( positionX - 1, positionY) is EndLevel)						positionX--;					break;				case Keyboard.RIGHT :					if ( carte.objet( positionX + 1, positionY) is EndLevel)						_endLevel();					if ( carte.sol ( positionX + 1, positionY ) is Sol || carte.objet( positionX + 1, positionY) is EndLevel)						positionX++;					break;				case Keyboard.UP :					if ( carte.objet( positionX, positionY - 1) is EndLevel)						_endLevel();					if ( carte.sol ( positionX, positionY - 1 ) is Sol || carte.objet( positionX, positionY - 1) is EndLevel)						positionY--;					break;				case Keyboard.DOWN :					if ( carte.objet( positionX, positionY + 1) is EndLevel)						_endLevel();					if ( carte.sol ( positionX, positionY + 1 ) is Sol || carte.objet( positionX, positionY + 1) is EndLevel)						positionY++;					break;			}									if (_phoneInput) {				if (_phoneInput.phoneDirecton == "left") {										if ( carte.objet( positionX - 1, positionY) is EndLevel)						_endLevel();					if ( carte.sol ( positionX - 1, positionY ) is Sol || carte.objet( positionX - 1, positionY) is EndLevel)						positionX--;				}								if (_phoneInput.phoneDirecton == "right") {										if ( carte.objet( positionX + 1, positionY) is EndLevel)						_endLevel();					if ( carte.sol ( positionX + 1, positionY ) is Sol || carte.objet( positionX + 1, positionY) is EndLevel)						positionX++;				}								if (_phoneInput.pacmanClimb == "up") {										if ( carte.objet( positionX, positionY - 1) is EndLevel)						_endLevel();					if ( carte.sol ( positionX, positionY - 1 ) is Sol || carte.objet( positionX, positionY - 1) is EndLevel)						positionY--;				}								if (_phoneInput.pacmanClimb == "down") {										if ( carte.objet( positionX, positionY + 1) is EndLevel)						_endLevel();					if ( carte.sol ( positionX, positionY + 1 ) is Sol || carte.objet( positionX, positionY + 1) is EndLevel)						positionY++;				}			}						/**			 * On replace le héros au bon endroit.			 */			this.x = carte.largeurObjets * positionX;			this.y = carte.hauteurObjets * positionY;		}		public function _endLevel():void {						var timer:Timer = new Timer(250);			timer.addEventListener(TimerEvent.TIMER, _timer);						timer.start();		}				private function _timer(tEvt:TimerEvent):void {						tEvt.target.removeEventListener(TimerEvent.TIMER, _timer);						stage.dispatchEvent(new NetworkEvent(NetworkEvent.END_PACMAN));		}				public override function dispose ():void		{			/**			 * Supression des écouteurs.			 */			this.removeEventListener ( Event.ENTER_FRAME, deplacement );			stage.removeEventListener ( KeyboardEvent.KEY_DOWN, keyDownHandler );			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);						_phoneInput = null;						/**			 * Supression de l'instance.			 */			delete this;		}	}}