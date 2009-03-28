class LastYoutubePlayer {
  
  // create a MovieClip to load the player into
  var ytplayer:MovieClip = _root.createEmptyMovieClip("ytplayer", 0);

  // create a listener object for the MovieClipLoader to use
  var ytPlayerLoaderListener:Object = {
    onLoadInit: function() { 
      // When the player clip first loads, we start an interval to check for when the
      // player is ready
      this.loadInterval = setInterval(this.checkPlayerLoaded, 250);
    }
  };
  
  var loadInterval:Number;


  function checkPlayerLoaded():Void {
      // once the player is ready, we can subscribe to events, or in the case of
      // the chromeless player, we could load videos
      if (ytplayer.isPlayerLoaded()) {
          ytplayer.addEventListener("onStateChange", onPlayerStateChange);
          ytplayer.addEventListener("onError", onPlayerError);
          clearInterval(loadInterval);
      }
  }

  function onPlayerStateChange(newState:Number) {
      trace("New player state: "+ newState);
  }

  function onPlayerError(errorCode:Number) {
      trace("An error occurred: "+ errorCode);
  }

  

  static var app : LastYoutubePlayer;

  function LastYoutubePlayer() {
    
    // create a MovieClipLoader to handle the loading of the player
    var ytPlayerLoader:MovieClipLoader = new MovieClipLoader();
    ytPlayerLoader.addListener(ytPlayerLoaderListener);

    // load the player
    ytPlayerLoader.loadClip("http://www.youtube.com/apiplayer", ytplayer);


    _root.createEmptyMovieClip("square_mc", 1);
    _root.square_mc.beginFill(0xFF0000);
    _root.square_mc.moveTo(0, 0);
    _root.square_mc.lineTo(100, 0);
    _root.square_mc.lineTo(100, 100);
    _root.square_mc.lineTo(0, 100);
    _root.square_mc.lineTo(0, 0);
    _root.square_mc.endFill();
    
    _root.square_mc.onPress = function(){
      try{
      _root.ytplayer.loadVideoById("9JaPNKslTxI")
      _root.ytplayer.setSize(640,385);
      }catch(e:Error){
        _root.tf.text = "Error: "+e.message
      }
    }

    _root.createTextField("tf", 2, 0, 0, 100, 30)
    _root.tf.text = "Hello World!"
    _root.tf.color = 0xffffff;
    
    var my_fmt:TextFormat = new TextFormat();
    my_fmt.color = 0xFFFFFF;
    my_fmt.underline = true;
    _root.tf.setTextFormat(my_fmt);

  }

  // entry point
  static function main(mc) {
    app = new YTDemo();
  }
}
