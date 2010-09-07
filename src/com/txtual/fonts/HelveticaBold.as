package com.txtual.fonts
{
	import flash.text.Font;
	
	public class HelveticaBold extends Font
	{
		[Embed(source="assets/fonts/HelveticaNeueLTStd-Bd.otf", fontName="HelveticaBold", mimeType="application/x-font-truetype", embedAsCFF="false")]
		public static const HELVETICA_BOLD : String;
		
		public static const NAME : String = "HelveticaBold";
		
		public function HelveticaBold()
		{
			//
		}
	}
}