package {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IEventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;

public class ServerManager extends Sprite {

    private static const SERVER : String = 'http://scan2sell-server.heroku.com/create-product';
//    private static const SERVER : String = 'http://localhost:5000/create-product';

    private var m_loader         : URLLoader;
    private var m_logger         : Logger;

    public function ServerManager(logger:Logger) {
        m_loader = new URLLoader();
        m_loader.dataFormat = URLLoaderDataFormat.VARIABLES;
        configureListeners(m_loader);
        m_logger = logger;
    }

    public function createProduct(barcode:String):void {
        m_logger.log('Creating product with barcode:' + barcode);

        var variables : URLVariables = new URLVariables();
        variables.barcode = barcode;

        doRequest(variables);
    }

    public function doRequest(data:Object):void {
        var request:URLRequest = new URLRequest(SERVER);
        request.data = data;
        request.method = URLRequestMethod.GET;

        try {
            m_loader.load(request);
        } catch (error:Error) {
            trace("Unable to load requested document.");
        }
    }

    private function configureListeners(dispatcher:IEventDispatcher):void {
        dispatcher.addEventListener(Event.COMPLETE, completeHandler);
        dispatcher.addEventListener(Event.OPEN, openHandler);
        dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
        dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
    }

    private function completeHandler(event:Event):void {
        var loader:URLLoader = URLLoader(event.target);
        m_logger.log("completeHandler: " + loader.data);
    }

    private function openHandler(event:Event):void {
        m_logger.log("openHandler: " + event);
    }

    private function progressHandler(event:ProgressEvent):void {
        m_logger.log("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
    }

    private function securityErrorHandler(event:SecurityErrorEvent):void {
        m_logger.log("securityErrorHandler: " + event);
    }

    private function httpStatusHandler(event:HTTPStatusEvent):void {
        m_logger.log("httpStatusHandler: " + event);
    }

    private function ioErrorHandler(event:IOErrorEvent):void {
        m_logger.log("ioErrorHandler: " + event);
    }
}
}
