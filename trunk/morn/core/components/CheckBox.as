/**
 * Morn UI Version 2.0.0526 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.BitmapData;
	
	import morn.core.utils.ObjectUtils;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	/**多选按钮*/
	public class CheckBox extends Button {
		
		private var offsetx:Number = 5;
		private var offsety:Number = 5;
		
		private var _backTexture:Texture = null;
		private var _backImg:starling.display.Image = null;
		
		public function CheckBox(skin:String = null, label:String = "") {
			super(skin, label);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			_toggle = true;
			_autoSize = false;
		}
		
		override protected function initialize():void {
			super.initialize();
			_btnLabel.autoSize = "left";
		}
		
		override protected function changeLabelSize():void {
			_btnLabel.width = _btnLabel.textField.textWidth + offsetx;//ObjectUtils.getTextField(_btnLabel.format).width + offsetx;
			_btnLabel.height = ObjectUtils.getTextField(_btnLabel.format).height + offsety + 0.5;//_btnLabel.textField.textHeight + offsety;//ObjectUtils.getTextField(_btnLabel.format).height + offsety;
			_btnLabel.x = _bitmap.width + _labelMargin[0];
			_btnLabel.y = (_bitmap.height - _btnLabel.height + 1) * 0.5 + _labelMargin[1];
			
			reDraw();
		}
		
		override public function reDraw():void {
			if(_btnLabel.width > 0 && _btnLabel.height > 0)
			{
				//画到场景里
				removeAll();
				
				if(_bitmap.clips != null)
				{
					var bitdata:BitmapData = new BitmapData(_btnLabel.width + _bitmap.width, _btnLabel.height, true, 0x0);
					bitdata.draw(_bitmap.clips[_bitmap.index]);
					_backTexture = Texture.fromBitmapData(bitdata);
					bitdata.dispose();
					_backImg = new starling.display.Image(_backTexture);
					_backImg.smoothing = TextureSmoothing.NONE;
					addChild(_backImg);
				}
				_btnLabel.reDraw();
				addChild(_btnLabel);
			}
		}
		
		override public function removeAll():void {
			if(_backTexture != null){
				_backTexture.dispose();
				_backTexture = null;
			}
			if(_backImg != null){
				_backImg.dispose();
				_backImg = null;
			}
			if(_btnLabel != null){
				_btnLabel.removeAll();
			}
			removeChildren(0, -1, true);
		}
		
		override public function commitMeasure():void {
			exeCallLater(changeLabelSize);
		}
		
		override public function set dataSource(value:Object):void {
			_dataSource = value;
			if (value is Boolean) {
				selected = value;
			} else if (value is String) {
				selected = value == "true";
			} else {
				super.dataSource = value;
			}
		}
	}
}