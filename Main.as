package
{
  import flash.events.*;
  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.display.SimpleButton;
  import flash.display.StageDisplayState;
  import flash.display.StageAlign;
  import flash.display.Shape;

  import choppingblock.video.*;

  public class Main extends Sprite
  {
    private var _youTubeLoader:YouTubeLoader;
    private var text_field : TextField = new TextField();
    private var play_button : SimpleButton;

    public function Main()
    {
      stage.align = StageAlign.TOP_LEFT;  

      initYoutubePlayer();
      initControls();
    }

    private function initYoutubePlayer():void
    {
      _youTubeLoader = new YouTubeLoader(); 
      _youTubeLoader.addEventListener(YouTubeLoaderEvent.LOADED, youtubePlayerLoadedHandler, false, 0, true);
//    _youTubeLoader.addEventListener(YouTubeLoaderEvent.STATE_CHANGE, youtubePlayerStateChangeHandler, false, 0, true);
      _youTubeLoader.create();
      _youTubeLoader.x = 0;
      _youTubeLoader.y = 0;
      addChild(_youTubeLoader);
    }

    private function initControls():void
    {
      text_field.text = "Status";
      text_field.textColor = 0xFFFFFF;
      text_field.x = 0;
      text_field.y = 0;
      addChild(text_field)

      createPlayButton();
    }

    private function createPlayButton():void
    {
      play_button=new SimpleButton();
      play_button.x = 160;
      play_button.y = 90;
      
      play_button.upState = playButtonShape(25);
      play_button.overState = playButtonShape(35);
      play_button.downState = playButtonShape(50);
      play_button.hitTestState = play_button.upState;
      
      play_button.addEventListener(MouseEvent.CLICK, youtubePlayHandler);
      
      addChild(play_button);
    }

    private function playButtonShape(param:Number):Shape
    {
      var shape:Shape=new Shape();
      shape.graphics.beginFill(0xFFFFFF,0.5);
      shape.graphics.drawCircle(play_button.x,play_button.y,param);
      shape.graphics.endFill();
      return(shape);
    }

    private function youtubePlayerLoadedHandler(event:YouTubeLoaderEvent):void
    {
      _youTubeLoader.setSize(640, 385)
      text_field.text = 'Youtube loaded'
    }

    private function youtubePlayHandler(event:Event):void
    {
      if(_youTubeLoader._state == 'paused'){
        _youTubeLoader.play()
      }else{
        _youTubeLoader.pause()
      }
    }
  }
} 
