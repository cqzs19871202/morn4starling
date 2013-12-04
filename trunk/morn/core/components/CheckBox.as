/**
 * Morn UI Version 2.0.0526 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.BitmapData;
	
	import morn.core.utils.ObjectUtils;
	
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	import starling.events.Event;
	
	/**多选按钮*/
	public class CheckBox extends Button {
		
		private var offsetx:Number = 5;
		private var offsety:Number = 5;
		
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
			_btnLabel.width = _btnLabel.textField.textWidth + offsetx;
			_btnLabel.height = _btnLabel.textField.textHeight + offsety;
			_btnLabel.x = _bitmap.width + _labelMargin[0];
			_btnLabel.y = (_bitmap.height - _btnLabel.height) * 0.5 + _labelMargin[1];
			
			reDraw();
		}
		
		override public function reDraw():void {
			if(_btnLabel.width > 0 && _btnLabel.height > 0)
			{
				//画到场景里
				removeEventListener(TouchEvent.TOUCH, onMouse);
				removeChildren(0, -1, true);
				if(_bitmap.clips != null)
				{
					var bitdata:BitmapData = new BitmapData(_btnLabel.width + _bitmap.width, _btnLabel.height, true, 0x0);
					bitdata.draw(_bitmap);
					var tex:Texture = Texture.fromBitmapData(bitdata);
					bitdata.dispose();
					var im:starling.display.Image = new starling.display.Image(tex);
					addChild(im);
				}
				addChild(_btnLabel);
				addEventListener(TouchEvent.TOUCH, onMouse);
			}
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