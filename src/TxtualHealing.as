package
{
	import com.txtual.Logger;
	import com.txtual.Particle;
	import com.txtual.TxtManager;
	import com.txtual.TxtMessage;
	import com.txtual.behaviors.Zoomer;
	import com.txtual.fonts.FontLibrary;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.hires.debug.Stats;
	
	[SWF(width="1024", height="768", frameRate="30", backgroundColor="#000000", pageTitle="TxtualHealing")]
	
	public class TxtualHealing extends Sprite
	{
		
		private var stats				: Stats;
		
		private var timer				: Timer;
		
		public function TxtualHealing()
		{
			stats = new Stats();
			addChild(stats);			
			timer = new Timer(2000);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			
			TxtManager.getInstance().loadedSignal.addOnce(onXMLLoaded);
			TxtManager.getInstance().load("copy.plist");
		}
		
		private function onTimer(e:TimerEvent):void
		{
			var theMessage:TxtMessage = TxtManager.getInstance().getNextMessage();
			Logger.log(theMessage);
			addChild(new Zoomer(new Particle(theMessage.message)));
		}
		
		private function onXMLLoaded(theXML:XML):void
		{
			timer.start();
			
//			addChild(new Zoomer(new Particle("T-Cat will win!")));
//			addChild(new Zoomer(new Particle("No, Bunny!", FontLibrary.HELVETICA_BOLD)));
//			addChild(new Zoomer(new Particle("Neither of you will emerge victorious, you cats! There can be ONLY ONE...", FontLibrary.HELVETICA_BOLD, .5)));
		}
	}
}