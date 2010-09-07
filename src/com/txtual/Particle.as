package com.txtual
{
	import com.greensock.TweenMax;
	import com.txtual.Logger;
	import com.txtual.fonts.FontLibrary;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.osflash.signals.Signal;
	
	public class Particle extends Sprite
	{
		public var index					: int;
		
		private var field					: TextField;
		private var format					: TextFormat;
		private var _text					: String;
		private var _font					: String;
		private var _size					: int;
		
		
		public var blur						: Number;
		
		public var lifespan					: int;
		public var age						: int;
		public var birthing					: Boolean = false;
		public var dying					: Boolean = false;
		
		public var changed					: Signal;
		
		public function Particle(theText:String="Hello", theFont:String="default", theScale:Number=1)
		{
			
			scaleX = scaleY = theScale;
			
			cacheAsBitmap = true;
			alpha = 0;
			visible = false;
			
			changed = new Signal();
			
			format = new TextFormat();
			format.leading = 1;
			format.leading = -10;
			format.align = TextFormatAlign.CENTER;
			format.letterSpacing = 0.5;
			format.color = 0xFFFFFF;
			
			field = new TextField();
			field.selectable = false;
			field.antiAliasType = AntiAliasType.ADVANCED;
			field.autoSize = TextFieldAutoSize.LEFT;
			field.multiline = true;
			field.wordWrap = true;
			field.width = 500;
			field.embedFonts = true;
			
			addChild(field);
			field.x = -(field.width * .5);
			
			text = theText;
			if (theFont == "default") { font = FontLibrary.HELVETICA_ROMAN; } else { font = theFont; }
			size = 48;	
			
			blur = Math.random()*4;
			var myBlur:BlurFilter = new BlurFilter(blur, blur, 1);
			this.filters = [myBlur];
			
			lifespan = 150 + Math.round((Math.random()*100));
			age = 0;
			
		}
		
		override public function toString():String
		{
			return "[Particle   id: " + text + "]";
		}
		
		public function get text():String
		{
			return field.text;
		}
		
		public function set text(value:String):void
		{
			Logger.log("setting text to " + value);
			field.text = value + "\n ";
			update();
		}
		
		public function set font(value:String):void
		{
			format.font = value;
			update();
		}
		
		public function set size(value:int):void
		{
			format.size = value;
			field.setTextFormat(format);
			update();
		}
		
		public function update():void
		{
			field.setTextFormat(format);
			changed.dispatch();
		}
	}
}