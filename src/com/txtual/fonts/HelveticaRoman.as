package com.txtual.fonts
{
	import flash.text.Font;
	
	public class HelveticaRoman extends Font
	{
		[Embed(source="assets/fonts/HelveticaNeueLTStd-Roman.otf", fontName="HelveticaRoman", mimeType="application/x-font-truetype", embedAsCFF="false")]
		public static const HELVETICA_ROMAN : String;
		
		public static const NAME : String = "HelveticaRoman";
		
		public function HelveticaRoman()
		{
			//
		}
	}
}