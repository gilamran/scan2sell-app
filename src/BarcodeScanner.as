package {
import com.sbhave.nativeExtensions.zbar.Config;
import com.sbhave.nativeExtensions.zbar.Scanner;
import com.sbhave.nativeExtensions.zbar.ScannerEvent;
import com.sbhave.nativeExtensions.zbar.Symbology;

public class BarcodeScanner {

    private var s:Scanner;
    private var ctr:int=0;
    private var cb:Function;
    private var m_logger : Logger;

    public function BarcodeScanner(logger:Logger, cb:Function) {
        m_logger = logger;
        this.cb = cb;
        s = new Scanner();
        s.setConfig(Symbology.EAN13, Config.ENABLE,1);
        s.addEventListener(ScannerEvent.SCAN, onScan);
        s.startPreview("rear");
//        s.setDimensions(300,300);
//        s.setPosition(50,150);
        s.attachScannerToPreview();
    }

    private function onScan(event:ScannerEvent):void {
        if(ctr < 1) {
            trace("Scan Event " + event.data);
            cb(event.data);
            ctr++;
        }else{
            s.stopPreview();
        }
    }
}
}
