package defenseofaegir.levels {

	import Box2DAS.Dynamics.ContactEvent;

	import defenseofaegir.utils.MathUtils;

	import com.citrusengine.core.State;
	import com.citrusengine.objects.platformer.Missile;
	import com.citrusengine.physics.Box2D;

	import org.osflash.signals.Signal;

	import flash.events.MouseEvent;

	/**
	 * @author Aymeric
	 */
	public class ALevel extends State {
		
		public var lvlEnded:Signal;
		
		protected var _nameLevel:String;

		public function ALevel() {
			
			super();
			
			lvlEnded = new Signal();
		}
		
		override public function initialize():void {
			
			super.initialize();
			
			var box2D:Box2D = new Box2D("Box2D");
			box2D.visible = true;
			add(box2D);
			
			stage.addEventListener(MouseEvent.CLICK, _fire);
		}
		
		override public function destroy():void {
			
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
