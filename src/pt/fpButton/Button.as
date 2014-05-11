package pt.fpButton 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Data;
	/**
	 * ...
	 * @author Miguel M
	 */
	public class Button extends Entity
	{
		[Embed(source="buttonPlaceholder.png")]private const buttonImg:Class;
		private var buttonSM:Spritemap;
		private var beenPressed:Boolean;
		private var onReleased:Function;
		public function Button(x:Number = 0, y:Number = 0, handler:Function = null, scale:Number = 1, text:String = "") 
		{
			buttonSM = new Spritemap(buttonImg, 32, 32);
			buttonSM.add("unpressed", [0]);
			buttonSM.add("pressed", [1]);
			buttonSM.scale = scale;
			this.graphic = buttonSM;
			this.x = x-(buttonSM.width*scale)/2;
			this.y = y-(buttonSM.height*scale)/2;
			var buttonText:Text = new Text(text);
			buttonText.size = 8 * scale;
			buttonText.centerOO();
			buttonText.x = (buttonSM.width * scale) / 2;
			buttonText.y = (buttonSM.height * scale) / 2;
			addGraphic(buttonText);
			buttonSM.play("unpressed");
			setHitbox(32*buttonSM.scale, 32*buttonSM.scale);
			beenPressed = false;
			onReleased = handler;
		}
		override public function update():void {
			if (this.collidePoint(this.x, this.y, Input.mouseX, Input.mouseY) && Input.mousePressed) {
				buttonSM.play("pressed");
				beenPressed = true;
			}else if (this.collidePoint(this.x, this.y, Input.mouseX, Input.mouseY) && Input.mouseReleased && beenPressed) {
				beenPressed = false;
				buttonSM.play("unpressed");
				onReleased();
			}else if (!this.collidePoint(this.x, this.y, Input.mouseX, Input.mouseY)) {
				buttonSM.play("unpressed");
			}
		}
	}

}