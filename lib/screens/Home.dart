import 'package:volume/volume.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../widgets/BotIcons.dart';
import '../widgets/TopIcons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int maxVol, currentVol;
  AudioManager audioManager;
  ShowVolumeUI showVolumeUI = ShowVolumeUI.HIDE;
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    audioManager = AudioManager.STREAM_MUSIC;
    initAudioStreamType();
    updateVolumes();

    assetsAudioPlayer.open(
        Audio.liveStream("http://149.56.195.94:8322/bolpunjabiradio"),
        showNotification: true,
        notificationSettings: NotificationSettings(
          prevEnabled: false,
          nextEnabled: false,
        ));
  }

  Future<void> initAudioStreamType() async {
    await Volume.controlVolume(AudioManager.STREAM_MUSIC);
  }

  updateVolumes() async {
    maxVol = await Volume.getMaxVol;
    currentVol = await Volume.getVol;
    setState(() {});
  }

  setVol(int i) async {
    await Volume.setVol(i, showVolumeUI: ShowVolumeUI.HIDE);
  }

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: _deviceSize.height,
        child: Column(
          children: <Widget>[
            Container(
                height: _deviceSize.height * 0.35,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black54.withOpacity(0.8), BlendMode.srcOver),
                    image: NetworkImage(
                        'http://bolpunjabi.com/admin/images/1589510843.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: TopIcons()),
            Container(
              height: 100,
              width: 100,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(
                      'http://bolpunjabi.com/admin/images/1589510843.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              "Bol Punjabi Radio",
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: <Widget>[
                  Text(
                    "Now Playing",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Song_Name - Artist_Name",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.volume_off),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      currentVol -= 1;
                      setVol(currentVol);
                      updateVolumes();
                    }),
                Expanded(
                  child: (currentVol != null || maxVol != null)
                      ? Slider(
                          min: 0,
                          max: maxVol / 1.0,
                          value: currentVol / 1.0,
                          onChanged: (value) {
                            setVol(value.toInt());
                            updateVolumes();
                          })
                      : Container(),
                ),
                IconButton(
                    icon: Icon(Icons.volume_up),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      currentVol += 1;
                      setVol(currentVol);
                      updateVolumes();
                    }),
              ],
            ),
            PlayerBuilder.isPlaying(
                player: assetsAudioPlayer,
                builder: (ctx, _isPlaying) {
                  return IconButton(
                      iconSize: 50,
                      icon: _isPlaying
                          ? Icon(Icons.pause_circle_outline)
                          : Icon(Icons.play_circle_outline),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        assetsAudioPlayer
                            .playOrPause()
                            .then((_) => setState(() {
                                  _isPlaying = !_isPlaying;
                                }));
                      });
                }),
            Expanded(child: BotIcons())
          ],
        ),
      ),
    );
  }
}
