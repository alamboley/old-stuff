package afp.components {

	import afp.services.vo.EventVO;

	import com.greensock.BlitMask;
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	import com.greensock.plugins.ThrowPropsPlugin;
	import com.greensock.plugins.TweenPlugin;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	TweenPlugin.activate([ThrowPropsPlugin]);

	/**
	 * @author Aymeric
	 */
	public class List extends Sprite {

		private var _elements:Vector.<EventVO>;
		private var _length:uint;
		
		private var _mc:Sprite;
		private var _bounds:Shape;
		private var _blitMask:BlitMask;

		private var _t1:uint, _t2:uint, _y1:Number, _y2:Number;

		public function List(elements:Vector.<EventVO>) {

			_elements = elements;
			_length = _elements.length;

			addEventListener(Event.ADDED_TO_STAGE, _init);
		}

		private function _init(evt:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, _init);
			
			_mc = new Sprite();
			addChild(_mc);
			
			_mc.graphics.beginFill(0xCCCCCC);
			_mc.graphics.drawRoundRect(0, 0, 250, 20 * _length, 15, 15);
			_mc.graphics.endFill();
			
			var listeElement:ListElement;
			for (var i:uint = 0; i < _length; ++i) {
				listeElement = new ListElement(_elements[i]);
				listeElement.y = 20 * i;
				listeElement.addEventListener(MouseEvent.CLICK, _click);
				_mc.addChild(listeElement);
			}

			_bounds = new Shape();
			_bounds.graphics.beginFill(0xFF0000);
			_bounds.graphics.drawRect(0, 0, 250, 100);
			_bounds.graphics.endFill();
			addChild(_bounds);
			
			_mc.mask = _bounds;

			//_blitMask = new BlitMask(_mc, _bounds.x, _bounds.y, _bounds.width, _bounds.height, false);
			
			//_blitMask.update(null, true);

			_mc.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
		}

		private function _click(mEvt:MouseEvent):void {
			
			trace('ok');
		}

		private function _mouseDown(mEvt:MouseEvent):void {

			TweenLite.killTweensOf(_mc);
			_y1 = _y2 = _mc.y;
			_t1 = _t2 = getTimer();
			_mc.startDrag(false, new Rectangle(_bounds.x, -99999, 0, 99999999));
			_mc.addEventListener(Event.ENTER_FRAME, _ef);
			_mc.stage.addEventListener(MouseEvent.MOUSE_UP, _mouseUp);
		}

		private function _mouseUp(mEvt:MouseEvent):void {

			_mc.stopDrag();
			_mc.stage.removeEventListener(MouseEvent.MOUSE_UP, _mouseUp);
			_mc.removeEventListener(Event.ENTER_FRAME, _ef);
			
			var time:Number = (getTimer() - _t2) / 1000;
			var yVelocity:Number = (_mc.y - _y2) / time;
			var yOverlap:Number = Math.max(0, _mc.height - _bounds.height);
			
			ThrowPropsPlugin.to(_mc, {throwProps:{y:{velocity:yVelocity, max:_mc.height - _bounds.height, min:_bounds.height - yOverlap, resistance:300}}, ease:Strong.easeOut}, 10, 0.3, 1);
		}

		private function _ef(evt:Event):void {

			_y2 = _y1;
			_t2 = _t1;
			_y1 = _mc.y;
			_t1 = getTimer();
			//_blitMask.update();
		}
	}
}
