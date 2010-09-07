package com.txtual
{
	import flash.display.Sprite;

	public class TxtMessage extends Sprite
	{
		public var index						: uint;
		
		public var address					: String;
		public var message					: String;
		public var shortMessage				: String;
		public var timestamp				: String;
		public var day						: String;
		public var time						: String;
		public var offset					: String;
		public var date						: Date;
		
		public function TxtMessage(adr:String, msg:String, tms:String)
		{
			address = adr;
			message = msg;
			if (message.length <= 25) 
			{ 
				shortMessage = message;
			} 
			else
			{
				shortMessage = message.substr(0, 24) + "…";
			}
			timestamp = tms;
			date = makeDate();
		}
		
		/*
		public function init(address:String, message:String, timestamp:String):void
		{
			address = address;
			message = message;
			timestamp = timestamp;
			date = makeDate();
		}
		*/
		
		private function makeDate():Date
		{
			day = timestamp.slice(0, timestamp.indexOf(" "));
			time = timestamp.slice(timestamp.indexOf(" ")+1, timestamp.lastIndexOf(" "));
			offset = timestamp.slice(timestamp.lastIndexOf(" ")+1);
			day = day.split("-").join("/");
			return new Date(day + " " + time + " " + offset);
		}
		
		override public function toString():String
		{
			return "[ TxtMessage ::: " + shortMessage + ", " + address + ", " + timestamp + " ]";
		}
	}
}