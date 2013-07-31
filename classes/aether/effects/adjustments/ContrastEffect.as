package aether.effects.adjustments {
	
	import aether.effects.ImageEffect;
	import aether.utils.Adjustments;
		
	import flash.display.BitmapData;
	
	public class ContrastEffect extends ImageEffect {
	
		private var _amount:Number;

		public function ContrastEffect(
			amount:Number,
			blendMode:String=null,
			alpha:Number=1
		) {
			init(blendMode, alpha);
			_amount = amount;
		}
	
		override protected function applyEffect(bitmapData:BitmapData):void {
			Adjustments.adjustContrast(bitmapData, _amount);
		}
	
	}
	
}