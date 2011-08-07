package defenseofaegir.levels {

	import defenseofaegir.utils.MathUtils;

	import com.citrusengine.objects.platformer.Missile;

	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * @author Aymeric
	 */
	public class LevelA1 extends ALevel {

		public function LevelA1(levelObjectsMC:MovieClip = null) {
			
			super(levelObjectsMC);
			
			_nameLevel = "A1";
		}
		
		override public function initialize():void {
			
			super.initialize();
			
			_enemyTimer = new Timer(2000);
			_enemyTimer.addEventListener(TimerEvent.TIMER, _enemyFire);
			_enemyTimer.start();
		}
		
		override public function destroy():void {
			
			_enemyTimer.removeEventListener(TimerEvent.TIMER, _enemyFire);
			_enemyTimer.stop();
			_enemyTimer = null;
			
			super.destroy();
		}
		
		private function _enemyFire(tEvt:TimerEvent):void {
			
			var posX:Number = Math.random() * stage.stageWidth;
			var missile:Missile = new Missile("Missile", {x:posX, y:0, width:20, height:20, speed:2, angle:MathUtils.angleDirection(posX, Math.random() * stage.stageWidth, 0, 650)});
			add(missile);
		}
	}
}
