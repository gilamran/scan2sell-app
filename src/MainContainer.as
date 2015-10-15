package {
import flash.display.Sprite;
import flash.events.MouseEvent;

public class MainContainer extends Sprite {

    private var m_scanButton    : Sprite;
    private var m_testButton    : Sprite;
    private var m_serverManager : ServerManager;
    private var m_logger        : Logger;

    public function MainContainer(logger:Logger, serverManager:ServerManager) {
        m_logger = logger;
        m_serverManager = serverManager;

        m_scanButton = new Sprite();
        m_scanButton.graphics.beginFill(0xff0000);
        m_scanButton.graphics.drawCircle(50, 50, 50);
        m_scanButton.graphics.endFill();
        m_scanButton.addEventListener(MouseEvent.CLICK, onScanClicked);
        addChild(m_scanButton);

        m_testButton = new Sprite();
        m_testButton.graphics.beginFill(0xffff00);
        m_testButton.graphics.drawCircle(50, 50, 50);
        m_testButton.graphics.endFill();
        m_testButton.x = 200;
        m_testButton.addEventListener(MouseEvent.CLICK, onTestClicked);
        addChild(m_testButton);
    }

    private function onTestClicked(e:MouseEvent):void {
        m_serverManager.createProduct('Test-Barcode');
    }

    private function onScanClicked(e:MouseEvent):void {
        var bs : BarcodeScanner = new BarcodeScanner(m_logger, function(result:String):void {
            m_logger.log(result);
            m_serverManager.createProduct(result);
        });
    }
}
}
