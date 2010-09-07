package com.txtual.fonts
{
	
	import flash.display.Sprite;
	import flash.text.Font;

	public class FontLibrary extends Sprite
	{
		
		private static var instance					: FontLibrary;
		private static var allowInstantiation		: Boolean;
				
		public static const HELVETICA_ROMAN			: String = HelveticaRoman.NAME;
		public static const HELVETICA_BOLD 			: String = HelveticaBold.NAME;
		
		public function FontLibrary(name:String = "FontLibrary") 
		{
			if (!allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use FontLibrary.getInstance()");
			} else {
				this.name = name;
				init();
			}
		}
		
		public static function getInstance(name:String = "FontLibrary"):FontLibrary {
			if (instance == null) {
				allowInstantiation = true;
				instance = new FontLibrary(name);
				allowInstantiation = false;
			}
			return instance;
		}
		
		private function init():void
		{		
			//
		}
	}
}