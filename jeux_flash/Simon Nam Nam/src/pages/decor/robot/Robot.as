package pages.decor.robot {

	import flash.display.MovieClip;

	/**
	 * @author Aymeric
	 */
	public class Robot extends ARobot {

		public var jambe:Jambe;
		public var cou:Cou;
		public var buste:Buste;
		public var tete:Tete;

		public var ikNode_3:MovieClip;
		public var ikNode_4:MovieClip;
		public var ikNode_5:MovieClip;
		public var ikNode_6:MovieClip;
		
		private var _etat:uint;

		public function Robot() {
			super();
		}

		override public function initMachine():void {

			super.initMachine();
			this.gotoAndPlay("debut");
			this.tete.ecran.gotoAndPlay("debut");
		}

		override public function jouerSon(son:String):void {

			super.jouerSon(son);

			switch (son) {

				case "MACHINE_SON1":
					this.gotoAndPlay("scrtach1");
					this.tete.ecran.gotoAndPlay("normal");
					break;

				case "MACHINE_SON2":
					this.gotoAndPlay("scrtach2");
					this.tete.ecran.gotoAndPlay("normal");
					break;

				case "MACHINE_SON3":
					this.gotoAndPlay("scrtach3");
					this.tete.ecran.gotoAndPlay("normal");
					break;

				case "MACHINE_SON4":
					this.gotoAndPlay("scrtach4");
					this.tete.ecran.gotoAndPlay("normal");
					break;

				case "MACHINE_A_TOI":
					this.gotoAndPlay("atoi");
					this.tete.ecran.gotoAndPlay("normal");
					break;
			}
		}

		override public function attendre():void {

			super.attendre();

			this.gotoAndPlay("normal");
			this.tete.ecran.gotoAndPlay("normal");
		}

		override public function moquer():void {

			super.moquer();
			this.gotoAndPlay("echec1");
			this.tete.ecran.gotoAndPlay("echec");
		}

		override public function degradation($value:uint):void {
			
			_etat = $value;

			super.degradation(_etat);

			if (_etat == 1) {

				this.gotoAndPlay("reussite" + _etat);
				this.tete.ecran.gotoAndPlay("reussite" + _etat);
			}

			if (_etat == 2) {

				this.gotoAndPlay("reussite" + _etat);
				this.tete.ecran.gotoAndPlay("reussite" + _etat);
				this.tete.ecran.vitre.gotoAndPlay("casse" + (-_etat));
				this.tete.gotoAndPlay("casse" + (-_etat));
				this.cou.gotoAndPlay("casse" + (-_etat));
				this.buste.gotoAndPlay("casse" + (-_etat));
				this.jambe.gotoAndPlay("casse" + (-_etat));
				this.ikNode_5.gotoAndPlay("casse" + (-_etat));
				this.ikNode_6.gotoAndPlay("casse" + (-_etat));
				this.ikNode_3.gotoAndPlay("casse" + (-_etat));
				this.ikNode_4.gotoAndPlay("casse" + (-_etat));
			}
		}

		override public function gagne():void {

			super.gagne();

			this.gotoAndPlay("echec2");
			this.tete.ecran.gotoAndPlay("echec");
		}

		override public function perd():void {

			super.perd();

			this.gotoAndPlay("reussite3");
			this.tete.ecran.gotoAndPlay("reussite3");
			this.tete.ecran.vitre.gotoAndPlay("casse2");
			this.tete.gotoAndPlay("casse2");
			this.cou.gotoAndPlay("casse2");
			this.buste.gotoAndPlay("casse2");
			this.jambe.gotoAndPlay("casse2");
			this.ikNode_5.gotoAndPlay("casse2");
			this.ikNode_6.gotoAndPlay("casse2");
			this.ikNode_3.gotoAndPlay("casse2");
			this.ikNode_4.gotoAndPlay("casse2");
		}

	}
}
