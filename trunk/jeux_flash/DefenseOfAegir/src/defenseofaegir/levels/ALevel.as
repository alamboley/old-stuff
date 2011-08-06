package defenseofaegir.levels {

	import Box2DAS.Dynamics.ContactEvent;

	import defenseofaegir.utils.MathUtils;

	import com.citrusengine.core.State;
	import com.citrusengine.objects.CitrusSprite;
	import com.citrusengine.objects.platformer.Missile;
	import com.citrusengine.objects.platformer.Sensor;
	import com.citrusengine.physics.Box2D;
	import com.citrusengine.utils.ObjectMaker;

	import org.osflash.signals.Signal;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * @author Aymeric
	 */
	public class ALevel extends State {
		
		public var lvlEnded:Signal;
		
		protected var _nameLevel:String;
		
		private var _levelObjectsMC:MovieClip;

		public function ALevel(levelObjectsMC:MovieClip = null) {
			
			super();
			
			_levelObjectsMC = levelObjectsMC;
			
			lvlEnded = new Signal();
			
			var objects:Array = [CitrusSprite, Sensor];
		}
		
		override public function initialize():void {
			
			super.initialize();
			
			var box2D:Box2D = new Box2D("Box2D");
			box2D.visible = true;
			add(box2D);
			
			if (_levelObjectsMC != null)
				ObjectMaker.FromMovieClip(_levelObjectsMC);
			
			stage.addEventListener(MouseEvent.CLICK, _fire);
		}
		
		override public function destroy():void {
			
			stage.removeEventListener(MouseEvent.CLICK, _fire);
			
			super.destroy();
		}
		
		private function _fire(mEvt:MouseEvent):void {
			
			var missile:Missile = new Missile("Missile", {x:stage.stageWidth * 0.5, y:650, width:20, height:20, speed:2, angle:MathUtils.angleDirection(stage.stageWidth * 0.5, stage.mouseX, 650, stage.mouseY)});
			add(missile);
		}
		
		protected function _endLevel(cEvt:ContactEvent):void {
			
			lvlEnded.dispatch();
		}
		
		public function get nameLevel():String {
			
			return _nameLevel;
		}
	}
}
