package com.txtual
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.XMLLoader;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	
	public class TxtManager extends Sprite
	{
		private static var instance						: TxtManager;
		private static var allowInstantiation			: Boolean;
		
		public var loadedSignal 						: Signal;
		public var updateSignal							: Signal;
		private var loader 								: XMLLoader;
		private var status								: String;
		private var path								: String;
		
		private var pollTimer							: Timer;
		private static const POLL_INTERVAL				: uint = 4;
				
		private var theXML								: XML;
		
		private static const MAX_MESSAGES				: uint = 500;
		private var messageArray						: Array;
		private var messageIndex						: uint = 0;
		public var count								: uint;
		
		public static const NOT_LOADED_STATUS			: String = "Not Loaded";
		public static const LOADED_STATUS				: String = "Loaded";
		public static const ERROR_STATUS				: String = "Error";       
		
		public function TxtManager(name:String="TxtManager")
		{
			if (!allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use TxtManager.getInstance()");
			} else {
				this.name = name;
				init();
			}
		}

		public static function getInstance(name:String = "TxtManager"):TxtManager {
			if (instance == null) {
				allowInstantiation = true;
				instance = new TxtManager(name);
				allowInstantiation = false;
			}
			return instance;
		}
		
		private function init():void
		{
			loadedSignal = new Signal(XML);
			updateSignal = new Signal();
			
			messageArray = new Array();
//			for (var i:int = 0; i < MAX_MESSAGES; i++)
//			{
//				messageArray.push(new TxtMessage());
//			}
			
			count = 0;
			
			pollTimer = new Timer(POLL_INTERVAL*1000);
			pollTimer.addEventListener(TimerEvent.TIMER, onPollTimer);
			pollTimer.start();
		}
		
		private function onPollTimer(e:TimerEvent):void
		{
			pollTimer.stop();
			loader.load(true);
			//load(path);
		}
		
		override public function toString():String
		{
			return "[TxtManager path: " + name + ", status: " + status + "]";
		}
		
		public function load(thePath:String="contents.plist"):void
		{
			path = thePath;
			status = NOT_LOADED_STATUS;
			loader = new XMLLoader(path, { onComplete: loadComplete, onError: loadError });
			loader.load(true);
		}
		
		private function loadComplete(e:LoaderEvent):void
		{
			theXML = loader.getContent(path);
			count = theXML..array.dict.length();
			messageArray = [];
			for (var i:int = 0; i < count; i++)
			{
				var address:String = theXML..array.dict[i].children()[1];
				var message:String = theXML..array.dict[i].children()[3];
				var timestamp:String = theXML..array.dict[i].children()[7];
				messageArray.push(new TxtMessage(address, message, timestamp));
			}
			
			//Logger.log("count: " + count + "\n" + messageArray + "\n------------\n\n");
			status = LOADED_STATUS;
			loadedSignal.dispatch(loader.getContent(path));
			pollTimer.start();
		}
		
		private function loadError(e:LoaderEvent):void
		{
			//Logger.log("load error " + e.text);	
			status = ERROR_STATUS;
		}
		
		public function getNextMessage():TxtMessage
		{
			var nextMessage:TxtMessage = messageArray[messageIndex];
			messageIndex ++;
			if (messageIndex == messageArray.length) { messageIndex = 0; }
			return nextMessage;
		}
	}
}