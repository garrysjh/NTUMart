import 'dart:convert';

import 'package:http/http.dart';

enum MediaType { image, video, text }

class WhatsappStory {
  final MediaType? mediaType;
  final String? media;
  final double? duration;
  final String? caption;
  final String? when;
  final String? color;

  WhatsappStory({
    this.mediaType,
    this.media,
    this.duration,
    this.caption,
    this.when,
    this.color,
  });
}

class Highlight {
  final String? image;
  final String? headline;

  Highlight({this.image, this.headline});
}

class Gnews {
  final String? title;
  final List<Highlight>? highlights;

  Gnews({this.title, this.highlights});
}

/// The repository fetches the data from the same directory from git.
/// This is just to demonstrate fetching from a remote (workflow).
class Repository {
  static MediaType _translateType(String? type) {
    if (type == "image") {
      return MediaType.image;
    }

    if (type == "video") {
      return MediaType.video;
    }

    return MediaType.text;
  }

 

  static Future<List<WhatsappStory>> getWhatsappStories() async {
    const String response = '''
{
  "data": [
      {
        "mediaType": "image",
        "media": "https://ryonanna.com/wp-content/uploads/2020/07/tama-canteen-667x1024.jpg",
        "duration": "8.0",
        "caption": "We're chilling at the canteen, come check us out!",
        "when": "14 hours ago",
        "color": ""
      },
      {
        "mediaType": "image",
        "media": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExaHJxZ2h4empubGpwcnNzaDd3N282cHQ0aDg4bmloYWdvb2drcXpyMiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ccLA75Is1P2by8Wx07/giphy.gif",
        "duration": "8.0",
        "caption": "Looking forward to a Monday at hall!",
        "when": "10 hours ago",
        "color": ""
      },
      {
        "mediaType": "image",
        "media": "https://github.com/garrysjh/NTUMart/raw/keegan-story-update/frontend/assets/img/keegangif.mp4",
        "duration": "8.0",
        "caption": "Giving away maggi, come get it! Level 2-07",
        "when": "6 hours ago",
        "color": ""
      }
      ]
}
''';


    // final response = await rootBundle.loadString('hall.json');

    final data = await json.decode(response)['data'];

    final res = data.map<WhatsappStory>((it) {
      return WhatsappStory(
          caption: it['caption'],
          media: it['media'],
          duration: double.parse(it['duration']),
          when: it['when'],
          mediaType: _translateType(it['mediaType']),
          color: it['color']);
    }).toList();

    return res;
  }

static Future<List<WhatsappStory>> getFloorStories() async {
    const String response = '''
{
  "data": [
      {
        "mediaType": "image",
        "media": "https://ryonanna.com/wp-content/uploads/2020/07/room-795x1024.jpg",
        "duration": "8.0",
        "caption": "I'm moving out at 20-05-01, check out my items!",
        "when": "14 hours ago",
        "color": ""
      },
      {
        "mediaType": "image",
        "media": "https://images.squarespace-cdn.com/content/v1/5ff2bfec15120a7c1d22098a/1626686613279-OIDII2TE7046K5ME1S05/saraca-laundry-room.jpeg",
        "duration": "8.0",
        "caption": "Bro who messed up the laundry machine again???? ",
        "when": "10 hours ago",
        "color": ""
      }
      ]
}
''';


    // final response = await rootBundle.loadString('hall.json');

    final data = await json.decode(response)['data'];

    final res = data.map<WhatsappStory>((it) {
      return WhatsappStory(
          caption: it['caption'],
          media: it['media'],
          duration: double.parse(it['duration']),
          when: it['when'],
          mediaType: _translateType(it['mediaType']),
          color: it['color']);
    }).toList();

    return res;
  }


  static Future<Gnews> getNews() async {



    const uri =
        "https://raw.githubusercontent.com/blackmann/storyexample/master/lib/data/gnews.json";
    final response = await get(Uri.parse(uri));

    // use utf8.decode to make emojis work
    final data = jsonDecode(utf8.decode(response.bodyBytes))['data'];

    final title = data['title'];
    final highlights = data['highlights'].map<Highlight>((it) {
      return Highlight(headline: it['headline'], image: it['image']);
    }).toList();

    return Gnews(title: title, highlights: highlights);
  }
}