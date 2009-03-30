class LastYoutubePlayer {
  
  // create a MovieClip to load the player into
  var ytplayer:MovieClip = _root.createEmptyMovieClip("ytplayer", 0);
 
  var loadInterval:Number = 5;

  // create a listener object for the MovieClipLoader to use
  var ytPlayerLoaderListener:Object = {
    onLoadComplete: function() { 
      // When the player clip first loads, we start an interval to check for when the
      // player is ready
      setInterval(this.par.checkPlayerLoaded, 250);
    }
  };

  function checkPlayerLoaded():Void {
      // once the player is ready, we can subscribe to events, or in the case of
      // the chromeless player, we could load videos
      //
      if (_root.ytplayer.isPlayerLoaded()) {

          _root.ytplayer.addEventListener("onStateChange", onPlayerStateChange);
          _root.ytplayer.addEventListener("onError", onPlayerError);
         
          _root.ytplayer.setSize(640,385);
          
          clearInterval(1);
      }
  }

  function onPlayerStateChange(newState:Number) {
      trace("New player state: "+ newState);
      _root.tf.text = "State changed"

  }

  function onPlayerError(errorCode:Number) {
      trace("An error occurred: "+ errorCode);
  }

  static var app : LastYoutubePlayer;

  function LastYoutubePlayer() {
    ytPlayerLoaderListener.par = this 

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
      var my_lv:LoadVars = new LoadVars();
      my_lv.load("http://localhost:8080/")
      
      my_lv.onLoad = function(success:Boolean) {
          if (success) {
            _root.tf.text = this["video_id"];

            _root.ytplayer.loadVideoById(this["video_id"])
          } else {
            _root.tf.text = "Error loading/parsing LoadVars.";
          }
      };

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
    
    // create a MovieClipLoader to handle the loading of the player
    var ytPlayerLoader:MovieClipLoader = new MovieClipLoader();
    ytPlayerLoader.addListener(ytPlayerLoaderListener);
    // load the player
    ytPlayerLoader.loadClip("http://gdata.youtube.com/apiplayer?key=AI39si4Nxri5jhcmN6d20gl4A1eKK63xgtw_SRNQePzBiALphr1WGF0zg5JBPLvytL0hXbHanoCczMbsbfGBSjyKswTXpib5Ig", ytplayer);
  }

  // entry point
  static function main(mc) {
    app = new LastYoutubePlayer();
  }
}
