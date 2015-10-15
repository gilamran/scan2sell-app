package {
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

public class Logger extends Sprite {

    private var m_textField:TextField = new TextField();

    public function Logger() {
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        m_textField.text = "Logger created";
        m_textField.selectable = false;
        m_textField.border = true;
        m_textField.mouseEnabled = false;
        addChild(m_textField);
    }

    private function onAddedToStage(event:Event):void {
        fitToStage();
        stage.addEventListener(Event.RESIZE, onStageResized);
    }

    private function onStageResized(event:Event):void {
        fitToStage();
    }

    private function fitToStage():void {
        m_textField.width = stage.stageWidth;
        m_textField.height = stage.stageHeight/2;
        m_textField.y = m_textField.height;
    }

    public function log(text:String):void {
        m_textField.text = m_textField.text + text + '\n';
    }
}
}
