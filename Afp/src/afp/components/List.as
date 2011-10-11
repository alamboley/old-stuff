package afp.components {

	import afp.services.vo.EventVO;

	import com.greensock.BlitMask;
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	import com.greensock.plugins.ThrowPropsPlugin;
	import com.greensock.plugins.TweenPlugin;

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

		private var _bounds:Rectangle;
		private var _blitMask:BlitMask;

		private var _t1:uint, _t2:uint, _y1:Number, _y2:Number;

		public function List(elements:Vector.<EventVO>) {

			_elements = elements;

			addEventListener(Event.ADDED_TO_STAGE, _init);
		}

		private function _init(evt:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, _init);
			
			this.graphics.beginFill(0xFF0000);
			this.graphics.drawRect(0, 0, 400, 200);
			this.graphics.endFill();

			_bounds = new Rectangle(30, 30, 250, 150);

			_blitMask = new BlitMask(this, _bounds.x, _bounds.y, _bounds.width, _bounds.height, false);

			_blitMask.update(null, true);

			_blitMask.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
		}

		private function _mouseDown(mEvt:MouseEvent):void {

			TweenLite.killTweensOf(this);
			_y1 = _y2 = this.y;
			_t1 = _t2 = getTimer();
			startDrag(false, new Rectangle(_bounds.x, -99999, 0, 99999999));
			addEventListener(Event.ENTER_FRAME, _ef);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, _mouseUp);
		}

		private function _mouseUp(mEvt:MouseEvent):void {

			this.stopDrag();
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, _mouseUp);
			this.removeEventListener(Event.ENTER_FRAME, _ef);
			var time:Number = (getTimer() - _t2) / 1000;
			var yVelocity:Number = (this.y - _y2) / time;
			var yOverlap:Number = Math.max(0, this.height - _bounds.height);
			ThrowPropsPlugin.to(this, {throwProps:{y:{velocity:yVelocity, max:_bounds.top, min:_bounds.top - yOverlap, resistance:300}}, onUpdate:_blitMask.update, ease:Strong.easeOut}, 10, 0.3, 1);
		}

		private function _ef(evt:Event):void {

			_y2 = _y1;
			_t2 = _t1;
			_y1 = this.y;
			_t1 = getTimer();
			_blitMask.update();
		}
	}
}
