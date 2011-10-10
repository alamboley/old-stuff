package afp {

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Capabilities;

	public class Main extends Sprite {
		
		private var _stageWidth:Number, _stageHeight:Number;
		
		private var _info:String;
		
		private var _service:String = "http://www.prdurand.FR/AFPCRM10/";

		public function Main() {
			
			addEventListener(Event.ADDED_TO_STAGE, _init);
		}
		
		private function _init(evt:Event):void {
			
			removeEventListener(Event.ADDED_TO_STAGE, _init);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			stage.addEventListener(Event.RESIZE, _resize);
		}

		private function _resize(evt:Event):void {
			
			stage.removeEventListener(Event.RESIZE, _resize);
			
			_stageWidth = Math.min(stage.fullScreenWidth, stage.fullScreenHeight);
			_stageHeight = Math.max(stage.fullScreenWidth, stage.fullScreenHeight);
			
			_info = "Detected Resolution:" + _stageWidth + " x " + _stageHeight;
			_info += "\nDevice type : " + Capabilities.manufacturer;
			trace(_info);
			
			var toto:Scene = new Scene();
			addChild(toto);
		}
	}
}
