package {

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

public class Main extends Sprite {

    private var m_logger         : Logger;
    private var m_serverManager  : ServerManager;
    private var m_mainContainer  : MainContainer;

    public function Main() {
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        m_logger = new Logger();
        m_serverManager = new ServerManager(m_logger);
        m_mainContainer = new MainContainer(m_logger, m_serverManager);
        addChild(m_mainContainer);
        addChild(m_logger);

        m_logger.log('Started');
    }
}
}
