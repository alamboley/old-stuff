package ui 
{

	import citrus.core.CitrusEngine;
	import com.greensock.TweenLite;
	import starling.text.TextField;
	
	import starling.text.BitmapFont;
	import starling.utils.Color;
	import starling.utils.HAlign;
	
	public class Caption extends TextField
	{
		private var _ce:CitrusEngine;
		
		private var _queueText:Vector.<Object>;
		
		private var _endLast:Boolean = true;
		
		public var fadeDuration:Number = 0.3;
		
		private var _displayTime:Number;
		
		public function Caption() 
		{
			super(400, 300, text, "ArialMT");
			
			_ce = CitrusEngine.getInstance();
			_queueText = new Vector.<Object>();
			alpha = 0;
			fontSize = BitmapFont.NATIVE_SIZE;
			width = _ce.stage.stageWidth;
			color = Color.WHITE;
			autoScale = true;
			hAlign = HAlign.CENTER;
		}
		
		public function enqueueText(text:String = "<no Text>", duration:Number = 2):void
		{
			_queueText.push( { str:text, d:duration } );
			//if (_queueText.length == 0)
				//update();
		}
		
		public function update():void
		{
			if (_queueText.length > 0 && _endLast)
			{
				playStuff(_queueText.shift());
			}
		}
		
		private function playStuff(o:Object):void
		{
			this.text =  o.str;
			_displayTime = o.d - 2 * (fadeDuration);
			
			alpha = 0;
			_endLast = false;
			
			//SEQUENCE
			fadeIN();
		}
		
		// PHASES
		
		private function fadeIN():void
		{
			TweenLite.to(this, fadeDuration , { alpha:1 } );
			
			//next
			TweenLite.delayedCall(fadeDuration, displayText);
		}
		
		private function displayText():void
		{
			//next
			TweenLite.delayedCall(_displayTime, fadeOUT);
		}
		
		private function fadeOUT():void
		{
			
			//next
			TweenLite.to(this, fadeDuration , { alpha:0 } );
			TweenLite.delayedCall(fadeDuration, end);
		}
		
		private function end():void
		{
			alpha = 1;
			text = "";
			 _endLast = true;
		}
		
	}

}