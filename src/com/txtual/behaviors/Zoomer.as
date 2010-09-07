package com.txtual.behaviors
{
	import com.greensock.TweenMax;
	import com.txtual.Logger;
	import com.txtual.Particle;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class Zoomer extends Sprite
	{
		private var target				: Particle;
		
		private var vx						: Number;
		private var vy						: Number;
		private var vz						: Number;
		
		private var rx						: Number;
		private var ry						: Number;
		private var rz						: Number;
	
		public function Zoomer(theTarget:Particle)
		{
			target = theTarget;
			if (stage) { init(); } else { addEventListener(Event.ADDED_TO_STAGE, init); }
			
		}
		
		private function init(e:Event=null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(target);
			
			var offset:Number = ((Math.random()*100)-50);
			
			target.x = stage.stageWidth * .5 + offset;
			target.y = stage.stageHeight * .5 + offset;
			target.z = 500 + (Math.random() * 400 - 200);
			
			vx = (Math.random() - .5) * 2;
			vy = (Math.random() - .5) * 2;
			vz = -(Math.random()*5);
			
			rx = (Math.random() - .5) * .2;
			ry = (Math.random() - .5) * .2;
			rz = (Math.random() - .5) * .2;
			
			birth();
		}
		
		private function birth():void
		{
			Logger.log(target + " being born...");
			target.birthing = true;
			TweenMax.to(target, 2, { autoAlpha: 1, onComplete: function():void { target.birthing = false; } } );
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			target.x += vx;
			target.y += vy;
			target.z += vz;
			
			target.rotationX += rx;
			target.rotationY += ry;
			target.rotationZ += rz;
			
			target.age ++;
			if (target.age > target.lifespan && !target.dying)
			{
				death();
			}
		}
		
		private function death():void
		{
			target.dying = true;
			TweenMax.to(target, 2, { autoAlpha: 0, onComplete: recycle });
		}
		
		private function recycle():void
		{
			Logger.log("recycling " + target);
			target.dying = false;
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}